<%@page import="org.apache.poi.ss.usermodel.Font"%>
<%@page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.DateFormat"%>
<%@page import="gk.myname.vn.entity.Contract"%>
<%@page import="gk.myname.vn.entity.PartnerManager"%>
<%@page import="gk.myname.vn.entity.BBDS"%>
<%@page import="gk.myname.vn.entity.MsgBrandSubmit"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="java.sql.*"%><%@page import="java.io.FileOutputStream"%><%@page import="java.io.File"%><%@page import="java.util.Date"%><%@page import="org.apache.poi.ss.usermodel.Cell"%><%@page import="org.apache.poi.ss.usermodel.Row"%><%@page import="java.util.Set"%><%@page import="java.util.Map"%><%@page import="java.util.HashMap"%><%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%><%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%><%@page import="java.util.ArrayList"%><%@page autoFlush="true"  %><%@page contentType="text/html; charset=utf-8" %>
<%
    try {
        Account userlogin = Account.getAccount(session);
        if (userlogin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        ArrayList<BBDS> all = null;
        BBDS smDao = new BBDS();
        //Lay cac gia tri parameter tu url
        int type = RequestTool.getInt(request, "type", 0);
        String groupBr = "";
        String stRequest = RequestTool.getString(request, "stRequest");
        String endRequest = RequestTool.getString(request, "endRequest");
        String oper = "";//RequestTool.getString(request, "oper");
        int result = RequestTool.getInt(request, "result", 0);
        String userSender = RequestTool.getString(request, "userSender", "");
        String cp_code = RequestTool.getString(request, "cp_code");
        
        if (!userSender.isEmpty() || !userSender.equals("")) {
            //Neu chon user thi Lay cp code tu user
            cp_code = Account.getCpCode(userSender);
        }
        //Lay list bien ban doi soat tu query
        System.out.println("userSender="+userSender);
        System.out.println("cp_code="+cp_code);
        System.out.println("stRequest="+stRequest);
        System.out.println("endRequest="+endRequest);
        System.out.println("oper="+oper);
        System.out.println("result="+result);
        System.out.println("groupBr="+groupBr);
        all = smDao.bbds(userSender, cp_code, 0, stRequest, endRequest, oper, result, groupBr);
        //Lay thang nam doi soat
        String yearDS = smDao.getYear(stRequest);
        String monthDS = smDao.getMonth(stRequest);
        //Lay so hop dong
        /*truyen vao cp code vao bang partner lay id 
        sau do truyen id vao contract lay so hop dong  */
        int idCom = PartnerManager.getIDCompany(cp_code);
        String contractNo = Contract.getNumContract(idCom);
        //Lay ten cong ty
        String cpnName = PartnerManager.getNameCompany(cp_code);
        /*truyen vao cp code vao bang partner lay ten cong ty  */
        out.clear();
        out = pageContext.pushBody();
        //Truyen vao file excel
        createExcel(all, response, cpnName, contractNo, yearDS, monthDS, cp_code);
        return;
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
%>

<%!
    public static void createExcel(ArrayList<BBDS> allMoLog, HttpServletResponse response, String nameCpn, String contractNumb, String year, String month, String cp_code) {
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet("bbds_" + cp_code + "_" + month + "_" + year);
        sheet.setDefaultColumnWidth(7);                //Rộng cột mặc định 8
//        sheet.setDefaultRowHeight((short) -1);           //Rộng cột mặc định 15

//        CellStyle sss = workbook.createCellStyle();
//        Font font = workbook.createFont();
//        font.setFontName("Times New Roman");
//        font.setFontHeight((short) 11);
//        sss.setFont(font);
        //Lay ngay thang hom nay theo format VIET NAM
        DateFormat df = DateFormat.getDateInstance(DateFormat.LONG, new Locale("vi", "VN"));
        String dt = df.format(new Date());

        //Bat dau fotmat van ban
        sheet.createRow(0).createCell(0).setCellValue("BIÊN BẢN XÁC NHẬN SẢN LƯỢNG - DOANH THU DỊCH VỤ TIN NHẮN BRANDNAME GIỮA ");
        sheet.createRow(1).createCell(0).setCellValue("CÔNG TY CP TRUYỀN THÔNG VÀ THƯƠNG MẠI HTC VÀ " + nameCpn.toUpperCase());
        sheet.createRow(2).createCell(0).setCellValue("THÁNG " + month + "-" + year);
        sheet.createRow(3).createCell(0).setCellValue("'- Căn cứ theo hợp đồng hợp tác số: " + contractNumb + " giữa CÔNG TY CP TRUYỀN THÔNG VÀ THƯƠNG MẠI HTC VÀ " + nameCpn.toUpperCase() + " về việc hợp tác cung cấp dịch vụ quản lý tin nhắn");
        sheet.createRow(4).createCell(0).setCellValue("'- Hôm nay, " + dt + " CÔNG TY CP TRUYỀN THÔNG VÀ THƯƠNG MẠI HTC VÀ " + nameCpn.toUpperCase() + " cùng ký biên bản xác nhận số liệu sản lượng - doanh thu cước dịch vụ quản lý tin nhắn. Cụ thể như sau:");

        Row rTelco = sheet.createRow(5);
        rTelco.createCell(0).setCellValue("Mạng");
        rTelco.createCell(1).setCellValue("Viettel");
        rTelco.createCell(11).setCellValue("Mobifone");
        rTelco.createCell(21).setCellValue("Vinaphone");
        rTelco.createCell(31).setCellValue("VNM");
        rTelco.createCell(32).setCellValue("BL");
        rTelco.createCell(33).setCellValue("DDG");
        rTelco.createCell(34).setCellValue("Tổng");

        Row rGroup = sheet.createRow(6);
        rGroup.createCell(0).setCellValue("Nhóm");
        for (int i = 1; i <= 10; i++) {
            rGroup.createCell(i).setCellValue("N" + (i - 1));
        }
        for (int i = 11; i <= 20; i++) {
            rGroup.createCell(i).setCellValue("N" + (i - 11));
        }
        for (int i = 21; i <= 30; i++) {
            rGroup.createCell(i).setCellValue("N" + (i - 21));
        }
        sheet.createRow(7).createCell(0).setCellValue("Giá bán");
        //Ket thuc format van ban

        //Bat dau trut so lieu
        Row rSL = sheet.createRow(8);
        rSL.createCell(0).setCellValue("Sản lượng");

        //Tao map va list luu so lieu
        Map<String, Integer> mVTE = new HashMap<>();
        Map<String, Integer> mVMS = new HashMap<>();
        Map<String, Integer> mGPC = new HashMap<>();
        ArrayList<BBDS> lVNM = new ArrayList<>();
        ArrayList<BBDS> lBL = new ArrayList<>();
        ArrayList<BBDS> lDDG = new ArrayList<>();

        //Gan du lieu vao Map or List
        for (BBDS onemo : allMoLog) {
            if (onemo.getTelco() != null && onemo.getTelco().equals("VTE") && onemo.getResult() == 1) {
                mVTE.put(onemo.getGroup(), onemo.getTotal());
            } else if (onemo.getTelco() != null && onemo.getTelco().equals("VMS") && onemo.getResult() == 1) {
                mVMS.put(onemo.getGroup(), onemo.getTotal());
            } else if (onemo.getTelco() != null && onemo.getTelco().equals("GPC") && onemo.getResult() == 1) {
                mGPC.put(onemo.getGroup(), onemo.getTotal());
            } else if (onemo.getTelco() != null && onemo.getTelco().equals("VNM") && onemo.getResult() == 1) {
                lVNM.add(onemo);
            } else if (onemo.getTelco() != null && onemo.getTelco().equals("BL") && onemo.getResult() == 1) {
                lBL.add(onemo);
            }else if (onemo.getTelco() != null && onemo.getTelco().equals("DDG") && onemo.getResult() == 1) {
                lDDG.add(onemo);
            } else {
                System.out.println("Lac loai " + onemo);
            }
        }
        /*
        -Thuc hien trut so lieu theo tung nha mang
        -Den o nao thi tao o ay, sau do so khop nhom nao roi trut du lieu tu MAP hoac LIST tuong ung cua nhom vao
        */
        Set<String> kVTE = mVTE.keySet();
        for (int i = 1; i <= 10; i++) {
            for (String sVTE : kVTE) {
                if (sVTE.equals("N" + i)) {
                    rSL.createCell(i + 1).setCellValue((Integer) mVTE.get(sVTE));
                }
                if (sVTE.equals("0")) {
                    rSL.createCell(1).setCellValue((Integer) mVTE.get(sVTE));
                }
            }
        }
        Set<String> kVMS = mVMS.keySet();
        for (int i = 11; i <= 20; i++) {
            for (String sVMS : kVMS) {
                if (sVMS.equals("N" + (i - 10))) {
                    rSL.createCell(i + 1).setCellValue((Integer) mVMS.get(sVMS));
                }
                if (sVMS.equals("0")) {
                    rSL.createCell(11).setCellValue((Integer) mVMS.get(sVMS));
                }
            }
        }
        Set<String> kGPC = mGPC.keySet();
        for (int i = 21; i <= 30; i++) {
            for (String sGPC : kGPC) {
                if (sGPC.equals("N" + (i - 20))) {
                    rSL.createCell(i + 1).setCellValue((Integer) mGPC.get(sGPC));
                }
                if (sGPC.equals("0")) {
                    rSL.createCell(21).setCellValue((Integer) mGPC.get(sGPC));
                }
            }
        }

        int totalVNM = 0;
        for (BBDS e : lVNM) {
            totalVNM += e.getTotal();
        }
        rSL.createCell(31).setCellValue(totalVNM);

        int totalBL = 0;
        for (BBDS e1 : lBL) {
            totalBL += e1.getTotal();
        }
        rSL.createCell(32).setCellValue(totalBL);
        
        int totalDDG = 0;
        for (BBDS e1 : lDDG) {
            totalDDG += e1.getTotal();
        }
        rSL.createCell(33).setCellValue(totalDDG);
        rSL.createCell(34).setCellFormula("SUM(b9:ag10)"); //Tổng sản lượng
        //Ket thuc trut so lieu

        Row rFee = sheet.createRow(9);
        rFee.createCell(0).setCellValue("Phí duy trì");
        rFee.createCell(34).setCellFormula("SUM(b10:ag11)"); //Tổng phí

        Row rTotal = sheet.createRow(10);
        rTotal.createCell(0).setCellValue("Doanh thu");
        rTotal.createCell(34).setCellFormula("SUM(b11:ag12)"); //Tổng tiền

        Row rSum = sheet.createRow(12);
        rSum.createCell(0).setCellValue("Doanh thu T" + month + "/" + year + " " + cp_code + " phải trả cho HTC (bao gồm VAT) là:");
        rSum.createCell(34).setCellFormula("SUM(AI10:AI11)");//Thanh tien gom phi

        sheet.createRow(13).createCell(0).setCellValue("Số tiền bằng chữ: ");
        sheet.createRow(14).createCell(0).setCellValue("Biên bản này được lập thành 02 bản có giá trị pháp lý như nhau, mỗi bên giữ 02 bản.");

        sheet.createRow(16).createCell(20).setCellValue("Hà Nội, " + dt);

        Row rDaiDien = sheet.createRow(17);
        rDaiDien.createCell(1).setCellValue("ĐẠI DIỆN " + nameCpn.toUpperCase());
        rDaiDien.createCell(20).setCellValue("ĐẠI DIỆN CÔNG TY HTC");

        Row rGD = sheet.createRow(18);
        rGD.createCell(1).setCellValue("GIÁM ĐỐC");
        rGD.createCell(20).setCellValue("GIÁM ĐỐC");

        try {
            ServletOutputStream os = null;
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment; filename=bbds_" + cp_code + "_" + month + "_" + year + ".xls");
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