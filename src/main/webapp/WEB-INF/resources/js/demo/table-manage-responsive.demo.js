/*
Template Name: Color Admin - Responsive Admin Dashboard Template build with Twitter Bootstrap 4
Version: 4.7.0
Author: Sean Ngu
Website: http://www.seantheme.com/color-admin/admin/
*/

var handleDataTableResponsive = function() {
	"use strict";

	if ($('#data-table-responsive').length !== 0) {
		$('#data-table-responsive').DataTable({
			responsive: true
			, searching: false
			, paging: false
			, info: false
			, ordering: false
		});
	}
};

var TableManageResponsive = function () {
	"use strict";
	return {
		//main function
		init: function () {
			handleDataTableResponsive();
		}
	};
}();

$(document).ready(function() {
	TableManageResponsive.init();
});