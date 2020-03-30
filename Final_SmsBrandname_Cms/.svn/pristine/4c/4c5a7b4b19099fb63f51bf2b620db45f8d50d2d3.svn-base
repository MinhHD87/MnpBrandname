<%@page import="java.nio.file.Files"%><%@page import="java.nio.file.Path"%><%@page import="java.nio.file.FileSystems"%><%@page import="java.util.Enumeration"%><%@page import="java.util.Properties"%><%@page import="java.io.FileNotFoundException"%><%@page import="gk.myname.vn.entity.BrandLabel_Declare"%><%@page import="gk.myname.vn.utils.FileUtils"%><%@page import="java.io.FileInputStream"%><%@page import="java.io.File"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="gk.myname.vn.entity.Campaign"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page contentType="text/html; charset=utf-8" %><%@ page trimDirectiveWhitespaces="true" %>
<%  Account userlogin = Account.getAccount(session);
    try {
        if (userlogin == null) {
            session.setAttribute("error", "Bạn cần đăng nhập để truy cập hệ thống");
            out.print("<script>top.location='" + request.getContextPath() + "/admin/login.jsp';</script>");
            return;
        }
    } catch (Exception ex) {
        System.out.println("Vao Exception CheckLogin:" + ex.getMessage());
        out.print("<script>top.location='" + request.getContextPath() + "/admin/login.jsp';</script>");
        return;
    }
    try {
        int cpid = RequestTool.getInt(request, "bid");
        BrandLabel_Declare brDao = new BrandLabel_Declare();
        brDao = brDao.getById(cpid);
        Account acc = Account.getAccount(session);
        if (acc != null) {
            if (brDao != null) {
                String folder = BrandLabel_Declare.BRAND_FILE_DECLARE + "/" + brDao.getBrandLabel().toLowerCase() + "-" + brDao.getId() + "/";
                File f = new File(folder);
                if (f.exists()) {
                    File[] arr = f.listFiles();
                    if (arr != null && arr.length > 0) {
                        String contentType = Files.probeContentType(arr[0].toPath());
                        ServletOutputStream sout = null;
                        response.setContentType(contentType);
                        response.setHeader("Content-Disposition", "attachment; filename=" + arr[0].getName());
                        sout = response.getOutputStream();
                        sout.flush();
//                        out.clear(); // where out is a JspWriter
//                        out = pageContext.pushBody();
                        FileInputStream fin = new FileInputStream(arr[0]);
                        try {
                            FileUtils.copy(fin, sout);
                        } finally {
                            if (fin != null) {
                                fin.close();
                            }
                            if (sout != null) {
                                sout.close();
                            }
                        }
                    }

                }
            }
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>