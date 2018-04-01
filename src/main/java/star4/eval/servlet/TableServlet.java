/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package star4.eval.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import star4.eval.bean.EvalTable;
import star4.eval.bean.User;
import star4.eval.service.EvalTableService;
import star4.eval.service.UserService;

/**
 *
 * @author ankhyfw
 */
@WebServlet(urlPatterns = {"/getTable.do"})
public class TableServlet extends HttpServlet {

    private final EvalTableService evalTableService = new EvalTableService();

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
        
        String type=request.getParameter("type");
        
        HttpSession session = request.getSession();
//        User user=(User)session.getAttribute("user");
        
        EvalTable evalTable = evalTableService.findByAcademicYear(year);
        
        session.setAttribute("evalTable", evalTable);
        request.setAttribute("year", year);
        request.setAttribute("type", type);
        
        switch (type) {
                case UserService.CNCOLLECTIONC:
//                    response.sendRedirect("admin.jsp");
                    request.getRequestDispatcher("admin.jsp").forward(request, response);
                    break;
                case UserService.CNCOLLECTIONA:
                    response.sendRedirect("auditor.jsp");
                    break;
                default:
                    response.sendRedirect("teacher.jsp");
                    break;
            }
//        request.getRequestDispatcher("teachingEffort_admin.jsp").forward(request, response);
        System.out.println("getTableServlet...");
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
