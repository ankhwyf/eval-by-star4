function addLine(model) {
    if (model === null)
        model = ""
    else
        model = model + "-"
        
    var tpl = "";
    tpl += "<tr class=\"hover\">";
    tpl += "<td>";
    tpl += "<div>";
    tpl += " <div class=\"textarea " + model + "content\" contenteditable=\"true\"></div>";
    tpl += "<input class=\"" + model + "content-input\" name=\"content\" style=\"display: none;\" />"
    tpl += "<i class=\"fa fa-trash delete\"></i>";
    tpl += "<div>";
    tpl += "</td>";
    tpl += "<td class=\"width_100\"><div class=\"textarea " + model + "score\" contenteditable=\"true\" style=\"width:100%\"></div></td>";
    tpl += "<input class=\"" + model + "score-input\" name=\"score\" style=\"display: none;\" />"
    tpl += " <td class=\"width_100\"></td>";
    tpl += " <td class=\"width_100\"></td>";
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
    var contents = document.getElementsByClassName('basic-content');
    var scores = document.getElementsByClassName('basic-score');
    
    var contentInput = document.getElementsByClassName('basic-content-input');
    var scoreInput = document.getElementsByClassName('basic-score-input');
    
    if (scores === null || contents === null || scores.length === 0 || contents.length === 0) 
        return false;
    
    for (var i = 0; i < contents.length; i++) {
        contentInput[i].value = contents[i].innerHTML;
        console.log(contentInput[i].value)
    }
    for (var i = 0; i < scores.length; i++) {
        scoreInput[i].value = scores[i].innerHTML;
        console.log(scoreInput[i].value)
    }
    return true;
}

function submitRoutine() {
    var basicContents = document.getElementsByClassName('basic-content');
    var basicScores = document.getElementsByClassName('basic-score');
    var extendContents = document.getElementsByClassName('extend-content');
    var extendScores = document.getElementsByClassName('extend-score');
    
    var basicContentInput = document.getElementsByClassName('basic-content-input');
    var basicScoreInput = document.getElementsByClassName('basic-score-input');
    var extendContentInput = document.getElementsByClassName('extend-content-input');
    var extendScoreInput = document.getElementsByClassName('extend-score-input');
    
    if (basicContents === null || basicScores === null || extendContents === null || extendScores === null || 
            basicContents.length === 0 || basicScores.length === 0 || extendContents.length === 0 || extendScores.length === 0) 
        return false;
    
    for (var i = 0; i < basicContents.length; i++) {
        basicContentInput[i].value = basicContents[i].innerHTML;
        console.log(basicContentInput[i].value)
    }
    for (var i = 0; i < basicScores.length; i++) {
        basicScoreInput[i].value = basicScores[i].innerHTML;
        console.log(basicScoreInput[i].value)
    }
    for (var i = 0; i < extendContents.length; i++) {
        extendContentInput[i].value = extendContents[i].innerHTML;
        console.log(extendContentInput[i].value)
    }
    for (var i = 0; i < extendScores.length; i++) {
        extendScoreInput[i].value = extendScores[i].innerHTML;
        console.log(extendScoreInput[i].value)
    }
    return true;
}

function submitConstruct() {
    submitRoutine();
}

function submitOthers() {
    submitRoutine();
}

$(".add").click(function () {
    if ($(this).parent().parent().children('td').length === 5) {
        $(this).parent().parent().children().eq(2).children().append(addLine());
    } else
        $(this).parent().parent().children().eq(1).children().append(addLine());

    $('.delete').bind('click', function () {
        del();
    });
});

$(".add_gzl").click(function () {
    $(".gzl_basic_score").append(addLine("basic"));
    
    $('.delete').bind('click', function () {
        del();
    });
});

$(".add_routine_basic").click(function () {
    $(".routine_basic").append(addLine("basic"));
    
    $('.delete').bind('click', function () {
        del();
    });
});

$(".add_routine_extend").click(function () {
    $(".routine_extend").append(addLine("extend"));
    
    $('.delete').bind('click', function () {
        del();
    });
});

$(".add_construct_basic").click(function () {
    $(".construct_basic").append(addLine("basic"));
    
    $('.delete').bind('click', function () {
        del();
    });
});

$(".add_construct_extend").click(function () {
    $(".construct_extend").append(addLine("extend"));
    
    $('.delete').bind('click', function () {
        del();
    });
});

$(".add_others_basic").click(function () {
    $(".others_basic").append(addLine("basic"));
    
    $('.delete').bind('click', function () {
        del();
    });
});

$(".add_others_extend").click(function () {
    $(".others_extend").append(addLine("extend"));
    
    $('.delete').bind('click', function () {
        del();
    });
});

$('.add-me').click(function () {
    $(this).parent().children().eq(4).append(addMessage());
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