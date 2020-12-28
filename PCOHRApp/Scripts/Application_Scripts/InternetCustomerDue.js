$(document).ready(function () {
    loadInitialization();
});

$('#btnSaveId').click(function () {
    GenerateRDLC("PDF");
});
$('#btnExcelId').click(function () {
    GenerateRDLC('Excel');
});
$('#btnWordId').click(function () {
    GenerateRDLC('Word');
});

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


function GenerateRDLC(fileType) {
    var zoneId = $('#zoneId').val();
    var reportType = 'InternetBillDue';
    var viewURL = '/CableReport/ShowReport?fileType=' + fileType + '&zoneId=' + zoneId + "&reportType=" + reportType;
    $.fancybox(
        {
            'title': 'Report Window',
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
