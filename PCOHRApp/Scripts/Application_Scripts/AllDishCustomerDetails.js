﻿
$(document).ready(function () {
    loadInitialization();
});

$('#btnSaveId').click(function () {
    GenerateRDLC('PDF');
});

$('#btnExcelId').click(function () {
    GenerateRDLC('Excel');
});
$('#btnWordId').click(function () {
    GenerateRDLC('Word');
});


function GenerateRDLC(fileType) {
    var activeStatus = $('#activeStatusId').val() == "" ? null : $('#activeStatusId').val() == '1' ? true : false;
    var zoneId = $('#zoneId').val();
    var reportType = 'AllDishCustomerDetails';
    var viewURL = '/CableReport/ShowReport?fileType='+fileType+'&isActive=' + activeStatus + '&zoneId=' + zoneId + "&reportType=" + reportType;
    var src = '/CableReport/ReportViewer';
    $.fancybox(
		{
		    'title': 'Report Window',
		    'maxWidth': 800,
		    'type': 'iframe',
		    'transitionIn': 'elastic',
		    'transitionOut': 'elastic',
		    'speedIn': 1000,
		    'speedOut': 700,
		    autoSize: false,
		    closeClick: false,
		    afterShow: after_show(fileType),
		    'href': viewURL
		});
}
function after_show(fileType) {
    if (fileType != "PDF") {
        setTimeout(function () { $.fancybox.close(); }, 19000);
    }
}




function loadInitialization() {
    $('#messageBoxId').hide();
    $('#errorMessageBoxId').hide();
    $('#successMessageBoxId').hide();

    
    $.get('/Zone/GetZoneListForDropdown', function (data) {
        zones = data.data;
        $('#zoneId').select2({
            data: zones
        });
    });
}