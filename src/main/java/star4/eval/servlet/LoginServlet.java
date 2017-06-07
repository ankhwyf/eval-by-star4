package star4.eval.servlet;

import com.google.gson.Gson;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
<<<<<<< HEAD

import com.mongodb.DBObject;

import star4.eval.MongoDBInterface;
=======
>>>>>>> e58379e4eeedff2472c08f6c65d2e88dfe9bc700
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
<<<<<<< HEAD
          
=======

>>>>>>> e58379e4eeedff2472c08f6c65d2e88dfe9bc700
        req.setCharacterEncoding("UTF-8");
        String loginName = req.getParameter("login_name");
        String loginPwd = req.getParameter("login_pwd");
        String loginType = req.getParameter("radio_item");
        HttpSession session = req.getSession();
        if (loginName == null || loginPwd == null) {
            req.setAttribute("loginError", true);
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        } else {
<<<<<<< HEAD
            MongoDBInterface db = new MongoDBInterface();
            DBObject str;
            str = db.queryUser(loginType, loginName, loginPwd);
            
=======
            User user = userService.checkLoginUser(loginName, loginPwd, loginType);
>>>>>>> e58379e4eeedff2472c08f6c65d2e88dfe9bc700
//	查询失败
            if (user == null) {
                req.setAttribute("loginError", true);
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            } else {
<<<<<<< HEAD
                User user = new User();
                String username = (String) str.get("name");//姓名
                String userEmail = (String) str.get("email");//null
                String userCardID = (String) str.get("cardID");
                user.setName(username);
                user.setEmail(userEmail);
                user.setCardID(userCardID);
                user.setPassword(loginPwd);
                user.setType(loginType);
                
=======
>>>>>>> e58379e4eeedff2472c08f6c65d2e88dfe9bc700
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(60*60);
            }
            EvalTable evalTable = evalTableService.findByAcademicYear("2016");
            session.setAttribute("evalTable", evalTable);
            switch (loginType) {
<<<<<<< HEAD
                case MongoDBInterface.CNCOLLECTIONC:
                    DBObject strTable = db.queryTable("2016");
                    EvalTable evalTable = new Gson().fromJson(strTable.toString(), EvalTable.class);
                    session.setAttribute("evalTable",evalTable);
                    resp.sendRedirect("teachingEffort_admin.jsp");
=======
                case UserService.CNCOLLECTIONC:
                    resp.sendRedirect("admin.jsp");
>>>>>>> e58379e4eeedff2472c08f6c65d2e88dfe9bc700
                    break;
                case UserService.CNCOLLECTIONA:
                    resp.sendRedirect("auditor.jsp");
                    break;
                default:
                    resp.sendRedirect("teacher.jsp");
                    break;
            }
        }
        System.out.println("get LoginServlet...");
    }
}
