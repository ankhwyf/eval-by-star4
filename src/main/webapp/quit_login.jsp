<%-- 
    Document   : quit_login
    Created on : 2017-5-28, 19:30:36
    Author     : ankhyfw
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="login.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome!</title>
    </head>
    <body>
       <%
          session.removeAttribute("user");
          session.invalidate();
          out.print("<script>alert('退出成功！');</script>");
       %>
      
    </body>
</html>
