<%@page import="star4.eval.MongoDBInterface"%>
<%@page import="com.mongodb.DBObject"%>
<%@page import="star4.eval.bean.SupportingMaterial"%>
<%@page import="com.google.gson.*"%>
<%@page import="java.util.List"%>
<%@page import="star4.eval.bean.SupportingMaterial.Doc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>佐证材料</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="font-awesome/css/font-awesome.min.css" rel='stylesheet' />
<link href="css/supportingMaterial.css" rel="stylesheet">
<script src="js/jquery-1.12.3.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript">
	var nowTeacherId = null;
	var nowTeacherName = null;
	var nowYear = null;
	function Window_Load() {
		var t = document.getElementById("supportingMaterialIdNameYear");
		var rows = t.getElementsByTagName("tr");

		// 给tr绑定click事件
		for ( var i in rows) {
			rows[i].onclick = rowClick;
		}

		rows[1].onclick();
	}
	function rowClick(e) {
		// 获取点击的行中的数据
		var cell = document.getElementById("supportingMaterialIdNameYear").rows[this.rowIndex].cells;
		nowTeacherId = cell[0].innerHTML;
		nowTeacherName = cell[1].innerHTML;
		nowYear = cell[2].innerHTML;
		/* 
		 location.href = "supportingMaterial.jsp?teacherId=" + nowTeacherId
		 + "&teacherName=" + nowTeacherName + "&year=" + nowYear;
		 window.location.href = url; */

		/* alert(nowTeacherName); */
		var form1 = document.getElementById("form1");
		form1.teacherId.value = nowTeacherId;
		form1.teacherName.value = nowTeacherName;
		form1.year.value = nowYear;
	}

	/* var tempForm = document.getElementById("tempForm");
	tempForm.nowTeacherId.value = nowTeacherId;
	tempForm.nowTeacherName.value = nowTeacherName;
	tempForm.nowYear.value = nowYear;
	tempForm.submit();
	alert(nowTeacherName); */
</script>
</head>
<body onload="Window_Load();">
<form action="" id="form1">
	<div class="box">
		<div class="container">
			<div class="row page-hd">
				<div class="page-hd-title">
					<i class="fa fa-file-text"></i>
					<h4 class="title-name">佐证材料</h4>
				</div>
				<div class="back-bt">
					<span class="back-name">返回>></span>
				</div>
			</div>
			<div class="row search">
				<div class="col-md-2">
					<section id="search-box"> <label for="search-input">
						<i class="fa fa-search" aria-hidden="true"></i>
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
						<%
							// 查询所有 学号 姓名 学年
							MongoDBInterface db = new MongoDBInterface();
							List<DBObject> lists = db.querySupportingMaterial();
							System.out.println(lists);
							for (DBObject list : lists) {
								SupportingMaterial supportingMaterial = new Gson().fromJson(list.toString(), SupportingMaterial.class);
								String teacher_id = supportingMaterial.getTeacher_id();
								String teacher_name = supportingMaterial.getTeacher_name();
								String academic_year = supportingMaterial.getAcademic_year();
								System.out.println(teacher_id);
						%>
						<tr>
							<td><%=teacher_id%></td>
							<td><%=teacher_name%></td>
							<td><%=academic_year%></td>
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
							// 查询 该学号 该姓名 该学年的所有文件
							String nowTeacherId = request.getParameter("teacherId");
							String nowTeacherName = request.getParameter("teacherName");
							String nowYear = request.getParameter("year");
							/* System.out.print(nowTeacherId + "," + nowTeacherName + "," + nowYear); */
							DBObject strTable;
							/* strTable = db.querySupportingMaterial("20102010", "张三", "2016-2017"); */
							strTable = db.querySupportingMaterial(nowTeacherId, nowTeacherName, nowYear);
							SupportingMaterial supportingMaterial = new Gson().fromJson(strTable.toString(), SupportingMaterial.class);
							List<Doc> docs = supportingMaterial.getDocs();
							for (Doc doc : docs) {
						%>
						<tr>
							<td><%=doc.doc_name + doc.doc_address%></td>
							<td><i class="fa fa-eye" aria-hidden="true"></i> <i
								class="fa fa-download" aria-hidden="true"></i></td>
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
</body>
</html>