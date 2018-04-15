/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package star4.eval.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import star4.eval.bean.EvalTable;
import star4.eval.service.EvalTableService;

/**
 *
 * @author ankhyfw
 */
@WebServlet(urlPatterns = {"/getIndex.do"})
public class ConfigureServlet extends HttpServlet {

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
        String test = (String) request.getParameter("test");
        if (test == null || test.length() == 0) {
            test = "0";
        }
        request.setAttribute("test", test);
        
        String successCreated = "";
        successCreated = dealCreate(request,response) + "";
        request.setAttribute("successCreated", successCreated);
        
        request.getRequestDispatcher("home").forward(request, response);
    }
      public boolean dealCreate(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
        EvalTableService service = new EvalTableService();
        
        String[] years = service.findAllYears();
        String year = years[years.length-1];
        year = service.changeYear(year);
        
        evalTable.setAcademic_year(year);
        evalTable.setIs_publish(false);
        
        return service.insertEval(evalTable);
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
