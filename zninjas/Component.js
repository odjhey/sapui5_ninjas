jQuery.sap.declare("sap.ui.app.wt.Component");
sap.ui.define([
	  "sap/ui/core/UIComponent",
	  "sap/ui/model/json/JSONModel",
	  "sap/ui/app/wt/components/GenericDialog"
	], function (UIComponent, JSONModel, GenericDialog ){
	  "use strict";

	  return UIComponent.extend("sap.ui.app.wt.Component",{

	    metadata: {
	      manifest: 'json'
	    },

	    init : function(){
	      //call super
	      UIComponent.prototype.init.apply(this, arguments);
	      // set data model
	      var oData = {
	        ninja : {
	          name : "kenshin"
	        }
	      };

	      var oModel = new JSONModel(oData);
	      this.setModel(oModel);

	// GenericDialog
	      this._genericDialog = new GenericDialog(this.getAggregation("rootControl"));
	    },

	    openDialog: function(){
	      this._genericDialog.open();
	    }

	  });

	});
