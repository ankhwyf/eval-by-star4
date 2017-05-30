<%-- 
    Document   : teachingRoutine
    Created on : 2017-5-28, 18:54:16
    Author     : ankhyfw
--%>

<%@page import="star4.eval.bean.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="titleBar.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>admin</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/common.css">
        <link rel="stylesheet" href="css/teachingRoutine.css">
        <script type="text/javascript">
            function selectOption(){
            var value= $(".form-control").val();
            $("#endyear").text(parseInt(value)+1);
            }
            
        </script>
    </head>
    <body>
        <main class="container">
            <div class="row title">
                <div class="col-md-8">
                    <strong>杭州国际服务工程学院教师本科教学工作业绩考核评分表</strong>
                    <span>（</span>
                    <form>
                        <select class="form-control" onchange="selectOption()">
                            <option value="2012">2012</option>
                            <option value="2013">2013</option>
                            <option value="2014">2014</option>
                            <option value="2015">2015</option>
                            <option value="2016" selected>2016</option>
                        </select>
                    </form>
                    -<span id="endyear">2017</span> 学年）
                </div>
                <div class="col-md-4 text-right operation">
                    <a href="configure.html">
                        <i class="fa fa-cog fa-spin" style="font-size: 18px"></i>
                        <span>其他高级配置</span>
                    </a>
                </div>
            </div>

            <div class="row content">
                <div class="col-md-7 show">
                    <div class="tabbable"> <!-- Only required for left/right tabs -->
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab1" data-toggle="tab">教学工作量</a></li>
                            <li><a href="#tab2" data-toggle="tab">教学常规</a></li>
                            <li><a href="#tab3" data-toggle="tab">教学建设</a></li>
                            <li><a href="#tab4" data-toggle="tab">其他</a></li>
                            <li><a href="#tab5" data-toggle="tab">备注</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-5 text-right operation">
                    <a href="#">
                        <i class="fa fa-rocket" style="font-size: 18px"></i>
                        <span>发布</span>
                    </a>
                    <a href="statistics.html">
                        <i class="fa fa-bar-chart" style="font-size: 18px"></i>
                        <span>统计</span>
                    </a>
                    <a href="#">
                        <i class="fa fa-file-text-o" style="font-size: 18px"></i>
                        <span>预览表格</span>
                    </a>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab1">
                            <p>I'm in Section 1.</p>
                        </div>
                        <div class="tab-pane" id="tab2">
                            <p>Howdy, I'm in Section 2.</p>
                        </div>
                        <div class="tab-pane" id="tab3">
                            <p>Howdy, I'm in Section 3.</p>
                        </div>
                        <div class="tab-pane" id="tab4">
                            <p>Howdy, I'm in Section 4.</p>
                        </div>
                        <div class="tab-pane" id="tab5">
                            <p>Howdy, I'm in Section 5.</p>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <footer>
            © 2017 <img src="img/heart.png" alt=""> 杭州师范大学繁星四月小组
        </footer>
        <!-- 
<iframe src="wenzhang_xinwen.html" id="Mainindex" name="Mainindex" width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0"></iframe> -->
        <!-- 内置浏览器 -->
    </body>
    <script type="text/javascript" src="js/jquery-1.12.2.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
</html>
