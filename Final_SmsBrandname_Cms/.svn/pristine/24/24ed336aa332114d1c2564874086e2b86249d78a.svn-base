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
        ArrayList<MsgBrandRequest> all = null;
        MsgBrandRequest logDao = new MsgBrandRequest();
        int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
        if (currentPage < 1) {
            currentPage = 1;
        }
        int err_code = RequestTool.getInt(request, "err_code", -1);
        int type = RequestTool.getInt(request, "type", -1);
        int result = RequestTool.getInt(request, "result", -1);
        int totalRow = RequestTool.getInt(request, "totalRow");
        if (totalRow > 1000000) {
            totalRow = 1000000;
        }
        int bid = RequestTool.getInt(request, "_label");
        BrandLabel brLabel = BrandLabel.getFromCache(bid);
        //--
        String label = "";
        if (brLabel != null) {
            label = brLabel.getBrandLabel();
        }
        String phone = RequestTool.getString(request, "phone");
//        String provider = RequestTool.getString(request, "provider");
        String telco = RequestTool.getString(request, "telco");
        String stRequest = RequestTool.getString(request, "stRequest");
        if (Tool.checkNull(stRequest)) {
            stRequest = DateProc.createDDMMYYYY();
        }
        String endRequest = RequestTool.getString(request, "endRequest");
        if (Tool.checkNull(endRequest)) {
            endRequest = DateProc.createDDMMYYYY();
        }
        String cp_code = RequestTool.getString(request, "cp_code");
        String userSender = RequestTool.getString(request, "userSender");
        String tranId = RequestTool.getString(request, "tranId");

        all = logDao.getAllLog_MsgReq(currentPage, totalRow, userSender, cp_code, label, type, result, stRequest, endRequest, phone, telco, err_code,tranId);
        out.clear();
        out = pageContext.pushBody();
        createExcel(all, response);
        return;
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
%>

<%!
    public static void createExcel(ArrayList<MsgBrandRequest> allMoLog, HttpServletResponse response) {
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));
//        Map<String, Object[]> data = new HashMap<String, Object[]>();
        ArrayList<Object[]> data = new ArrayList();
        double total = 0;
        double totalPrice = 0;
        data.add(new Object[]{
            "ACCOUNT",
            "SENDER",
            "OPER",
            "RECEIVER",
            "MESSAGE",
            "TOTAL",
            "PRICE",
            "REQUEST",
            "RESULT-INT",
            "DESC",
            "TYPE",
            "GW",
            "Group",
            "TRANID",
            "SYS_ID"
        });
        for (MsgBrandRequest onemo : allMoLog) {
            total += onemo.getTotalSms();
            if(onemo.getResult()==99){
                totalPrice += onemo.getPriceSMS();
            }
            data.add(new Object[]{
                onemo.getUserSender(),
                onemo.getLabel(),
                onemo.getOper(),
                onemo.getPhone() + "",
                onemo.getMessage() + "",
                (double) onemo.getTotalSms(),
                (double) onemo.getPriceSMS(),
                onemo.getRequestTime() + "",
                onemo.getResult() + "",
                onemo.getErrInfo(),
                getType(onemo.getType()),
                onemo.getSendTo(),
                onemo.getBrGroup(),
                onemo.getTranId(),
                onemo.getSysId()
            });
        }
        data.add(new Object[]{
            "", "", "", "", "",
            total,totalPrice,
            "", "", "", "", "", "", "", ""
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
            response.setHeader("Content-Disposition", "attachment; filename=Request_DETAIL-" + DateProc.createDDMMYYYY() + ".xlsx");
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