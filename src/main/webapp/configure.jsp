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
        <script type="text/javascript" src="js/modals.js"></script>

    </head>
    <body>
        <main class="container">
            <div class="row title">
                <div class="col-md-7 smalltitle">
                    <img src="img/configure.png" alt="">
                    <strong>一二级指标配置</strong>
                </div>
                <div class="col-md-5 text-right back">
                    <a href="admin.jsp">返回>></a>
                </div>
            </div>

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
                        <%                            EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
                            List<SubTable> evalTables = evalTable.getTables();
                            SubTable tab1 = evalTables.get(0);
                            SubTable tab2 = evalTables.get(1);
                            SubTable tab3 = evalTables.get(2);
                            SubTable tab4 = evalTables.get(3);
                        %>
                        <div class="configure-content">
                            <table class="table table-bordered">
                                <tr><td>
                                        <div class="pull-left"><strong><%=tab1.first_indicator%></strong></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                                <tr><td>
                                        <div class="pull-left"><strong><%=tab2.first_indicator%></strong></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                                <tr><td>
                                        <div class="pull-left"><strong><%=tab3.first_indicator%></strong></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                                <tr><td>
                                        <div class="pull-left"><strong><%=tab4.first_indicator%></strong></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
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
                                <tr><td>
                                        <div class="pull-left"><strong>教学工作量</strong><span>30分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                                <tr><td>
                                        <div class="pull-left"><strong>教学常规</strong><span>40分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                                <tr><td>
                                        <div class="pull-left"><strong>教学建设</strong><span>30分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
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
                                <tr><td>
                                        <div class="pull-left"><strong>教学工作量</strong><span>30分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                                <tr><td>
                                        <div class="pull-left"><strong>教学常规</strong><span>40分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
                                <tr><td>
                                        <div class="pull-left"><strong>教学建设</strong><span>30分</span></div>
                                        <div class="pull-right">
                                            <i class="fa fa-edit"></i>
                                            <i class="fa fa-trash"></i>
                                        </div>
                                    </td></tr>
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
        <script type="text/javascript" src="js/configure.js"></script>
        <script>

// 鼠标悬停和离开

            $(".container .content .col-md-4 .configure table tr").hover(function () {
                $(this).css('background', '#f5f5f5');
                $(this).find('.pull-right').show();
            }, function () {
                $(this).css('background', '#ffffff');
                $(this).find('.pull-right').hide();
            })

            $(".container .content .col-md-4 .configure table tr .fa-trash").click(function () {
                console.log("1");
                $(this).parent().parent().remove();
            });

            $(".container .content .col-md-4 .configure table tr .fa-edit").click(function () {
                $(this).parent().parent().remove();
            });

            $('#addFirst').click(function () {
                modals.feedBackShow('添加一级目录', 0);
            });
            $('#addSecond').click(function () {
                modals.feedBackShow('添加二级目录',1);
            });
            $('#addThird').click(function () {
                modals.feedBackShow('添加工作内容',1);
            });
        </script>
    </body>

</html>
