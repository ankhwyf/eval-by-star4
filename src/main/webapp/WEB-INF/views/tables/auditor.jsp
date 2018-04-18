
<%@page import="star4.eval.bean.DetailTable.ThirdIndicatorDe"%>
<%@page import="star4.eval.bean.DetailTable.SubTableDe"%>
<%@page import="star4.eval.service.EvalTableService"%>
<%@page import="star4.eval.service.UserService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="star4.eval.bean.DetailTable"%>
<%@page import="star4.eval.service.DetailService"%>
<%@page import="star4.eval.bean.EvalTable.ThirdIndicator"%>
<%@page import="star4.eval.bean.EvalTable.SecondIndicator"%>
<%@page import="star4.eval.bean.EvalTable.Remark"%>
<%@page import="star4.eval.bean.EvalTable.SubTable"%>
<%@page import="java.util.List"%>
<%@page import="star4.eval.bean.EvalTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/titleBar.jspf"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/auditor.css">
        <script type="text/javascript" src="js/auditor.js"></script>
    </head>
    <body>
        <main class="container"> <%            String[] yearsDetail = (String[]) session.getAttribute("yearsDetail");
            String yearDetail = (String) session.getAttribute("yearDetail");
            EvalTableService service = new EvalTableService();
            int y = 0;
            %>
            <div class="row title">
                <div class="col-md-8">
                    <strong>杭州国际服务工程学院教师本科教学工作业绩考核评分表</strong> （
                    <form method="post" action="getTable.do" id="submit-auditor">
                        <select class="form-control" name="yearDetail" id="select-auditor-year">
                            <%
                                for (y = yearsDetail.length - 1; y >= 0; y--) {

                            %>
                            <option value="<%=yearsDetail[y]%>" <%= yearsDetail[y].equals(yearDetail) ? "selected" : ""%> ><%=yearsDetail[y]%></option>
                            <%
                                }
                            %>

                        </select>
                    </form>
                    -<span id="endyear-auditor"><%=service.changeYear(yearDetail)%></span> 学年）
                </div>
            </div>
            <div class="row">
                <div class="col-md-1 auditor-formate">
                    <ul class="auditor list-unstyled" id="list-teacher">
                        <%
                            String indexStr = (String) session.getAttribute("index");

                            int index = Integer.parseInt(indexStr);

                           
                            List<DetailTable> detailTables = (List<DetailTable>) session.getAttribute("detailTables");
                            DetailTable detailTemp;

                            for (int i = 0; i < detailTables.size(); i++) {
                                detailTemp = detailTables.get(i);
                        %>
                        <li class="list-teacher <%= i == index ? "clicked" : ""%> <%= detailTemp.isIs_audit() ? "is-audit" : "is-noaudit"%>" data-toggle="tooltip" title="<%= detailTemp.isIs_audit()?"已审核":"未审核"%>" ><%=detailTemp.getName()%></li>
                            <%
                                }
                            %>

                    </ul>
                </div>
                <div class="col-md-11">

                    <%
                        String success = (String) session.getAttribute("success");
                        if (success != null && success.length() != 0) {
                            session.removeAttribute("success");
                        }
                        //考核表
                        EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
                        //考核子表
                        List<SubTable> evalTables = evalTable.getTables();
                        //备注
                        List<Remark> remarks = evalTable.getRemark();
                        //工作量表
                        List<String> effortTable = evalTable.getEffortTable();

                        DetailTable detailTable = detailTables.get(index);

                        List<SubTableDe> scores = detailTable.getTables();
                        List<String> effortDetail = detailTable.getEffortTable();

                        SubTable tab;
                        SubTableDe score;
                    %>

                    <div class="row content">
                        <div class="col-md-7 show">
                            <div class="tabbable">
                                <!-- Only required for left/right tabs -->
                                <ul class="nav nav-tabs">
                                    <%
                                        int i = 0;
                                        for (i = 0; i < evalTables.size(); i++) {
                                            tab = evalTables.get(i);
                                    %>
                                    <li><a href="#tab<%=i%>" data-toggle="tab"><%=tab.first_indicator%></a></li>
                                        <%
                                            }
                                        %>
                                    <li><a href="#tab<%=i%>" data-toggle="tab">工作量</a></li>
                                        <%
                                            i = i + 1;
                                        %>
                                    <li class=""><a href="#tab<%=i%>" data-toggle="tab">备注</a></li>
                                </ul>
                            </div>
                        </div>

                        <div class="col-md-5 text-right operation">
                            <a href="processAudit.do" id="submit-audit"> <i class="fa fa-send"
                                                                            style="font-size: 18px"></i> <span>提交</span>
                            </a> <a href="checkMaterial.jsp"> <i class="fa fa-upload"
                                                                      style="font-size: 18px"></i> <span>佐证材料</span>
                            </a> <a href="previewTeacher.jsp"> <i class="fa fa-file-text-o"
                                                                  style="font-size: 18px"></i> <span>预览表格</span>
                            </a>
                        </div>
                        <div id="select-name">
                            <%=detailTable.getCardID()%>  <%=detailTable.getName()%>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="tab-content" style="height: auto; min-height: 100px">

                                <%
                                    SecondIndicator secondIndicator;
                                    ThirdIndicator thirdIndicator;
                                    ThirdIndicatorDe thirdDetail;
                                    for (i = 0; i < evalTables.size(); i++) {
                                        tab = evalTables.get(i);
                                        score = scores.get(i);
                                        int l = tab.second_indicator.size();
                                %>
                                <div class="tab-pane" id="tab<%=i%>">
                                    <div id="table-<%=i%>">
                                        <form action="processAudit.do" method="post" onsubmit="sumbitAuditorSub(<%=i%>,<%=l%>)">
                                            <input name="type" value="detail-<%=i%>" type="hidden">
                                            <input name="length" value="<%=l%>" type="hidden">
                                            <table border="1" cellspacing="0" cellpadding="0">
                                                <tr class="tr-center">
                                                    <td class="width_100">一级指标</td>
                                                    <td class="width_100">二级指标</td>
                                                    <td class="width_280">内涵</td>
                                                    <td class="width_50">指标分值</td>
                                                    <td class="width_50">教师自评分</td>
                                                    <td class="width_300">自评分依据</td>
                                                    <td class="width_100">系部审核分</td>
                                                </tr>
                                                <tr>
                                                    <td rowspan="<%=l%>" class="width_100">
                                                        <!--一级指标--> <%=tab.first_indicator%> <%=service.outputScore(tab)%>
                                                    </td>
                                                    <%
                                                        for (int j = 0; j < l; j++) {
                                                            secondIndicator = tab.second_indicator.get(j);
                                                    %>
                                                    <td class="width_100">
                                                        <!--二级指标-->
                                                        <div class="width_100">
                                                            <%=secondIndicator.title%>
                                                            <%=secondIndicator.score%>分
                                                            <%=secondIndicator.remark%>
                                                        </div>
                                                    </td>
                                                    <td colspan="4">
                                                        <table id="<%=i%>-<%=j%>-basic" border="1" cellspacing="0"
                                                               cellpadding="0">
                                                            <%
                                                                for (int z = 0; z < secondIndicator.third_indicator.size(); z++) {

                                                                    thirdIndicator = secondIndicator.third_indicator.get(z);
                                                                    thirdDetail = score.second_indicator.get(j).third_indicator.get(z);
                                                            %>
                                                            <tr class="hover">
                                                                <td class="width_280">
                                                                    <!--内涵--> <%=z + 1%>. <%=thirdIndicator.content%>
                                                                </td>
                                                                <td class="width_50">
                                                                    <!--指标分值--> <%=thirdIndicator.score%>
                                                                </td>
                                                                <td class="width_50" style="font-weight: bold;">
                                                                    <!--教师自评分--> 
                                                                    <%=thirdDetail.teacher_score%>
                                                                </td>
                                                                <td class="width_300">
                                                                    <!--依据--> 
                                                                    <%=thirdDetail.proof%>
                                                                </td>
                                                            </tr>
                                                            <%
                                                                }
                                                            %>
                                                        </table>
                                                    </td>
                                                    <td>
                                                        <div class="textarea <%=i%>-<%=j%>-score" contenteditable="true"
                                                             style="height: 100%; width: 100%;font-size: 15px;">
                                                            <%=score.second_indicator.get(j).auditor_score%>
                                                        </div> <input class="<%=i%>-<%=j%>-score-input" name="content-<%=j%>"
                                                                      type="hidden" />
                                                    </td>
                                                    <!--审核分-->

                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </table>
                                            <input type="submit" class="btn btn-primary float-right save-btn"
                                                   value="保存">
                                        </form>
                                    </div>
                                </div>
                                <%
                                    }
                                %>

                                <!--<工作量>-->
                                <div class="tab-pane" id="tab<%=i%>">
                                    <table border="1" cellspacing="0" cellpadding="0">
                                        <tr class="tr-center">
                                            <%
                                                int effortSize = effortTable.size();
                                                for (int j = 0; j < effortSize; j++) {
                                            %>
                                            <td><%=effortTable.get(j)%></td>
                                            <%
                                                }
                                            %>
                                        </tr>

                                        <%
                                            for (int j = 0; j < effortDetail.size(); j++) {
                                        %>
                                        <tr class="hover">
                                            <%
                                                String[] strSp = effortDetail.get(j).split(",");
                                                for (int z = 0; z < effortSize && z < strSp.length; z++) {
                                            %>
                                            <td><%=strSp[z]%></td>
                                            <%
                                                }
                                            %>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </table>
                                </div>

                                <%
                                    i = i + 1;
                                %>
                                <!--<备注>-->
                                <div class="tab-pane" id="tab<%=i%>">
                                    <i class="fa fa-flag blue"></i> <span class="message">备注信息</span>
                                    <table class="remark-table" border="1" cellspacing="0"
                                           cellpadding="0">
                                        <tr class="tr-center">
                                            <td>备注项</td>
                                            <td class="width_400">备注说明</td>
                                        </tr>
                                        <%
                                            for (int j = 0; j < remarks.size(); j++) {
                                                Remark remark = remarks.get(j);
                                        %>
                                        <tr class="hover">
                                            <td><%=remark.keypoint%></td>
                                            <td><%=remark.content%></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </table>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <footer>
            © 2018 <img src="img/heart.png" alt=""> 杭州师范大学
        </footer>
        <!-- 
        <!-- 内置浏览器 -->
        <script type="text/javascript">
            $('.list-teacher').click(function () {
                $('.list-teacher').css('background', '#fff');
                $(this).css('background', '#eee');
                // 获取点击的行中的数据
                window.location = "home?index=" + $(this).index();
            });

            $('.list-teacher').hover(function () {
                orgBgColor = $(this).css("background-color");
                $(this).css('background-color', '#f5f5f5');
            }, function () {
                $(this).css('background-color', orgBgColor);
            });
            var m = '<%=success%>';
            if (m === 'true') {
                modals.alertSmShow("提交成功！");
            }
            $('#submit-audit').click(function () {
                modals.loadingShow();
            });

        </script>
    </body>

</html>
