
### CREATE Entity

```abap
  METHOD ninjasset_create_entity.

    DATA ls_req_payload LIKE er_entity.
    io_data_provider->read_entry_data(
      IMPORTING
        es_data = ls_req_payload
    ).

    data: ls type YSRV_TeST.
   clear ls.
   move-corresponding ls_req_payload to ls.

   if ls-ninjaid is initial.
     select single max( ninjaid ) from ysrv_test
       into @data(lll).
     ls-ninjaid = lll + 1.
   endif.

    MODIFY ysrv_test FROM ls.
    COMMIT WORK AND WAIT.
    IF sy-subrc IS INITIAL.
      er_entity = ls_req_payload.
    ELSE.
*      raise exception type /iwbep/cx_mgw_bust_exception
*      exporting textid = /iwbep/cx_mgw_busi_exception=>business_error_unlimited
*                message_unlimited = 'Samting wong happened.'.
    ENDIF.

  ENDMETHOD.
```
### Get EntitySet

```abap
  METHOD ninjasset_get_entityset.

    DATA wa LIKE LINE OF et_entityset.

* build filter select options.
    DATA lt_data_range TYPE RANGE OF ysrv_test-name.
    READ TABLE it_filter_select_options ASSIGNING FIELD-SYMBOL(<f>)
    WITH KEY property = 'Name'.
    IF sy-subrc IS INITIAL.
      LOOP AT <f>-select_options ASSIGNING FIELD-SYMBOL(<so>).
        APPEND INITIAL LINE TO lt_data_range ASSIGNING FIELD-SYMBOL(<dr>).
        MOVE-CORRESPONDING <so> TO <dr>.
      ENDLOOP.
*      append lines of <f>-select_options to lt_data_range.
    ENDIF.

    SELECT * FROM ysrv_test INTO TABLE @et_entityset
      WHERE name IN @lt_data_range.


  ENDMETHOD.
```
