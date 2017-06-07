
// 鼠标悬停和离开
function react() {
    $(".container .content .col-md-4 .configure table tr").hover(function () {
        $(this).css('background', '#f5f5f5');
        $(this).find('.pull-right').show();
    }, function () {
        $(this).css('background', '#ffffff');
        $(this).find('.pull-right').hide();
    })

    $(".container .content .col-md-4 .configure table tr .fa-trash").click(function () {
        console.log("1");
        $(this).parent().parent().remove();
    });

    $(".container .content .col-md-4 .configure table tr .fa-edit").click(function () {
        $(this).parent().parent().remove();
    });

    $('#addFirst').click(function () {
        modals.feedBackShow('编辑一级目录', "");
    });
    $('#addSecond').click(function () {
        modals.feedBackShow('编辑二级目录', "分");
    });
    $('#addThird').click(function () {
        modals.feedBackShow('编辑工作内容', "分");
    });
}

