/*
 * Copyright (C) 2017 star4
 */
package star4.eval.servlet;

import java.io.IOException;
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

@WebServlet(urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {
    
    private final EvalTableService evalTableService=new EvalTableService();
    private final DetailService detailService=new DetailService();
    
    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        User user = (User) session.getAttribute("user");
        
        String[] years=evalTableService.findAll();
        String year=years[years.length-1];
        System.out.println("get Year..."+year);
        
        session.setAttribute("years", years);
        
        EvalTable evalTable;
        DetailTable detailTable;
        
        
        if (user != null && user.getIdentity() != null) {
            String id=user.getIdentity().get(0);
            
            switch (id) {
                case UserService.COLLECTIONC:
                    evalTable = evalTableService.findEvalByAcademicYear(year);
                    session.setAttribute("evalTable", evalTable);
                    loginByAdmin(request, response);
                    break;
                case UserService.COLLECTIONA:
                    detailTable=detailService.findDetailByAcademicYear(year);
                    session.setAttribute("detailTable", detailTable);
                    loginByAuditor(request, response);
                    break;
                default:
                    detailTable=detailService.findDetailByAcademicYear(year);
                    session.setAttribute("detailTable", detailTable);
                    loginByTeacher(request, response);
                    break;
            }
        } else {
            response.sendRedirect("login");
        }
    }

    private void loginByAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/tables/admin.jsp").forward(request, response);
    }

    private void loginByAuditor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/tables/auditor.jsp").forward(request, response);
    }

    private void loginByTeacher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/tables/teacher.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

}
