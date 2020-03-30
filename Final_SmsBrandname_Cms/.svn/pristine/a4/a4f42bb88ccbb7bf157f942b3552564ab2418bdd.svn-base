<%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.entity.ResendEntity"%><%@page import="org.apache.poi.ss.usermodel.Cell"%><%@page import="org.apache.poi.ss.usermodel.Row"%><%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%><%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%><%@page import="gk.myname.vn.utils.ExcelUtil"%><%@page import="java.util.ArrayList"%><%@page import="gk.myname.vn.multipart.request.MultipartFile"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="gk.myname.vn.multipart.request.HttpServletMultipartRequest"%><%@page contentType="text/html; charset=utf-8" %>
<%
    Account userlogin = Account.getAccount(session);
    if (userlogin == null) {
        out.print("Bạn cần đăng nhập để truy cập hệ thống");
        return;
    } else if (userlogin.getUserType() != Account.TYPE.ADMIN.val) {
        out.print("Bạn cần đăng nhập để truy cập hệ thống");
        return;
    }
    if (!userlogin.checkEdit(request)) {
        out.print("Bạn không có quyền truy cập module này!");
        return;
    }
    try {
        HttpServletMultipartRequest req = new HttpServletMultipartRequest(request);
        String userSender = RequestTool.getString(req, "userSender", "0");
        if (userSender.equals("0")) {
            out.print("Bạn chưa chọn khách hàng để gửi lại...");
            return;
        }
        MultipartFile file = req.getFileParameter("fileUpload");
        if (file != null) {
            ArrayList<ResendEntity> listData = new ArrayList<ResendEntity>();
            if (file.getExtentsion().endsWith("xls")) {
                // Excel 2003
                HSSFSheet data = ExcelUtil.readXsl(file.getInputStream());
                int i = 1;
                for (Row _oneRow : data) {
                    if (i == 1) {
                        i++;
                        continue;
                    }
                    // Duyet qua tung dong cua mot sheet
                    ResendEntity oneCell = new ResendEntity();
                    // Duyet qua tung cell cua mot dong
                    String label = ExcelUtil.normalizeCellType(_oneRow.getCell(0));
                    String phone = ExcelUtil.normalizeCellType(_oneRow.getCell(1));
                    String message = ExcelUtil.normalizeCellType(_oneRow.getCell(2));
                    if (Tool.checkNull(label) || Tool.checkNull(phone) || Tool.checkNull(message)) {
                        continue;
                    }
                    oneCell.setLabel(label);
                    oneCell.setPhone(phone);
                    oneCell.setMessage(message);
                    oneCell.setSendBy(userlogin.getUserName());
                    listData.add(oneCell);
                }
                ResendEntity reSendDao = new ResendEntity();
                reSendDao.processListData(listData, userSender);
                out.print("Import Success List ReSend:" + listData.size());
            } else if (file.getExtentsion().endsWith("xlsx")) {
                // Excel > 2003
                XSSFSheet data = ExcelUtil.readXslx(file.getInputStream());
                int i = 1;
                for (Row _oneRow : data) {
                    if (i == 1) {
                        i++;
                        continue;
                    }
                    // Duyet qua tung dong cua mot sheet
                    ResendEntity oneCell = new ResendEntity();
                    // Duyet qua tung cell cua mot dong
                    String label = ExcelUtil.normalizeCellType(_oneRow.getCell(0));
                    String phone = ExcelUtil.normalizeCellType(_oneRow.getCell(1));
                    String message = ExcelUtil.normalizeCellType(_oneRow.getCell(2));
                    if (Tool.checkNull(label) || Tool.checkNull(phone) || Tool.checkNull(message)) {
                        continue;
                    }
                    oneCell.setLabel(label);
                    oneCell.setPhone(phone);
                    oneCell.setMessage(message);
                    oneCell.setSendBy(userlogin.getUserName());
                    listData.add(oneCell);
                }
                ResendEntity reSendDao = new ResendEntity();
                reSendDao.processListData(listData, userSender);
                out.print("Import Success List ReSend:" + listData.size());
            } else {
                out.print("Invalid File Type");
            }
        } else {
            out.print("File input not Found");
        }
    } catch (Exception ex) {
        out.print("System Error Contact Administrator:<br/>" + ex.getMessage());
    }
%>