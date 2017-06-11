function addLine(model) {
    if (model === null)
        model = ""
    else
        model = model + "-"
        
    var tpl = "";
    tpl += "<tr class=\"hover\">";
    tpl += "<td>";
    tpl += "<div>";
    tpl += " <div class=\"textarea\" contenteditable=\"true\"></div>";
    tpl += "<input class=\"" + model + "content-input\" name=\"keypoint\" style=\"display: none;\" />"
    tpl += "<i class=\"fa fa-trash delete\"></i>";
    tpl += "<div>";
    tpl += "</td>";
    tpl += "<td class=\"width_100\"><div class=\"textarea\" contenteditable=\"true\" style=\"width:100%\"></div></td>";
    tpl += "<input class=\"" + model + "score-input\" name=\"content\" style=\"display: none;\" />"
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
    $(".gzl_basice_score").append(addLine());
    
    
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

initSelected();