
<%@page import="star4.eval.bean.DetailTable"%>
<%@page import="java.util.List"%>
<%@page import="star4.eval.service.DetailService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="titleBar.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>statistics</title>
        <link rel="stylesheet" href="css/statistics.css">

    </head>
    <body>
        <main class="container">
            <div class="row title">
                <div class="col-md-7 smalltitle">
                    <i class="fa fa-bar-chart"></i>
                    <strong>统计</strong>
                </div>
                <div class="col-md-5 text-right back">
                    <a href="home">返回>></a>
                </div>
            </div>
            <%                String year = (String) session.getAttribute("year");
                System.out.println("yearyearyear:"+year);
                DetailService detailService = new DetailService();
                List<DetailTable> details = detailService.findAllTablesByYear(year);
                DetailTable detailTable;
                int[] submit = {0, 0};
                int[] audit = {0, 0};
                int[] rank = {0, 0};
                for (int i = 0; i < details.size(); i++) {
                    detailTable = details.get(i);

                    if (detailTable.isIs_submit()) {
                        submit[1]++;
                    } else {
                        submit[0]++;
                    }
                    if (detailTable.isIs_audit()) {
                        audit[1]++;
                    } else {
                        audit[0]++;
                    }
                    if (detailTable.isIs_submit() && detailTable.isIs_audit()) {
                        String auditSco = detailTable.getAuditor_total_sco();
                        if (detailService.isContainNumber(auditSco)) {
                            int score = Integer.parseInt(auditSco);
                            if (score >= 60 && score <= 100) {
                                rank[1]++;
                            } else {
                                rank[0]++;
                            }
                        } else if (auditSco.equals("不合格")) {
                            rank[0]++;
                        }
                    }
                }

            %>
            <div class="row content">
                <div class="col-md-4">
                    <div class="configure" id="submitInformation">

                    </div>
                </div>

                <div class="col-md-4">
                    <div class="configure" id="auditInformation">

                    </div>
                </div>
                <div class="col-md-4">
                    <div class="configure" id="rankInformation">

                    </div>
                </div>
            </div>


        </main>
        <footer>
            © 2018 <img src="img/heart.png" alt=""> 杭州师范大学
        </footer>
    </body>

    <script type="text/javascript">
        var submit = new Array();
        var audit = new Array();
        var rank = new Array();
        submit[0] = <%=submit[0]%>;
        submit[1] = <%=submit[1]%>;
        audit[0] = <%=audit[0]%>;
        audit[1] = <%=audit[1]%>;
        rank[0] = <%=rank[0]%>;
        rank[1] = <%=rank[1]%>;
    </script>
    <script type="text/javascript" src="js/tools/echarts.min.js"></script>
    <script type="text/javascript" src="js/statistics.js"></script>
</html>
