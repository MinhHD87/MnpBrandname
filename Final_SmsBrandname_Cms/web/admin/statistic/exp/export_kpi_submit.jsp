<%@page import="java.sql.Date"%><%@page import="org.apache.poi.ss.usermodel.Cell"%><%@page import="org.apache.poi.ss.usermodel.Row"%><%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%><%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="java.util.ArrayList"%><%@page import="gk.myname.vn.entity.KpiSubmit"%><%@page import="gk.myname.vn.admin.Account"%><%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        Account userlogin = Account.getAccount(session);
        if (userlogin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        ArrayList<KpiSubmit> all = null;
        KpiSubmit kpisubmit = new KpiSubmit();
        System.out.println("ok");
        String date1 = RequestTool.getString(request, "log_date1");
        String date2 = RequestTool.getString(request, "log_date2");
        String user_sender = RequestTool.getString(request, "user_sender");
        String oper = RequestTool.getString(request, "oper");
        String cp_code = RequestTool.getString(request, "cp_code");
        all = kpisubmit.excel(date1, date2, user_sender, oper, cp_code);
        out.clear();
        out = pageContext.pushBody();
        createExcel(all, response);

        return;
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
%>

<%!
    public static void createExcel(ArrayList<KpiSubmit> allMoLog, HttpServletResponse response) {
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));

//        Map<String, Object[]> data = new HashMap<String, Object[]>();
        ArrayList<Object[]> data = new ArrayList();
        double total = 0;
        data.add(new Object[]{
            "Ngày",
            "Tài Khoản",
            "Tổng ",
            "Kết quả",
            "Nhà Mạng",
            "Mã",
            "Gửi tới"
        });
        for (KpiSubmit onemo : allMoLog) { 
           data.add(new Object[]{
                DateProc.Timestamp2DDMMYYYY(onemo.getLog_date()),
                onemo.getUser_sender(),
                (double) onemo.getTotal(),
                onemo.getResult(),
                onemo.getOper(),
                onemo.getCp_code(),
                onemo.getSend_to()
            });
        }
        data.add(new Object[]{
            "Ngày",
            "Tài Khoản",
            "Tổng ",
            "Kết quả",
            "Nhà Mạng",
            "Mã",
            "Gửi tới"
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
            response.setHeader("Content-Disposition", "attachment; filename=KpiSubmit-" + DateProc.createDDMMYYYY() + ".xls");
            os = response.getOutputStream();
            os.flush();
            workbook.write(os);
            System.out.println("Excel written successfully..");
        } catch (Exception e) {
            // e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

//    private static String getType(int type) {
//        if (type == BrandLabel.TYPE.CSKH.val) {
//            return "CSKH";
//        } else if (type == BrandLabel.TYPE.QC.val) {
//            return "Tin QC";
//        } else {
//            return type + "";
//        }
//    }
%>