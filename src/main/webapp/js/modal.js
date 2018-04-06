
function Modals() {}

// loading
Modals.prototype.loadingShow = function () {
    $(document.body).append("<div class='loading-backdrop'>" + "<div class='loading'><img src='img/loading.png'><p>请稍后...</p></div>" + "</div>");
};
Modals.prototype.loadingHide = function () {
    $('.loading-backdrop').remove();
};
// 小弹框 有确认一个按钮
Modals.prototype.alertSmShow = function (cont, fn) {
    var dom = "<div class='alert-sm-backdrop'>" + "<div class='alert-sm'>" + "<div class='alert-sm-body'>" + cont + "</div>" + "<div class='alert-sm-foot'>" + "<button id='btnAlertSmYes'>确定</button>" + "</div>" + "</div>" + "</div>";

    $(document.body).append(dom);
    $("#btnAlertSmYes").click(function () {
        if (fn) {
            fn();
        } else {
            $('.alert-sm-backdrop').remove();
        }
    });
};
Modals.prototype.alertSmHide = function () {
    $('.alert-sm-backdrop').remove();
};

Modals.prototype.judge = function (cont, fn) {
    var dom = "<div class='alert-sm-backdrop'>" + "<div class='alert-sm'>" + "<div class='alert-sm-body'>" + cont + "</div>" + "<div class='alert-sm-foot'>" + "<button id='btnAlertSmNO'>取消</button>" + "<button id='btnAlertSmYes'>确定</button>" + "</div>" + "</div>" + "</div>";


    $(document.body).append(dom);
    $("#btnAlertSmYes").click(function () {
        if (fn) {
            fn();
        } else {
            $('.alert-sm-backdrop').remove();
        }
    });
    $("#btnAlertSmNO").click(function () {
        if (fn) {
            fn();
        } else {
            $('.alert-sm-backdrop').remove();
        }
    });
};
//添加
Modals.prototype.feedBackShow = function (con, unit, fn) {
    var dom = "<div class='feed-back-backdrop'>" +
            "<div class='fb-cont'>" +
            "<div class='fb-hd c-blue '><i class='fa fa-edit'></i>" + con +
            "</div>" +
            "<button class='fb-xx btnFbX' id='btnFbX'>X</button>" +
            "<div class='line'>" +
            "<span>指标名称：</span>" +
            "<input type='text' class='form-control name' id='name'>" +
            "</div>";
    if (unit === 1) {
        dom += "<div class='line'>" +
                "<span>指标分值：</span>" +
                "<input type='text' class='form-control grades' id='grades'>" + "分" +
                "</div>";
        dom += "<div class='line'>" +
                "<span class='line-s'>指标说明：</span>" +
                "<textarea class='fb-bd feedBackMsg form-control' rows='3' placeholder='请输入您的指标说明' id='feedBackMsg'></textarea>" +
                "</div>";
    }

    dom += "<button class='fb-ft btnFeedBackPost' id='btnFeedBackPost'>保存</button>" + "</div>" + "</div>";

    $(document.body).append(dom);

    $("#btnFeedBackPost").click(function () {
        if (fn) {
            fn();
        } else {
            var name = "无",
                    grades = "0",
                    feedBackMsg = "";
            name = $('#name').val();
            if (unit === 1) {
                grades = $('#grades').val();
                feedBackMsg = $('#feedBackMsg').val();
            }
            console.log("name:"+name);
            console.log("grades:"+grades);
            console.log("feedBackMsg:"+feedBackMsg); 
        }
        var bulidtpl = '';
        bulidtpl += '<tr class="hover-h"><td>';
        if (unit !== 1) {
            bulidtpl += '<div class="pull-left"><strong>' + name + '</strong></div>';
        } else {
            bulidtpl += '<div class="pull-left"><strong>' + name + '</strong><span>'+ grades + '</span>' + '分' + '<textarea style="display:none;">' + feedBackMsg + '</textarea></div>';
        }

        bulidtpl += '<div class="pull-right">';
        bulidtpl += '<i class="fa fa-edit"></i><i class="fa fa-trash"></i></div></td></tr>';

        $('.container .content .col-md-4 .configure table').eq(unit).append(bulidtpl);

        $('.container .content .col-md-4 .configure table tr').bind({
            mouseenter: function () {
                $(this).css('background', '#f5f5f5');
                $(this).find('.pull-right').show();
            },
            mouseleave: function () {
                $(this).css('background', '#ffffff');
                $(this).find('.pull-right').hide();
            }
        });
        $('.container .content .col-md-4 .configure table tr .fa-trash').bind('click', function () {
            $(this).parent().parent().parent().remove();
        });
        $(".container .content .col-md-4 .configure table tr .fa-edit").bind('click', function () {
            var content = $(this).parent().parent().parent().parent().parent().parent().parent().find('.theme').find('span').html();
            var index = $(this).parent().parent().parent().index();
            if (content === "一级指标") {
                modals.feedBackModify('编辑一级目录', 0, index);
            } else if (content === "二级指标") {
                modals.feedBackModify('编辑二级目录', 1, index);
            } else if (content === "工作内容") {
                modals.feedBackModify('编辑工作内容', 2, index);
            }
        });
        $(".btnFbX").bind('click', function () {
            $('.feed-back-backdrop').remove();
        });

        $('.feed-back-backdrop').remove();
        

    });


    $(".btnFbX").click(function () {
        $('.feed-back-backdrop').remove();
    });
};

//修改
Modals.prototype.feedBackModify = function (con, unit, index, fn) {
    var name = $(".container .content .col-md-4 .configure table").eq(unit).find('tr').eq(index).find('strong').html();
    var grades = $(".container .content .col-md-4 .configure table").eq(unit).find('tr').eq(index).find('span').html();
    var feedBackMsg = $('.container .content .col-md-4 .configure table').eq(unit).find('tr').eq(index).find('textarea').val();
    
    var dom = "<div class='feed-back-backdrop'>" + 
                "<div class='fb-cont'>" + 
                    "<div class='fb-hd c-blue '><i class='fa fa-edit'></i>" + con + "</div>" + 
                    " <button class='fb-xx btnFbX' id='btnFbX'>X</button>" + 
                        "<div class='line'>" + 
                        "<span>指标名称：</span>" + 
                        "<input type='text' class='form-control name' id='name' value=" + name + ">" + 
                        "</div>";

    if (unit === 1) {
        dom += "<div class='line'>" + "<span>指标分值：</span>" + "<input type='text' class='form-control grades' id='grades' value='"+ grades +"'>" + "分</div>";
        dom += "<div class='line'>" + "<span class='line-s'>指标说明：</span>" + "<textarea class='fb-bd feedBackMsg' placeholder='请输入您的指标说明' id='feedBackMsg'>" +feedBackMsg+ "</textarea>" + "</div>";
    }
    dom+="<button class='fb-ft btnFeedBackPost' id='btnFeedBackPost'>保存</button>" + "</div>" + "</div>";
    
    $(document.body).append(dom);
    
    $("#btnFeedBackPost").click(function () {
        if (fn) {
            fn();
        } else {
             var name = "无",
                    grades = "0",
                    feedBackMsg = "";
            name = $('#name').val();
            
            $(".container .content .col-md-4 .configure table tr").eq(index).find('strong').text(name);
            if (unit === 1) {
                grades = $('#grades').val();
                feedBackMsg = $('#feedBackMsg').val();
                
                $(".container .content .col-md-4 .configure table tr").eq(index).find('span').text(grades);
                $(".container .content .col-md-4 .configure table tr").eq(index).find('textarea').text(feedBackMsg);
            }
            
            console.log("nameupdate111:"+name);
            console.log("gradesupdate111:"+grades);
            console.log("feedBackMsgupdate111:"+feedBackMsg);
            
        }
        
         $(".btnFbX").bind('click', function () {
            $('.feed-back-backdrop').remove();
        });

        $('.feed-back-backdrop').remove();

    });
    $(".btnFbX").click(function () {
        $('.feed-back-backdrop').remove();
    });
};
Modals.prototype.feedBackHide = function () {
    $('#feed-back-backdrop').remove();
};


var modals = new Modals();



/*删除特定cookie*/
function delCookie(name) {
    var myDate = new Date();
    myDate.setTime(-1000); //设置时间
    document.cookie = name + "=''; expires=" + myDate.toGMTString();
}
$("#reLogin").on("click", function () {
    delCookie("BZPFtoken");

    var url = window.location.href.split("?")[0];
    window.location.href = "http://account.startdt.com/login.html?service=" + url;
});
