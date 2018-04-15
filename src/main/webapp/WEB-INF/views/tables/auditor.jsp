
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
</head>
<body>
	<main class="container"> <%
 	String[] yearsDetail = (String[]) session.getAttribute("yearsDetail");
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
							if (yearsDetail[y].equals(yearDetail)) {
					%>
					<option value="<%=yearsDetail[y]%>" selected="selected"><%=yearsDetail[y]%></option>
					<%
						} else {
					%>
					<option value="<%=yearsDetail[y]%>"><%=yearsDetail[y]%></option>
					<%
						}
						}
					%>

				</select>
			</form>
			-<span id="endyear-auditor"><%=service.changeYear(yearDetail)%></span> 学年）
		</div>
	</div>
	<div class="row">
		<div class="col-md-1 auditor-formate">
			<ul class="auditor list-unstyled">
				<%
					String name;
					DetailService detailService = new DetailService();
					List<DetailTable> detailTables = detailService.findAllTablesByYear(yearDetail);
					DetailTable detailTemp;

					for (int i = 0; i < detailTables.size(); i++) {
						detailTemp = detailTables.get(i);
						name = userService.findByCardID(detailTemp.getCardID(), UserService.COLLECTIONUSER).getName();
						if (detailTemp.isIs_submit() && !detailTemp.isIs_audit()) {//待审核
				%>
				<li class="list-teacher"><%=name%></li>
				<%
					}
					}
				%>
				<li class="small">--已审核--</li>
				<%
					for (int i = 0; i < detailTables.size(); i++) {
						detailTemp = detailTables.get(i);
						name = userService.findByCardID(detailTemp.getCardID(), UserService.COLLECTIONUSER).getName();
						System.out.println("name:" + name);
						if (detailTemp.isIs_submit() && detailTemp.isIs_audit()) {//已审核
				%>
				<li class="list-teacher"><%=name%></li>
				<%
					}
					}
				%>

			</ul>
		</div>
		<div class="col-md-11">

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
					<a href="#" onclick="ajaxSend()"> <i class="fa fa-send"
						style="font-size: 18px"></i> <span>提交</span>
					</a> <a href="supportingMaterial.jsp"> <i class="fa fa-upload"
						style="font-size: 18px"></i> <span>佐证材料</span>
					</a> <a href="previewTeacher.jsp"> <i class="fa fa-file-text-o"
						style="font-size: 18px"></i> <span>预览表格</span>
					</a>
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
								<form action="processDetail.do" method="post" onsubmit="">
									<input name="type" value="detail-<%=i%>" type="hidden">
									<table border="1" cellspacing="0" cellpadding="0">
										<tr>
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
														<td class="width_50">
															<!--教师自评分--> <%=thirdDetail.teacher_score%></div>
														</td>
														<td class="width_300">
															<!--依据--> <%=thirdDetail.proof%>
														</td>
													</tr>
													<%
														}
													%>
												</table>
											</td>
											<td>
												<div class="textarea <%=j%>-score" contenteditable="true"
													style="height: 100%; width: 100%;">
													<%=score.second_indicator.get(j).auditor_score%>
												</div> <input class="<%=j%>-score-input" name="content"
												type="hidden" />
											</td>
											<!--审核分-->

										</tr>
										<%
											}
										%>
									</table>
									<input type="submit" class="btn btn-primary float-right"
										value="保存" style="width: 120px;">
								</form>
							</div>
						</div>
						<%
							}
						%>

						<!--<工作量>-->
						<div class="tab-pane" id="tab<%=i%>">
							<table border="1" cellspacing="0" cellpadding="0">
								<tr>
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
								<tr>
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
	<script>
		function addLine() {
			var tpl = "";
			tpl += "<tr>";
			for (j = 0; j < 6; j++) {
				tpl += "<td>";
				tpl += "<div class=\"textarea\" contenteditable=\"true\" style=\"width:100%;\"></div>";
				tpl += "</td>";
			}
			tpl += "</tr>";
			return tpl;
		}

		$(".add").click(
				function() {
					$(this).parent().parent().children().eq(0).children()
							.append(addLine());
				});

		$(".form-control").change(function() {
			var value = $(".form-control").val();
			$("#endyear").text(parseInt(value) + 1);
			$("#submit").submit();
		});
	</script> </main>

	<footer>
		© 2018 <img src="img/heart.png" alt=""> 杭州师范大学
	</footer>
	<!-- 
        <!-- 内置浏览器 -->
	<script type="text/javascript">
		$('.list-teacher').click(function() {
			$('.list-teacher').css('background', '#fff');
			$(this).css('background', '#eee');
			// 获取点击的行中的数据
			//                window.location = "auditor.jsp?index=" + $(this).index();
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
