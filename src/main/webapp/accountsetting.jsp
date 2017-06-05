<%-- 
    Document   : accountsetting
    Created on : 2017-6-4, 14:28:30
    Author     : ankhyfw
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="titleBar.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account settings</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/common.css">
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
                    <a href="teachingEffort_admin.jsp">返回>></a>
                </div>
            </div>

            <div class="row content">
                <div class="setting ">
                    <p><span>工号:</span><span><%=user.getCardID()%></span></p>
                    <p><span>姓名:</span><span><%=username%></span></p>
                    <p><span>邮箱:</span><span><%=user.getEmail()%>
                        </span><span>修改</span></p>
                    <p><span>密码:</span><span>*******</span><span>修改</span></p>
                </div>
            </div>

        </main>
    </body>
    <script type="text/javascript" src="js/jquery-1.12.2.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/echarts.min.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
</html>
