

sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/json/JSONModel",
  "sap/ui/model/Filter",
  "sap/ui/model/FilterOperator"
],function( Controller, JSONModel, Filter, FilterOperator){
  'use strict';

  return Controller.extend('sap.ui.app.wt.components.NinjaList', {
  
  onFilterNinjas: function(oEvent){
    //build filter array
    var aFilter = [];
    var sQuery = oEvent.getParameter("query");
    if (sQuery) {
      aFilter.push(new Filter("Name", FilterOperator.Contains, sQuery));
    }

    // filter binding
    var oList = this.getView().byId("ninjaList");
    var oBinding = oList.getBinding("items");
    oBinding.filter(aFilter);
  }
  
  });

});
