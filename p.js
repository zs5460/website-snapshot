"use strict";
var url = "http://www.rednet.cn/";
var system = require('system');
// if (system.args.length === 2) {
// 	url = system.args[1];
// }
var page = require('webpage').create();
page.viewportSize = { width: 1280, height: 800 };
page.open(url, function() {
    setTimeout(function() {
		// page.evaluate(function() {
		// 	$('#time').hide();
        // });
        page.render('/app/data/tmp.png');
        phantom.exit();
    }, 3000);
});