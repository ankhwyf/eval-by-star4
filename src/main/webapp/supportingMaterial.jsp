<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="star4.eval.service.MaterialService"%>
<%@page import="star4.eval.bean.SupportingMaterial"%>
<%@page import="java.util.List"%>
<%@page import="star4.eval.bean.SupportingMaterial.Doc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="titleBar.jspf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>佐证材料</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="font-awesome/css/font-awesome.min.css" rel='stylesheet' />
        <link rel="stylesheet" href="css/common.css">
        <link href="css/supportingMaterial.css" rel="stylesheet">
        <style>
            .container {
                width: 80%;
                height: 500px;
                border: solid 1px #aaa;
                background: white;

            }
            .page-hd {
                border-bottom: solid 1px #aaa;
            }
            .search {
                border-bottom: solid 1px #aaa;
            }
            .student {
                height: 411px;
                border-right: solid 1px #aaa;
            }
            .fa-file-text, .fa-eye, .fa-download,.back-name, .search-bt  {
                color: #44b6d2;
            }
            .search-bt {
                border: solid 1px #44b6d2;
            }
        </style>
        <script src="js/jquery-1.12.2.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </head>
    <body>
        <form action="" id="form1">
            <div class="box">
                <div class="container">
                    <div class="row page-hd">
                        <div class="page-hd-title">
                            <i class="fa fa-file-text"></i>
                            <span class="title-name">佐证材料</span>
                        </div>
                        <div class="back-bt">
                            <a href="home" class="back-name">返回>></a>
                        </div>
                    </div>
                    <div class="row search">
                        <div class="col-md-2">
                            <section id="search-box"> <label for="search-input">
                                </label> <input id="search-input" class="search-input" type="text"
                                                placeholder="请输入工号/姓名/学年"\> </section>
                        </div>
                        <div class="col-md-1 search-bt-box">
                            <button type="button" class="btn btn-default search-bt">搜索</button>
                        </div>
                    </div>

                    <div class="row material-table">
                        <div class="col-md-4 student">
                            <table class="table table-hover student-table"
                                   id="supportingMaterialIdNameYear">
                                <tr>
                                    <td>工号</td>
                                    <td>姓名</td>
                                    <td>学年</td>
                                </tr>
                                <%                                    String indexStr = request.getParameter("index");
                                    // 查询所有 学号 姓名 学年
                                    MaterialService materialService = new MaterialService();//实例化
                                    List<SupportingMaterial> materials = materialService.findAll();//拿到教师列表
                                    SupportingMaterial material = new SupportingMaterial();
                                    boolean flag = false;
                                    int index = 0;
                                    if (indexStr != null && !indexStr.equals("")) {
                                        index = Integer.parseInt(indexStr);
                                        material = materials.get(index - 1);
                                        flag = true;
                                    }
                                    String teacherId;//工号
                                    String teacherName;//姓名
                                    String academicYear;//学年
                                    for (int i = 0; i < materials.size(); i++) {
                                        SupportingMaterial temp = materials.get(i);
                                        teacherId = temp.getTeacher_id();
                                        teacherName = temp.getTeacher_name();
                                        academicYear = temp.getAcademic_year();
                                        System.out.println(teacherId);
                                %>
                                <tr class="select"
                                    <%
                                        if (i == index - 1) {
                                    %>style="background-color:#eee;"<%
                                        }
                                    %>
                                    >
                                    <td><%=teacherId%></td>
                                    <td><%=teacherName%></td>
                                    <td><%=academicYear%></td>
                                </tr>
                                <%
                                    }
                                %>

                            </table>
                        </div>

                        <div class="col-md-8 material">
                            <table class="table table-bordered">
                                <tr>
                                    <td>材料名称</td>
                                    <td>操作</td>
                                </tr>
                                <%
                                    List<Doc> docs = flag ? material.getDocs() : materials.get(0).getDocs();

                                    for (Doc doc : docs) {
                                %>
                                <tr class="material-item">
                                    <td><%=doc.doc_name%></td>
                                    <td><i class="fa fa-eye" aria-hidden="true"></i> 

                                        <a href="DownloadServlet?docname=<%=URLEncoder.encode(doc.doc_name, "UTF-8")%>">
                                            <i class="fa fa-download" aria-hidden="true"></i></a>
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
        </form>
        <script type="text/javascript">
            var orgBgColor = null;
            $('.select').click(function () {
                $('.select').css('background', '#fff');
                $(this).css('background', '#eee');
                $('.material-item').remove();
                // 获取点击的行中的数据
                var cell = document.getElementById("supportingMaterialIdNameYear").rows[this.rowIndex].cells;
                window.location = "supportingMaterial.jsp?index=" + this.rowIndex;

            });

//            $('.select').hover(function () {
//                orgBgColor = $(this).css("background-color");
//                $(this).css('background-color', '#f5f5f5');
//            },function(){
//                $(this).css('background-color', orgBgColor);
//            });
        </script>
    </body>
</html>