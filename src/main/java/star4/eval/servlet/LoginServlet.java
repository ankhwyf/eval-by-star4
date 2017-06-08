package star4.eval.servlet;

import java.io.IOException;
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

@WebServlet(urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    private final EvalTableService evalTableService = new EvalTableService();

    private void logonFailure(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("loginError", true);
        this.doGet(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String loginName = request.getParameter("login_name");
        String loginPwd = request.getParameter("login_pwd");
        String loginType = request.getParameter("radio_item");
        HttpSession session = request.getSession();
        if (loginName == null || loginPwd == null) {
            logonFailure(request, response);
        } else {
            User user = userService.checkLoginUser(loginName, loginPwd, loginType);
//	查询失败
            if (user == null) {
                logonFailure(request, response);
            } else {
                session.setAttribute("user", user);
            }
            EvalTable evalTable = evalTableService.findByAcademicYear("2016");
            session.setAttribute("evalTable", evalTable);
            response.sendRedirect("home");
        }
    }
}
