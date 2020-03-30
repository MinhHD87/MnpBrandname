<%@page import="java.util.Date"%><%@page import="org.apache.poi.ss.usermodel.Cell"%><%@page import="org.apache.poi.ss.usermodel.Row"%><%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%><%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.entity.MsgBrandSubmit"%><%@page import="java.util.ArrayList"%><%@page import="gk.myname.vn.admin.Account"%><%@page autoFlush="true"  %><%@page contentType="text/html; charset=utf-8" %> 
<%
    try {
        Account userlogin = Account.getAccount(session);
        if (userlogin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        ArrayList<MsgBrandSubmit> all = null;
        MsgBrandSubmit submDao = new MsgBrandSubmit();
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
        String provider = RequestTool.getString(request, "provider");
        String telco = RequestTool.getString(request, "telco");
        String stRequest = RequestTool.getString(request, "stRequest");
        if (Tool.checkNull(stRequest)) {
            stRequest = DateProc.createDDMMYYYY();
        }
        String endRequest = RequestTool.getString(request, "endRequest");
        if (Tool.checkNull(endRequest)) {
            endRequest = DateProc.createDDMMYYYY();
        }
        String tranId = RequestTool.getString(request, "tranId");
        String cp_code = RequestTool.getString(request, "cp_code");
        String userSender = RequestTool.getString(request, "userSender");
        all = submDao.getMsgSubmitLog(currentPage, totalRow, userSender, cp_code, label, type, result, provider, stRequest, endRequest, phone, telco, err_code,tranId);
        out.clear();
        out = pageContext.pushBody();
        createExcel(all, response, provider);
        return;
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
%>

<%!
    public static void createExcel(ArrayList<MsgBrandSubmit> allMoLog, HttpServletResponse response, String provider) {
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));
//        Map<String, Object[]> data = new HashMap<String, Object[]>();
        ArrayList<Object[]> data = new ArrayList();
        double total = 0;
        double totalPrice = 0;
        data.add(new Object[]{
            "ACCOUNT",
            "SENDER",
            "RECEIVER",
            "MESSAGE",
            "OPER",
            "TOTAL",
            "TOTAL_PRICE",
            "Time Send",
            "RESULT-INT",
            "ERROR-INFO",
            "DESC",
            "TYPE",
            "GW",
            "Group",
            "TRANID",
            "SYS_ID"
        });
        for (MsgBrandSubmit onemo : allMoLog) {
            total += onemo.getTotalSms();
            if(onemo.getResult()==1){
                totalPrice += onemo.getTotalPrice();
            }
            data.add(new Object[]{
                onemo.getUserSender(),
                onemo.getLabel(),
                onemo.getPhone() + "",
                onemo.getMessage(),
                onemo.getOper(),
                (double) onemo.getTotalSms(),
                (double) onemo.getTotalPrice(),
                onemo.getTimeSend() + "",
                onemo.getResult() + "",
                getKetquaString(onemo.getResult()),
                onemo.getErrInfo(),
                getType(onemo.getType()),
                onemo.getSendTo(),
                onemo.getBrGroup(),
                onemo.getTranId(),
                onemo.getSysId()
            });
        }
        data.add(new Object[]{"", "", "", "", "",
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
            response.setHeader("Content-Disposition", "attachment; filename=Submit_DETAIL-" + DateProc.createDDMMYYYY() + ".xlsx");
            os = response.getOutputStream();
            os.flush();
            workbook.write(os);
            System.out.println("Excel written successfully..");
        } catch (Exception e) {
            // e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }

    private static String getKetquaString(int result) {
        String str = "";
        switch (result) {
            case 0:
                str = "Gửi lỗi";
                break;
            case 1:
                str = "Thành công";
                break;
            case -9995:
                str = "Mẫu tin chưa khai báo";
                break;
            case 104:
                str = "Lỗi Brand chưa duyệt";
                break;
            case 105:
                str = "Lỗi Template không đúng";
                break;
            case 904:
                str = "Lỗi Brand tạm khóa";
                break;
            case -8888:
                str = "Tin Chờ gửi";
                break;
            case -9999:
                str = "Tin Chờ duyệt";
                break;
            case -9998:
                str = "Lỗi khi gửi của SMS";
                break;
            case -9997:
                str = "Service Send SMS Error";
                break;
            case -9996:
                str = "Nhà mạng chưa cấp";
                break;
            default:
                str = result + "";

        }
        return str;
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