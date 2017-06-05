<%-- 
    Document   : teachingRoutine
    Created on : 2017-5-28, 18:54:16
    Author     : ankhyfw
--%>

<%@page import="star4.eval.bean.EvalTable.ThirdIndicator"%>
<%@page import="star4.eval.bean.EvalTable.SecondIndicator"%>
<%@page import="star4.eval.bean.EvalTable.Remark"%>
<%@page import="star4.eval.bean.EvalTable.SubTable"%>
<%@page import="java.util.List"%>
<%@page import="star4.eval.bean.EvalTable"%>
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
            function selectOption() {
                var value = $(".form-control").val();
                $("#endyear").text(parseInt(value) + 1);
                $("#submit").submit();
            }

        </script>
    </head>
    <body>
     
        <main class="container">
            <div class="row title">
                <div class="col-md-8">
                    <strong>杭州国际服务工程学院教师本科教学工作业绩考核评分表</strong>
                    <span>（</span>
                    <form method="post" action="getTable.do" id="submit">
                        <select class="form-control" onchange="selectOption()" name="year">
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
            <iframe src="table.jsp" frameborder="0" scrolling="auto" width="100%" height="330"></iframe>
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
