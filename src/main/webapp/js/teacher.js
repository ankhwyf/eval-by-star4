function submitDetail(param, a) {
    for (var j = 0; j < a; j++) {
        var scores = document.getElementsByClassName(param + "-" + j + '-score');
        var proofs = document.getElementsByClassName(param + "-" + j + '-proof');

        var scoreInput = document.getElementsByClassName(param + "-" + j + '-score-input');
        var proofInput = document.getElementsByClassName(param + "-" + j + '-proof-input');

        if (scores === null || proofs === null || scores.length === 0 || proofs.length === 0)
            return false;

        console.log("scores " + scores.length + "; proofs " + proofs.length);
        for (var i = 0; i < scores.length; i++) {
            scoreInput[i].value = scores[i].innerHTML;
            console.log(scoreInput[i].value);
        }
        for (var i = 0; i < proofs.length; i++) {
            proofInput[i].value = proofs[i].innerHTML;
            console.log(proofInput[i].value);
        }
    }
    return true;
}
function submitLoad(param) {
    for (var i = 0; i < param; i++) {
        var contents = document.getElementsByClassName('load-content-' + i);
        var contentInput = document.getElementsByClassName('load-input-' + i);
        if (contents === null || contents.length === 0)
            return false;
        for (var j = 0; j < contents.length; j++) {
            contentInput[j].value = contents[j].innerHTML;
            console.log("i:" + i + " j:" + j + " contentInput: " + contentInput[j].value);
        }
    }
    return true;
}
function addLoadLine(a) {
    var tpl = "";
    tpl += "<tr class=\"hover\">";
    for (var i = 0; i < a; i++) {
        tpl += "<td>";
        tpl += "<div class=\"textarea load-content-" + i + "\" contenteditable=\"true\">";
        tpl += "</div>";
        tpl += "<input class=\"load-input-" + i + "\" name=\"load-" + i + "\" type=\"hidden\" />";
        tpl += "</td>";
    }
    tpl += "<td><i class=\"fa fa-trash load-delete\"></i></td>";
    tpl += "</tr>";
    return tpl;
}

function delLoad() {
    $(".load-delete").click(function () {
        $(this).parent().parent().remove();
    });
}

function addLoadClick(a) {
    $('.load-table').append(addLoadLine(a));
    $('.load-delete').bind('click', function () {
        delLoad();
    });
}

$(document).on('change', '#select-teacher-year', function () {
    var value = $("#select-teacher-year").val();
    $("#endyear-teacher").text(parseInt(value) + 1);
    $("#submit-teacher").submit();
});

$(document).ready(function () {
    delLoad();
});




