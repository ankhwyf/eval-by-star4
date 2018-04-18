/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package star4.eval.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import star4.eval.bean.DetailTable;
import star4.eval.service.DetailService;

/**
 *
 * @author ankhyfw
 */
@WebServlet(urlPatterns = {"/processAudit.do"})
public class AuditServlet extends HttpServlet {
    
     private final DetailService detailService = new DetailService();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        int temp = 0;

        String type = request.getParameter("type");
        if (type == null || type.length() == 0) {
            type = "submit";
        } else {
            String[] strSpilt = type.split("-");
            temp = Integer.parseInt(strSpilt[1]);
        }

        // 发布
        switch (type) {
            case "submit":
                String success = dealSubmitAudit(request, response) + "";
                session.setAttribute("success", success);
                System.out.println("success`1:" + success);
                break;
            default:
                dealAuditSubTable(request, response, temp);
                break;
        }
        response.sendRedirect("home");

    }

    public boolean dealAuditSubTable(HttpServletRequest request, HttpServletResponse response, int temp) {
        //获取二级指标表格长度
        String length = request.getParameter("length");
        int subLength = 0;
        if (length != null && length.length() != 0) {
            subLength = Integer.parseInt(length);
        }

        HttpSession session = request.getSession();
        DetailTable detailTable = (DetailTable) session.getAttribute("detailTable");
        DetailService service = new DetailService();
        for (int j = 0; j < subLength; j++) {
            String score = request.getParameter("score-" + j);

            if (score != null) {
                detailTable.getTables().get(temp).second_indicator.get(j).auditor_score = score;
            }

        }
        return service.updateDetail(detailTable);
    }

    public boolean dealSubmitAudit(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        int index = Integer.parseInt((String)session.getAttribute("index"));
        List<DetailTable> detailTables = (List<DetailTable>)session.getAttribute("detailTables");
        
        DetailTable detailTable = detailTables.get(index);
        
        DetailService service = new DetailService();
        List<DetailTable.SubTableDe> scores = detailTable.getTables();
        DetailTable.SubTableDe score;

        int auditSco = 0;
        String badStr = "不合格";
        boolean flag = true;
        
        for (int i = 0; i < scores.size(); i++) {
            score = scores.get(i);
            for (int j = 0; j < score.second_indicator.size(); j++) {
                String auditScoreStr = score.second_indicator.get(j).auditor_score;
                if(!auditScoreStr.equals("")){
                    if (detailService.isContainNumber(auditScoreStr)) {
                            auditSco += Integer.parseInt(auditScoreStr);
                        } else if (auditScoreStr.contains(badStr)) {
                            detailTable.setAuditor_total_sco(badStr);
                            score.second_indicator.get(j).auditor_score = badStr;
                            flag = false;
                            break;
                        }
                } else {
                    score.second_indicator.get(j).auditor_score = 0 + "";
                }
            }
        }
        if(flag){
            if(auditSco > 100){
                auditSco = 100;
            }
            detailTable.setAuditor_total_sco(auditSco + "");
        }
        
        detailTable.setIs_audit(true);

        return service.updateDetail(detailTable);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
