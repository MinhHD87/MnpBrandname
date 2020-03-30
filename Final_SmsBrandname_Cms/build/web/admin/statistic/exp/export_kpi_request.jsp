<%@page import="gk.myname.vn.entity.KPI_Request"%>
<%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="java.sql.*"%><%@page import="java.io.FileOutputStream"%><%@page import="java.io.File"%><%@page import="java.util.Date"%><%@page import="org.apache.poi.ss.usermodel.Cell"%><%@page import="org.apache.poi.ss.usermodel.Row"%><%@page import="java.util.Set"%><%@page import="java.util.Map"%><%@page import="java.util.HashMap"%><%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%><%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%><%@page import="java.util.ArrayList"%><%@page autoFlush="true"  %><%@page contentType="text/html; charset=utf-8" %> 
<!DOCTYPE html>
<%
    try {
        Account userlogin = Account.getAccount(session);
        if (userlogin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }
        
        KPI_Request kpidao = new KPI_Request();
        String userSender = RequestTool.getString(request, "userSender");
        String oper = RequestTool.getString(request, "oper");
        String cp_code = RequestTool.getString(request, "cp_code");
        String result = RequestTool.getString(request, "result");
        String stRequest = RequestTool.getString(request, "stRequest");
        String endRequest = RequestTool.getString(request, "endRequest");
        int currentPage = RequestTool.getInt(request, "page", 1);
        int maxRow = RequestTool.getInt(request, "maxRow");
        int totalRow = kpidao.countAll(userSender, oper, cp_code, result, stRequest, endRequest);
        String strOrder = "ORDER BY B.TOTAL_COUNT DESC";

        ArrayList<KPI_Request> all = kpidao.staticKPI_Request(currentPage, totalRow, userSender, oper, cp_code, result, stRequest, endRequest);
        out.clear();
        out = pageContext.pushBody();
        createExcel(all, response, userSender);
        return;
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
%>
<%!
    public static void createExcel(ArrayList<KPI_Request> allMoLog, HttpServletResponse response, String userSender) {
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));

//        Map<String, Object[]> data = new HashMap<String, Object[]>();
        ArrayList<Object[]> data = new ArrayList();
        double total = 0;
        data.add(new Object[]{
//            "STT",
            "Ngày Gửi",
            "Người Gửi",
            "Tổng",
            "Kết quả gửi",
            "Nhà Mạng",});
        for (KPI_Request onemo : allMoLog) {
            total += onemo.getTotal_Count();
            data.add(new Object[]{
//                onemo.getId(),
                DateProc.Timestamp2DDMMYY(onemo.getLog_Date()),
                onemo.getUserSender(),
                (double) onemo.getTotal_Count(),
                onemo.getResult(),
                onemo.getOper(),});
        }
        data.add(new Object[]{
//            "STT",
            "Ngày Gửi",
            "Người Gửi",
            total,
            "Kết quả gửi",
            "Nhà Mạng",});

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
            response.setHeader("Content-Disposition", "attachment; filename=KPI_REQUEST" + DateProc.createDDMMYYYY() + ".xls");
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