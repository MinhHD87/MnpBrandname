<%@page import="gk.myname.vn.entity.TransActionBilling"%>
<%@page import="gk.myname.vn.entity.MsgBrandRequest"%><%@page import="java.util.Date"%><%@page import="org.apache.poi.ss.usermodel.Cell"%><%@page import="org.apache.poi.ss.usermodel.Row"%><%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%><%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.ArrayList"%><%@page import="gk.myname.vn.admin.Account"%>
<%@page autoFlush="true"  %><%@page contentType="text/html; charset=utf-8" %> 
<%
    try {
        Account userlogin = Account.getAccount(session);
        if (userlogin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }
        //--
        ArrayList<TransActionBilling> all = null;
        TransActionBilling logDao = new TransActionBilling();
        int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
        if (currentPage < 1) {
            currentPage = 1;
        }
        
        String type = RequestTool.getString(request, "type");
        int totalRow = RequestTool.getInt(request, "totalRow");
        if (totalRow > 1000000) {
            totalRow = 1000000;
        }
        
        String transBillingID = RequestTool.getString(request, "transBillingID");
        String telco = RequestTool.getString(request, "telco");
        String stRequest = RequestTool.getString(request, "stRequest");
        if (Tool.checkNull(stRequest)) {
            stRequest = DateProc.createDDMMYYYY();
        }
        String endRequest = RequestTool.getString(request, "endRequest");
        if (Tool.checkNull(endRequest)) {
            endRequest = DateProc.createDDMMYYYY();
        }
        String userSender = RequestTool.getString(request, "userSender");

        //all = logDao.getAllLog_MsgReq(currentPage, totalRow, userSender, cp_code, label, type, result, stRequest, endRequest, phone, telco, err_code,tranId);
//        System.out.println("currentPage"+currentPage);
//        System.out.println("totalRow"+totalRow);
//        System.out.println("userSender"+userSender);
//        System.out.println("type"+type);
//        System.out.println("stRequest"+stRequest);
//        System.out.println("endRequest"+endRequest);
//        System.out.println("transBillingID"+transBillingID);
//        System.out.println("telco"+telco);
        all = logDao.getAllTransActionBilling(currentPage, totalRow, userSender,  type,   stRequest, endRequest, transBillingID, telco);
        out.clear();
        out = pageContext.pushBody();
        createExcel(all, response);
        return;
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
%>

<%!
    public static void createExcel(ArrayList<TransActionBilling> allMoLog, HttpServletResponse response) {
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));
//        Map<String, Object[]> data = new HashMap<String, Object[]>();
        ArrayList<Object[]> data = new ArrayList();
        double total = 0;
        double totalPrice = 0;
        data.add(new Object[]{
            "ID",
            "BILLING_TRANS",
            "TYPE_TRANS",
            "MONEY_TRANS",
            "ACCOUNT_NAME",
            "ACTION_ACCOUNT",
            "UNIT_PRICE",
            "NUMBER_UNIT",
            "TELCO",
            "TIME_ACTION",
            "BALANCE_BEFORE",
            "BALANCE_TRANS",
            "COMMENT_NOTE"
        });
        for (TransActionBilling onemo : allMoLog) {
            total += onemo.getMoney_trans();
            
            data.add(new Object[]{
                (double)onemo.getId(),
                onemo.getBilling_trans(),
                onemo.getType_trans(),
                (double)onemo.getMoney_trans(),
                onemo.getAccount_name()+ "",
                onemo.getAction_account()+ "",
                (double) onemo.getUnit_price(),
                (double) onemo.getNumber_unit(),
                onemo.getTelco()+ "",
                onemo.getTime_action()+ "",
                (double)onemo.getBalance_before(),
                (double)onemo.getBalance_trans(),
                onemo.getComment_note()
            });
        }
        data.add(new Object[]{
            "", "", "", 
            total,
            "", "", "", "", "", "", "", "", ""
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
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=TransBilling_DETAIL-" + DateProc.createDDMMYYYY() + ".xlsx");
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