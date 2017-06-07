/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package star4.eval.servlet;

<<<<<<< HEAD
import com.google.gson.Gson;
import com.mongodb.DBObject;
=======
>>>>>>> e58379e4eeedff2472c08f6c65d2e88dfe9bc700
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
<<<<<<< HEAD
import star4.eval.MongoDBInterface;
import star4.eval.bean.EvalTable;
=======
import star4.eval.bean.EvalTable;
import star4.eval.service.EvalTableService;
import star4.eval.service.UserService;
>>>>>>> e58379e4eeedff2472c08f6c65d2e88dfe9bc700

/**
 *
 * @author ankhyfw
 */
@WebServlet(urlPatterns = {"/getTable.do"})
public class TableServlet extends HttpServlet {

<<<<<<< HEAD
=======
    private final EvalTableService evalTableService = new EvalTableService();

>>>>>>> e58379e4eeedff2472c08f6c65d2e88dfe9bc700
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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet TableServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TableServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
//        processRequest(request, response);
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
//        processRequest(request, response);
        String year = request.getParameter("year");
<<<<<<< HEAD
        System.out.println("------"+year);
        MongoDBInterface db = new MongoDBInterface();
        DBObject strTable;
        HttpSession session=request.getSession();
        strTable = db.queryTable(year);
       
        EvalTable evalTable = new Gson().fromJson(strTable.toString(), EvalTable.class);
        session.setAttribute("evalTable",evalTable);
        response.sendRedirect("table.jsp");
//        request.getRequestDispatcher("teachingEffort_admin.jsp").forward(request, response);
        System.out.println("getTableServlet...");
        db.close();
=======
        System.out.println("------" + year);
        HttpSession session = request.getSession();

        EvalTable evalTable = evalTableService.findByAcademicYear(year);
        session.setAttribute("evalTable", evalTable);
        
        String loginType="";
         switch (loginType) {
                case UserService.CNCOLLECTIONC:
                    response.sendRedirect("admin.jsp");
                    break;
                case UserService.CNCOLLECTIONA:
                    response.sendRedirect("auditor.jsp");
                    break;
                default:
                    response.sendRedirect("teacher.jsp");
                    break;
            }
        response.sendRedirect("admin.jsp");
//        request.getRequestDispatcher("teachingEffort_admin.jsp").forward(request, response);
        System.out.println("getTableServlet...");
>>>>>>> e58379e4eeedff2472c08f6c65d2e88dfe9bc700
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
