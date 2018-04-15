$(document).on('change', '#select-auditor-year', function () {
    var value = $("#select-auditor-year").val();
    $("#endyear-auditor").text(parseInt(value) + 1);
    $("#submit-auditor").submit();
});



