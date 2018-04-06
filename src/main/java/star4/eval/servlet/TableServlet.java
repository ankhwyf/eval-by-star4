/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package star4.eval.servlet;

import java.io.IOException;import java.util.ArrayList;
import java.util.List;
;
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
    private final UserService userService=new UserService();

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
        String year = request.getParameter("year");
        System.out.println("------" + year);
        
        String identity = request.getParameter("identity");
        
        HttpSession session = request.getSession();
        EvalTable evalTable;
        DetailTable detailTable;
        
        if(identity==null || identity.length()==0){
             User user = (User) session.getAttribute("user");
             identity = user.getIdentity().get(0);
             request.setAttribute("identity", identity);
             System.out.println("identity"+identity);
        }
        
        request.setAttribute("year", year);
        request.setAttribute("identity", identity);
        System.out.println("getTableServlet..."+year);
        
        switch (identity) {
                case UserService.COLLECTIONA: //审核员
                    detailTable=detailTableService.findDetailByAcademicYear(year);
                    session.setAttribute("detailTable", detailTable);
                    request.getRequestDispatcher("/WEB-INF/views/tables/auditor.jsp").forward(request, response);
                    break;
                case UserService.COLLECTIONT: //教师
                    detailTable=detailTableService.findDetailByAcademicYear(year);
                    session.setAttribute("detailTable", detailTable);
                    request.getRequestDispatcher("/WEB-INF/views/tables/teacher.jsp").forward(request, response);
                    break;
                default: //管理员
                    evalTable = evalTableService.findEvalByAcademicYear(year);
                    session.setAttribute("evalTable", evalTable);
//                    response.sendRedirect("admin.jsp");
                    request.getRequestDispatcher("/WEB-INF/views/tables/admin.jsp").forward(request, response);
                    break;
            }
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
