

sap.ui.define([
  "sap/ui/base/Object"
], function(UI5Object){
  "use strict";

  return UI5Object.extend("sap.ui.app.wt.components.GenericDialog", {
    constructor : function(oView){
      this._oView = oView;
    } ,

    open : function() {
      console.log("open");
      var oView = this._oView;
      var oDialog = oView.byId("wadapDialog");

      if (!oDialog){
        var oFragmentController = {
          saramopo : function(){
            oDialog.close();
          }
        };

        oDialog = sap.ui.xmlfragment(oView.getId(), 
          "sap.ui.app.wt.components.GenericDialog", oFragmentController );
        oView.addDependent(oDialog);
     }
     oDialog.open();

    }
  });
});
