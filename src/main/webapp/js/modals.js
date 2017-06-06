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


//问题反馈
Modals.prototype.feedBackShow =function (fn) {
    var dom ="<div class='feed-back-backdrop'>"
                +"<div class='fb-cont'>"
                    +"<div class='fb-hd c-blue '>数据需求反馈</div>"
                    +" <button class='fb-xx' id='btnFbX'>X</button>"
                    +"<textarea class='fb-bd' placeholder='请输入您的数据需求' id='feedBackMsg'></textarea>"
                    +"<button class='fb-ft' id='btnFeedBackPost'>提交</button>"
                +"</div>"
             +"</div>";

    $(document.body).append(dom);
    $("#btnFeedBackPost").click(function () {
        if(fn){
            fn();
        }else {
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