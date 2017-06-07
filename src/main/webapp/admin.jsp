
<%@page import="star4.eval.bean.EvalTable.ThirdIndicator"%>
<%@page import="star4.eval.bean.EvalTable.SecondIndicator"%>
<%@page import="star4.eval.bean.EvalTable.Remark"%>
<%@page import="star4.eval.bean.EvalTable.SubTable"%>
<%@page import="java.util.List"%>
<%@page import="star4.eval.bean.EvalTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="titleBar.jspf" %>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>admin</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/common.css">
        <link rel="stylesheet" href="css/teachingRoutine.css">
        <link rel="stylesheet" href="css/table.css">
        <script type="text/javascript" src="js/jquery-1.12.2.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/modals.js"></script>
        <script type="text/javascript" src="js/common.js"></script>
    </head>
    <body>
        <main class="container">
            <div class="row title">
                <div class="col-md-8">
                    <strong>杭州国际服务工程学院教师本科教学工作业绩考核评分表</strong>
                    <span>（</span>
                    <form method="post" action="getTable.do" id="submit">
                        <select class="form-control" name="year">
                            <option value="2013">2013</option>
                            <option value="2014">2014</option>
                            <option value="2015">2015</option>
                            <option value="2016" selected>2016</option>
                        </select>
                    </form>
                    -<span id="endyear">2017</span> 学年）
                </div>
                <div class="col-md-4 text-right operation">
                    <a href="configure.jsp">
                        <i class="fa fa-cog fa-spin" style="font-size: 18px"></i>
                        <span>其他高级配置</span>
                    </a>
                </div>
            </div>      
            <!--            <iframe src="table.jsp" frameborder="0" scrolling="auto" width="100%" height="330" style="background-color: white"></iframe>-->
            <%!
                String outputScore(SubTable tab) {
                    List<SecondIndicator> list = tab.second_indicator;
                    String output = "";
                    for (int i = 0; i < list.size(); i++) {
                        if (i == 0) {
                            output += list.get(i).score;
                        } else {
                            output += "+" + list.get(i).score;
                        }
                    }
                    return output + "分";
                }
            %>
            <%            EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
                List<SubTable> evalTables = evalTable.getTables();
                SubTable tab1 = evalTables.get(0);
                SubTable tab2 = evalTables.get(1);
                SubTable tab3 = evalTables.get(2);
                SubTable tab4 = evalTables.get(3);
                List<Remark> remarks = evalTable.getRemark();
            %>
            <div class="row content">
                <div class="col-md-7 show">
                    <div class="tabbable"> <!-- Only required for left/right tabs -->
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab1" data-toggle="tab"><%=tab1.first_indicator%></a></li>
                            <li><a href="#tab2" data-toggle="tab"><%=tab2.first_indicator%></a></li>
                            <li><a href="#tab3" data-toggle="tab"><%=tab3.first_indicator%></a></li>
                            <li><a href="#tab4" data-toggle="tab"><%=tab4.first_indicator%></a></li>
                            <li><a href="#tab5" data-toggle="tab">备注</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-5 text-right operation">
                    <a href="#" onclick="ajaxSubmit()">
                        <i class="fa fa-rocket" style="font-size: 18px"></i>
                        <span>发布</span>
                    </a>
                    <a href="statistics.html">
                        <i class="fa fa-bar-chart" style="font-size: 18px"></i>
                        <span>统计</span>
                    </a>
                    <a href="#">
                        <i class="fa fa-file-text-o" style="font-size: 18px"></i>
                        <span>预览表格</span>
                    </a>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="tab-content" style="height:auto;min-height:100px">
                        <div class="tab-pane active" id="tab1">
                            <div id="table1" >
                                <!--整个单元格为3行，4列。
                                其中“一级指标”那个文字对应一行，“操作”下面每个图标分别对应一行；
                                “一级标题”文字对应一列，“二级指标”、“内涵”、“指标分值”、
                                “教师自评分”、“自评分依据”放在子table里作为一列，“系统审核分”一列，“操作”一列-->
                                <table border="1" cellspacing="0" cellpadding="0" >
                                    <!--第一行开始-->
                                    <tr>
                                        <td class="width_100">一级指标</td>
                                        <!--“指标分值”、“教师自评分”、“自评分依据”放在子table里，作为一列，且在外层table里跨行-->
                                        <td rowspan="2">
                                            <!--单元格跨行，指标、自评分等放在一个table里 开始-->
                                            <table border="1" cellspacing="0" cellpadding="0">
                                                <!--子table第一行 开始-->
                                                <tr>
                                                    <td class="width_100">二级指标</td>
                                                    <td class="width_400">内涵</td>
                                                    <td class="width_60">指标分值</td>
                                                    <td class="width_60">教师自评分</td>
                                                    <td>自评分依据（教学建设项目或教学成果奖励需提供原始文件）</td>
                                                </tr>
                                                <!--子table第一行 结束-->
                                                <%
                                                    List<SecondIndicator> secondIndicators = tab1.second_indicator;
                                                    for (int i = 0; i < secondIndicators.size(); i++) {
                                                        SecondIndicator secondIndicator = tab1.second_indicator.get(i);
                                                        for (int j = 0; j < secondIndicator.third_indicator.size(); j++) {
                                                            String content = secondIndicator.third_indicator.get(j).content;
                                                            String score = secondIndicator.third_indicator.get(j).score;
                                                %>
                                                <!--子table第二行 开始-->
                                                <tr>
                                                    <!--二级标题内容 开始-->
                                                    <td class="width_100">
                                                        <%=secondIndicator.title%> <%=secondIndicator.score%>分
                                                    </td>
                                                    <!--二级标题内容 结束-->
                                                    <!--内涵的内容 开始-->
                                                    <td class="width_400">
                                                        <div class="textarea" contenteditable="true" name="content"><%=content%></div>
                                                        <i class="fa fa-trash delete"></i>
                                                    </td>
                                                    <!--内涵的内容 结束-->
                                                    <td><div class="textarea" contenteditable="true" name="score" style="width:100%;height:100%;"><%=score%></div>
                                                    </td>
                                                    <td></td>
                                                    <td></td>
                                                </tr>
                                                <!--子table第二行 结束-->
                                                <%
                                                        }
                                                    }
                                                %>
                                            </table>
                                            <!--单元格跨列，指标、自评分等放在一个table里 结束-->
                                        </td>
                                        <td>系部审核分</td> 
                                        <td>操作</td>
                                    </tr>
                                    <!--第一行结束-->

                                    <!--第二行开始-->
                                    <tr>
                                        <!--一级标题内容，跨行 开始-->
                                        <td rowspan="2">
                                            <%=tab1.first_indicator%> <%=outputScore(tab1)%>
                                        </td>
                                        <!--一级标题内容，跨行 结束-->
                                        <!--系统审核分内容 开始-->
                                        <td>

                                        </td>
                                        <!--系统审核分内容 结束-->
                                        <!--操作图标 开始-->
                                        <td>
                                            <i class="fa fa-plus-square green add"></i>
                                        </td>
                                        <!--操作图标 结束-->
                                    </tr>
                                    <!--第二行结束-->

                                    <!--第三行开始-->
                                    <tr>
                                        <td>
                                            <!--工作内容、教学对象、人数、总学时、各项教学工作内容总学时核算、合计放在一个table里 开始-->
                                            <table class="t_in_t" border="1" cellspacing="0" cellpadding="0">
                                                <!-- 标题行 开始 -->
                                                <tr>
                                                    <%
                                                        List<String> effortTable = tab1.effort_table;
                                                        int effortSize = effortTable.size();
                                                        for (int i = 0; i < effortSize; i++) {
                                                    %><td>
                                                        <%=effortTable.get(i)%>
                                                    </td><%
                                                        }
                                                    %>

                                                </tr>
                                                <!-- 标题行 结束 -->
                                                <%
                                                    for (int i = 0; i < 3; i++) {
                                                %>
                                                <tr>
                                                    <%
                                                        for (int j = 0; j < effortSize; j++) {
                                                    %><td></td><%
                                                        }
                                                    %>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </table>
                                            <!--工作内容、教学对象、人数、总学时、各项教学工作内容总学时核算、合计放在一个table里 结束-->
                                        </td>
                                        <!--留白 / 开始-->
                                        <td>
                                            <i class="fa fa-minus gray"></i>
                                        </td>
                                        <!--留白 / 结束-->
                                        <!--操作图标2 开始-->
                                        <td>
                                            <i class="fa fa-minus gray"></i>
                                        </td>
                                        <!--操作图标2 结束-->
                                    </tr>
                                    <!--第三行结束-->
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab2">
                            <div id="table2">
                                <table border="1" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            一级指标
                                        </td>
                                        <td class="width_100">
                                            二级指标
                                        </td>
                                        <td>
                                            内涵
                                        </td>
                                        <td class="width_100">
                                            指标分值
                                        </td>
                                        <td class="width_100">
                                            教师自评分
                                        </td>
                                        <td class="width_100">
                                            自评分依据
                                        </td>
                                        <td class="width_100">
                                            系统审核分
                                        </td>
                                        <td class="width_100">
                                            操作
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2" class="width_100">
                                            <%=tab2.first_indicator%> <%=outputScore(tab2)%>
                                        </td>
                                        <%
                                            int secondIndicatorSize = tab2.second_indicator.size();
                                            SecondIndicator secondIndicator = tab2.second_indicator.get(0);
                                        %>
                                        <td class="width_100">
                                            <div class="width_100">
                                                <%=secondIndicator.title%> <%=secondIndicator.score%>分 <%=secondIndicator.remark%>
                                            </div>
                                        </td>
                                        <td colspan="4">
                                            <table border="1" cellspacing="0" cellpadding="0">
                                                <%
                                                    for (int i = 0; i < secondIndicator.third_indicator.size(); i++) {
                                                        ThirdIndicator thirdIndicator = secondIndicator.third_indicator.get(i);
                                                %>
                                                <tr class="hover">
                                                    <td>
                                                        <div>
                                                            <div class="textarea" contenteditable="true" name="content"><%=thirdIndicator.content%></div>
                                                            <i class="fa fa-trash delete"></i>
                                                        </div>
                                                    </td>
                                                    <td class="width_100">
                                                        <!--<input type="text" name="score" value="" style="border:0;width:80%">-->
                                                        <div class="textarea" contenteditable="true" style="height:100%"><%=thirdIndicator.score%></div>
                                                    </td>
                                                    <td class="width_100"></td>
                                                    <td class="width_100"></td>
                                                </tr>

                                                <%}%>
                                            </table>
                                        </td>
                                        <td></td>
                                        <td><i class="fa fa-plus-square green add"></i></td>
                                    </tr>

                                    <tr>
                                        <%
                                            for (int i = 1; i < secondIndicatorSize; i++) {
                                                secondIndicator = tab2.second_indicator.get(i);
                                        %>
                                        <td>
                                            <div class="width_100">
                                                <%=secondIndicator.title%> <%=secondIndicator.score%>分 <%=secondIndicator.remark%>
                                            </div>
                                        </td>
                                        <td colspan="4">
                                            <table border="1" cellspacing="0" cellpadding="0">
                                                <%for (int j = 0; j < secondIndicator.third_indicator.size(); j++) {
                                                        ThirdIndicator thirdIndicator = secondIndicator.third_indicator.get(j);
                                                %>
                                                <tr class="hover">
                                                    <td>
                                                        <div>
                                                            <div class="textarea" contenteditable="true" name="content"><%=thirdIndicator.content%></div>
                                                            <i class="fa fa-trash delete"></i>
                                                        </div>
                                                    </td>
                                                    <td class="width_100">
                                                        <!--<input type="text" name="score" value="" style="border:0;width:80%">-->
                                                        <div class="textarea" contenteditable="true" style="height:100%"><%=thirdIndicator.score%></div>
                                                    </td>
                                                    <td class="width_100"></td>
                                                    <td class="width_100"></td>
                                                </tr>
                                                <%}%>
                                            </table>
                                        </td>
                                        <td></td>
                                        <td><i class="fa fa-plus-square green add"></i></td>
                                        <%}%>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab3">
                            <div id="table3">
                                <table border="1" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            一级指标
                                        </td>
                                        <td class="width_100">
                                            二级指标
                                        </td>
                                        <td>
                                            内涵
                                        </td>
                                        <td class="width_100">
                                            指标分值
                                        </td>
                                        <td class="width_100">
                                            教师自评分
                                        </td>
                                        <td class="width_100">
                                            自评分依据
                                        </td>
                                        <td class="width_100">
                                            系统审核分
                                        </td>
                                        <td class="width_100">
                                            操作
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2" class="width_100">
                                            <%=tab3.first_indicator%> <%=outputScore(tab3)%>
                                        </td>
                                        <%
                                            secondIndicatorSize = tab3.second_indicator.size();
                                            secondIndicator = tab3.second_indicator.get(0);
                                        %>
                                        <td class="width_100">
                                            <div class="width_100">
                                                <%=secondIndicator.title%> <%=secondIndicator.score%>分 <%=secondIndicator.remark%>
                                            </div>
                                        </td>
                                        <td colspan="4">
                                            <table border="1" cellspacing="0" cellpadding="0">
                                                <%
                                                    for (int i = 0; i < secondIndicator.third_indicator.size(); i++) {
                                                        ThirdIndicator thirdIndicator = secondIndicator.third_indicator.get(i);
                                                %>
                                                <tr class="hover">
                                                    <td>
                                                        <div>
                                                            <div class="textarea" contenteditable="true" name="content"><%=thirdIndicator.content%></div>
                                                            <i class="fa fa-trash delete"></i>
                                                        </div>
                                                    </td>
                                                    <td class="width_100">
                                                        <!--                                                        <input type="text" name="score" value="" style="border:0;width:80%">-->
                                                        <div class="textarea" contenteditable="true" style="height:100%"><%=thirdIndicator.score%></div>
                                                    </td>
                                                    <td class="width_100"></td>
                                                    <td class="width_100"></td>
                                                </tr>
                                                <%}%>
                                            </table>
                                        </td>
                                        <td></td>
                                        <td><i class="fa fa-plus-square green add"></i></td>
                                    </tr>

                                    <tr>
                                        <%
                                            for (int i = 1; i < secondIndicatorSize; i++) {
                                                secondIndicator = tab3.second_indicator.get(i);
                                        %>
                                        <td class="width_100">
                                            <div class="width_100">
                                                <%=secondIndicator.title%> <%=secondIndicator.score%>分 <%=secondIndicator.remark%>
                                            </div>
                                        </td>
                                        <td colspan="4">
                                            <table border="1" cellspacing="0" cellpadding="0">
                                                <%for (int j = 0; j < secondIndicator.third_indicator.size(); j++) {
                                                        ThirdIndicator thirdIndicator = secondIndicator.third_indicator.get(j);
                                                %>
                                                <tr class="hover">
                                                    <td>
                                                        <div>
                                                            <div class="textarea" contenteditable="true" name="content"><%=thirdIndicator.content%></div>
                                                            <i class="fa fa-trash delete"></i>
                                                        </div>
                                                    </td>
                                                    <td class="width_100">
                                                        <div class="textarea" contenteditable="true" style="height:100%"><%=thirdIndicator.score%></div>
                                                    </td>
                                                    <td class="width_100"></td>
                                                    <td class="width_100"></td>
                                                </tr>
                                                <%}%>
                                            </table>
                                        </td>
                                        <td></td>
                                        <td><i class="fa fa-plus-square green add"></i></td>
                                        <%}%>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab4">
                            <div id="table4">
                                <table border="1" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            一级指标
                                        </td>
                                        <td class="width_100">
                                            二级指标
                                        </td>
                                        <td>
                                            内涵
                                        </td>
                                        <td class="width_100">
                                            指标分值
                                        </td>
                                        <td class="width_100">
                                            教师自评分
                                        </td>
                                        <td class="width_100">
                                            自评分依据
                                        </td>
                                        <td class="width_100">
                                            系统审核分
                                        </td>
                                        <td class="width_100">
                                            操作
                                        </td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2" class="width_100">
                                            <%=tab4.first_indicator%> <%=outputScore(tab4)%>
                                        </td>
                                        <%
                                            secondIndicatorSize = tab4.second_indicator.size();
                                            secondIndicator = tab4.second_indicator.get(0);
                                        %>
                                        <td>
                                            <%=secondIndicator.title%> <%=secondIndicator.score%>分 <%=secondIndicator.remark%>
                                        </td>
                                        <td colspan="4">
                                            <table border="1" cellspacing="0" cellpadding="0">
                                                <%
                                                    for (int i = 0; i < secondIndicator.third_indicator.size(); i++) {
                                                        ThirdIndicator thirdIndicator = secondIndicator.third_indicator.get(i);
                                                %>
                                                <tr class="hover">
                                                    <td>
                                                        <div>
                                                            <div class="textarea" contenteditable="true" name="content"><%=thirdIndicator.content%></div>
                                                            <i class="fa fa-trash delete"></i>
                                                        </div>
                                                    </td>
                                                    <td class="width_100">
                                                        <div class="textarea" contenteditable="true" style="height:100%"><%=thirdIndicator.score%></div>
                                                    </td>
                                                    <td class="width_100"></td>
                                                    <td class="width_100"></td>
                                                </tr>
                                                <%}%>
                                            </table>
                                        </td>
                                        <td></td>
                                        <td><i class="fa fa-plus-square green add"></i></td>
                                    </tr>

                                    <tr>
                                        <%
                                            for (int i = 1; i < secondIndicatorSize; i++) {
                                                secondIndicator = tab4.second_indicator.get(i);
                                        %>
                                        <td>
                                            <%=secondIndicator.title%> <%=secondIndicator.score%>分 <%=secondIndicator.remark%>
                                        </td>
                                        <td colspan="4">
                                            <table border="1" cellspacing="0" cellpadding="0">
                                                <%for (int j = 0; j < secondIndicator.third_indicator.size(); j++) {
                                                        ThirdIndicator thirdIndicator = secondIndicator.third_indicator.get(j);
                                                %>
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <div class="textarea" contenteditable="true" name="content"><%=thirdIndicator.content%></div>
                                                            <i class="fa fa-trash delete"></i>
                                                        </div>
                                                    </td>
                                                    <td class="width_100">
                                                        <div class="textarea" contenteditable="true" style="height:100%"><%=thirdIndicator.score%></div>
                                                    </td>
                                                    <td class="width_100"></td>
                                                    <td class="width_100"></td>
                                                </tr>
                                                <%}%>
                                            </table>
                                        </td>
                                        <td></td>
                                        <td><i class="fa fa-plus-square green add"></i></td>
                                        <%}%>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab5">
                            <form id="table5" action="process.do" method="post">
                                <i class="fa fa-flag blue"></i>
                                <span class="message">备注信息</span>
                                <span class="add-point float-right add-me">新增备注</span>
                                <i class="fa fa-plus-square-o blue-add float-right add-me"></i>
                                <table border="1" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td>
                                            备注项
                                        </td>
                                        <td class="width_400">
                                            备注说明
                                        </td>
                                    </tr>
                                    <%
                                        for (int i = 0; i < remarks.size(); i++) {
                                            Remark remark = remarks.get(i);
                                    %>
                                    <tr class="hover">
                                        <td>
                                            <!--<input type="text" name="keypoint" value="" style="border:0;"/>-->
                                            <div class="textarea" contenteditable="true" name="keypoint"><%=remark.keypoint%></div>
                                        </td>
                                        <td>
                                            <!--<textarea name="remark_content" style="border:0"></textarea>-->
                                            <div class="textarea" contenteditable="true" name="content" style="height:100%"><%=remark.content%></div>
                                            <i class="fa fa-trash delete"></i>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </table>
                                <input type="submit" class="btn btn-primary float-right" value="保存" style="width:120px;">
                            </form>
                                
                        </div>
                    </div>
                </div>
            </div>
            <script>
                function addLine() {
                    var tpl = "";
                    tpl += "<tr class=\"hover\">";
                    tpl += "<td>";
                    tpl += "<div>";
                    tpl += " <div class=\"textarea\" contenteditable=\"true\" name=\"content\"></div>";
                    tpl += "<i class=\"fa fa-trash delete\"></i>";
                    tpl += "<div>";
                    tpl += "</td>";
                    tpl += "<td class=\"width_100\"><div class=\"textarea\" contenteditable=\"true\"></div></td>";
                    tpl += " <td class=\"width_100\"></td>";
                    tpl += " <td class=\"width_100\"></td>";
                    tpl += "<tr>";
                    return tpl;
                }
                function addMessage() {
                    var tpl = "";
                    tpl += "<tr class=\"hover\">";
                    tpl += "<td>";
                    tpl += "<div class=\"textarea\" contenteditable=\"true\" name=\"keypoint\"></div>";
                    tpl += "</td>";
                    tpl += "<td>";
                    tpl += "<div class=\"textarea\" contenteditable=\"true\" name=\"content\" style=\"height:100%\"></div>";
                    tpl += "<i class=\"fa fa-trash delete\"></i>";
                    tpl += "</td>";
                    tpl += "</tr>";
                    return tpl;
                }
                function del() {
                    $(".delete").click(function () {
                        if ($(this).parent().parent().children().length === 2) {
                            $(this).parent().parent().remove();
                        } else
                            $(this).parent().parent().parent().remove();
                    });
                }
                $(".add").click(function () {
                    if ($(this).parent().parent().children('td').length === 5) {
                        $(this).parent().parent().children().eq(2).children().append(addLine());
                    } else
                        $(this).parent().parent().children().eq(1).children().append(addLine());

                    $('.delete').bind('click', function () {
                        del();
                    });
                });
                $('.add-me').click(function () {
                    $(this).parent().children().eq(4).append(addMessage());
                    $('.delete').bind('click', function () {
                        del();
                    });
                });
                
                $(".form-control").change(function(){
                     var value = $(".form-control").val();
                    $("#endyear").text(parseInt(value) + 1);
                    $("#submit").submit();
                });
                del();
            </script>
        </main>
        <footer>
            © 2017 <img src="img/heart.png" alt=""> 杭州师范大学繁星四月小组
        </footer>
        <!-- 
<iframe src="wenzhang_xinwen.html" id="Mainindex" name="Mainindex" width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0"></iframe> -->
        <!-- 内置浏览器 -->
    </body>

</html>
