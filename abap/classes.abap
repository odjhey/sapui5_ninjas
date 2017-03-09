ass ZCL_ZSRV_TEST_ODEE_DPC_EXT definition
  public
  inheriting from ZCL_ZSRV_TEST_ODEE_DPC
  create public .

public section.
protected section.

  methods NINJASSET_GET_ENTITYSET
    redefinition .
  methods NINJASSET_CREATE_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZSRV_TEST_ODEE_DPC_EXT IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_ZSRV_TEST_ODEE_DPC_EXT->NINJASSET_CREATE_ENTITY
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_ENTITY_NAME                 TYPE        STRING
* | [--->] IV_ENTITY_SET_NAME             TYPE        STRING
* | [--->] IV_SOURCE_NAME                 TYPE        STRING
* | [--->] IT_KEY_TAB                     TYPE        /IWBEP/T_MGW_NAME_VALUE_PAIR
* | [--->] IO_TECH_REQUEST_CONTEXT        TYPE REF TO /IWBEP/IF_MGW_REQ_ENTITY_C(optional)
* | [--->] IT_NAVIGATION_PATH             TYPE        /IWBEP/T_MGW_NAVIGATION_PATH
* | [--->] IO_DATA_PROVIDER               TYPE REF TO /IWBEP/IF_MGW_ENTRY_PROVIDER(optional)
* | [<---] ER_ENTITY                      TYPE        ZCL_ZSRV_TEST_ODEE_MPC=>TS_NINJAS
* | [!CX!] /IWBEP/CX_MGW_BUSI_EXCEPTION
* | [!CX!] /IWBEP/CX_MGW_TECH_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD ninjasset_create_entity.
**TRY.
*CALL METHOD SUPER->NINJASSET_CREATE_ENTITY
*  EXPORTING
*    IV_ENTITY_NAME          =
*    IV_ENTITY_SET_NAME      =
*    IV_SOURCE_NAME          =
*    IT_KEY_TAB              =
**    IO_TECH_REQUEST_CONTEXT =
*    IT_NAVIGATION_PATH      =
**    IO_DATA_PROVIDER        =
**  IMPORTING
**    ER_ENTITY               =
*    .
** CATCH /IWBEP/CX_MGW_BUSI_EXCEPTION .
** CATCH /IWBEP/CX_MGW_TECH_EXCEPTION .
**ENDTRY.

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


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_ZSRV_TEST_ODEE_DPC_EXT->NINJASSET_GET_ENTITYSET
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_ENTITY_NAME                 TYPE        STRING
* | [--->] IV_ENTITY_SET_NAME             TYPE        STRING
* | [--->] IV_SOURCE_NAME                 TYPE        STRING
* | [--->] IT_FILTER_SELECT_OPTIONS       TYPE        /IWBEP/T_MGW_SELECT_OPTION
* | [--->] IS_PAGING                      TYPE        /IWBEP/S_MGW_PAGING
* | [--->] IT_KEY_TAB                     TYPE        /IWBEP/T_MGW_NAME_VALUE_PAIR
* | [--->] IT_NAVIGATION_PATH             TYPE        /IWBEP/T_MGW_NAVIGATION_PATH
* | [--->] IT_ORDER                       TYPE        /IWBEP/T_MGW_SORTING_ORDER
* | [--->] IV_FILTER_STRING               TYPE        STRING
* | [--->] IV_SEARCH_STRING               TYPE        STRING
* | [--->] IO_TECH_REQUEST_CONTEXT        TYPE REF TO /IWBEP/IF_MGW_REQ_ENTITYSET(optional)
* | [<---] ET_ENTITYSET                   TYPE        ZCL_ZSRV_TEST_ODEE_MPC=>TT_NINJAS
* | [<---] ES_RESPONSE_CONTEXT            TYPE        /IWBEP/IF_MGW_APPL_SRV_RUNTIME=>TY_S_MGW_RESPONSE_CONTEXT
* | [!CX!] /IWBEP/CX_MGW_BUSI_EXCEPTION
* | [!CX!] /IWBEP/CX_MGW_TECH_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method NINJASSET_GET_ENTITYSET.
**TRY.
*CALL METHOD SUPER->NINJASSET_GET_ENTITYSET
*  EXPORTING
*    IV_ENTITY_NAME           =
*    IV_ENTITY_SET_NAME       =
*    IV_SOURCE_NAME           =
*    IT_FILTER_SELECT_OPTIONS =
*    IS_PAGING                =
*    IT_KEY_TAB               =
*    IT_NAVIGATION_PATH       =
*    IT_ORDER                 =
*    IV_FILTER_STRING         =
*    IV_SEARCH_STRING         =
**    IO_TECH_REQUEST_CONTEXT  =
**  IMPORTING
**    ET_ENTITYSET             =
**    ES_RESPONSE_CONTEXT      =
*    .
** CATCH /IWBEP/CX_MGW_BUSI_EXCEPTION .
** CATCH /IWBEP/CX_MGW_TECH_EXCEPTION .
**ENDTRY.

    DATA wa LIKE LINE OF et_entityset.

* build filter select options.
    data lt_data_range type range of ysrv_test-name.
    read table IT_FILTER_SELECT_OPTIONS assigning field-symbol(<f>)
    with key PROPERTY = 'Name'.
    if sy-subrc is initial.
      loop at <f>-select_options assigning field-symbol(<so>).
        append initial line to lt_data_range assigning field-symbol(<dr>).
        move-corresponding <so> to <dr>.
      endloop.
*      append lines of <f>-select_options to lt_data_range.
    endif.

    select * from YSRV_TEST into table et_entityset
      where name in lt_data_range.


  endmethod.
ENDCLASS.
