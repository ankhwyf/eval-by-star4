/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package star4.eval.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import star4.eval.bean.DetailTable;
import star4.eval.bean.DetailTable.SecondIndicatorDe;
import star4.eval.bean.DetailTable.SubTableDe;
import star4.eval.bean.EvalTable;
import star4.eval.bean.EvalTable.Remark;
import star4.eval.bean.EvalTable.SecondIndicator;
import star4.eval.bean.EvalTable.ThirdIndicator;
import star4.eval.bean.DetailTable.ThirdIndicatorDe;
import star4.eval.bean.EvalTable.SubTable;
import star4.eval.bean.User;
import star4.eval.service.DetailService;
import star4.eval.service.EvalTableService;
import star4.eval.service.UserService;

/**
 *
 * @author ankhyfw
 */
@WebServlet(urlPatterns = {"/process.do"})
public class SaveServlet extends HttpServlet {
    

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
        request.setCharacterEncoding("UTF-8");
        String success = "";
        int temp = 0;
        
        
        //处理提交类型
        String type = request.getParameter("type");
        if (type == null || type.equals("")) {
            type = "publish";
        } else if(!type.equals("remark")){
            String[] strSpilt=type.split("-");
            temp=Integer.parseInt(strSpilt[1]);
        }
        
        switch (type) {
            case "remark":
                dealRemark(request, response);
                break;
            case "gzl":
                
                break;
            case "advanced":
                
                break;
            case "publish":
                success = dealPublish(request, response)+"";
                break;
            default:dealSubTable(request, response,temp);
                break;
//            case "routine":
//                dealRoutine(request, response);
//                break;
//            case "construct":
//                dealConstruct(request, response);
//                break;
//            case "others":
//                dealOthers(request, response);
//                break;
        }
        request.setAttribute("success", success);
        
        request.getRequestDispatcher("home").forward(request, response);

    }

    public boolean dealRemark(HttpServletRequest request, HttpServletResponse response) {
        String[] keypoints = request.getParameterValues("keypoint");
        String[] contents = request.getParameterValues("content");

        System.out.println("keypoints:" + keypoints[keypoints.length - 1]);
        System.out.println("get SaveServlet...");

        HttpSession session = request.getSession();
        EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");

        List<Remark> remarkList = new ArrayList<>();
        EvalTableService service = new EvalTableService();
        
        if(keypoints != null && contents!=null){
            for (int i = 0; i < keypoints.length || i < contents.length; i++) {
                String keypoint = keypoints[i];
                String content = contents[i];
                Remark remark = (new EvalTable()).new Remark();
                if (keypoint == null) {
                    keypoint = "";
                }
                if (content == null) {
                    content = "";
                }
                remark.keypoint = keypoint;
                remark.content = content;
                remarkList.add(remark);
            }
        } 
        evalTable.getRemark().clear();
        evalTable.getRemark().addAll(remarkList);
        return service.updateEval(evalTable);
    }

    public boolean dealSubTable(HttpServletRequest request, HttpServletResponse response,int temp) {
        String[] contents = request.getParameterValues("content");
        String[] scores = request.getParameterValues("score");

        System.out.println("get SaveServlet...");

        HttpSession session = request.getSession();
        EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
        EvalTableService service = new EvalTableService();
        
        if(contents!=null && scores!=null){
            List<ThirdIndicator> thirdList = new ArrayList<>();
            int contentLength = contents.length;
            int scoreLength = scores.length;
            for (int i = 0; i < contentLength && i < scoreLength; i++) {
                String score = "";
                String content = "";
                if (i < contentLength) {
                    score = scores[i];
                }
                if (i < scoreLength) {
                    content = contents[i];
                }
                ThirdIndicator third = (new EvalTable()).new ThirdIndicator();
                third.score = score;
                third.content = content;
                System.out.println(score + "---" + content);
                thirdList.add(third);
            }
            List<SecondIndicator> secondIndicator = evalTable.getTables().get(temp).second_indicator;
            int size = secondIndicator.size();
            for(int i=0; i<size; i++){
                secondIndicator.get(i).third_indicator.clear();
            }
            for(int i=0;i<size;i++){
                secondIndicator.get(i).third_indicator.addAll(thirdList);
            }
        }
        return service.updateEval(evalTable);
    }


    public boolean dealPublish(HttpServletRequest request, HttpServletResponse response) {
        EvalTableService service = new EvalTableService();
        DetailService detailService = new DetailService();
        UserService userService = new UserService();
        DetailTable detailTable = new DetailTable();
        
        List<User> usersList = new ArrayList();
        usersList = userService.findAll();
        
        HttpSession session = request.getSession();
        EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
        
        // 未发布时，则为所有教师更新表格
        if(!evalTable.isIs_publish()) {
            for (User usersList1 : usersList) {
                detailTable.setCardID(usersList1.getCardID());
                detailTable.setAcademic_year(evalTable.getAcademic_year());
                detailTable.setIs_submit(false);
                detailTable.setIs_audit(false);
                detailTable.setAudit_level("");
                detailTable.setGrade_proof("");
                detailTable.setTeacher_total_sco("");
                detailTable.setAuditor_total_sco("");
                detailTable.setCollege_admin_sco("");
                
                List<SubTable> evalTables = evalTable.getTables();
                List<String> effortTable = evalTable.getEffortTable();
                
                SubTableDe subTableDe = new DetailTable().new SubTableDe();
                
                List<String> effort = new ArrayList();
                List<SubTableDe> detailTables = new ArrayList<>();
                List<ThirdIndicatorDe> thirdIndicatorDes = new ArrayList<>();
                List<SecondIndicatorDe> secondIndicatorDes = new ArrayList<>();
                for (int z = 0; z < evalTables.size(); z++) {
                    SubTable sub = evalTables.get(z);
                    for(int j = 0; j< sub.second_indicator.size(); j++) {
                        SecondIndicatorDe second = (new DetailTable()).new SecondIndicatorDe();
                        SecondIndicator sec = sub.second_indicator.get(j);
                        second.auditor_score = "";
                        for (int i=0;i<sec.third_indicator.size();i++) {
                            ThirdIndicatorDe third = (new DetailTable()).new ThirdIndicatorDe();
                            third.teacher_score = "";
                            third.proof = "";
                            thirdIndicatorDes.add(third);
                        }
                        secondIndicatorDes.add(second);
                        subTableDe.second_indicator = secondIndicatorDes;
                    }
                    detailTables.add(subTableDe);
                }
                
                detailTable.setTables(detailTables);
                String str="";
                for(int i=1;i<effortTable.size();i++){
                    str+=",";
                }
                effort.add(str);
                detailTable.setEffortTable(effort);
                detailService.insertDetail(detailTable);
            }
        }
        evalTable.setIs_publish(true);
        return service.updateEval(evalTable);
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
