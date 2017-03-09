
sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/json/JSONModel",
  "sap/m/MessageToast",
  "sap/ui/model/resource/ResourceModel"
], function( Controller, JSONModel, MessageToast, ResourceModel ){
  "use strict";
  return Controller.extend(
    "sap.ui.app.wt.components.App", {

  //    onInit: function(){
  //    },
     
      onPressz: function(){
        //read from i18n Resource
        var oBundle = this.getView().getModel("i18n").getResourceBundle();
        var oNinja  = this.getView().getModel().getProperty("/ninja/name");
        var sMsg    = oBundle.getText("helloMsg", [oNinja]);

        var oddnin = this.getView().getModel("ddnin");

        oddnin.create(
          '/ninjasSet', {
            Ninjaid: '',
            Name: oNinja 
          },
          {
            success: function s (odata, resp){
              console.log(odata);
              console.log(resp);
              oddnin.odata = odata;
              MessageToast.show(sMsg);
            },
            error: function e (err){
              if(err){
                console.log(err);
              }
            }
          }
        );

      },

      onDialogPress: function(){
        this.getOwnerComponent().openDialog();
      },

    }
  );
});
