<%-- 
    Document   : preview
    Created on : 2018-1-6, 18:35:47
    Author     : ankhyfw
--%>

<%@page import="star4.eval.service.UserService"%>
<%@page import="star4.eval.bean.DetailTable.ThirdIndicatorDe"%>
<%@page import="star4.eval.bean.DetailTable.SubTableDe"%>
<%@page import="star4.eval.bean.DetailTable"%>
<%@page import="star4.eval.service.EvalTableService"%>
<%@page import="star4.eval.bean.EvalTable.ThirdIndicator"%>
<%@page import="star4.eval.bean.EvalTable.SecondIndicator"%>
<%@page import="star4.eval.bean.EvalTable.Remark"%>
<%@page import="star4.eval.bean.EvalTable.SubTable"%>
<%@page import="java.util.List"%>
<%@page import="star4.eval.bean.EvalTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>preview</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/table.css">
        <!--<link rel="stylesheet" href="css/cursor.css">-->
        <script type="text/javascript" src="js/tools/jquery-1.12.2.min.js"></script>
        <!--<script type="text/javascript" src="js/tools/tableExport.js"></script>-->
        <!--<script type="text/javascript" src="js/tools/jquery.base64.js"></script>-->
        <!--<script type="text/javascript" src="js/jspdf/libs/sprintf.js"></script>-->
        <!--<script type="text/javascript" src="js/jspdf/libs/base64.js"></script>-->
        <!--<script type="text/javascript" src="js/tools/jquery.table2excel.js"></script>-->
        <!--<script type="text/javascript" src="js/tools/jquery.base64.ext.js"></script>-->
    </head>
    <body>

        <%
            String identity = (String) session.getAttribute("identity");

            EvalTableService service = new EvalTableService();
            //考核表
            EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
            //考核子表
            List<SubTable> evalTables = evalTable.getTables();
            //备注
            List<Remark> remarks = evalTable.getRemark();
            //工作量表
            List<String> effortTable = evalTable.getEffortTable();

            SubTable tab;
            DetailTable detailTable = (DetailTable) session.getAttribute("detailTable");
            if (identity.equals(UserService.COLLECTIONA)) {
                List<DetailTable> detailTables = (List<DetailTable>) session.getAttribute("detailTables");
                int index = Integer.parseInt((String) session.getAttribute("index"));
                detailTable = detailTables.get(index);
            }
            List<SubTableDe> scores = detailTable.getTables();
            List<String> effortDetail = detailTable.getEffortTable();
            SubTableDe score;

            String detailYear = detailTable.getAcademic_year();

        %>
        <main class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="tab-content">
                        <div class="tab-pane" style="display:inline;">
                            <table id="preview-table" border="1" cellspacing="0" cellpadding="0" style="border-color:#000;">
                                <caption> <Strong>杭州国际服务工程学院教师本科教学工作业绩考核评分表 ( <%=detailYear%> - <%=service.changeYear(detailYear)%> 年)</Strong>
                                    <button type="button" class="btn btn-success" onclick="tableToExcel('preview-table', 'name', 'myfile.xls')" style="float:right;">生成Excel</button>
                                    <div id="list-selected-name"><%=detailTable.getCardID()%>  <%=detailTable.getName()%></div>
                                </caption>

                                <tr class="tr-center">
                                    <td class="width_100">一级指标</td>
                                    <td class="width_100">二级指标</td>
                                    <td class="width_280">内涵</td>
                                    <td class="width_100">指标分值</td>
                                    <td class="width_100">教师自评分</td>
                                    <td>自评分依据</td>
                                    <td class="width_100">系部审核分</td> 
                                </tr>
                                <%
                                    SecondIndicator secondIndicator;
                                    ThirdIndicator thirdIndicator;
                                    ThirdIndicatorDe thirdDetail;
                                    for (int i = 0; i < evalTables.size(); i++) {
                                        tab = evalTables.get(i);
                                        score = scores.get(i);
                                %>
                                <tr>
                                    <td rowspan="2" class="width_100"> <!--一级指标-->
                                        <%=tab.first_indicator%>  <%=service.outputScore(tab)%>
                                    </td>
                                    <%
                                        for (int j = 0; j < tab.second_indicator.size(); j++) {
                                            secondIndicator = tab.second_indicator.get(j);

                                    %>
                                    <td class="width_100">
                                        <%=secondIndicator.title%> <%=secondIndicator.score%>分 <%=secondIndicator.remark%>
                                    </td>
                                    <td colspan="4">
                                        <table border="1" cellspacing="0" cellpadding="0" style="border-color:#000;">
                                            <%
                                                for (int z = 0; z < secondIndicator.third_indicator.size(); z++) {
                                                    thirdIndicator = secondIndicator.third_indicator.get(z);
                                                    thirdDetail = score.second_indicator.get(j).third_indicator.get(z);
                                            %>
                                            <tr class="hover">
                                                <td class="width_280"><%=thirdIndicator.content%></td>
                                                <td class="width_100"><%=thirdIndicator.score%></td>
                                                <td class="width_100"><%=thirdDetail.teacher_score%></td>
                                                <td><%=thirdDetail.proof%></td>
                                            </tr>
                                            <%
                                                }
                                            %>
                                        </table>
                                    </td>
                                    <td class="width_100" style="vertical-align: middle;">
                                        <%if (detailTable.isIs_audit()) {
                                        %>
                                        <%=score.second_indicator.get(j).auditor_score%>
                                        <%}%>
                                    </td>

                                </tr>
                                <%
                                    }
                                %>
                                <% if (i == 0) {
                                        int effortSize = effortTable.size();
                                %>
                                <tr>
                                    <td colspan="5">
                                        <table class="t_in_t" border="1" cellspacing="0" cellpadding="0" style="border-color:#000;">
                                            <tr class="tr-center">
                                                <%
                                                    for (int w = 0; w < effortSize; w++) {
                                                %>
                                                <td><%=effortTable.get(w)%></td>
                                                <%}%>
                                            </tr>
                                            <%
                                                for (int p = 0; p < effortDetail.size(); p++) {
                                            %>
                                            <tr>
                                                <%
                                                    String[] strSp = effortDetail.get(p).split(",");
                                                    for (int y = 0; y < effortSize; y++) {
                                                %>

                                                <td><%=strSp[y]%></td>
                                                <%}%>
                                            </tr>
                                            <%}%>

                                        </table>
                                    </td>
                                    <td class="width_100"></td>
                                </tr>

                                <%}
                                    }%>
                                <tr></tr>
                                <tr>
                                    <td colspan="3" style="text-align:center;"><strong>考核分合计</strong></td>
                                    <td class="width_100">/</td>
                                    <td class="width_100"><%=detailTable.getTeacher_total_sco()%></td>
                                    <td>/</td>
                                    <td class="width_100"><%=detailTable.getAuditor_total_sco()%></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><h5>学院审核分</h5></td>
                                    <td colspan="5"></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><strong>直接定级</strong></td>
                                    <td colspan="5">直接定为优秀（含免考核）或直接定为不合格依据：</td>
                                </tr>
                                <tr>
                                    <td colspan="2">直接定为优秀或不合格</td>
                                    <td colspan="5"></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><h5>系部负责人签名：</h5></td>
                                    <td colspan="5"></td>
                                </tr>
                            </table>
                            <h5>备注：</h5>
                            <dl class="dl-horizontal">
                                <%
                                    for (int i = 0; i < remarks.size(); i++) {
                                %>
                                <dt class="width_280"><%=remarks.get(i).keypoint%></dt>
                                <dd><%=remarks.get(i).content%></dd>
                                <%}%>
                            </dl>
                        </div>
                    </div>
                </div>
            </div>
        </main>

    </body>
</html>
