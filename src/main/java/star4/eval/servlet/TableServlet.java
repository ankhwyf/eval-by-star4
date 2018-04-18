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
import star4.eval.bean.EvalTable;
import star4.eval.bean.User;
import star4.eval.service.DetailService;
import star4.eval.service.EvalTableService;
import star4.eval.service.UserService;

/**
 *
 * @author ankhyfw
 */
@WebServlet(urlPatterns = {"/getTable.do"})
public class TableServlet extends HttpServlet {

    private final EvalTableService evalTableService = new EvalTableService();
    private final DetailService detailTableService = new DetailService();

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
        String year = request.getParameter("year");
        String yearDetail = request.getParameter("yearDetail");
        String yearTeacher = request.getParameter("yearTeacher");
        
        String identity = request.getParameter("identity");
        
        EvalTable evalTable;
        User user = (User) session.getAttribute("user");
        
        if (identity == null || identity.length() == 0) {
            identity = (String) session.getAttribute("identity");
            if (identity == null || identity.length() == 0) {
                identity = user.getIdentity().get(0);
            }
        }

        System.out.println("getTable--identity:" + identity);
        System.out.println("getTable--yearDetail:" + yearDetail);

        session.setAttribute("identity", identity);

        switch (identity) {
            case UserService.COLLECTIONA: //审核员
                List<DetailTable> detailTables = detailTableService.findAllTablesByYear(yearDetail);
                evalTable = evalTableService.findEvalByAcademicYear(yearDetail);
                session.setAttribute("detailTables", detailTables);
                session.setAttribute("evalTable", evalTable);
                session.setAttribute("yearDetail", yearDetail);
                break;
            case UserService.COLLECTIONT: //教师
                DetailTable detailTable = detailTableService.findDetailTable(yearTeacher,user.getCardID());
                evalTable = evalTableService.findEvalByAcademicYear(yearTeacher);
                System.out.println("------tableServlet" + yearTeacher);
                
                session.setAttribute("detailTable", detailTable);
                session.setAttribute("evalTable", evalTable);
                session.setAttribute("yearTeacher", yearTeacher);
                break;
            default: //管理员
                evalTable = evalTableService.findEvalByAcademicYear(year);
                System.out.println("getTableServlet..." + year);
                
                session.setAttribute("evalTable", evalTable);
                session.setAttribute("year", year);
                break;
        }
        response.sendRedirect("home");
    }

    // <editor-fold defaultstate="flapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
