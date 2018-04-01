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
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/common.css">
        <link rel="stylesheet" href="css/modals.css">
        <link rel="stylesheet" href="css/configure.css">
        <script type="text/javascript" src="js/jquery-1.12.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/common.js"></script>
        <script type="text/javascript" src="js/modal.js"></script>

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
            
            <div class="row content">
                <div class="col-md-4">
                    <div class="configure">
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
                                    for (int i = 0; i < evalTables.size(); i++) {
                                        tab = evalTables.get(i);
                                %>
                                <tr><td>
                                        <div class="pull-left">
                                            <strong><%=tab.first_indicator%></strong>
                                        </div>
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
                                    tab = evalTables.get(0);
                                    List<SecondIndicator> secondIndicators=tab.second_indicator;
                                    
                                 for(int i=0;i<secondIndicators.size();i++){
                                    secondIndicator=secondIndicators.get(i);
                                %>
                                <tr><td>
                                        <div class="pull-left"><strong><%=secondIndicator.title%></strong><span><%=secondIndicator.score%>分</span></div>
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
                                  List<String> effortTable=evalTable.getEffortTable();
                                  for(int i=0;i<effortTable.size();i++){
                                %>
                                 <tr><td>
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
                <button type="button" class="btn btn-primary" id="submit">保存并返回</button>
            </div>


        </main>

        <!-- <div class="configure">
                
        </div> -->
        <script type="text/javascript" src="js/configure_new.js"></script>
    </body>

</html>
