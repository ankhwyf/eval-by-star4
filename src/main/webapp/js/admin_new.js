function addLine(model, prefix) {
    if (model === null)
        model = "";
    else
        model = model + "-";
    
    if (prefix === null)
        prefix = "";
    else
        prefix = prefix + "-";
        
    var tpl = "";
    tpl += "<tr class=\"hover\">";
    tpl += "<td>";
    tpl += "<div>";
    tpl += " <div class=\"textarea " + model + "content\" contenteditable=\"true\"></div>";
    tpl += "<input class=\"" + model + "content-input\" name=\"" + prefix + "content\" style=\"display: none;\" />";
    tpl += "<i class=\"fa fa-trash delete\"></i>";
    tpl += "<div>";
    tpl += "</td>";
    tpl += "<td class=\"width-100\"><div class=\"textarea " + model + "score\" contenteditable=\"true\" style=\"width:100%\"></div>";
    tpl += "<input class=\"" + model + "score-input\" name=\"" + prefix + "score\" style=\"display: none;\" /></td>";
    tpl += " <td class=\"width-100\"></td>";
    tpl += " <td class=\"width-100\"></td>";
    tpl += "<tr>";
    return tpl;
}
function addMessage() {
    var tpl = "";
    tpl += "<tr class=\"hover\">";
    tpl += "<td>";
    tpl += "<div class=\"textarea remark-keypoint\" contenteditable=\"true\"></div>";
    tpl += "<input class=\"keypoint-input\" name=\"keypoint\" style=\"display: none;\" />"
    tpl += "</td>";
    tpl += "<td>";
    tpl += "<div class=\"textarea remark-content\" contenteditable=\"true\" style=\"height:100%\"></div>";
    tpl += "<input class=\"content-input\" name=\"content\" style=\"display: none;\" />"
    tpl += "<i class=\"fa fa-trash delete\"></i>";
    tpl += "</td>";
    tpl += "</tr>";
    return tpl;
}
function del() {
    $(".delete").click(function () {
        if ($(this).parent().parent().children().length === 2) {
            $(this).parent().parent().remove();
        } else
            $(this).parent().parent().parent().remove();
    });
}

function submitRemark() {
    var keypoints = document.getElementsByClassName('remark-keypoint');
    var contents = document.getElementsByClassName('remark-content');
    
    var kpInput = document.getElementsByClassName('keypoint-input');
    var contentInput = document.getElementsByClassName('content-input');
    
    if (keypoints === null || contents === null || keypoints.length === 0 || contents.length === 0) 
        return false;
    
    for (var i = 0; i < keypoints.length; i++) {
        kpInput[i].value = keypoints[i].innerHTML;
    }
    for (var i = 0; i < contents.length; i++) {
        contentInput[i].value = contents[i].innerHTML;
    }
    return true;
}

function submitGzl() {
    return submitSingle("gzl");
}

function submitOthers() {
    return submitSingle("others");
}

function submitSingle(param) {
    var contents = document.getElementsByClassName(param + '-basic-content');
    var scores = document.getElementsByClassName(param + '-basic-score');
    
    var contentInput = document.getElementsByClassName(param + '-basic-content-input');
    var scoreInput = document.getElementsByClassName(param + '-basic-score-input');
    
    if (scores === null || contents === null || scores.length === 0 || contents.length === 0) 
        return false;
    
    console.log("content " + contents.length + "; score " + scores.length);
    for (var i = 0; i < contents.length; i++) {
        contentInput[i].value = contents[i].innerHTML;
        console.log(contentInput[i].value);
    }
    for (var i = 0; i < scores.length; i++) {
        scoreInput[i].value = scores[i].innerHTML;
        console.log(scoreInput[i].value);
    }
    return true;
}

function submit(param) {
    var basicContents = document.getElementsByClassName(param + '-basic-content');
    var basicScores = document.getElementsByClassName(param + '-basic-score');
    var extendContents = document.getElementsByClassName(param + '-extend-content');
    var extendScores = document.getElementsByClassName(param + '-extend-score');
    
    var basicContentInput = document.getElementsByClassName(param + '-basic-content-input');
    var basicScoreInput = document.getElementsByClassName(param + '-basic-score-input');
    var extendContentInput = document.getElementsByClassName(param + '-extend-content-input');
    var extendScoreInput = document.getElementsByClassName(param + '-extend-score-input');
    
    if (basicContents === null || basicScores === null || extendContents === null || extendScores === null || 
            basicContents.length === 0 || basicScores.length === 0 || extendContents.length === 0 || extendScores.length === 0) 
        return false;
    
    for (var i = 0; i < basicContents.length; i++) {
        basicContentInput[i].value = basicContents[i].innerHTML;
        console.log(basicContentInput[i].value);
    }
    for (var i = 0; i < basicScores.length; i++) {
        basicScoreInput[i].value = basicScores[i].innerHTML;
        console.log(basicScoreInput[i].value);
    }
    for (var i = 0; i < extendContents.length; i++) {
        extendContentInput[i].value = extendContents[i].innerHTML;
        console.log(extendContentInput[i].value);
    }
    for (var i = 0; i < extendScores.length; i++) {
        extendScoreInput[i].value = extendScores[i].innerHTML;
        console.log(extendScoreInput[i].value);
    }
    return true;
}

function submitRoutine() {
    return submit('routine');
}

function submitConstruct() {
    return submit('construct');
}

$(".add-gzl").click(function () {
    $(".gzl-basic").append(addLine("gzl-basic", null));
    
    $('.delete').bind('click', function () {
        del();
    });
});

$(".add-routine-basic").click(function () {
    $(".routine-basic").append(addLine("routine-basic", "basic"));
    
    $('.delete').bind('click', function () {
        del();
    });
});

$(".add-routine-extend").click(function () {
    $(".routine-extend").append(addLine("routine-extend", "extend"));
    
    $('.delete').bind('click', function () {
        del();
    });
});

$(".add-construct-basic").click(function () {
    $(".construct-basic").append(addLine("construct-basic", "basic"));
    
    $('.delete').bind('click', function () {
        del();
    });
});

$(".add-construct-extend").click(function () {
    $(".construct-extend").append(addLine("construct-extend", "extend"));
    
    $('.delete').bind('click', function () {
        del();
    });
});

$(".add-others-basic").click(function () {
    $(".others-basic").append(addLine("others-basic", null));
    
    $('.delete').bind('click', function () {
        del();
    });
});

$('.add-me').click(function () {
//    $(this).parent().children().eq(4).append(addMessage());
    $('.remark-table').append(addMessage());
    $('.delete').bind('click', function () {
        del();
    });
});

$(".form-control").change(function () {
    var value = $(".form-control").val();
    $("#endyear").text(parseInt(value) + 1);
    $("#submit").submit();
});

del();