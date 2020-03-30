<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="gk.myname.vn.entity.RouteTable"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="gk.myname.vn.utils.DateProc"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.entity.BrandLabel"%>
<%@page import="java.util.ArrayList"%>
<%
    try {
        ArrayList<BrandLabel> allBrand = null;
        BrandLabel dao = new BrandLabel();
        int currentPage = RequestTool.getInt(request, "page", 1);
        int status = RequestTool.getInt(request, "status", -2);
        String _label = RequestTool.getString(request, "_label");
        String telco = RequestTool.getString(request, "telco");
        String providerCode = RequestTool.getString(request, "providerCode");
        String cpuser = RequestTool.getString(request, "cpuser", "0");
        //Them HOAN
        String group = RequestTool.getString(request, "groupBr", "");
        String stRq = RequestTool.getString(request, "stRequest");
        String endRq = RequestTool.getString(request, "endRequest");
        //HOAN HET
        
        int totalRow = dao.countAll(_label, cpuser, status, providerCode, telco,group,stRq,endRq);
        
        allBrand = dao.getAllEx(_label, cpuser, status, providerCode, telco,group,stRq,endRq);
        out.clear();
        out = pageContext.pushBody();
        createExcel(allBrand, response);
        return;
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
%>

<%!
    public static void createExcel(ArrayList<BrandLabel> allMoLog, HttpServletResponse response) {
        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));
//        Map<String, Object[]> data = new HashMap<String, Object[]>();
        ArrayList<Object[]> data = new ArrayList();
        double total = 0;
        int i = 1;
        String status = "";
        data.add(new Object[]{
            "STT",
            "CP_CODE",
            "BRAND NAME",
            "Viettel",
            "Nhóm",
            "Mobifone",
            "Nhóm",
            "Vinaphone",
            "Nhóm",
            "VNMobile",
            "GTEL",
            "Create Date",
            "Status",});
        for (BrandLabel onemo : allMoLog) {
            RouteTable route = onemo.getRoute();
            //Dat gia tri cho status Brand
            if (onemo.getStatus() == BrandLabel.STATUS.BLOCK.val) {
//                System.out.println(BrandLabel.STATUS.BLOCK.desc);
                status = BrandLabel.STATUS.BLOCK.desc;
            } else if (onemo.getStatus() == BrandLabel.STATUS.ACTIVE.val) {
//                System.out.println(BrandLabel.STATUS.ACTIVE.desc);
                status = BrandLabel.STATUS.ACTIVE.desc;
            } else if (onemo.getStatus() == BrandLabel.STATUS.WAIT.val) {
//                System.out.println(BrandLabel.STATUS.WAIT.desc);
                status = BrandLabel.STATUS.WAIT.desc;
            } else if (onemo.getStatus() == BrandLabel.STATUS.PROCESS.val) {
//                System.out.println(BrandLabel.STATUS.PROCESS.desc);
                status = BrandLabel.STATUS.PROCESS.desc;
            } else if (onemo.getStatus() == BrandLabel.STATUS.REJECT.val) {
//                System.out.println(BrandLabel.STATUS.REJECT.desc);
                status = BrandLabel.STATUS.REJECT.desc;
            } else if (onemo.getStatus() == BrandLabel.STATUS.DELETE.val) {
//                System.out.println(BrandLabel.STATUS.DELETE.desc);
                status = BrandLabel.STATUS.DELETE.desc;
            } else {
                status = "Unknow";
            }
            //Dat gia tri cho tung hang
            data.add(new Object[]{
                i++,
                onemo.getCp_code(),
                onemo.getBrandLabel(),
                route.getVte().getRoute_CSKH(),
                route.getVte().getGroup(),
                route.getMobi().getRoute_CSKH(),
                route.getMobi().getGroup(),
                route.getVina().getRoute_CSKH(),
                route.getVina().getGroup(),
                route.getVnm().getRoute_CSKH(),
                route.getBl().getRoute_CSKH(),
                onemo.getCreateDate(),
                status
            });
        }
        data.add(new Object[]{
            "", "", "", "", "",
            total,
            "", "", "", "", "", "", "", ""
        });
        int rownum = 0;
        for (Object[] objArr : data) {
            Row row = sheet.createRow(rownum++);
            int cellnum = 0;
            for (Object obj : objArr) {
                Cell cell = row.createCell(cellnum++);
                if (obj instanceof Timestamp) {
                    cell.setCellValue((Date) obj);
                } else if (obj instanceof Boolean) {
                    cell.setCellValue((Boolean) obj);
                } else if (obj instanceof String) {
                    cell.setCellValue((String) obj);
                } else if (obj instanceof Double) {
                    cell.setCellValue((Double) obj);
                } else if (obj instanceof Integer) {
                    cell.setCellValue((Integer) obj);
                } else {
                    cell.setCellValue((String) obj);
                }
            }
        }

        try {
            ServletOutputStream os = null;
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            response.setHeader("Content-Disposition", "attachment; filename=ListBrand_DETAIL-" + DateProc.createDDMMYYYY() + ".xlsx");
            os = response.getOutputStream();
            os.flush();
            workbook.write(os);
            System.out.println("Excel written successfully..");
        } catch (Exception e) {
            // e.printStackTrace();
            System.out.println(e.getMessage());
        }
    }
%>