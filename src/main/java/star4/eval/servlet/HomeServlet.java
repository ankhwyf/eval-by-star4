/*
 * Copyright (C) 2017 star4
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

@WebServlet(urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    private final EvalTableService evalTableService = new EvalTableService();
    private final DetailService detailService = new DetailService();

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        String year = (String) session.getAttribute("year");
        String yearDetail = (String) session.getAttribute("yearDetail");
        String yearTeacher = (String) session.getAttribute("yearTeacher");
        
        String[] years = evalTableService.findAllYears();
        String[] yearsDetail = detailService.findAllYearsDe();
        
        EvalTable evalTable;
        DetailTable detailTable;

        if (user != null && user.getIdentity() != null) {
            //获取身份
            String identity = (String) request.getParameter("identity");
            System.out.println("identity:" + identity);

            if (identity == null || identity.length() == 0) {
                identity = (String) session.getAttribute("identity");
                if (identity == null || identity.length() == 0) {
                    identity = user.getIdentity().get(0);
                }
            }

            session.setAttribute("identity", identity);
            switch (identity) {
                case UserService.COLLECTIONC: //管理員
                    if (year == null || year.length() == 0) {
                        year = years[years.length - 1];
                    }
                    evalTable = evalTableService.findEvalByAcademicYear(year);
                    session.setAttribute("evalTable", evalTable);
                    //考核表年份列表
                    session.setAttribute("year", year);
                    session.setAttribute("years", years);
                    loginByAdmin(request, response);
                    break;
                case UserService.COLLECTIONA: //审核员
                    if (yearDetail == null || yearDetail.length() == 0) {
                        yearDetail = yearsDetail[yearsDetail.length - 1];
                    }
                    String index = request.getParameter("index");
                    if(index == null || index.length() == 0){
                        index = "0";
                    }
                    
                    evalTable = evalTableService.findEvalByAcademicYear(yearDetail);
                    List<DetailTable> detailTables = detailService.findAllTablesByYear(yearDetail);
                    
                    session.setAttribute("evalTable", evalTable);
                    session.setAttribute("detailTables", detailTables);
                    // 细则年份列表
                    session.setAttribute("yearsDetail", yearsDetail);
                    session.setAttribute("yearDetail", yearDetail);
                    
                    session.setAttribute("index", index);
                    loginByAuditor(request, response);
                    break;
                default: //教师
                    String[] yearsTeacher = detailService.findYearsByCardID(user.getCardID());
                    if (yearTeacher == null || yearTeacher.length() == 0) {
                        yearTeacher = yearsTeacher[yearsTeacher.length - 1];
                    }
                    evalTable = evalTableService.findEvalByAcademicYear(yearTeacher);
                    detailTable = detailService.findDetailTable(yearTeacher,user.getCardID());
                    session.setAttribute("detailTable", detailTable);
                    session.setAttribute("evalTable", evalTable);
                    // 细则年份列表
                    session.setAttribute("yearsTeacher", yearsTeacher);
                    session.setAttribute("yearTeacher", yearTeacher);
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
