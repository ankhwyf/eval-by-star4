
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
<%@include file="/titleBar.jspf"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/teacher.css">
        <script type="text/javascript" src="js/teacher.js"></script>
    </head>
    <body>

        <main class="container">
            <%                String success = (String) session.getAttribute("success");
             if(success != null && success.length() != 0){
                 session.removeAttribute("success");
             }
             System.out.println("success`2:" + success);
                String[] yearsTeacher = (String[]) session.getAttribute("yearsTeacher");
                String yearTeacher = (String) session.getAttribute("yearTeacher");
                System.out.println("yearTeacherfromteacher.jsp:" + yearTeacher);
                EvalTableService service = new EvalTableService();
                int y = 0;
            %>
            <div class="row title">
                <div class="col-md-8">
                    <strong>杭州国际服务工程学院教师本科教学工作业绩考核评分表</strong>
                    （
                    <form method="post" action="getTable.do" id="submit-teacher">
                        <select class="form-control" name="yearTeacher" id="select-teacher-year">
                            <%
                                for (y = yearsTeacher.length - 1; y >= 0; y--) {
                                   %>
                            <option value="<%=yearsTeacher[y]%>" <%= yearsTeacher[y].equals(yearTeacher)?"selected":"" %> ><%=yearsTeacher[y]%></option>
                            <%
                                }
                            %>
                        </select>
                    </form>
                    -<span id="endyear-teacher"><%=service.changeYear(yearTeacher)%></span> 学年）
                </div>
            </div>      

            <%
                
                //考核表
                EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
                //考核子表
                List<SubTable> evalTables = evalTable.getTables();
                //备注
                List<Remark> remarks = evalTable.getRemark();
                //工作量表
                List<String> effortTable = evalTable.getEffortTable();

                DetailTable detailTable = (DetailTable) session.getAttribute("detailTable");
                List<SubTableDe> scores = detailTable.getTables();
                List<String> effortDetail = detailTable.getEffortTable();

                SubTable tab;
                SubTableDe score;
            %>
            <div class="row content">
                <div class="col-md-7 show">
                    <div class="tabbable"> <!-- Only required for left/right tabs -->
                        <ul class="nav nav-tabs">
                            <%                                int i = 0;
                                for (i = 0; i < evalTables.size(); i++) {
                                    tab = evalTables.get(i);
                            %>
                            <li><a href="#tab<%=i%>" data-toggle="tab"><%=tab.first_indicator%></a></li>
                                <%}%>
                            <li><a href="#tab<%=i%>" data-toggle="tab">工作量</a></li>
                                <%i = i + 1;%>
                            <li class=""><a href="#tab<%=i%>" data-toggle="tab">备注</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-5 text-right operation">
                    <a href="processDetail.do" id="submit-table">
                        <i class="fa fa-send" style="font-size: 18px"></i>
                        <span>提交</span>
                    </a>
                    <a href="supportingMaterial.jsp">
                        <i class="fa fa-upload" style="font-size: 18px"></i>
                        <span>上传材料</span>
                    </a>
                    <a href="previewTeacher.jsp">
                        <i class="fa fa-file-text-o" style="font-size: 18px"></i>
                        <span>预览表格</span>
                    </a>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tab-content" style="height:auto;min-height:100px">

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
                                <form action="processDetail.do" method="post" onsubmit="submitDetail(<%=i%>,<%=l%>)">
                                    <input name="type" value="detail-<%=i%>" type="hidden">
                                    <input name="length" value="<%=l%>" type="hidden">
                                    <table border="1" cellspacing="0" cellpadding="0" >
                                        <tr class="tr-center">
                                            <td class="width_100">一级指标</td>
                                            <td class="width_100">二级指标</td>
                                            <td class="width_280">内涵</td>
                                            <td class="width_100">指标分值</td>
                                            <td class="width_100">教师自评分</td>
                                            <td>自评分依据</td>
                                            <td class="width_100">系部审核分</td> 
                                        </tr>
                                        <tr>
                                            <td rowspan="<%=l%>" class="width_100"> <!--一级指标-->
                                                <%=tab.first_indicator%>  <%=service.outputScore(tab)%>
                                            </td>
                                            <%
                                                for (int j = 0; j < l; j++) {
                                                    secondIndicator = tab.second_indicator.get(j);
                                            %>
                                            <td class="width_100"> <!--二级指标-->
                                                <div class="width_100">
                                                    <%=secondIndicator.title%> <%=secondIndicator.score%>分 <%=secondIndicator.remark%>
                                                </div>
                                            </td>
                                            <td colspan="4">
                                                <table id="<%=i%>-<%=j%>-basic" border="1" cellspacing="0" cellpadding="0">
                                                    <%
                                                        for (int z = 0; z < secondIndicator.third_indicator.size(); z++) {

                                                            thirdIndicator = secondIndicator.third_indicator.get(z);
                                                            thirdDetail = score.second_indicator.get(j).third_indicator.get(z);
                                                    %>
                                                    <tr class="hover">
                                                        <td class="width_280"> <!--内涵-->
                                                            <%=z + 1%>. <%=thirdIndicator.content%>
                                                        </td>
                                                        <td class="width_100"> <!--指标分值-->
                                                            <%=thirdIndicator.score%>
                                                        </td>
                                                        <td class="width_100"> <!--教师自评分-->
                                                            <div class="textarea <%=i%>-<%=j%>-score" contenteditable="true"><%=thirdDetail.teacher_score%></div>
                                                            <input class="<%=i%>-<%=j%>-score-input" name="score-<%=j%>" type="hidden"/>
                                                        </td>
                                                        <td> <!--依据-->
                                                            <div class="textarea <%=i%>-<%=j%>-proof" contenteditable="true"><%=thirdDetail.proof%></div>
                                                            <input class="<%=i%>-<%=j%>-proof-input" name="proof-<%=j%>" type="hidden"/>
                                                        </td>
                                                    </tr>
                                                    <%}%>
                                                </table>
                                            </td>
                                            <td>
                                                <%
                                                    if (detailTable.isIs_audit()) {
                                                %>
                                                <%=score.second_indicator.get(j).auditor_score%>
                                                <%
                                                    }
                                                %>
                                            </td><!--审核分-->

                                        </tr>
                                        <%}%>
                                    </table>
                                    <input type="submit" class="btn btn-primary float-right save-btn" value="保存">
                                </form>
                            </div>
                        </div>
                        <%}%>

                        <!--<工作量>-->
                        <%int effortSize = effortTable.size();%>
                        <div class="tab-pane" id="tab<%=i%>">
                            <form action="processDetail.do" method="post" onsubmit="submitLoad(<%=effortSize%>)">
                                <input name="type" value="load-detail" type="hidden"/>
                                <input name="loadSize" value="<%=effortSize%>" type="hidden"/>
                                <span class="add-point float-right add-me" onclick="addLoadClick(<%=effortSize%>)">新增一行</span>
                                <i class="fa fa-plus-square-o blue-add float-right add-load"></i>
                                <table class="load-table" border="1" cellspacing="0" cellpadding="0">
                                    <tr class="tr-center">
                                        <%
                                            for (int j = 0; j < effortSize; j++) {
                                        %>
                                        <td> <%=effortTable.get(j)%> </td>
                                        <%}%>
                                        <td>操作</td>
                                    </tr>

                                    <%
                                        for (int j = 0; j < effortDetail.size(); j++) {
                                    %>
                                    <tr class="hover">
                                        <%
                                            String[] strSp = effortDetail.get(j).split(",");

                                            for (int z = 0; z < effortSize; z++) {%>
                                        <td>
                                            <div class="textarea load-content-<%=z%>" contenteditable="true"> <%=strSp[z]%></div>
                                            <input class="load-input-<%=z%>" name="load-<%=z%>" type="hidden" />
                                        </td>

                                        <%}%>
                                        <td><i class="fa fa-trash load-delete" ></i></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </table>
                                <input type="submit" class="btn btn-primary float-right save-btn" value="保存">
                            </form>
                        </div>

                        <%i = i + 1;%>
                        <!--<备注>-->
                        <div class="tab-pane" id="tab<%=i%>">
                            <i class="fa fa-flag blue"></i>
                            <span class="message">备注信息</span>
                            <table class="remark-table" border="1" cellspacing="0" cellpadding="0">
                                <tr class="tr-center">
                                    <td>备注项</td>
                                    <td class="width_400">备注说明</td>
                                </tr>
                                <%
                                    for (int j = 0; j < remarks.size(); j++) {
                                        Remark remark = remarks.get(j);
                                %>
                                <tr class="hover">
                                    <td>
                                        <%=remark.keypoint%>
                                    </td>
                                    <td>
                                        <%=remark.content%>
                                    </td>
                                </tr>
                                <%}%>
                            </table>
                        </div>

                    </div>
                </div>
            </div>

        </main>
        <footer>
            © 2018 <img src="img/heart.png" alt=""> 杭州师范大学
        </footer>
        <script>
            var m = '<%=success%>';
            if (m === 'true') {
                modals.alertSmShow("提交成功！");
            }
            $('#submit-table').click(function () {
                modals.loadingShow();
            });

        </script>
    </body>

</html>
