<%@page import="gk.myname.vn.config.MyContext"%><%@page import="java.io.File"%><%@page import="gk.myname.vn.utils.FileUtils"%><%@page import="gk.myname.vn.entity.MsgBrandAds"%><%@page import="gk.myname.vn.entity.Campaign"%><%@page import="gk.myname.vn.entity.UserAction"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="gk.myname.vn.entity.MsgBrandCustomer"%><%@page import="gk.myname.vn.utils.SMSUtils"%><%@page import="gk.myname.vn.utils.ExcelUtil"%><%@page import="gk.myname.vn.multipart.request.MultipartFile"%><%@page import="gk.myname.vn.entity.ListCustomer"%><%@page import="java.util.ArrayList"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="java.sql.Timestamp"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.multipart.request.HttpServletMultipartRequest"%><%@ page contentType="text/html; charset=utf-8" %><%  String infoLog = "";
    Account userlogin = Account.getAccount(session);
    if (userlogin == null || userlogin.getUserType() != Account.TYPE.ADMIN.val) {
        infoLog = "Không đăng nhập hoặc sử dụng User để Truy cập:" + ((userlogin == null) ? "userlogin null" : "u=" + userlogin.getUserName() + "| type=" + userlogin.getUserType());
        UserAction log = new UserAction(userlogin == null ? "not Login" : userlogin.getUserName(),
                UserAction.TABLE.msg_brand_customer.val,
                UserAction.TYPE.UPLOAD.val,
                UserAction.RESULT.REJECT.val,
                infoLog);
        log.logAction(request);
        session.setAttribute("mess", "Bạn cần đăng nhập để truy cập hệ thống");
        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");

        return;
    }
    HttpServletMultipartRequest req = new HttpServletMultipartRequest(request);
    // BrandLabel by Id
    int cpid = RequestTool.getInt(req, "cpid");
    String sento = RequestTool.getString(req, "sento");
    String group = RequestTool.getString(req, "group");
    String timeSearch = RequestTool.getString(req, "timeSearch");
    Campaign cpDao = new Campaign();
    cpDao = cpDao.findById(cpid);
    if (cpDao == null) {
        out.print("Chiến dịch bạn chọn không hợp lệ...");
        return;
    } else {
        
        out.print(cpDao);
    }
    Account acc = Account.getAccount(cpDao.getUserSender());
    if (acc == null) {
        out.print("Tài khoản trong Chiến Dịch bạn chọn không hợp lệ...");
        return;
    }
    //RequestTool.debugParam(req);
    //---
    ArrayList<MsgBrandAds> listData = null;
    // File Input Phone
    MultipartFile file = req.getFileParameter("fileUpload_" + cpid);
    String pathFileResult = MyContext.ROOT_DIR + "/upload/campaign/result/";
    File f = new File(pathFileResult);
    if (!f.exists()) {
        f.mkdirs();
    }
    if (file.getExtentsion().endsWith("xls")) {
        // Excel 2003
        listData = MsgBrandAds.readXsl(file.getInputStream(), 0, cpDao, sento, group);
        FileUtils.writeFileToDisk(file.getByteFromFile(), pathFileResult + cpid + ".xls");
    } else if (file.getExtentsion().endsWith("xlsx")) {
        // Excel > 2003
        listData = MsgBrandAds.readXslx(file.getInputStream(), 0, cpDao, sento, group);
        FileUtils.writeFileToDisk(file.getByteFromFile(), pathFileResult + cpid + ".xlsx");
    }
    if (listData != null && !listData.isEmpty()) {
        Tool.debug("listData.size(): " + listData.size());
        MsgBrandAds msgQc = new MsgBrandAds();
        msgQc.addNewMsg(listData,timeSearch);
    }
%>