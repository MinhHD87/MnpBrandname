/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.service;

import gk.myname.vn.entity.Contract;
import gk.myname.vn.utils.DateProc;
import gk.myname.vn.utils.Tool;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author MinhKudo
 */
@WebServlet(name = "UploadServlet", urlPatterns = {"/UploadServlet"})
public class UploadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // location to store file uploaded
    private static final String UPLOAD_DIRECTORY = "upload/contract";

    // upload settings
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String file_path = "";
        try {
            boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
            if (!isMultiPart) {

            } else {
                List<FileItem> items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
                Iterator iter = items.iterator();
                Hashtable<String, String> params = new Hashtable<>();
                String fileName = null;
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (item.isFormField()) {
                        params.put(item.getFieldName(), item.getString());
                    } else {
                        try {
                            String itemName = item.getName();
                            fileName = itemName.substring(itemName.lastIndexOf("\\") + 1);
                            String RealPath = getServletContext().getRealPath("/") + "upload/contract/" + fileName;
//                            File file = new File(RealPath);
//                            if (!file.exists()) {
//                                if (file.mkdir()) {
//                                    System.out.println("ok");
//                                } else {
//                                    System.out.println("failse");
//                                }
//                            }
                            File savedFile = new File(RealPath);
                            item.write(savedFile);
                            file_path = fileName;
                        } catch (Exception e) {
                            System.out.println(e.getMessage());
                        }
                    }
                }
                HttpSession session = request.getSession();
                int subID = Tool.string2Integer(params.get("subID"));
                int partnerID = Tool.string2Integer(params.get("partnerID"));
                String contract_no = Tool.validStringRequest(params.get("contract_no"));
                Timestamp start_time = DateProc.String2Timestamp(params.get("start_time"));
                Timestamp expire_time = DateProc.String2Timestamp(params.get("expire_time"));
                int auto_renew = Tool.string2Integer(params.get("auto_renew"));
                String option_info = Tool.validStringRequest(params.get("option_info"));
                int vte = Tool.string2Integer(params.get("vte"));
                int vms = Tool.string2Integer(params.get("vms"));
                int vina = Tool.string2Integer(params.get("vina"));
                int vnm = Tool.string2Integer(params.get("vnm"));
                int bl = Tool.string2Integer(params.get("bl"));
//                int email_id = Tool.string2Integer(params.get("emaiID"));

                if (subID == 0 || partnerID == 0 || contract_no.equals("")) {
                    session.setAttribute("mess", "Chi nhánh, Cộng sự, Hợp đồng không được để trống");
                    response.sendRedirect(request.getContextPath() + "/admin/contract/");
                    return;
                }
                
                Contract contr = new Contract();
                contr.setSub_id(subID);
                contr.setPartner_id(partnerID);
                contr.setContract_no(contract_no);
                contr.setStart_time(start_time);
                contr.setExpire_time(expire_time);
                contr.setAuto_renew(auto_renew);
                contr.setOption_info(option_info);
                contr.setFile_path(file_path);
                contr.setVte(vte);
                contr.setVms(vms);
                contr.setVina(vina);
                contr.setVnm(vnm);
                contr.setBl(bl);
//                contr.setEmail_id(email_id);
                //------------
                Contract contract = new Contract();

                if (contract.add(contr)) {
                    session.setAttribute("mess", "Thêm mới đối tác thành công!");
                } else {
                    session.setAttribute("mess", "Thêm mới dữ liệu lỗi! Hợp đồng có thể đã tồn tại");
                }
                response.sendRedirect(request.getContextPath() + "/admin/contract/");
                return;
            }
        } catch (Exception e) {
            System.out.print("loi");
        }
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
