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
import star4.eval.bean.DetailTable.SubTableDe;
import star4.eval.bean.DetailTable.ThirdIndicatorDe;
import star4.eval.service.DetailService;

/**
 *
 * @author ankhyfw
 */
@WebServlet(urlPatterns = {"/processDetail.do"})
public class DetailServlet extends HttpServlet {
 private final DetailService detailService = new DetailService();
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
        String loadSize = request.getParameter("loadSize");
        int temp = 0;
        int size = 0;

        if (loadSize != null && loadSize.length() != 0) {
            size = Integer.parseInt(loadSize);
        }

        String type = request.getParameter("type");
        if (type == null || type.length() == 0) {
            type = "publish";
        } else if (!type.equals("load-detail")) {
            String[] strSpilt = type.split("-");
            temp = Integer.parseInt(strSpilt[1]);
        }

    
        // 发布
        String success;
        switch (type) {
            case "load-detail":
                dealLoadDetail(request, response, size);
                break;
            case "publish":
                success = dealPublish(request, response) + "";
                request.setAttribute("success", success);
                break;
            default:
                dealSubTableDe(request, response, temp);
                break;
        }
        response.sendRedirect("home");
    }

    public boolean dealSubTableDe(HttpServletRequest request, HttpServletResponse response, int temp) {

        String[] scores = request.getParameterValues("score");
        String[] proofs = request.getParameterValues("proof");

        HttpSession session = request.getSession();
        DetailTable detailTable = (DetailTable) session.getAttribute("detailTable");
        DetailService service = new DetailService();

        if (proofs != null && scores != null) {
            List<DetailTable.ThirdIndicatorDe> thirdList = new ArrayList<>();
            int proofLength = proofs.length;
            int scoreLength = scores.length;
            for (int i = 0; i < proofLength && i < scoreLength; i++) {
                String score = "";
                String proof = "";
                if (i < scoreLength) {
                    score = scores[i];
                }
                if (i < proofLength) {
                    proof = proofs[i];
                }

                DetailTable.ThirdIndicatorDe third = (new DetailTable()).new ThirdIndicatorDe();
                third.proof = proof;
                third.teacher_score = score;
                System.out.println(score + "---proof" + proof);
                thirdList.add(third);
            }
            List<DetailTable.SecondIndicatorDe> secondIndicator = detailTable.getTables().get(temp).second_indicator;
            int size = secondIndicator.size();
            for (int i = 0; i < size; i++) {
                secondIndicator.get(i).third_indicator.clear();
            }
            for (int i = 0; i < size; i++) {
                secondIndicator.get(i).third_indicator.addAll(thirdList);
            }
        }
        return service.updateDetail(detailTable);
    }

    public boolean dealLoadDetail(HttpServletRequest request, HttpServletResponse response, int loadSize) {
        HttpSession session = request.getSession();
        DetailTable detailTable = (DetailTable) session.getAttribute("detailTable");
        DetailService service = new DetailService();
        
        List<String> loadStrs = new ArrayList<>();
        String[][] loadTable = new String[loadSize][];
        int m = 0;
        String loadStr = "";
        for (int i = 0; i < loadSize; i++) {
            String[] contents = request.getParameterValues("load-" + i);
            int contentSize = contents.length;
            loadTable[i] = new String[contentSize];
            System.arraycopy(contents, 0, loadTable[i], 0, contentSize);
        }
        for (int i = 0; i < loadTable.length; i++) {
            for (int j = 0; j < loadTable[i].length; j++) {
                System.out.println("i:" + i + "j:" + j +" "+ loadTable[i][j]);
            }
        }

        while (m < loadTable[0].length) {
            for (String[] loadTable1 : loadTable) {
                String content = loadTable1[m];
                if (content == null || content.length() == 0) {
                    content = " ";
                }
                loadStr += content + ",";
            }
            System.out.println("loadStr:"+loadStr);
            loadStrs.add(loadStr);
            loadStr = "";
            ++m;
        }

        detailTable.setEffortTable(loadStrs);

        return service.updateDetail(detailTable);
    }

    public boolean dealPublish(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        DetailTable detailTable = (DetailTable) session.getAttribute("detailTable");
        
        DetailService service = new DetailService();
        
        List<SubTableDe> scores = detailTable.getTables();
        SubTableDe score;
        ThirdIndicatorDe thirdDetail;
        
        int teacherSco = 0;
        String badStr = "不合格";
         for (int i = 0; i < scores.size(); i++) {
             score = scores.get(i);
             for (int j = 0; j < score.second_indicator.size(); j++) {
                 for (int z = 0; z < score.second_indicator.get(j).third_indicator.size(); z++) {
                     thirdDetail = score.second_indicator.get(j).third_indicator.get(z);
                     String teaScore = thirdDetail.teacher_score;
                     if(!teaScore.equals("")){
                         if(detailService.isContainNumber(teaScore))
                         {
                             teacherSco += Integer.parseInt(teaScore);
                         } else if(teaScore.contains(badStr))
                         {
                                 detailTable.setTeacher_total_sco(badStr);
                                 break;
                         }
                     }
                     else thirdDetail.teacher_score = 0+"";
                 }
             }
         }
         
        detailTable.setTeacher_total_sco(teacherSco+"");
        
        detailTable.setIs_submit(true);
        
        return service.updateDetail(detailTable);
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
