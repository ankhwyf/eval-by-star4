<%@page import="star4.eval.bean.EvalTable.SecondIndicator"%>
<%@page import="star4.eval.bean.EvalTable.SubTable"%>
<%@page import="java.util.List"%>
<%@page import="star4.eval.bean.EvalTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="titleBar.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>configure</title>
        <link rel="stylesheet" href="css/configure.css">
        <script type="text/javascript" src="js/configure.js"></script> 
    </head>

    <body>
        <main class="container">
            <div class="row title">
                <div class="col-md-7 smalltitle">
                    <img src="img/configure.png" alt="">
                    <strong>一二级指标配置</strong>
                </div>
                <div class="col-md-5 text-right back">
                    <a href="home">返回>></a>
                </div>
            </div>
            <%  EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
                List<SubTable> evalTables = evalTable.getTables();
                SubTable tab;
                SecondIndicator secondIndicator;
            %>

            <form action="process.do" method="post" onsubmit="submitCfig()" id="configureFrm" name="configureFrm">
                <div class="row content">
                    <div class="col-md-4">
                        <div class="configure">
                            <input name="type" value="advanced" style="display:none" />
                            <div class="theme text-left">
                                <img src="img/v1.png" alt="">
                                <span>一级指标</span>
                                <div class="pull-right">
                                    <i class="fa fa-plus" id="addFirst"></i>
                                </div>
                            </div>

                            <div class="configure-content">
                                <table class="table table-bordered">

                                    <%
                                        String index = (String) request.getParameter("test");
                                        int temp = 0;
                                        System.out.println("index" + index);
                                        if (index == null || index.length() == 0) {
                                            index = "0";
                                        }
                                        temp = Integer.parseInt(index);
                                        System.out.println("temp" + temp);

                                        for (int i = 0; i < evalTables.size(); i++) {
                                            tab = evalTables.get(i);
                                    %>
                                    <tr class="hover-h">
                                        <!--<input type="hidden" name="test" id="test" value="" onclick="trIndex()">-->
                                        <td>
                                            <div class="pull-left">
                                                <strong><%=tab.first_indicator%></strong>
                                            </div>
                                            <div class="pull-right">
                                                <i class="fa fa-edit"></i>
                                                <i class="fa fa-trash"></i>
                                            </div>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="configure">
                            <div class="theme text-left">
                                <img src="img/v2.png" alt="">
                                <span>二级指标</span>
                                <div class="pull-right">
                                    <i class="fa fa-plus" id="addSecond"></i>
                                </div>
                            </div>

                            <div class="configure-content">
                                <table class="table table-bordered table-hover">
                                    <%
                                        if (temp <= evalTables.size()) {
                                            tab = evalTables.get(temp);
                                            List<SecondIndicator> secondIndicators = tab.second_indicator;

                                            for (int i = 0; i < secondIndicators.size(); i++) {
                                                secondIndicator = secondIndicators.get(i);
                                    %>
                                    <tr class="hover-h"><td>
                                            <div class="pull-left">
                                                <strong><%=secondIndicator.title%></strong>
                                                <span><%=secondIndicator.score%></span>分
                                                <textarea style="display:none;"><%=secondIndicator.remark%></textarea>
                                            </div>
                                            <div class="pull-right">
                                                <i class="fa fa-edit"></i>
                                                <i class="fa fa-trash"></i>
                                            </div>
                                        </td></tr>
                                        <%
                                                }
                                            }
                                        %>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="configure">
                            <div class="theme text-left">
                                <img src="img/workcotent.png" alt="">
                                <span>工作内容</span>
                                <div class="pull-right">
                                    <i class="fa fa-plus" id="addThird"></i>
                                </div>
                            </div>

                            <div class="configure-content">
                                <table class="table table-bordered table-hover">
                                    <%
                                        List<String> effortTable = evalTable.getEffortTable();
                                        for (int i = 0; i < effortTable.size(); i++) {
                                    %>
                                    <tr class="hover-h"><td>
                                            <div class="pull-left"><strong><%=effortTable.get(i)%></strong></div>
                                            <div class="pull-right">
                                                <i class="fa fa-edit"></i>
                                                <i class="fa fa-trash"></i>
                                            </div>
                                        </td></tr>
                                        <%
                                            }
                                        %>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-primary" id="submit">保存并返回</button>
                </div>
            </form>
        </main>
        <footer>
            © 2018 <img src="img/heart.png" alt=""> 杭州师范大学
        </footer>
    </body>
</html>
