<%@page import="gk.myname.vn.entity.MsgBrandAds"%>
<%@page import="gk.myname.vn.entity.CDRSubmit"%>
<%@page import="gk.myname.vn.entity.MsgBrandSubmit"%>
<%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="java.sql.*"%><%@page import="java.io.FileOutputStream"%><%@page import="java.io.File"%><%@page import="java.util.Date"%><%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%><%@page import="java.util.Set"%><%@page import="java.util.Map"%><%@page import="java.util.HashMap"%><%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%><%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="java.util.ArrayList"%>
<%@page autoFlush="true"  %><%@page contentType="text/html; charset=utf-8" %> 
<%
    try {
        Account userlogin = Account.getAccount(session);
        if (userlogin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        ArrayList<MsgBrandAds> all = null;
        MsgBrandAds smDao = new MsgBrandAds();
        String startTime = RequestTool.getString(request, "startTime");
        String endTime = RequestTool.getString(request, "endTime");
        String result = RequestTool.getString(request, "result");
        String userSender = RequestTool.getString(request, "userSender");
        String label = RequestTool.getString(request, "label");
        all = smDao.staticAll(startTime, endTime, result, userSender, label);
        out.clear();
        out = pageContext.pushBody();
        createExcel(all, response);
        return;
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
%>

<%!
    public static void createExcel(ArrayList<MsgBrandAds> allMoLog, HttpServletResponse response) {
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));
        double total = 0;
        ArrayList<Object[]> data = new ArrayList();
        data.add(new Object[]{
                "Ngày",
                "Nhãn",
                "User gửi",
                "Nhà mạng",
                "Tổng tin nhắn"
            });
        for (MsgBrandAds onemo : allMoLog) {
            total += onemo.getTotalMsg();
            data.add(new Object[]{
                onemo.getTimeSend(),
                onemo.getLabel(),
                onemo.getUserSender(),
                onemo.getOper(),
                (double)onemo.getTotalMsg()
            });
        }
        data.add(new Object[]{
            "",
            "",
            "",
            "",
            total+""
        });
        int rownum = 0;
        for (Object[] objArr : data) {
            Row row = sheet.createRow(rownum++);
            int cellnum = 0;
            for (Object obj : objArr) {
                Cell cell = row.createCell(cellnum++);
                if (obj instanceof Date) {
                    cell.setCellValue((Date) obj);
                } else if (obj instanceof Boolean) {
                    cell.setCellValue((Boolean) obj);
                } else if (obj instanceof String) {
                    cell.setCellValue((String) obj);
                } else if (obj instanceof Double) {
                    cell.setCellValue((Double) obj);
                } else {
                    cell.setCellValue((String) obj);
                }
            }
        }

        try {
            ServletOutputStream os = null;
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=LogQC-" + DateProc.createDDMMYYYY() + ".xls");
            os = response.getOutputStream();
            os.flush();
            workbook.write(os);
            System.out.println("Excel written successfully..");
        } catch (Exception e) {
            // e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

    private static String getType(int type) {
        if (type == BrandLabel.TYPE.CSKH.val) {
            return "CSKH";
        } else if (type == BrandLabel.TYPE.QC.val) {
            return "Tin QC";
        } else {
            return type + "";
        }
    }
%>