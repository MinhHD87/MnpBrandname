<%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.FileUtils"%><%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.multipart.request.MultipartFile"%><%@page import="gk.myname.vn.multipart.request.HttpServletMultipartRequest"%><%@page import="gk.myname.vn.admin.Account"%><%@page contentType="text/html; charset=utf-8" %>
<%
    Account userlogin = Account.getAccount(session);
    String[] extention = {"rar", "zip", "jpeg", "png", "pdf", "jpg"};
    if (userlogin == null) {
        out.print("Bạn cần đăng nhập để truy cập hệ thống");
        return;
    } else if (userlogin.getUserType() != Account.TYPE.ADMIN.val) {
        out.print("Bạn không được phép thực hiện xử lý này");
        return;
    }
    HttpServletMultipartRequest req = new HttpServletMultipartRequest(request);
    int pid = RequestTool.getInt(req, "pid");
    PartnerManager partner = PartnerManager.getCacheById(pid);
    if (partner == null) {
        out.print("Yêu cầu không hợp lệ. Không lấy được thông tin khách hàng");
        return;
    }
    MultipartFile file = req.getFileParameter("fileUpload");
    if (file != null) {
        String ext = file.getExtentsion();
        if (validExtention(extention, ext)) {
            FileUtils.writeFileToDisk(file.getByteFromFile(), MyContext.ROOT_DIR + "/upload/contract/" + partner.getCode().toLowerCase() + "-" + partner.getId() + "/" + file.getName());
            out.print("Tải tài liệu thành công!");
        } else {
            out.print("Yêu cầu không hợp lệ! Định dang file không cho phép");
            return;
        }
    } else {
        out.print("Yêu cầu không hợp lệ. File tải lên không được tìm thấy");
        return;
    }
%>
<%!
    public boolean validExtention(String[] extention, String ext) {
        boolean flag = false;
        try {
            for (String one : extention) {
                if (ext.equals(one.trim())) {
                    flag = true;
                    break;
                }
            }
        } catch (Exception e) {
        }
        return flag;
    }
%>
