/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.service;

import gk.myname.vn.admin.Account;
import gk.myname.vn.entity.Campaign;
import gk.myname.vn.utils.RequestTool;
import gk.myname.vn.utils.Tool;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author Private
 */
@WebServlet(name = "DownloadCamPaign", urlPatterns = {"/DownloadCamPaign"})
public class DownloadCamPaign extends HttpServlet {

    static Logger logger = Logger.getLogger(DownloadCamPaign.class);

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
//        response.setContentType("text/html;charset=UTF-8");
        try {
            int cpid = RequestTool.getInt(request, "cpid");
            Campaign cpDao = new Campaign();
            cpDao = cpDao.findById(cpid);
            HttpSession session = request.getSession();
            Account acc = Account.getAccount(session);
            if (acc != null) {
                if (cpDao != null) {
                    File f = new File("/data/webroot/upload/campaign/advertisement/" + cpDao.getId() + "-" + cpDao.getCampaignId() + ".xlsx");
                    if (f.exists()) {
                        ServletOutputStream sout = null;
                        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                        response.setHeader("Content-Disposition", "attachment; filename="+ cpDao.getId() + "-" + cpDao.getCampaignId() + ".xlsx");
                        sout = response.getOutputStream();
                        sout.flush();
                        FileInputStream fin = new FileInputStream(f);
                        try {
                            copy(fin, sout);
                        } finally {
                            if (fin != null) {
                                fin.close();
                            }
                        }
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            logger.error(Tool.getLogMessage(ex));
        }
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
    private static final int bufferSize = 8192;

    public static void copy(InputStream in, OutputStream out) throws IOException {
        byte[] buffer = new byte[bufferSize];
        int read;

        while ((read = in.read(buffer, 0, bufferSize)) != -1) {
            out.write(buffer, 0, read);
        }
    }
}
