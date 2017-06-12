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
import star4.eval.bean.EvalTable;
import star4.eval.bean.EvalTable.Remark;
import star4.eval.bean.EvalTable.ThirdIndicator;
import star4.eval.service.EvalTableService;

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
        
        String type = request.getParameter("type");
        
        switch(type) {
            case "remark":
                dealRemark(request, response);
                break;
            case "gzl":
                dealGzl(request, response);
                break;
            case "routine":
                dealRoutine(request, response);
                break;
            case "construct":
                dealConstruct(request, response);
                break;
            case "others":
                dealOthers(request, response);
                break;
        }
        
    }
    
    public void dealRemark(HttpServletRequest request, HttpServletResponse response) {
        String[] keypoints=request.getParameterValues("keypoint");
        String[] contents=request.getParameterValues("content");
        
        System.out.println("keypoints:" + keypoints[keypoints.length - 1]);
        System.out.println("get SaveServlet...");
        
        HttpSession session = request.getSession();
        EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
        
        List<Remark> remarkList = new ArrayList<>();
        EvalTableService service = new EvalTableService();
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
        evalTable.getRemark().clear();
        evalTable.getRemark().addAll(remarkList);
        service.updateRemark(evalTable);
    }
    
    public void dealGzl(HttpServletRequest request, HttpServletResponse response) {
        String[] contents=request.getParameterValues("content");
        String[] scores=request.getParameterValues("score");
        
        System.out.println("get SaveServlet...");
        
        HttpSession session = request.getSession();
        EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
        
        List<ThirdIndicator> thirdList = new ArrayList<>();
        EvalTableService service = new EvalTableService();
        for (int i = 0; i < scores.length || i < contents.length; i++) {
            String score = scores[i];
            String content = contents[i];
            ThirdIndicator third = (new EvalTable()).new ThirdIndicator();
            if (score == null) {
                score = "";
            }
            if (content == null) {
                content = "";
            }
            third.score = score;
            third.content = content;
            thirdList.add(third);
        }
        evalTable.getTables().get(0).second_indicator.get(0).third_indicator.clear();
        evalTable.getTables().get(0).second_indicator.get(0).third_indicator.addAll(thirdList);
        service.updateGzl(evalTable);
    }
    
    public void dealRoutine(HttpServletRequest request, HttpServletResponse response) {
        String[] basicContents=request.getParameterValues("basic-content");
        String[] basicScores=request.getParameterValues("basic-score");
        String[] extendContents=request.getParameterValues("extend-content");
        String[] extendScores=request.getParameterValues("extend-score");
        
        System.out.println("get SaveServlet...");
        
        HttpSession session = request.getSession();
        EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
        
        List<ThirdIndicator> basicThirdList = new ArrayList<>();
        EvalTableService service = new EvalTableService();
        for (int i = 0; i < basicContents.length || i < basicScores.length; i++) {
            String score = basicScores[i];
            String content = basicContents[i];
            ThirdIndicator third = (new EvalTable()).new ThirdIndicator();
            if (score == null) {
                score = "";
            }
            if (content == null) {
                content = "";
            }
            third.score = score;
            third.content = content;
            basicThirdList.add(third);
        }
        List<ThirdIndicator> extendThirdList = new ArrayList<>();
        for (int i = 0; i < extendContents.length || i < extendScores.length; i++) {
            String score = extendScores[i];
            String content = extendContents[i];
            ThirdIndicator third = (new EvalTable()).new ThirdIndicator();
            if (score == null) {
                score = "";
            }
            if (content == null) {
                content = "";
            }
            third.score = score;
            third.content = content;
            extendThirdList.add(third);
        }
        evalTable.getTables().get(1).second_indicator.get(0).third_indicator.clear();
        evalTable.getTables().get(1).second_indicator.get(1).third_indicator.clear();
        evalTable.getTables().get(1).second_indicator.get(0).third_indicator.addAll(basicThirdList);
        evalTable.getTables().get(1).second_indicator.get(1).third_indicator.addAll(extendThirdList);
        service.updateRoutine(evalTable);
    }
    
    public void dealConstruct(HttpServletRequest request, HttpServletResponse response) {
        String[] basicContents=request.getParameterValues("basic-content");
        String[] basicScores=request.getParameterValues("basic-score");
        String[] extendContents=request.getParameterValues("extend-content");
        String[] extendScores=request.getParameterValues("extend-score");
        
        System.out.println("get SaveServlet...");
        
        HttpSession session = request.getSession();
        EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
        
        List<ThirdIndicator> basicThirdList = new ArrayList<>();
        EvalTableService service = new EvalTableService();
        for (int i = 0; i < basicContents.length || i < basicScores.length; i++) {
            String score = basicScores[i];
            String content = basicContents[i];
            ThirdIndicator third = (new EvalTable()).new ThirdIndicator();
            if (score == null) {
                score = "";
            }
            if (content == null) {
                content = "";
            }
            third.score = score;
            third.content = content;
            basicThirdList.add(third);
        }
        List<ThirdIndicator> extendThirdList = new ArrayList<>();
        for (int i = 0; i < extendContents.length || i < extendScores.length; i++) {
            String score = extendScores[i];
            String content = extendContents[i];
            ThirdIndicator third = (new EvalTable()).new ThirdIndicator();
            if (score == null) {
                score = "";
            }
            if (content == null) {
                content = "";
            }
            third.score = score;
            third.content = content;
            extendThirdList.add(third);
        }
        evalTable.getTables().get(1).second_indicator.get(0).third_indicator.clear();
        evalTable.getTables().get(1).second_indicator.get(1).third_indicator.clear();
        evalTable.getTables().get(1).second_indicator.get(0).third_indicator.addAll(basicThirdList);
        evalTable.getTables().get(1).second_indicator.get(1).third_indicator.addAll(extendThirdList);
        service.updateConstruct(evalTable);
    }
    
    public void dealOthers(HttpServletRequest request, HttpServletResponse response) {
        String[] basicContents=request.getParameterValues("basic-content");
        String[] basicScores=request.getParameterValues("basic-score");
        String[] extendContents=request.getParameterValues("extend-content");
        String[] extendScores=request.getParameterValues("extend-score");
        
        System.out.println("get SaveServlet...");
        
        HttpSession session = request.getSession();
        EvalTable evalTable = (EvalTable) session.getAttribute("evalTable");
        
        List<ThirdIndicator> basicThirdList = new ArrayList<>();
        EvalTableService service = new EvalTableService();
        for (int i = 0; i < basicContents.length || i < basicScores.length; i++) {
            String score = basicScores[i];
            String content = basicContents[i];
            ThirdIndicator third = (new EvalTable()).new ThirdIndicator();
            if (score == null) {
                score = "";
            }
            if (content == null) {
                content = "";
            }
            third.score = score;
            third.content = content;
            basicThirdList.add(third);
        }
        List<ThirdIndicator> extendThirdList = new ArrayList<>();
        for (int i = 0; i < extendContents.length || i < extendScores.length; i++) {
            String score = extendScores[i];
            String content = extendContents[i];
            ThirdIndicator third = (new EvalTable()).new ThirdIndicator();
            if (score == null) {
                score = "";
            }
            if (content == null) {
                content = "";
            }
            third.score = score;
            third.content = content;
            extendThirdList.add(third);
        }
        evalTable.getTables().get(1).second_indicator.get(0).third_indicator.clear();
        evalTable.getTables().get(1).second_indicator.get(1).third_indicator.clear();
        evalTable.getTables().get(1).second_indicator.get(0).third_indicator.addAll(basicThirdList);
        evalTable.getTables().get(1).second_indicator.get(1).third_indicator.addAll(extendThirdList);
        service.updateOthers(evalTable);
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
