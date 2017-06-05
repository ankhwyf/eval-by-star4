package star4.eval.servlet;

import com.google.gson.Gson;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mongodb.DBObject;

import star4.eval.MongoDBInterface;
import star4.eval.bean.EvalTable;
import star4.eval.bean.User;

@WebServlet(urlPatterns = {"/login.do"})
public class LoginServlet extends HttpServlet {

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
            MongoDBInterface db = new MongoDBInterface();
            DBObject str;
            str = db.queryUser(loginType, loginName, loginPwd);
            
//	查询失败
            if (str == null) {
                req.setAttribute("loginError", true);
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            } else {
                User user = new User();
                String username = (String) str.get("name");//姓名
                String userEmail = (String) str.get("email");//null
                String userCardID = (String) str.get("cardID");
                user.setName(username);
                user.setEmail(userEmail);
                user.setCardID(userCardID);
                user.setPassword(loginPwd);
                user.setType(loginType);
                
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(60*60);
            }
            switch (loginType) {
                case MongoDBInterface.CNCOLLECTIONC:
                    DBObject strTable = db.queryTable("2016");
                    EvalTable evalTable = new Gson().fromJson(strTable.toString(), EvalTable.class);
                    session.setAttribute("evalTable",evalTable);
                    resp.sendRedirect("teachingEffort_admin.jsp");
                    break;
                case MongoDBInterface.CNCOLLECTIONA:
                    resp.sendRedirect("teachingEffort_auditor.jsp");
                    break;
                default:
                    resp.sendRedirect("teachingEffort_teacher.jsp");
                    break;
            }
            db.close();
        }
        System.out.println("get LoginServlet...");
    }
}
