
function addLine(model, prefix) {
    if (model === null)
        model = "";
    else
        model = model + "-";
    
//    if (prefix === null)
        prefix = "";
//    else
//        prefix = prefix + "-";
        
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
function publish(){
    
    
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

function submitSingle(param) {
    var contents = document.getElementsByClassName(param + '-content');
    var scores = document.getElementsByClassName(param + '-score');
    
    var contentInput = document.getElementsByClassName(param + '-content-input');
    var scoreInput = document.getElementsByClassName(param + '-score-input');
    
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

function addClick(a,b){
     $("#"+a+"-"+b+"-basic").append(addLine(a,b));
    $('.delete').bind('click', function () {
        del();
    });
}
$('.add-me').click(function () {
//    $(this).parent().children().eq(4).append(addMessage());
    $('.remark-table').append(addMessage());
    $('.delete').bind('click', function () {
        del();
    });
});


              
$("#select-admin-year").change(function () {
    var value = $("select-admin-year").val();
    $("#endyear").text(parseInt(value)+1);
    $("#submit-admin").submit();
});
$("#select-auditor-year").change(function () {
    var value = $("select-auditor-year").val();
    $("#endyear").text(parseInt(value)+1);
    $("#submit-auditor").submit();
});
$("#select-teacher-year").change(function () {
     var value = $("select-teacher-year").val();
    $("#endyear").text(parseInt(value)+1);
    $("#submit-teacher").submit();
});
$("#select-title-iden").change(function () {
    $("#submit-title").submit();
});
del();
