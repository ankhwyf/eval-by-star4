$(document).on('change', '#select-auditor-year', function () {
    var value = $("#select-auditor-year").val();
    $("#endyear-auditor").text(parseInt(value) + 1);
    $("#submit-auditor").submit();
});
function sumbitAuditorSub(param,a){
    for (var j = 0; j < a; j++) {
        var scores = document.getElementsByClassName(param + "-" + j + '-score');

        var scoreInput = document.getElementsByClassName(param + "-" + j + '-score-input');
s
        if (scores === null || scores.length === 0)
            return false;

        console.log("scores " + scores.length);
        for (var i = 0; i < scores.length; i++) {
            scoreInput[i].value = scores[i].innerHTML;
            console.log(scoreInput[i].value);
        }
    }
    return true;
}
$(function () {
  $('[data-toggle="tooltip"]').tooltip();
});

