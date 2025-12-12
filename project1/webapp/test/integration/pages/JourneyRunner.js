sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"project1/test/integration/pages/ZIW_ProductsList",
	"project1/test/integration/pages/ZIW_ProductsObjectPage"
], function (JourneyRunner, ZIW_ProductsList, ZIW_ProductsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('project1') + '/test/flp.html#app-preview',
        pages: {
			onTheZIW_ProductsList: ZIW_ProductsList,
			onTheZIW_ProductsObjectPage: ZIW_ProductsObjectPage
        },
        async: true
    });

    return runner;
});

