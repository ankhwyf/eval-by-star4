<%-- 
    Document   : admin
    Created on : 2018-1-30, 15:57:26
    Author     : ankhyfw
--%>

<%@page import="star4.eval.bean.EvalTable.ThirdIndicator"%>
<%@page import="star4.eval.bean.EvalTable.SecondIndicator"%>
<%@page import="star4.eval.bean.EvalTable.Remark"%>
<%@page import="star4.eval.bean.EvalTable.SubTable"%>
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
            
            <!--<标题行 和 其他高级配置按钮>-->
            <div class="row title">
                <div class="col-md-8">
                    <strong>杭州国际服务工程学院教师本科教学工作业绩考核评分表</strong>
                  （
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
                } else{
                    System.out.println("success:"+success);
                }
                //考核表
                EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
                //考核子表
                List<SubTable> evalTables = evalTable.getTables();
                //备注
                List<Remark> remarks = evalTable.getRemark();
                //工作量表
                List<String> effortTable=evalTable.getEffortTable();
                
                SubTable tab;
            %>
            
            <!--< tab栏 和 发布等按钮>-->
            <div class="row content">
                <div class="col-md-7 show">
                    <div class="tabbable"> <!-- Only required for left/right tabs -->
                        <ul class="nav nav-tabs">
                            <%
                             int i=0;
                             for(i=0;i<evalTables.size();i++){
                                  tab = evalTables.get(i);
                             %>
                             <li><a href="#tab<%=i%>" data-toggle="tab"><%=tab.first_indicator%></a></li>
                             <%
                             }
                            %>
                             <li><a href="#tab<%=i%>" data-toggle="tab">工作量</a></li>
                             <%i=i+1;%>
                             <li class=""><a href="#tab<%=i%>" data-toggle="tab">备注</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-5 text-right operation">
                    <a href="process.do" id="publish">
                        <i class="fa fa-rocket" style="font-size: 18px"></i>
                        <span>发布</span>
                    </a>
                    <a href="statistics.jsp">
                        <i class="fa fa-bar-chart" style="font-size: 18px"></i>
                        <span>统计</span>
                    </a>
                    <a href="preview.jsp">
                        <i class="fa fa-file-text-o" style="font-size: 18px"></i>
                        <span>预览表格</span>
                    </a>
                    <a href="#">
                        <i class="fa fa-file-text-o" style="font-size: 18px"></i>
                        <span>新建表格</span>
                    </a>
                </div>
            </div>
            
            
            <div class="row">
                <div class="col-md-12">
                    <div class="tab-content" style="height:auto;min-height:100px">
                        
                        <!--<考核子表>-->
                        <%
                        SecondIndicator secondIndicator;
                        ThirdIndicator thirdIndicator;
                        for(i=0;i<evalTables.size();i++){
                            tab = evalTables.get(i);
                        %>
                        <div class="tab-pane" id="tab<%=i%>">
                            <div id="table-<%=i%>">
                                <form action="process.do" method="post" onsubmit="submitSingle(<%=i%>)">
                                    <input name="type" value="eval-<%=i%>" style="display:none;" />
                                    <table border="1" cellspacing="0" cellpadding="0" >
                                        <tr>
                                            <td>一级指标</td>
                                            <td class="width_100">二级指标</td>
                                            <td>内涵</td>
                                            <td class="width_100">指标分值</td>
                                            <td class="width_100">教师自评分</td>
                                            <td class="width_100">自评分依据</td>
                                            <td class="width_100">系部审核分</td> 
                                            <td class="width_100">操作</td>
                                        </tr>
                                        
                                        <tr>
                                            <td rowspan="2" class="width_100"> <!--一级指标-->
                                               <%=tab.first_indicator%>  <%=outputScore(tab)%>
                                            </td>
                                            <%
                                            for(int j=0;j<tab.second_indicator.size();j++){
                                                secondIndicator=tab.second_indicator.get(j);
                                            %>
                                             <td class="width_100">
                                                <div class="width_100">
                                                    <%=secondIndicator.title%> <%=secondIndicator.score%>分 <%=secondIndicator.remark%>
                                                </div>
                                             </td>
                                             <td colspan="4">
                                                <table id="<%=i%>-<%=j%>-basic" border="1" cellspacing="0" cellpadding="0">
                                                    <%
                                                        for (int z = 0; z < secondIndicator.third_indicator.size(); z++) {
                                                           thirdIndicator = secondIndicator.third_indicator.get(z);
                                                    %>
                                                    <tr class="hover">
                                                        <td>
                                                            <div>
                                                                <div class="textarea <%=i%>-content" contenteditable="true"><%=thirdIndicator.content%></div>
                                                                <input class="<%=i%>-content-input" name="content" style="display:none;" />
                                                                <i class="fa fa-trash delete"></i>
                                                            </div>
                                                        </td>
                                                         <td class="width_100">
                                                            <!--<input type="text" name="score" value="" style="border:0;width:80%">-->
                                                            <div class="textarea <%=i%>-score" contenteditable="true" style="height:100%;width:100%;"><%=thirdIndicator.score%></div>
                                                            <input class="<%=i%>-score-input" name="score" style="display:none;" />
                                                        </td>
                                                        <td class="width_100"></td>
                                                        <td class="width_100"></td>
                                                    </tr>
                                                    <%}%>
                                                </table>
                                             </td>
                                             <td></td>
                                             <td><i class="fa fa-plus-square green" onclick="addClick(<%=i%>,<%=j%>)"></i></td>
                                        </tr>
                                         <%    
                                            }
                                            %>
                                    </table> 
                                    <input type="submit" class="btn btn-primary float-right" value="保存" style="width:120px;">
                                </form>
                            </div>
                        </div>
                        <%
                         }
                        %>
                        
                        
                        <!--<工作量>-->
                        <div class="tab-pane" id="tab<%=i%>">
                           <!--<form id="tableGzl" action="process.do" method="post" onsubmit="submitGzl()">-->
<!--                              <input name="type" value="eval-" style="display:none"/>-->
                              <table border="1" cellspacing="0" cellpadding="0">
                                <tr>
                                <%
                                  int effortSize=effortTable.size();
                                  for (int j = 0; j < effortSize ; j++) {
                                %>
                                    <td> <%=effortTable.get(j)%> </td>
                                <%}%>
                                </tr>
                                
                                <%
                                    for(int j=0;j<5;j++){
                                %>
                                <tr>
                                    <%for (int z = 0; z < effortSize ; z++) {%>
                                    <td></td>
                                    <%}%>
                                </tr>
                                <% 
                                 }
                                %>
                              </table>
                              
                           <!--</form>-->
                        </div>
                        
                        <%i=i+1;%>
                         <!--<备注>-->
                        <div class="tab-pane" id="tab<%=i%>">
                            <form id="tableRemark" action="process.do" method="post" onsubmit="submitRemark()">
                                <input name="type" value="remark" style="display:none" />
                                <i class="fa fa-flag blue"></i>
                                <span class="message">备注信息</span>
                                <span class="add-point float-right add-me">新增备注</span>
                                <i class="fa fa-plus-square-o blue-add float-right add-me"></i>
                                <table class="remark-table" border="1" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td>备注项</td>
                                    <td class="width_400">备注说明</td>
                                  </tr>
                                  <%
                                  for (int j = 0; j < remarks.size(); j++) {
                                     Remark remark = remarks.get(j);
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
                                  <%}%>
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
         <script>
//            function alerts(pa){
//                if(pa==='true'){
//                modals.alertSmShow("发布成功！");
//            }
          var m='<%=success%>';
          console.log(m);
          if(m==='true'){
              modals.alertSmShow("发布成功！");
          }
          $('#publish').click(function () {
                 modals.loadingShow();
              });
        </script>
        
    </body>
</html>
