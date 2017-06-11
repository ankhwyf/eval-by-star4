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
import star4.eval.bean.User;
import star4.eval.service.EvalTableService;
import star4.eval.service.UserService;

@WebServlet(urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    private final EvalTableService evalTableService = new EvalTableService();

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null && user.getType() != null) {
            String type = user.getType();
            if (type.equals(UserService.CNCOLLECTIONC)) {
                logonByAdmin(request, response);
            } else if (type.equals(UserService.CNCOLLECTIONA)) {
                logonByAuditor(request, response);
            } else {
                logonByTeacher(request, response);
            }
        } else {
            response.sendRedirect("login");
        }
    }

    private void logonByAdmin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/tables/admin.jsp").forward(request, response);
    }

    private void logonByAuditor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/tables/auditor.jsp").forward(request, response);
    }

    private void logonByTeacher(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/tables/teacher.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
