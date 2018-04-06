<%@page import="star4.eval.service.UserService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="titleBar.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account settings</title>
        <link rel="stylesheet" href="css/accountsetting.css">
    </head>
    <body>

        <main class="container">
            <div class="row title">
                <div class="col-md-7 smalltitle">
                    <i class="fa fa-bar-chart"></i>
                    <strong>账户设置</strong>
                </div>
                <div class="col-md-5 text-right back">
                    <a href="\home">返回>></a>
                </div>
            </div>

            <div class="row content">
                <form action="">
                    <div class="setting ">
                        <p><span>工号:</span><span><%=user.getCardID()%></span></p>
                        <p><span>姓名:</span><span><%=username%></span></p>
                        <p><span>邮箱:</span><span><%=user.getEmail()%>
                            </span><span>修改</span></p>
                        <p><span>密码:</span><span>*******</span><span>修改</span></p>
                    </div>
                </form>
            </div>

        </main>
        <footer>
            © 2018 <img src="img/heart.png" alt=""> 杭州师范大学
        </footer>
    </body>
</html>
