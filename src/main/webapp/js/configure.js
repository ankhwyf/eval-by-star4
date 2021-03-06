$(document).ready(function () {
    // 鼠标悬停和离开
    $(".container .content .col-md-4 .configure table tr").hover(function () {
//        $(this).css('background', '#f5f5f5');
        $(this).find('.pull-right').show();
    }, function () {
//        $(this).css('background', '#ffffff');
        $(this).find('.pull-right').hide();
    });

    $('.first').click(function () {
        // 获取点击的行中的数据
        window.location = "configure.jsp?index=" + $(this).parent().parent().index();
    });

    //删除一行
    $(".container .content .col-md-4 .configure table tr .fa-trash").click(function () {
        $(this).parent().parent().parent().remove();
    });

    //编辑
    $(".container .content .col-md-4 .configure table tr .fa-edit").click(function () {
        var content = $(this).parent().parent().parent().parent().parent().parent().parent().parent().find('.theme').find('span').html();
        var index = $(this).parent().parent().parent().index();
        if (content === "一级指标") {
            modals.feedBackModify('编辑一级目录', 0, index);
        } else if (content === "二级指标") {
            modals.feedBackModify('编辑二级目录', 1, index);
        } else if (content === "工作内容") {
            modals.feedBackModify('编辑工作内容', 2, index);
        }

    });

    $('#addFirst').click(function () {
        modals.feedBackShow('添加一级目录', 0);
    });
    $('#addSecond').click(function () {
        modals.feedBackShow('添加二级目录', 1);
    });
    $('#addThird').click(function () {
        modals.feedBackShow('添加工作内容', 2);
    });

});

