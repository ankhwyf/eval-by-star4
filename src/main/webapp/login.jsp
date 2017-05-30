<%-- 
    Document   : login
    Created on : 2017-5-28, 18:12:12
    Author     : ankhyfw
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome!</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/login.css">
    </head>
    <body>
        <%
           if(session.getAttribute("user")!=null){
             response.sendRedirect("teachingEffort_admin.jsp");
           }
        %>
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">
                        <img alt="Brand" src="img/logo.png">
                    </a>
                    <span class="title">教师考核平台</span>
                </div>
            </div>
        </nav>
        <div class="main">
            <div class="notice">
                <div class="notice-title">
                    <img src="img/notice.png" alt="" class="notice-icon">
                    <span>公告</span>
                </div>
                <ul class="notice-content">
                    <li>
                        <span class="new">2016-2017年度第二学期本科教学工作考核将于06月18日开始。</span>
                        <span class="date">2017-06-01</span>
                    </li>
                    <li>
                        <span class="new">2016-2017年度第二学期本科教学工作考核将于06月18日开始。</span>
                        <span class="date">2017-06-01</span>
                    </li>
                    <li>
                        <span class="new">2016-2017年度第二学期本科教学工作考核将于06月18日开始。</span>
                        <span class="date">2017-06-01</span>
                    </li>
                </ul>
            </div>
            <form class="login" action="login.do" method="post">
                <c:if test="${loginError}">
                <div class="login-panel__msg input-msg">
                    <img src="img/error.png" alt="">
                    <span>登录名或登录密码不正确</span>
                </div>
                </c:if>
                <div class="form-group">
                    <label for="user" class="control-label">登录名:</label>
                    <input type="text" class="input-user form-control" id="user" placeholder="邮箱/工号" name="login_name">
                </div>
                <div class="form-group">
                    <label for="user" class="control-label">登录密码:</label>
                    <a class="login-panel__forget" href="forget.html">忘记登录密码？</a>
                    <input type="password" class="input-pass form-control" id="user" placeholder="登录密码" name="login_pwd">
                </div>
                <div class="radiomutiple">
                    <input type="radio" class="radio1"  name="radio_item"  value="管理员" checked="checked">
                    管理员
                    <input type="radio" class="radio1"  name="radio_item" value="审核员">
                    审核员
                    <input type="radio" class="radio1"  name="radio_item" value="教师">
                    教师
                </div>
                <div class="form-group">
                    <input type="submit" class="login-panel__submit input-submit  btn btn-primary" value="登录">
                </div>
            </form>
        </div>
        <div class="footer">
            © 2017 <img src="img/heart.png" alt=""> 杭州师范大学繁星四月小组
        </div>


    </body>
    <script type="text/javascript" src="js/jquery-1.12.2.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/login.js"></script>
</html>
