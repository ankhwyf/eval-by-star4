/**
 * Created by zz on 2017/4/25.
 */
function Modals() {}

// loading
Modals.prototype.loadingShow =function () {
    $(document.body).append("<div class='loading-backdrop'>"
        +"<div class='loading'><img src='img/loading.png'><p>请稍后...</p></div>"
        +"</div>");
};
Modals.prototype.loadingHide=function () {
    $('.loading-backdrop').remove();
};
// 小弹框 有确认一个按钮
Modals.prototype.alertSmShow =function (cont,fn) {
    var dom ="<div class='alert-sm-backdrop'>"
                +"<div class='alert-sm'>"
                +"<div class='alert-sm-body'>"+cont+"</div>"
                +"<div class='alert-sm-foot'>"
                +"<button id='btnAlertSmYes'>确定</button>"
                +"</div>"
                +"</div>"
            +"</div>";

    $(document.body).append(dom);
    $("#btnAlertSmYes").click(function () {
        if(fn){
            fn();
        }else {
            $('.alert-sm-backdrop').remove();
        }
    });
};
Modals.prototype.alertSmHide=function(){
    $('.alert-sm-backdrop').remove();
};

Modals.prototype.judge =function (cont,fn) {
    var dom ="<div class='alert-sm-backdrop'>"
                +"<div class='alert-sm'>"
                +"<div class='alert-sm-body'>"+cont+"</div>"
                +"<div class='alert-sm-foot'>"
                +"<button id='btnAlertSmNO'>取消</button>"
                +"<button id='btnAlertSmYes'>确定</button>"
                +"</div>"
                +"</div>"
            +"</div>";


    $(document.body).append(dom);
    $("#btnAlertSmYes").click(function () {
        if(fn){
            fn();
        }else {
            $('.alert-sm-backdrop').remove();
        }
    });
    $("#btnAlertSmNO").click(function () {
        if(fn){
            fn();
        }else {
            $('.alert-sm-backdrop').remove();
        }
    });
};
//问题反馈
Modals.prototype.feedBackShow =function (con,unit,fn) {
    var dom ="<div class='feed-back-backdrop'>"
                +"<div class='fb-cont'>"
                    +"<div class='fb-hd c-blue '><i class='fa fa-edit'></i>"+con+"</div>"
                    +" <button class='fb-xx' id='btnFbX'>X</button>"
                    +"<div class='line'>" 
                    +"<span>指标名称：</span>"
                    +"<input type='text' class='form-control' id='name'>"
                    +"</div>";
                    if(unit!=0) {
                  dom +="<div class='line'>" 
                    +"<span>指标分值：</span>"
                    +"<input type='text' class='form-control' id='grades'>"+"分"
                    +"</div>"
                }
                dom +="<div class='line'>" 
                    +"<span class='line-s'>指标说明：</span>"
                    +"<textarea class='fb-bd' placeholder='请输入您的指标说明' id='feedBackMsg'></textarea>"
                    +"</div>"
                    +"<button class='fb-ft' id='btnFeedBackPost'>保存</button>"
                +"</div>"
             +"</div>";

    $(document.body).append(dom);
    $("#btnFeedBackPost").click(function () {
        if(fn){
            fn();
        }else {
            var name=$('#name').val();
            if(unit!=0) {
                
            var grades=$('#grades').val();
        }
        else {
            grades="";
        }
            var feedBackMsg=$('#feedBackMsg').val();
            // return {'name':name,'grades':grades,'feedBackMsg':feedBackMsg};
            var bulidtpl='';
            bulidtpl+='<tr><td>';
            bulidtpl+='<div class="pull-left"><strong>'+name+'</strong><span>'+grades+'分</span></div>';
            bulidtpl+='<div class="pull-right">';
            bulidtpl+='<i class="fa fa-edit"></i><i class="fa fa-trash"></i>/div></td></tr>';

            $(".container .content .col-md-4 .configure table").eq(unit).append(bulidtpl);

            $('.feed-back-backdrop').remove();
        }
    });
    $("#btnFbX").click(function () {
        $('.feed-back-backdrop').remove();
    })
};
Modals.prototype.feedBackHide=function(){
    $('.feed-back-backdrop').remove();
};


var modals = new Modals();



/*删除特定cookie*/
function delCookie(name){
    var myDate=new Date();
    myDate.setTime(-1000);//设置时间
    document.cookie=name+"=''; expires="+myDate.toGMTString();
}
$("#reLogin").on("click",function () {
    delCookie("BZPFtoken");

    var url =  window.location.href.split("?")[0];
    window.location.href  = "http://account.startdt.com/login.html?service="+url;
});