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
        
        // 考核表年份列表
        String[] years = evalTableService.findAllYears();
        String year = years[years.length-1];
        System.out.println("get Year..."+year);
        
        session.setAttribute("years", years);
        
        // 细则年份列表
        String[] yearsDetail = detailService.findAllYearsDe();
        String yearDetail = yearsDetail[yearsDetail.length-1];
        
        session.setAttribute("yearsDetail", yearsDetail);
        
        EvalTable evalTable;
        DetailTable detailTable;
        
        if (user != null && user.getIdentity() != null) {
             String identity = request.getParameter("identity");
            if(identity == null || identity.length() == 0){
                identity = user.getIdentity().get(1);
            }
        request.setAttribute("identity", identity);
            switch (identity) {
                case UserService.COLLECTIONC: //管理員
                    evalTable = evalTableService.findEvalByAcademicYear(year);
                    session.setAttribute("evalTable", evalTable);
                    loginByAdmin(request, response);
                    break;
                case UserService.COLLECTIONA: //审核员
                    evalTable = evalTableService.findEvalByAcademicYear(yearDetail);
                    detailTable=detailService.findDetailByAcademicYear(yearDetail);
                    session.setAttribute("detailTable", detailTable);
                    session.setAttribute("evalTable", evalTable);
                    loginByAuditor(request, response);
                    break;
                default:
                    evalTable = evalTableService.findEvalByAcademicYear(yearDetail);
                    detailTable=detailService.findDetailByAcademicYear(yearDetail);
                    session.setAttribute("detailTable", detailTable);
                    session.setAttribute("evalTable", evalTable);
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
