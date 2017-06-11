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
        service.update(evalTable);
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
