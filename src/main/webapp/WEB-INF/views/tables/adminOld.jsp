
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="star4.eval.bean.EvalTable.ThirdIndicator"%>
<%@page import="star4.eval.bean.EvalTable.SecondIndicator"%>
<%@page import="star4.eval.bean.EvalTable.Remark"%>
<%@page import="star4.eval.bean.EvalTable.SubTable"%>
<%@page import="java.util.List"%>
<%@page import="star4.eval.bean.EvalTable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="/titleBar.jspf" %>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>admin</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/common.css">
        <link rel="stylesheet" href="css/modals.css">
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
            <%            
                String success=(String)request.getAttribute("success");
                if(success==null){
                    success="";
                }
                EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
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
                    <a href="process.do" class="publish">
                        <i class="fa fa-rocket" style="font-size: 18px"></i>
                        <span>发布</span>
                    </a>
                    <a href="statistics.jsp">
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
                            <div id="table-gzl" >
                                <form id="tableGzl" action="process.do" method="post" onsubmit="submitGzl()">
                                    <input name="type" value="gzl" style="display:none;" />
                                    <!--整个单元格为3行，4列。
                                    其中“一级指标”那个文字对应一行，“操作”下面每个图标分别对应一行；
                                    “一级标题”文字对应一列，“二级指标”、“内涵”、“指标分值”、
                                    “教师自评分”、“自评分依据”放在子table里作为一列，“系统审核分”一列，“操作”一列-->
                                    <table border="1" cellspacing="0" cellpadding="0" >
                                        <!--第一行开始-->
                                        <tr>
                                            <td class="width_100" style="max-height: 30px">一级指标</td>
                                            <td class="width_100">二级指标</td>
                                            <td>内涵</td>
                                            <td class="width_100">指标分值</td>
                                            <td class="width_100">教师自评分</td>
                                            <td class="width_100">自评分依据</td>
                                            <td class="width_100">系部审核分</td> 
                                            <td class="width_100">操作</td>
                                        </tr>
                                        <!--第一行结束-->

                                        <!--第二行开始-->
                                        <tr>
                                            <!--一级标题内容，跨行 开始-->
                                            <td rowspan="2">
                                                <%=tab1.first_indicator%> <%=outputScore(tab1)%>
                                            </td>
                                            <!--一级标题内容，跨行 结束-->
                                            <td colspan="5">
                                                <!--单元格跨行，指标、自评分等放在一个table里 开始-->
                                                <table border="1" cellspacing="0" cellpadding="0">
                                                    <%
                                                        List<SecondIndicator> secondIndicators = tab1.second_indicator;
                                                        for (int i = 0; i < secondIndicators.size(); i++) {
                                                            SecondIndicator secondIndicator = tab1.second_indicator.get(i);
                                                    %>
                                                    <!--子table第二行 开始-->
                                                    <tr>
                                                        <!--二级标题内容 开始-->
                                                        <td class="width_100">
                                                            <%=secondIndicator.title%> <%=secondIndicator.score%>分
                                                        </td>
                                                        <!--二级标题内容 结束-->
                                                        <td colspan="4">
                                                            <table class="gzl-basic" border="1px" cellspacing="0" cellpadding="0">
                                                                <%
                                                                    for (int j = 0; j < secondIndicator.third_indicator.size(); j++) {
                                                                        String content = secondIndicator.third_indicator.get(j).content;
                                                                        String score = secondIndicator.third_indicator.get(j).score;
                                                                %>

                                                                <tr>

                                                                    <!--内涵的内容 开始-->
                                                                    <td>
                                                                        <div>
                                                                            <div class="textarea gzl-basic-content" contenteditable="true" name="content"><%=content%></div>
                                                                            <input class="gzl-basic-content-input" name="content" style="display:none;" />
                                                                            <i class="fa fa-trash delete"></i>
                                                                        </div>
                                                                    </td>
                                                                    <!--内涵的内容 结束-->
                                                                    <td class="width_100">
                                                                        <div class="textarea gzl-basic-score" contenteditable="true" name="score" style="width:100%;height:100%;"><%=score%></div>
                                                                        <input class="gzl-basic-score-input" name="score" style="display:none;" />
                                                                    </td>
                                                                    <td class="width_100"></td>
                                                                    <td class="width_100"></td>
                                                                </tr>
                                                                <%}%>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <!--子table第二行 结束-->
                                                    <%
                                                        }
                                                    %>
                                                </table>
                                                <!--单元格跨列，指标、自评分等放在一个table里 结束-->
                                            </td>
                                            <!--系统审核分内容 开始-->
                                            <td>

                                            </td>
                                            <!--系统审核分内容 结束-->
                                            <!--操作图标 开始-->
                                            <td>
                                                <i class="fa fa-plus-square green add-gzl"></i>
                                            </td>
                                            <!--操作图标 结束-->
                                        </tr>
                                        <!--第二行结束-->

                                       
                                    </table>
                                    <input type="submit" class="btn btn-primary float-right" value="保存" style="width:120px;">
                                </form>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab2">
                            <div id="table-routine">
                                <form action="process.do" method="post" onsubmit="submitRoutine()">
                                    <input name="type" value="routine" style="display:none;" />
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
                                                <table class="routine-basic" border="1" cellspacing="0" cellpadding="0">
                                                    <%
                                                        for (int i = 0; i < secondIndicator.third_indicator.size(); i++) {
                                                            ThirdIndicator thirdIndicator = secondIndicator.third_indicator.get(i);
                                                    %>
                                                    <tr class="hover">
                                                        <td>
                                                            <div>
                                                                <div class="textarea routine-basic-content" contenteditable="true"><%=thirdIndicator.content%></div>
                                                                <input name="basic-content" class="routine-basic-content-input" style="display:none;"/>
                                                                <i class="fa fa-trash delete"></i>
                                                            </div>
                                                        </td>
                                                        <td class="width_100">
                                                            <div class="textarea routine-basic-score" contenteditable="true" style="height:100%;width:100%"><%=thirdIndicator.score%></div>
                                                            <input name="basic-score" class="routine-basic-score-input" style="display:none;"/>
                                                        </td>
                                                        <td class="width_100"></td>
                                                        <td class="width_100"></td>
                                                    </tr>

                                                    <%}%>
                                                </table>
                                            </td>
                                            <td></td>
                                            <td><i class="fa fa-plus-square green add-routine-basic"></i></td>
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
                                                <table class="routine-extend" border="1" cellspacing="0" cellpadding="0">
                                                    <%for (int j = 0; j < secondIndicator.third_indicator.size(); j++) {
                                                            ThirdIndicator thirdIndicator = secondIndicator.third_indicator.get(j);
                                                    %>
                                                    <tr class="hover">
                                                        <td>
                                                            <div>
                                                                <div class="textarea routine-extend-content" contenteditable="true"><%=thirdIndicator.content%></div>
                                                                <input name="extend-content" class="routine-extend-content-input" style="display:none;" />
                                                                <i class="fa fa-trash delete"></i>
                                                            </div>
                                                        </td>
                                                        <td class="width_100">
                                                            <div class="textarea routine-extend-score" contenteditable="true" style="height:100%;width:100%;"><%=thirdIndicator.score%></div>
                                                            <input name="extend-score" class="routine-extend-score-input" style="display:none;"/>
                                                        </td>
                                                        <td class="width_100"></td>
                                                        <td class="width_100"></td>
                                                    </tr>
                                                    <%}%>
                                                </table>
                                            </td>
                                            <td></td>
                                            <td><i class="fa fa-plus-square green add-routine-extend"></i></td>
                                                <%}%>
                                        </tr>
                                    </table>
                                    <input type="submit" class="btn btn-primary float-right" value="保存" style="width:120px;">
                                </form>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab3">
                            <div id="table-construct">
                                <form action="process.do" method="post" onsubmit="submitConstruct()">
                                    <input name="type" value="construct" style="display:none;"/>
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
                                                <table class="construct-basic" border="1" cellspacing="0" cellpadding="0">
                                                    <%
                                                        for (int i = 0; i < secondIndicator.third_indicator.size(); i++) {
                                                            ThirdIndicator thirdIndicator = secondIndicator.third_indicator.get(i);
                                                    %>
                                                    <tr class="hover">
                                                        <td>
                                                            <div>
                                                                <div class="textarea construct-basic-content" contenteditable="true"><%=thirdIndicator.content%></div>
                                                                <input class="construct-basic-content-input" name="basic-content" style="display:none;" />
                                                                <i class="fa fa-trash delete"></i>
                                                            </div>
                                                        </td>
                                                        <td class="width_100">
                                                            <!--                                                        <input type="text" name="score" value="" style="border:0;width:80%">-->
                                                            <div class="textarea construct-basic-score" contenteditable="true" style="height:100%;width:100%;"><%=thirdIndicator.score%></div>
                                                            <input class="construct-basic-score-input" name="basic-score" style="display:none;" />
                                                        </td>
                                                        <td class="width_100"></td>
                                                        <td class="width_100"></td>
                                                    </tr>
                                                    <%}%>
                                                </table>
                                            </td>
                                            <td></td>
                                            <td><i class="fa fa-plus-square green add-construct-basic"></i></td>
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
                                                <table class="construct-extend" border="1" cellspacing="0" cellpadding="0">
                                                    <%for (int j = 0; j < secondIndicator.third_indicator.size(); j++) {
                                                            ThirdIndicator thirdIndicator = secondIndicator.third_indicator.get(j);
                                                    %>
                                                    <tr class="hover">
                                                        <td>
                                                            <div>
                                                                <div class="textarea construct-extend-content" contenteditable="true" name="content"><%=thirdIndicator.content%></div>
                                                                <input class="construct-extend-content-input" name="extend-content" style="display:none;" />
                                                                <i class="fa fa-trash delete"></i>
                                                            </div>
                                                        </td>
                                                        <td class="width_100">
                                                            <div class="textarea construct-extend-score" contenteditable="true" style="height:100%;width:100%;"><%=thirdIndicator.score%></div>
                                                            <input class="construct-extend-score-input" name="extend-score" style="display:none;" />
                                                        </td>
                                                        <td class="width_100"></td>
                                                        <td class="width_100"></td>
                                                    </tr>
                                                    <%}%>
                                                </table>
                                            </td>
                                            <td></td>
                                            <td><i class="fa fa-plus-square green add-construct-extend"></i></td>
                                                <%}%>
                                        </tr>
                                    </table>
                                    <input type="submit" class="btn btn-primary float-right" value="保存" style="width:120px;">
                                </form>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab4">
                            <div id="table-others">
                                <form action="process.do" method="post" onsubmit="submitOthers()">
                                    <input name="type" value="others" style="display: none;"/>
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
                                                <table class="others-basic" border="1" cellspacing="0" cellpadding="0">
                                                    <%
                                                        for (int i = 0; i < secondIndicator.third_indicator.size(); i++) {
                                                            ThirdIndicator thirdIndicator = secondIndicator.third_indicator.get(i);
                                                    %>
                                                    <tr class="hover">
                                                        <td>
                                                            <div>
                                                                <div class="textarea others-basic-content" contenteditable="true"><%=thirdIndicator.content%></div>
                                                                <input class="others-basic-content-input" name="content" style="display:none;" />
                                                                <i class="fa fa-trash delete"></i>
                                                            </div>
                                                        </td>
                                                        <td class="width_100">
                                                            <div class="textarea others-basic-score" contenteditable="true" style="height:100%;width:100%;"><%=thirdIndicator.score%></div>
                                                            <input class="others-basic-score-input" name="score" style="display:none;" />
                                                        </td>
                                                        <td class="width_100"></td>
                                                        <td class="width_100"></td>
                                                    </tr>
                                                    <%}%>
                                                </table>
                                            </td>
                                            <td></td>
                                            <td><i class="fa fa-plus-square green add-others-basic"></i></td>
                                        </tr>
                                    </table>
                                    <input type="submit" class="btn btn-primary float-right" value="保存" style="width:120px;">
                                </form>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab5">
                            <form id="tableRemark" action="process.do" method="post" onsubmit="submitRemark()">
                                <input name="type" value="remark" style="display:none" />
                                <i class="fa fa-flag blue"></i>
                                <span class="message">备注信息</span>
                                <span class="add-point float-right add-me">新增备注</span>
                                <i class="fa fa-plus-square-o blue-add float-right add-me"></i>
                                <table class="remark-table" border="1" cellspacing="0" cellpadding="0">
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
                                            <div class="textarea remark-keypoint" contenteditable="true">
                                                <%=remark.keypoint%>
                                            </div>
                                            <input class="keypoint-input" name="keypoint" style="display: none;" />
                                        </td>
                                        <td>
                                            <!--<textarea name="remark_content" style="border:0"></textarea>-->
                                            <div class="textarea remark-content" contenteditable="true"><%=remark.content%></div>
                                            <input class="content-input" name="content" style="display: none;" />
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
            <script type="text/javascript" src="js/admin_new.js"></script>
        </main>
        <footer>
            © 2017 <img src="img/heart.png" alt=""> 杭州师范大学
        </footer>
        <!-- 
<iframe src="wenzhang_xinwen.html" id="Mainindex" name="Mainindex" width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0"></iframe> -->
        <!-- 内置浏览器 -->
        <script>
            var success=<%=success%>;
            if(success==='true'){
                modals.alertSmShow("发布成功！");
            }
            $('.publish').click(function () {
                 modals.loadingShow();
              });
        </script>
    </body>

</html>
