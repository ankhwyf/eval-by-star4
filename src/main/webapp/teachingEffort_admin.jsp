
<%@page import="star4.eval.bean.EvalTable.ThirdIndicator"%>
<%@page import="star4.eval.bean.EvalTable.SecondIndicator"%>
<%@page import="star4.eval.bean.EvalTable.Remark"%>
<%@page import="star4.eval.bean.EvalTable.SubTable"%>
<%@page import="java.util.List"%>
<%@page import="star4.eval.bean.EvalTable"%>
<%@page import="star4.eval.bean.User"%>
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
        <style type="text/css">
            table {
                font-size: 12px;
                background-color: #fff;
            }
            table tr td {
                min-height: 100px;
                height: 20px;
            }
            table {
                border: none;
                width: 100%;
            }
            .t_in_t {
                width: 100%;
                height: 100%;
            }
            .width_60 {
                width: 60px;
            }
            .width_100 {
                width: 100px;
            }
            .width_120 {
                width: 120px;
            }
            .width_280 {
                width: 280px;
            }
            .width_400 {
                width: 400px;
            }
            .textarea{
                width: 400px; 
                min-height: 20px; 
                max-height: 300px;
                _height: 120px; 
                margin-left: auto; 
                margin-right: auto; 
                padding: 3px; 
                outline: 0; 
                border: 1px solid #a0b3d6; 
                font-size: 12px; 
                line-height: 24px;
                padding: 2px;
                word-wrap: break-word;
                overflow-x: hidden;
                overflow-y: auto;

                border-color: rgba(82, 168, 236, 0.8);
                box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);
            }
        </style>
        <script type="text/javascript">
            function selectOption() {
                var value = $(".form-control").val();
                $("#endyear").text(parseInt(value) + 1);
                $("#submit").submit();
            }

        </script>
    </head>
    <body>
        <main class="container">
            <div class="row title">
                <div class="col-md-8">
                    <strong>杭州国际服务工程学院教师本科教学工作业绩考核评分表</strong>
                    <span>（</span>
                    <form method="post" action="getTable.do" id="submit">
                        <select class="form-control" onchange="selectOption()" name="year">
                            <option value="2013">2013</option>
                            <option value="2014">2014</option>
                            <option value="2015">2015</option>
                            <option value="2016" selected>2016</option>
                        </select>
                    </form>
                    -<span id="endyear">2017</span> 学年）
                </div>
                <div class="col-md-4 text-right operation">
                    <a href="configure.html">
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
                    <a href="#">
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
                                                        <div class="textarea" contenteditable="true" name="content" style="width:100%;border:0;float:left;"><%=content%></div>
                                                    </td>
                                                    <!--内涵的内容 结束-->
                                                    <td><div class="textarea" contenteditable="true" name="score" style="width:100%;height:100%;border:0;float:left;"><%=score%></div>
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
                                            <!--TODO: 此处应有操作图标-->
                                            图标填充
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
                                            /
                                        </td>
                                        <!--留白 / 结束-->
                                        <!--操作图标2 开始-->
                                        <td>
                                            <!--TODO:此处应有图标-->
                                            图标填充
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
                                        %>
                                        <td class="width_100">
                                            <div class="width_100">
                                                <%=tab2.second_indicator.get(0).title%> <%=tab2.second_indicator.get(0).score%>分 <%=tab2.second_indicator.get(0).remark%>
                                            </div>
                                        </td>
                                        <td colspan="4">
                                            <table border="1" cellspacing="0" cellpadding="0">
                                                <%
                                                    for (int i = 0; i < tab2.second_indicator.get(0).third_indicator.size(); i++) {
                                                        ThirdIndicator thirdIndicator = tab2.second_indicator.get(0).third_indicator.get(i);
                                                %>
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <div class="textarea" contenteditable="true" name="content" style="width:90%;border:0;float:left;"><%=thirdIndicator.content%></div>
                                                            <img src="img/delete.png" style="margin:6px 0 0 6px;"/>
                                                        </div>
                                                    </td>
                                                    <td class="width_100"><input type="text" name="score" value="<%=thirdIndicator.score%>" style="border:0;width:80%"></td>
                                                    <td class="width_100"></td>
                                                    <td class="width_100"></td>
                                                </tr>
                                                <%}%>
                                            </table>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <%
                                            for (int i = 1; i < secondIndicatorSize; i++) {
                                                SecondIndicator secondIndicator = tab2.second_indicator.get(i);
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
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <div class="textarea" contenteditable="true" name="content" style="width:90%;border:0;float:left;"><%=thirdIndicator.content%></div>
                                                            <img src="img/delete.png" style="margin:6px 0 0 6px;"/>
                                                        </div>
                                                    </td>
                                                    <td class="width_100"><input type="text" name="score" value="<%=thirdIndicator.score%>" style="border:0;width:80%"></td>
                                                    <td class="width_100"></td>
                                                    <td class="width_100"></td>
                                                </tr>
                                                <%}%>
                                            </table>
                                        </td>
                                        <td></td>
                                        <td></td>
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
                                        %>
                                        <td class="width_100">
                                            <div class="width_100">
                                                <%=tab3.second_indicator.get(0).title%> <%=tab3.second_indicator.get(0).score%>分 <%=tab3.second_indicator.get(0).remark%>
                                            </div>
                                        </td>
                                        <td colspan="4">
                                            <table border="1" cellspacing="0" cellpadding="0">
                                                <%
                                                    for (int i = 0; i < tab3.second_indicator.get(0).third_indicator.size(); i++) {
                                                        ThirdIndicator thirdIndicator = tab3.second_indicator.get(0).third_indicator.get(i);
                                                %>
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <div class="textarea" contenteditable="true" name="content" style="width:90%;border:0;float:left;"><%=thirdIndicator.content%></div>
                                                            <img src="img/delete.png" style="margin:6px 0 0 6px;"/>
                                                        </div>
                                                    </td>
                                                    <td class="width_100"><input type="text" name="score" value="<%=thirdIndicator.score%>" style="border:0;width:80%"></td>
                                                    <td class="width_100"></td>
                                                    <td class="width_100"></td>
                                                </tr>
                                                <%}%>
                                            </table>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <%
                                            for (int i = 1; i < secondIndicatorSize; i++) {
                                                SecondIndicator secondIndicator = tab3.second_indicator.get(i);
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
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <div class="textarea" contenteditable="true" name="content" style="width:90%;border:0;float:left" ><%=thirdIndicator.content%></div>
                                                            <img src="img/delete.png" style="margin:6px 0 0 6px;"/>
                                                        </div>
                                                    </td>
                                                    <td class="width_100"><input type="text" name="score" value="<%=thirdIndicator.score%>" style="border:0;width:80%"></td>
                                                    <td class="width_100"></td>
                                                    <td class="width_100"></td>
                                                </tr>
                                                <%}%>
                                            </table>
                                        </td>
                                        <td></td>
                                        <td></td>
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
                                        %>
                                        <td>
                                            <%=tab4.second_indicator.get(0).title%> <%=tab4.second_indicator.get(0).score%>分 <%=tab4.second_indicator.get(0).remark%>
                                        </td>
                                        <td colspan="4">
                                            <table border="1" cellspacing="0" cellpadding="0">
                                                <%
                                                    for (int i = 0; i < tab4.second_indicator.get(0).third_indicator.size(); i++) {
                                                        ThirdIndicator thirdIndicator = tab4.second_indicator.get(0).third_indicator.get(i);
                                                %>
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <div class="textarea" contenteditable="true" name="content" style="width:90%;border:0;float:left;"><%=thirdIndicator.content%></div>
                                                            <img src="img/delete.png" style="margin:6px 0 0 6px;"/>
                                                        </div>
                                                    </td>
                                                    <td class="width_100"><div class="textarea" contenteditable="true" type="text" name="score" style="border:0;width:100%;height:100%;"><%=thirdIndicator.score%></td>
                                                    <td class="width_100"></td>
                                                    <td class="width_100"></td>
                                                </tr>
                                                <%}%>
                                            </table>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <%
                                            for (int i = 1; i < secondIndicatorSize; i++) {
                                                SecondIndicator secondIndicator = tab4.second_indicator.get(i);
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
                                                            <textarea name="content" style="width:90%;border:0;overflow-y: visible" ><%=thirdIndicator.content%></textarea>
                                                            <img src="img/delete.png" style="backgroud:white"/>
                                                        </div>
                                                    </td>
                                                    <td class="width_100"><input type="text" name="score" value="<%=thirdIndicator.score%>" style="border:0;width:80%"></td>
                                                    <td class="width_100"></td>
                                                    <td class="width_100"></td>
                                                </tr>
                                                <%}%>
                                            </table>
                                        </td>
                                        <td></td>
                                        <td></td>
                                        <%}%>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab5">
                            <div id="table5">
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
                                    <tr>
                                        <td><input type="text" name="keypoint" value="<%=remark.keypoint%>" style="border:0;"/></td>
                                        <td>
                                            <!--<textarea name="remark_content" style="border:0"></textarea>-->
                                            <div class="textarea" contenteditable="true"><%=remark.content%></div>
                                        </td>
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
        </main>
        <footer>
            © 2017 <img src="img/heart.png" alt=""> 杭州师范大学繁星四月小组
        </footer>
        <!-- 
<iframe src="wenzhang_xinwen.html" id="Mainindex" name="Mainindex" width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0"></iframe> -->
        <!-- 内置浏览器 -->
    </body>
    <script type="text/javascript" src="js/jquery-1.12.2.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/common.js"></script>
</html>