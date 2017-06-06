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

@WebServlet(urlPatterns = {"/login.do"})
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();

    private final EvalTableService evalTableService = new EvalTableService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // TODO Auto-generated method stub
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // TODO Auto-generated method stub

        req.setCharacterEncoding("UTF-8");
        String loginName = req.getParameter("login_name");
        String loginPwd = req.getParameter("login_pwd");
        String loginType = req.getParameter("radio_item");
        HttpSession session = req.getSession();
        if (loginName == null || loginPwd == null) {
            req.setAttribute("loginError", true);
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        } else {
            User user = userService.checkLoginUser(loginName, loginPwd, loginType);
//	查询失败
            if (user == null) {
                req.setAttribute("loginError", true);
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            } else {
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(60 * 60);
            }
            switch (loginType) {
                case UserService.CNCOLLECTIONC:
                    EvalTable evalTable = evalTableService.findByAcademicYear("2016");
                    session.setAttribute("evalTable", evalTable);
                    resp.sendRedirect("evalTable_admin.jsp");
                    break;
                case UserService.CNCOLLECTIONA:
                    resp.sendRedirect("evalTable_auditor.jsp");
                    break;
                default:
                    resp.sendRedirect("evalTable_teacher.jsp");
                    break;
            }
        }
        System.out.println("get LoginServlet...");
    }
}
