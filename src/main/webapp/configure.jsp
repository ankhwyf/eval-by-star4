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
            <%                String indexStr = (String) request.getParameter("index");
                if (indexStr == null || indexStr.length() == 0) {
                    indexStr = "0";
                }

                int index = Integer.parseInt(indexStr);
                
                EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
                List<SubTable> evalTables = evalTable.getTables();
                SubTable tab;
                SecondIndicator secondIndicator;
            %>

            <form action="process.do" method="post" onsubmit="submitAdvanced()">
                <input name="type" value="advanced" type="hidden" />
                <input name="firstIndex" value="<%=index%>" type="hidden" />
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
                                <table class="table table-bordered table-first">
                                    <%
                                        for (int i = 0; i < evalTables.size(); i++) {
                                            tab = evalTables.get(i);
                                    %>
                                    <tr class="hover-h <%= i == index ? "clicked" : ""%>">
                                        <td>
                                            <div class="pull-left first">
                                                <strong class="first-title" style="cursor: default;"><%=tab.first_indicator%></strong>
                                                <input class="first-title-input" type="hidden" name="first-title">
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
                                <table class="table table-bordered table-hover table-second">
                                    <%
                                        if (index < evalTables.size()) {
                                            tab = evalTables.get(index);
                                            List<SecondIndicator> secondIndicators = tab.second_indicator;

                                            for (int i = 0; i < secondIndicators.size(); i++) {
                                                secondIndicator = secondIndicators.get(i);
                                    %>
                                    <tr class="hover-h"><td>
                                            <div class="pull-left">
                                                <strong class="second-title"><%=secondIndicator.title%></strong>
                                                <input class="second-title-input" type="hidden" name="second-title">
                                                <span class="second-score"><%=secondIndicator.score%></span>分
                                                <input class="second-score-input" type="hidden" name="second-score">
                                                <textarea class="second-remark"style="display:none;"><%=secondIndicator.remark%></textarea>
                                                <input class="second-remark-input" type="hidden" name="second-remark">
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
                                <table class="table table-bordered table-hover table-third">
                                    <%
                                        List<String> effortTable = evalTable.getEffortTable();
                                        for (int i = 0; i < effortTable.size(); i++) {
                                    %>
                                    <tr class="hover-h"><td>
                                            <div class="pull-left">
                                                <strong class="third-effort"><%=effortTable.get(i)%></strong>
                                                <input class="third-effort-input" type="hidden" name="third-effort">
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

                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary" id="submit">保存并返回</button>
                </div>
            </form>
        </main>
        <footer>
            © 2018 <img src="img/heart.png" alt=""> 杭州师范大学
        </footer>
        <script>
            function submitAdvanced() {

                var firstTitles = document.getElementsByClassName('first-title');

                var firstTitleInput = document.getElementsByClassName('first-title-input');

                var secondTitles = document.getElementsByClassName('second-title');
                var scores = document.getElementsByClassName('second-score');
                var remarks = document.getElementsByClassName('second-remark');

                var secondTitleInput = document.getElementsByClassName('second-title-input');
                var scoreInput = document.getElementsByClassName('second-score-input');
                var remarkInput = document.getElementsByClassName('second-remark-input');

                var efforts = document.getElementsByClassName('third-effort');

                var effortInput = document.getElementsByClassName('third-effort-input');

                if (firstTitles === null || firstTitles.length === 0 || secondTitles === null || secondTitles.length === 0 || scores === null || scores.length === 0 || remarks === null || remarks.length === 0 || efforts === null || efforts.length === 0)
                    return false;

                console.log("firstTitles " + firstTitles.length);
                for (var i = 0; i < firstTitles.length; i++) {
                    firstTitleInput[i].value = firstTitles[i].innerHTML;
                    console.log(firstTitleInput[i].value);
                }

                console.log("secondTitles " + secondTitles.length);
                for (var i = 0; i < secondTitles.length; i++) {
                    secondTitleInput[i].value = secondTitles[i].innerHTML;
                    console.log("secondTitleInput:" + secondTitleInput[i].value);
                }

                console.log("scores " + scores.length);
                for (var i = 0; i < scores.length; i++) {
                    scoreInput[i].value = scores[i].innerHTML;
                    console.log(scoreInput[i].value);
                }

                console.log("remarks " + remarks.length);
                for (var i = 0; i < remarks.length; i++) {
                    remarkInput[i].value = remarks[i].value;
                    console.log(remarkInput[i].value);
                }

                console.log("efforts " + efforts.length);
                for (var i = 0; i < efforts.length; i++) {
                    effortInput[i].value = efforts[i].innerHTML;
                    console.log(effortInput[i].value);
                }

                return true;
            }

        </script>
    </body>
</html>
