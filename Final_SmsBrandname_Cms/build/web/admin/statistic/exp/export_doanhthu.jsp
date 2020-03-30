<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="gk.myname.vn.entity.Provider"%>
<%@page import="gk.myname.vn.entity.MsgBrandSubmit"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="java.sql.*"%><%@page import="java.io.FileOutputStream"%><%@page import="java.io.File"%><%@page import="java.util.Date"%><%@page import="org.apache.poi.ss.usermodel.Cell"%><%@page import="org.apache.poi.ss.usermodel.Row"%><%@page import="java.util.Set"%><%@page import="java.util.Map"%><%@page import="java.util.HashMap"%><%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%><%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%><%@page import="java.util.ArrayList"%><%@page autoFlush="true"  %><%@page contentType="text/html; charset=utf-8" %>
<%
    try {
        Account userlogin = Account.getAccount(session);
        if (userlogin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
            return;
        }

        ArrayList<MsgBrandSubmit> all = null;
        MsgBrandSubmit smDao = new MsgBrandSubmit();
        
        Provider allP = null;
        Provider smDaoP = new Provider();
        
        Account allA = null;
        Account smDaoA = new Account();

        String _label = RequestTool.getString(request, "_label");
        int type = RequestTool.getInt(request, "type", -1);
        String provider = RequestTool.getString(request, "provider");
        String groupBr = RequestTool.getString(request, "groupBr");
        String stRequest = RequestTool.getString(request, "stRequest");
        String endRequest = RequestTool.getString(request, "endRequest");
        String oper = RequestTool.getString(request, "oper");
        int result = RequestTool.getInt(request, "result", 0);
        String cp_code = RequestTool.getString(request, "cp_code");
        String userSender = RequestTool.getString(request, "userSender", "0");
        
        ArrayList<String> cccc = new ArrayList<>();
        
        if (Tool.checkNull(provider)) {
            ArrayList<MsgBrandSubmit> a1234 = null;
            a1234 = smDao.statisticSubm(userSender, cp_code, _label, type, "", stRequest, endRequest, oper, result, groupBr);
            ArrayList<String> bbbb = new ArrayList<>();
            for (MsgBrandSubmit element : a1234) {
                bbbb.add(element.getSendTo());
            }
            for (String element : bbbb) {
                if (!cccc.contains(element)) {
                    cccc.add(element);
                }
            }
        } else {            
            cccc.add(provider);
        }
        
        ArrayList<ArrayList<MsgBrandSubmit>> allArray = new ArrayList<>();
        ArrayList<Provider> arrayP = new ArrayList<>();
        for (String ddd : cccc) {
            all = smDao.statisticSubm(userSender, cp_code, _label, type, ddd, stRequest, endRequest, oper, result, groupBr);
            allP = smDaoP.getByCode(ddd);
            arrayP.add(allP);
            allArray.add(all);
        }

        System.out.println("===========");
        System.out.println(allArray.size());
        System.out.println("===========");
        
        allA = smDaoA.getDaiLy(cp_code);
        
        out.clear();
        out = pageContext.pushBody();
        
            createExcel(allArray, response, arrayP, stRequest, endRequest, allA);
        
        return;
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
%>

<%!
    public static void createExcel(ArrayList<ArrayList<MsgBrandSubmit>> allArray, HttpServletResponse response, ArrayList<Provider> provider, String stRequest, String endRequest, Account account) {
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));
//        Map<String, Object[]> data = new HashMap<String, Object[]>();
        ArrayList<Object[]> data = new ArrayList();
    Locale localeEN = new Locale("en", "EN");
    NumberFormat en = NumberFormat.getInstance(localeEN);

        data.add(new Object[]{            
            "",
            "",
            "",
            "",
            "Báo cáo sản lượng SMS theo nhóm",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            ""
        });
        data.add(new Object[]{            
            "",
            "",
            "",
            "",
            "Từ "+stRequest+" đến "+endRequest,
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            ""
        });
        data.add(new Object[]{            
            "",
            "",
            "",
            "",
            "Đại lý ["+account.getUserName()+"] "+account.getFullName(),
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            ""
        });
        data.add(new Object[]{
            "",
            "Nhà mạng",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "VIETTEL",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "MOBIFONE",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "VINAFONE",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "VIETNAMMOBILE",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "GMOBILE",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "ITELECOM",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            ""
        });
        data.add(new Object[]{      
            "",
            "Nhóm",
            "N0",
            "N1",
            "N2",
            "N3",
            "N4",
            "N5",
            "N6",
            "N7",
            "N8",
            "N9",
            "N10",
            "N11",
            "N12",
            "N13",
            "N14",
            "N15",
            "NNLC",
            "Tổng",
            "N0",
            "N1",
            "N2",
            "N3",
            "N4",
            "N5",
            "N6",
            "N7",
            "N8",
            "N9",
            "N10",
            "N11",
            "N12",
            "N13",
            "N14",
            "N15",
            "NNLC",
            "Tổng",
            "N0",
            "N1",
            "N2",
            "N3",
            "N4",
            "N5",
            "N6",
            "N7",
            "N8",
            "N9",
            "N10",
            "N11",
            "N12",
            "N13",
            "N14",
            "N15",
            "NNLC",
            "Tổng",
            "N0",
            "N1",
            "N2",
            "N3",
            "N4",
            "N5",
            "N6",
            "N7",
            "N8",
            "N9",
            "N10",
            "N11",
            "N12",
            "N13",
            "N14",
            "N15",
            "NNLC",
            "Tổng",
            "N0",
            "N1",
            "N2",
            "N3",
            "N4",
            "N5",
            "N6",
            "N7",
            "N8",
            "N9",
            "N10",
            "N11",
            "N12",
            "N13",
            "N14",
            "N15",
            "NNLC",
            "Tổng",
            "N0",
            "N1",
            "N2",
            "N3",
            "N4",
            "N5",
            "N6",
            "N7",
            "N8",
            "N9",
            "N10",
            "N11",
            "N12",
            "N13",
            "N14",
            "N15",
            "NNLC",
            "Tổng",
            "Total"
        });
int banVteG0 = account.getSell_price().getVte().getGroup0Price();
        int banVteG1 = account.getSell_price().getVte().getGroup1Price();
        int banVteG2 = account.getSell_price().getVte().getGroup2Price();
        int banVteG3 = account.getSell_price().getVte().getGroup3Price();
        int banVteG4 = account.getSell_price().getVte().getGroup4Price();
        int banVteG5 = account.getSell_price().getVte().getGroup5Price();
        int banVteG6 = account.getSell_price().getVte().getGroup6Price();
        int banVteG7 = account.getSell_price().getVte().getGroup7Price();
        int banVteG8 = account.getSell_price().getVte().getGroup8Price();
        int banVteG9 = account.getSell_price().getVte().getGroup9Price();
        int banVteG10 = account.getSell_price().getVte().getGroup10Price();
        int banVteG11 = account.getSell_price().getVte().getGroup11Price();
        int banVteG12 = account.getSell_price().getVte().getGroup12Price();
        int banVteG13 = account.getSell_price().getVte().getGroup13Price();
        int banVteG14 = account.getSell_price().getVte().getGroup14Price();
        int banVteG15 = account.getSell_price().getVte().getGroup15Price();
        int banVteGNLC = account.getSell_price().getVte().getGroupLCPrice();

        int banMobiG0 = account.getSell_price().getMobi().getGroup0Price();
        int banMobiG1 = account.getSell_price().getMobi().getGroup1Price();
        int banMobiG2 = account.getSell_price().getMobi().getGroup2Price();
        int banMobiG3 = account.getSell_price().getMobi().getGroup3Price();
        int banMobiG4 = account.getSell_price().getMobi().getGroup4Price();
        int banMobiG5 = account.getSell_price().getMobi().getGroup5Price();
        int banMobiG6 = account.getSell_price().getMobi().getGroup6Price();
        int banMobiG7 = account.getSell_price().getMobi().getGroup7Price();
        int banMobiG8 = account.getSell_price().getMobi().getGroup8Price();
        int banMobiG9 = account.getSell_price().getMobi().getGroup9Price();
        int banMobiG10 = account.getSell_price().getMobi().getGroup10Price();
        int banMobiG11 = account.getSell_price().getMobi().getGroup11Price();
        int banMobiG12 = account.getSell_price().getMobi().getGroup12Price();
        int banMobiG13 = account.getSell_price().getMobi().getGroup13Price();
        int banMobiG14 = account.getSell_price().getMobi().getGroup14Price();
        int banMobiG15 = account.getSell_price().getMobi().getGroup15Price();
        int banMobiGNLC = account.getSell_price().getMobi().getGroupLCPrice();

        int banVinaG0 = account.getSell_price().getVina().getGroup0Price();
        int banVinaG1 = account.getSell_price().getVina().getGroup1Price();
        int banVinaG2 = account.getSell_price().getVina().getGroup2Price();
        int banVinaG3 = account.getSell_price().getVina().getGroup3Price();
        int banVinaG4 = account.getSell_price().getVina().getGroup4Price();
        int banVinaG5 = account.getSell_price().getVina().getGroup5Price();
        int banVinaG6 = account.getSell_price().getVina().getGroup6Price();
        int banVinaG7 = account.getSell_price().getVina().getGroup7Price();
        int banVinaG8 = account.getSell_price().getVina().getGroup8Price();
        int banVinaG9 = account.getSell_price().getVina().getGroup9Price();
        int banVinaG10 = account.getSell_price().getVina().getGroup10Price();
        int banVinaG11 = account.getSell_price().getVina().getGroup11Price();
        int banVinaG12 = account.getSell_price().getVina().getGroup12Price();
        int banVinaG13 = account.getSell_price().getVina().getGroup13Price();
        int banVinaG14 = account.getSell_price().getVina().getGroup14Price();
        int banVinaG15 = account.getSell_price().getVina().getGroup15Price();
        int banVinaGNLC = account.getSell_price().getVina().getGroupLCPrice();

        int banVnmG0 = account.getSell_price().getVnm().getGroup0Price();
        int banVnmG1 = account.getSell_price().getVnm().getGroup1Price();
        int banVnmG2 = account.getSell_price().getVnm().getGroup2Price();
        int banVnmG3 = account.getSell_price().getVnm().getGroup3Price();
        int banVnmG4 = account.getSell_price().getVnm().getGroup4Price();
        int banVnmG5 = account.getSell_price().getVnm().getGroup5Price();
        int banVnmG6 = account.getSell_price().getVnm().getGroup6Price();
        int banVnmG7 = account.getSell_price().getVnm().getGroup7Price();
        int banVnmG8 = account.getSell_price().getVnm().getGroup8Price();
        int banVnmG9 = account.getSell_price().getVnm().getGroup9Price();
        int banVnmG10 = account.getSell_price().getVnm().getGroup10Price();
        int banVnmG11 = account.getSell_price().getVnm().getGroup11Price();
        int banVnmG12 = account.getSell_price().getVnm().getGroup12Price();
        int banVnmG13 = account.getSell_price().getVnm().getGroup13Price();
        int banVnmG14 = account.getSell_price().getVnm().getGroup14Price();
        int banVnmG15 = account.getSell_price().getVnm().getGroup15Price();
        int banVnmGNLC = account.getSell_price().getVnm().getGroupLCPrice();

        int banBlG0 = account.getSell_price().getBl().getGroup0Price();
        int banBlG1 = account.getSell_price().getBl().getGroup1Price();
        int banBlG2 = account.getSell_price().getBl().getGroup2Price();
        int banBlG3 = account.getSell_price().getBl().getGroup3Price();
        int banBlG4 = account.getSell_price().getBl().getGroup4Price();
        int banBlG5 = account.getSell_price().getBl().getGroup5Price();
        int banBlG6 = account.getSell_price().getBl().getGroup6Price();
        int banBlG7 = account.getSell_price().getBl().getGroup7Price();
        int banBlG8 = account.getSell_price().getBl().getGroup8Price();
        int banBlG9 = account.getSell_price().getBl().getGroup9Price();
        int banBlG10 = account.getSell_price().getBl().getGroup10Price();
        int banBlG11 = account.getSell_price().getBl().getGroup11Price();
        int banBlG12 = account.getSell_price().getBl().getGroup12Price();
        int banBlG13 = account.getSell_price().getBl().getGroup13Price();
        int banBlG14 = account.getSell_price().getBl().getGroup14Price();
        int banBlG15 = account.getSell_price().getBl().getGroup15Price();
        int banBlGNLC = account.getSell_price().getBl().getGroupLCPrice();

        int banDdgG0 = account.getSell_price().getDdg().getGroup0Price();
        int banDdgG1 = account.getSell_price().getDdg().getGroup1Price();
        int banDdgG2 = account.getSell_price().getDdg().getGroup2Price();
        int banDdgG3 = account.getSell_price().getDdg().getGroup3Price();
        int banDdgG4 = account.getSell_price().getDdg().getGroup4Price();
        int banDdgG5 = account.getSell_price().getDdg().getGroup5Price();
        int banDdgG6 = account.getSell_price().getDdg().getGroup6Price();
        int banDdgG7 = account.getSell_price().getDdg().getGroup7Price();
        int banDdgG8 = account.getSell_price().getDdg().getGroup8Price();
        int banDdgG9 = account.getSell_price().getDdg().getGroup9Price();
        int banDdgG10 = account.getSell_price().getDdg().getGroup10Price();
        int banDdgG11 = account.getSell_price().getDdg().getGroup11Price();
        int banDdgG12 = account.getSell_price().getDdg().getGroup12Price();
        int banDdgG13 = account.getSell_price().getDdg().getGroup13Price();
        int banDdgG14 = account.getSell_price().getDdg().getGroup14Price();
        int banDdgG15 = account.getSell_price().getDdg().getGroup15Price();
        int banDdgGNLC = account.getSell_price().getDdg().getGroupLCPrice();

        data.add(new Object[]{
            "",
            "Bán",
            banVteG0+"",
            banVteG1+"",
            banVteG2+"",
            banVteG3+"",
            banVteG4+"",
            banVteG5+"",
            banVteG6+"",
            banVteG7+"",
            banVteG8+"",
            banVteG9+"",
            banVteG10+"",
            banVteG11+"",
            banVteG12+"",
            banVteG13+"",
            banVteG14+"",
            banVteG15+"",
            banVteGNLC+"",
            "",
            banMobiG0+"",
            banMobiG1+"",
            banMobiG2+"",
            banMobiG3+"",
            banMobiG4+"",
            banMobiG5+"",
            banMobiG6+"",
            banMobiG7+"",
            banMobiG8+"",
            banMobiG9+"",
            banMobiG10+"",
            banMobiG11+"",
            banMobiG12+"",
            banMobiG13+"",
            banMobiG14+"",
            banMobiG15+"",
            banMobiGNLC+"",
            "",
            banVinaG0+"",
            banVinaG1+"",
            banVinaG2+"",
            banVinaG3+"",
            banVinaG4+"",
            banVinaG5+"",
            banVinaG6+"",
            banVinaG7+"",
            banVinaG8+"",
            banVinaG9+"",
            banVinaG10+"",
            banVinaG11+"",
            banVinaG12+"",
            banVinaG13+"",
            banVinaG14+"",
            banVinaG15+"",
            banVinaGNLC+"",
            "",
            banVnmG0+"",
            banVnmG1+"",
            banVnmG2+"",
            banVnmG3+"",
            banVnmG4+"",
            banVnmG5+"",
            banVnmG6+"",
            banVnmG7+"",
            banVnmG8+"",
            banVnmG9+"",
            banVnmG10+"",
            banVnmG11+"",
            banVnmG12+"",
            banVnmG13+"",
            banVnmG14+"",
            banVnmG15+"",
            banVnmGNLC+"",
            "",
            banBlG0+"",
            banBlG1+"",
            banBlG2+"",
            banBlG3+"",
            banBlG4+"",
            banBlG5+"",
            banBlG6+"",
            banBlG7+"",
            banBlG8+"",
            banBlG9+"",
            banBlG10+"",
            banBlG11+"",
            banBlG12+"",
            banBlG13+"",
            banBlG14+"",
            banBlG15+"",
            banBlGNLC+"",
            "",
            banDdgG0+"",
            banDdgG1+"",
            banDdgG2+"",
            banDdgG3+"",
            banDdgG4+"",
            banDdgG5+"",
            banDdgG6+"",
            banDdgG7+"",
            banDdgG8+"",
            banDdgG9+"",
            banDdgG10+"",
            banDdgG11+"",
            banDdgG12+"",
            banDdgG13+"",
            banDdgG14+"",
            banDdgG15+"",
            banDdgGNLC+"",
            ""
        });
data.add(new Object[]{            
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            ""
        });
    for (int i = 0; i < allArray.size(); i++) {  
        int vteN0 = 0;
        int vteN1 = 0;
        int vteN2 = 0;
        int vteN3 = 0;
        int vteN4 = 0;
        int vteN5 = 0;
        int vteN6 = 0;
        int vteN7 = 0;
        int vteN8 = 0;
        int vteN9 = 0;
        int vteN10 = 0;
        int vteN11 = 0;
        int vteN12 = 0;
        int vteN13 = 0;
        int vteN14 = 0;
        int vteN15 = 0;
        int vteNNLC = 0;
        int mobiN0 = 0;
        int mobiN1 = 0;
        int mobiN2 = 0;
        int mobiN3 = 0;
        int mobiN4 = 0;
        int mobiN5 = 0;
        int mobiN6 = 0;
        int mobiN7 = 0;
        int mobiN8 = 0;
        int mobiN9 = 0;
        int mobiN10 = 0;
        int mobiN11 = 0;
        int mobiN12 = 0;
        int mobiN13 = 0;
        int mobiN14 = 0;
        int mobiN15 = 0;
        int mobiNNLC = 0;
        int vinaN0 = 0;
        int vinaN1 = 0;
        int vinaN2 = 0;
        int vinaN3 = 0;
        int vinaN4 = 0;
        int vinaN5 = 0;
        int vinaN6 = 0;
        int vinaN7 = 0;
        int vinaN8 = 0;
        int vinaN9 = 0;
        int vinaN10 = 0;
        int vinaN11 = 0;
        int vinaN12 = 0;
        int vinaN13 = 0;
        int vinaN14 = 0;
        int vinaN15 = 0;
        int vinaNNLC = 0;
        int vnmN0 = 0;
        int vnmN1 = 0;
        int vnmN2 = 0;
        int vnmN3 = 0;
        int vnmN4 = 0;
        int vnmN5 = 0;
        int vnmN6 = 0;
        int vnmN7 = 0;
        int vnmN8 = 0;
        int vnmN9 = 0;
        int vnmN10 = 0;
        int vnmN11 = 0;
        int vnmN12 = 0;
        int vnmN13 = 0;
        int vnmN14 = 0;
        int vnmN15 = 0;
        int vnmNNLC = 0;
        int blN0 = 0;
        int blN1 = 0;
        int blN2 = 0;
        int blN3 = 0;
        int blN4 = 0;
        int blN5 = 0;
        int blN6 = 0;
        int blN7 = 0;
        int blN8 = 0;
        int blN9 = 0;
        int blN10 = 0;
        int blN11 = 0;
        int blN12 = 0;
        int blN13 = 0;
        int blN14 = 0;
        int blN15 = 0;
        int blNNLC = 0;
        int ddgN0 = 0;
        int ddgN1 = 0;
        int ddgN2 = 0;
        int ddgN3 = 0;
        int ddgN4 = 0;
        int ddgN5 = 0;
        int ddgN6 = 0;
        int ddgN7 = 0;
        int ddgN8 = 0;
        int ddgN9 = 0;
        int ddgN10 = 0;
        int ddgN11 = 0;
        int ddgN12 = 0;
        int ddgN13 = 0;
        int ddgN14 = 0;
        int ddgN15 = 0;
        int ddgNNLC = 0;

        
//        data.add(new Object[]{            
//            "",
//            "",
//            "",
//            "",
//            "Hướng ["+provider.get(i).getCode()+"] "+provider.get(i).getName(),
//            "",
//            "",
//            "",
//            "",
//            "",
//            "",
//            "",
//            "",
//            "",
//            "",
//            "",
//            "",
//            "",
//            ""
//        });

        for (MsgBrandSubmit onemo : allArray.get(i)) {
            if (onemo.getBrGroup().equals("N1")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN1 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN1 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN1 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN1 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN1 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN1 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N2")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN2 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN2 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN2 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN2 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN2 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN2 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N3")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN3 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN3 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN3 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN3 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN3 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN3 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N4")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN4 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN4 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN4 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN4 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN4 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN4 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N5")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN5 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN5 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN5 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN5 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN5 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN5 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N6")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN6 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN6 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN6 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN6 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN6 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN6 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N7")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN7 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN7 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN7 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN7 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN7 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN7 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N8")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN8 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN8 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN8 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN8 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN8 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN8 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N9")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN9 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN9 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN9 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN9 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN9 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN9 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N10")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN10 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN10 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN10 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN10 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN10 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN10 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N11")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN11 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN11 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN11 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN11 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN11 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN11 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N12")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN12 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN12 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN12 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN12 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN12 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN12 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N13")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN13 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN13 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN13 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN13 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN13 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN13 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N14")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN14 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN14 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN14 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN14 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN14 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN14 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("N15")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN15 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN15 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN15 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN15 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN15 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN15 += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("NNLC")) {
                if (onemo.getOper().equals("VTE")) {
                    vteNNLC += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaNNLC += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiNNLC += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmNNLC += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blNNLC += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgNNLC += onemo.getTotalSms();
                }
            }
            if (onemo.getBrGroup().equals("0")) {
                if (onemo.getOper().equals("VTE")) {
                    vteN0 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("GPC")) {
                    vinaN0 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VMS")) {
                    mobiN0 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("VNM")) {
                    vnmN0 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("BL")) {
                    blN0 += onemo.getTotalSms();
                } else if (onemo.getOper().equals("DDG")) {
                    ddgN0 += onemo.getTotalSms();
                }
            }
        }
        int vteTotal = vteN0+vteN1+vteN2+vteN3+vteN4+vteN5+vteN6+vteN7+vteN8+vteN9+vteN10+vteN11+vteN12+vteN13+vteN14+vteN15+vteNNLC;
        int vinaTotal = vinaN0+vinaN1+vinaN2+vinaN3+vinaN4+vinaN5+vinaN6+vinaN7+vinaN8+vinaN9+vinaN10+vinaN11+vinaN12+vinaN13+vinaN14+vinaN15+vinaNNLC;
        int vnmTotal = vnmN0+vnmN1+vnmN2+vnmN3+vnmN4+vnmN5+vnmN6+vnmN7+vnmN8+vnmN9+vnmN10+vnmN11+vnmN12+vnmN13+vnmN14+vnmN15+vnmNNLC;
        int mobiTotal = mobiN0+mobiN1+mobiN2+mobiN3+mobiN4+mobiN5+mobiN6+mobiN7+mobiN8+mobiN9+mobiN10+mobiN11+mobiN12+mobiN13+mobiN14+mobiN15+mobiNNLC;
        int blTotal = blN0+blN1+blN2+blN3+blN4+blN5+blN6+blN7+blN8+blN9+blN10+blN11+blN12+blN13+blN14+blN15+blNNLC;
        int ddgTotal = ddgN0+ddgN1+ddgN2+ddgN3+ddgN4+ddgN5+ddgN6+ddgN7+ddgN8+ddgN9+ddgN10+ddgN11+ddgN12+ddgN13+ddgN14+ddgN15+ddgNNLC;
        int totalTin = vteTotal + mobiTotal + vinaTotal + vnmTotal + blTotal + ddgTotal;

        int muaVteD0 = provider.get(i).getBuy_price().getVte().getGroup0Price();
        int muaVteD1 = provider.get(i).getBuy_price().getVte().getGroup1Price();
        int muaVteD2 = provider.get(i).getBuy_price().getVte().getGroup2Price();
        int muaVteD3 = provider.get(i).getBuy_price().getVte().getGroup3Price();
        int muaVteD4 = provider.get(i).getBuy_price().getVte().getGroup4Price();
        int muaVteD5 = provider.get(i).getBuy_price().getVte().getGroup5Price();
        int muaVteD6 = provider.get(i).getBuy_price().getVte().getGroup6Price();
        int muaVteD7 = provider.get(i).getBuy_price().getVte().getGroup7Price();
        int muaVteD8 = provider.get(i).getBuy_price().getVte().getGroup8Price();
        int muaVteD9 = provider.get(i).getBuy_price().getVte().getGroup9Price();
        int muaVteD10 = provider.get(i).getBuy_price().getVte().getGroup10Price();
        int muaVteD11 = provider.get(i).getBuy_price().getVte().getGroup11Price();
        int muaVteD12 = provider.get(i).getBuy_price().getVte().getGroup12Price();
        int muaVteD13 = provider.get(i).getBuy_price().getVte().getGroup13Price();
        int muaVteD14 = provider.get(i).getBuy_price().getVte().getGroup14Price();
        int muaVteD15 = provider.get(i).getBuy_price().getVte().getGroup15Price();
        int muaVteDNLC = provider.get(i).getBuy_price().getVte().getGroupLCPrice();

        int muaMobiG0 = provider.get(i).getBuy_price().getMobi().getGroup0Price();
        int muaMobiG1 = provider.get(i).getBuy_price().getMobi().getGroup1Price();
        int muaMobiG2 = provider.get(i).getBuy_price().getMobi().getGroup2Price();
        int muaMobiG3 = provider.get(i).getBuy_price().getMobi().getGroup3Price();
        int muaMobiG4 = provider.get(i).getBuy_price().getMobi().getGroup4Price();
        int muaMobiG5 = provider.get(i).getBuy_price().getMobi().getGroup5Price();
        int muaMobiG6 = provider.get(i).getBuy_price().getMobi().getGroup6Price();
        int muaMobiG7 = provider.get(i).getBuy_price().getMobi().getGroup7Price();
        int muaMobiG8 = provider.get(i).getBuy_price().getMobi().getGroup8Price();
        int muaMobiG9 = provider.get(i).getBuy_price().getMobi().getGroup9Price();
        int muaMobiG10 = provider.get(i).getBuy_price().getMobi().getGroup10Price();
        int muaMobiG11 = provider.get(i).getBuy_price().getMobi().getGroup11Price();
        int muaMobiG12 = provider.get(i).getBuy_price().getMobi().getGroup12Price();
        int muaMobiG13 = provider.get(i).getBuy_price().getMobi().getGroup13Price();
        int muaMobiG14 = provider.get(i).getBuy_price().getMobi().getGroup14Price();
        int muaMobiG15 = provider.get(i).getBuy_price().getMobi().getGroup15Price();
        int muaMobiGNLC = provider.get(i).getBuy_price().getMobi().getGroupLCPrice();

        int muaVinaG0 = provider.get(i).getBuy_price().getVina().getGroup0Price();
        int muaVinaG1 = provider.get(i).getBuy_price().getVina().getGroup1Price();
        int muaVinaG2 = provider.get(i).getBuy_price().getVina().getGroup2Price();
        int muaVinaG3 = provider.get(i).getBuy_price().getVina().getGroup3Price();
        int muaVinaG4 = provider.get(i).getBuy_price().getVina().getGroup4Price();
        int muaVinaG5 = provider.get(i).getBuy_price().getVina().getGroup5Price();
        int muaVinaG6 = provider.get(i).getBuy_price().getVina().getGroup6Price();
        int muaVinaG7 = provider.get(i).getBuy_price().getVina().getGroup7Price();
        int muaVinaG8 = provider.get(i).getBuy_price().getVina().getGroup8Price();
        int muaVinaG9 = provider.get(i).getBuy_price().getVina().getGroup9Price();
        int muaVinaG10 = provider.get(i).getBuy_price().getVina().getGroup10Price();
        int muaVinaG11 = provider.get(i).getBuy_price().getVina().getGroup11Price();
        int muaVinaG12 = provider.get(i).getBuy_price().getVina().getGroup12Price();
        int muaVinaG13 = provider.get(i).getBuy_price().getVina().getGroup13Price();
        int muaVinaG14 = provider.get(i).getBuy_price().getVina().getGroup14Price();
        int muaVinaG15 = provider.get(i).getBuy_price().getVina().getGroup15Price();
        int muaVinaGNLC = provider.get(i).getBuy_price().getVina().getGroupLCPrice();

        int muaVnmG0 = provider.get(i).getBuy_price().getVnm().getGroup0Price();
        int muaVnmG1 = provider.get(i).getBuy_price().getVnm().getGroup1Price();
        int muaVnmG2 = provider.get(i).getBuy_price().getVnm().getGroup2Price();
        int muaVnmG3 = provider.get(i).getBuy_price().getVnm().getGroup3Price();
        int muaVnmG4 = provider.get(i).getBuy_price().getVnm().getGroup4Price();
        int muaVnmG5 = provider.get(i).getBuy_price().getVnm().getGroup5Price();
        int muaVnmG6 = provider.get(i).getBuy_price().getVnm().getGroup6Price();
        int muaVnmG7 = provider.get(i).getBuy_price().getVnm().getGroup7Price();
        int muaVnmG8 = provider.get(i).getBuy_price().getVnm().getGroup8Price();
        int muaVnmG9 = provider.get(i).getBuy_price().getVnm().getGroup9Price();
        int muaVnmG10 = provider.get(i).getBuy_price().getVnm().getGroup10Price();
        int muaVnmG11 = provider.get(i).getBuy_price().getVnm().getGroup11Price();
        int muaVnmG12 = provider.get(i).getBuy_price().getVnm().getGroup12Price();
        int muaVnmG13 = provider.get(i).getBuy_price().getVnm().getGroup13Price();
        int muaVnmG14 = provider.get(i).getBuy_price().getVnm().getGroup14Price();
        int muaVnmG15 = provider.get(i).getBuy_price().getVnm().getGroup15Price();
        int muaVnmGNLC = provider.get(i).getBuy_price().getVnm().getGroupLCPrice();

        int muaBlG0 = provider.get(i).getBuy_price().getBl().getGroup0Price();
        int muaBlG1 = provider.get(i).getBuy_price().getBl().getGroup1Price();
        int muaBlG2 = provider.get(i).getBuy_price().getBl().getGroup2Price();
        int muaBlG3 = provider.get(i).getBuy_price().getBl().getGroup3Price();
        int muaBlG4 = provider.get(i).getBuy_price().getBl().getGroup4Price();
        int muaBlG5 = provider.get(i).getBuy_price().getBl().getGroup5Price();
        int muaBlG6 = provider.get(i).getBuy_price().getBl().getGroup6Price();
        int muaBlG7 = provider.get(i).getBuy_price().getBl().getGroup7Price();
        int muaBlG8 = provider.get(i).getBuy_price().getBl().getGroup8Price();
        int muaBlG9 = provider.get(i).getBuy_price().getBl().getGroup9Price();
        int muaBlG10 = provider.get(i).getBuy_price().getBl().getGroup10Price();
        int muaBlG11 = provider.get(i).getBuy_price().getBl().getGroup11Price();
        int muaBlG12 = provider.get(i).getBuy_price().getBl().getGroup12Price();
        int muaBlG13 = provider.get(i).getBuy_price().getBl().getGroup13Price();
        int muaBlG14 = provider.get(i).getBuy_price().getBl().getGroup14Price();
        int muaBlG15 = provider.get(i).getBuy_price().getBl().getGroup15Price();
        int muaBlGNLC = provider.get(i).getBuy_price().getBl().getGroupLCPrice();

        int muaDdgG0 = provider.get(i).getBuy_price().getDdg().getGroup0Price();
        int muaDdgG1 = provider.get(i).getBuy_price().getDdg().getGroup1Price();
        int muaDdgG2 = provider.get(i).getBuy_price().getDdg().getGroup2Price();
        int muaDdgG3 = provider.get(i).getBuy_price().getDdg().getGroup3Price();
        int muaDdgG4 = provider.get(i).getBuy_price().getDdg().getGroup4Price();
        int muaDdgG5 = provider.get(i).getBuy_price().getDdg().getGroup5Price();
        int muaDdgG6 = provider.get(i).getBuy_price().getDdg().getGroup6Price();
        int muaDdgG7 = provider.get(i).getBuy_price().getDdg().getGroup7Price();
        int muaDdgG8 = provider.get(i).getBuy_price().getDdg().getGroup8Price();
        int muaDdgG9 = provider.get(i).getBuy_price().getDdg().getGroup9Price();
        int muaDdgG10 = provider.get(i).getBuy_price().getDdg().getGroup10Price();
        int muaDdgG11 = provider.get(i).getBuy_price().getDdg().getGroup11Price();
        int muaDdgG12 = provider.get(i).getBuy_price().getDdg().getGroup12Price();
        int muaDdgG13 = provider.get(i).getBuy_price().getDdg().getGroup13Price();
        int muaDdgG14 = provider.get(i).getBuy_price().getDdg().getGroup14Price();
        int muaDdgG15 = provider.get(i).getBuy_price().getDdg().getGroup15Price();
        int muaDdgGNLC = provider.get(i).getBuy_price().getDdg().getGroupLCPrice();

        data.add(new Object[]{
            "",
            "Mua",
            muaVteD0+"",
            muaVteD1+"",
            muaVteD2+"",
            muaVteD3+"",
            muaVteD4+"",
            muaVteD5+"",
            muaVteD6+"",
            muaVteD7+"",
            muaVteD8+"",
            muaVteD9+"",
            muaVteD10+"",
            muaVteD11+"",
            muaVteD12+"",
            muaVteD13+"",
            muaVteD14+"",
            muaVteD15+"",
            muaVteDNLC+"",
            "",
            muaMobiG0+"",
            muaMobiG1+"",
            muaMobiG2+"",
            muaMobiG3+"",
            muaMobiG4+"",
            muaMobiG5+"",
            muaMobiG6+"",
            muaMobiG7+"",
            muaMobiG8+"",
            muaMobiG9+"",
            muaMobiG10+"",
            muaMobiG11+"",
            muaMobiG12+"",
            muaMobiG13+"",
            muaMobiG14+"",
            muaMobiG15+"",
            muaMobiGNLC+"",
            "",
            muaVinaG0+"",
            muaVinaG1+"",
            muaVinaG2+"",
            muaVinaG3+"",
            muaVinaG4+"",
            muaVinaG5+"",
            muaVinaG6+"",
            muaVinaG7+"",
            muaVinaG8+"",
            muaVinaG9+"",
            muaVinaG10+"",
            muaVinaG11+"",
            muaVinaG12+"",
            muaVinaG13+"",
            muaVinaG14+"",
            muaVinaG15+"",
            muaVinaGNLC+"",
            "",
            muaVnmG0+"",
            muaVnmG1+"",
            muaVnmG2+"",
            muaVnmG3+"",
            muaVnmG4+"",
            muaVnmG5+"",
            muaVnmG6+"",
            muaVnmG7+"",
            muaVnmG8+"",
            muaVnmG9+"",
            muaVnmG10+"",
            muaVnmG11+"",
            muaVnmG12+"",
            muaVnmG13+"",
            muaVnmG14+"",
            muaVnmG15+"",
            muaVnmGNLC+"",
            "",
            muaBlG0+"",
            muaBlG1+"",
            muaBlG2+"",
            muaBlG3+"",
            muaBlG4+"",
            muaBlG5+"",
            muaBlG6+"",
            muaBlG7+"",
            muaBlG8+"",
            muaBlG9+"",
            muaBlG10+"",
            muaBlG11+"",
            muaBlG12+"",
            muaBlG13+"",
            muaBlG14+"",
            muaBlG15+"",
            muaBlGNLC+"",
            "",
            muaDdgG0+"",
            muaDdgG1+"",
            muaDdgG2+"",
            muaDdgG3+"",
            muaDdgG4+"",
            muaDdgG5+"",
            muaDdgG6+"",
            muaDdgG7+"",
            muaDdgG8+"",
            muaDdgG9+"",
            muaDdgG10+"",
            muaDdgG11+"",
            muaDdgG12+"",
            muaDdgG13+"",
            muaDdgG14+"",
            muaDdgG15+"",
            muaDdgGNLC+"",
            ""
        });

        data.add(new Object[]{
            "",
            "Tin",
            vteN0+"",
            vteN1+"",
            vteN2+"",
            vteN3+"",
            vteN4+"",
            vteN5+"",
            vteN6+"",
            vteN7+"",
            vteN8+"",
            vteN9+"",
            vteN10+"",
            vteN11+"",
            vteN12+"",
            vteN13+"",
            vteN14+"",
            vteN15+"",
            vteNNLC+"",
            vteTotal+"",
            mobiN0+"",
            mobiN1+"",
            mobiN2+"",
            mobiN3+"",
            mobiN4+"",
            mobiN5+"",
            mobiN6+"",
            mobiN7+"",
            mobiN8+"",
            mobiN9+"",
            mobiN10+"",
            mobiN11+"",
            mobiN12+"",
            mobiN13+"",
            mobiN14+"",
            mobiN15+"",
            mobiNNLC+"",
            mobiTotal+"",
            vinaN0+"",
            vinaN1+"",
            vinaN2+"",
            vinaN3+"",
            vinaN4+"",
            vinaN5+"",
            vinaN6+"",
            vinaN7+"",
            vinaN8+"",
            vinaN9+"",
            vinaN10+"",
            vinaN11+"",
            vinaN12+"",
            vinaN13+"",
            vinaN14+"",
            vinaN15+"",
            vinaNNLC+"",
            vinaTotal+"",
            vnmN0+"",
            vnmN1+"",
            vnmN2+"",
            vnmN3+"",
            vnmN4+"",
            vnmN5+"",
            vnmN6+"",
            vnmN7+"",
            vnmN8+"",
            vnmN9+"",
            vnmN10+"",
            vnmN11+"",
            vnmN12+"",
            vnmN13+"",
            vnmN14+"",
            vnmN15+"",
            vnmNNLC+"",
            vnmTotal+"",
            blN0+"",
            blN1+"",
            blN2+"",
            blN3+"",
            blN4+"",
            blN5+"",
            blN6+"",
            blN7+"",
            blN8+"",
            blN9+"",
            blN10+"",
            blN11+"",
            blN12+"",
            blN13+"",
            blN14+"",
            blN15+"",
            blNNLC+"",
            blTotal+"",
            ddgN0+"",
            ddgN1+"",
            ddgN2+"",
            ddgN3+"",
            ddgN4+"",
            ddgN5+"",
            ddgN6+"",
            ddgN7+"",
            ddgN8+"",
            ddgN9+"",
            ddgN10+"",
            ddgN11+"",
            ddgN12+"",
            ddgN13+"",
            ddgN14+"",
            ddgN15+"",
            ddgNNLC+"",
            ddgTotal+"",
            totalTin+""
        });
        
        int dtVteG0 = banVteG0*vteN0;
        int dtVteG1 = banVteG1*vteN1;
        int dtVteG2 = banVteG2*vteN2;
        int dtVteG3 = banVteG3*vteN3;
        int dtVteG4 = banVteG4*vteN4;
        int dtVteG5 = banVteG5*vteN5;
        int dtVteG6 = banVteG6*vteN6;
        int dtVteG7 = banVteG7*vteN7;
        int dtVteG8 = banVteG8*vteN8;
        int dtVteG9 = banVteG9*vteN9;
        int dtVteG10 = banVteG10*vteN10;
        int dtVteG11 = banVteG11*vteN11;
        int dtVteG12 = banVteG12*vteN12;
        int dtVteG13 = banVteG13*vteN13;
        int dtVteG14 = banVteG14*vteN14;
        int dtVteG15 = banVteG15*vteN15;
        int dtVteGNLC = banVteGNLC*vteNNLC;

        int dtMobiG0 = banMobiG0*mobiN0;
        int dtMobiG1 = banMobiG1*mobiN1;
        int dtMobiG2 = banMobiG2*mobiN2;
        int dtMobiG3 = banMobiG3*mobiN3;
        int dtMobiG4 = banMobiG4*mobiN4;
        int dtMobiG5 = banMobiG5*mobiN5;
        int dtMobiG6 = banMobiG6*mobiN6;
        int dtMobiG7 = banMobiG7*mobiN7;
        int dtMobiG8 = banMobiG8*mobiN8;
        int dtMobiG9 = banMobiG9*mobiN9;
        int dtMobiG10 = banMobiG10*mobiN10;
        int dtMobiG11 = banMobiG11*mobiN11;
        int dtMobiG12 = banMobiG12*mobiN12;
        int dtMobiG13 = banMobiG13*mobiN13;
        int dtMobiG14 = banMobiG14*mobiN14;
        int dtMobiG15 = banMobiG15*mobiN15;
        int dtMobiGNLC = banMobiGNLC*mobiNNLC;

        int dtVinaG0 = banVinaG0*vinaN0;
        int dtVinaG1 = banVinaG1*vinaN1;
        int dtVinaG2 = banVinaG2*vinaN2;
        int dtVinaG3 = banVinaG3*vinaN3;
        int dtVinaG4 = banVinaG4*vinaN4;
        int dtVinaG5 = banVinaG5*vinaN5;
        int dtVinaG6 = banVinaG6*vinaN6;
        int dtVinaG7 = banVinaG7*vinaN7;
        int dtVinaG8 = banVinaG8*vinaN8;
        int dtVinaG9 = banVinaG9*vinaN9;
        int dtVinaG10 = banVinaG10*vinaN10;
        int dtVinaG11 = banVinaG11*vinaN11;
        int dtVinaG12 = banVinaG12*vinaN12;
        int dtVinaG13 = banVinaG13*vinaN13;
        int dtVinaG14 = banVinaG14*vinaN14;
        int dtVinaG15 = banVinaG15*vinaN15;
        int dtVinaGNLC = banVinaGNLC*vinaNNLC;

        int dtVnmG0 = banVnmG0*vnmN0;
        int dtVnmG1 = banVnmG1*vnmN1;
        int dtVnmG2 = banVnmG2*vnmN2;
        int dtVnmG3 = banVnmG3*vnmN3;
        int dtVnmG4 = banVnmG4*vnmN4;
        int dtVnmG5 = banVnmG5*vnmN5;
        int dtVnmG6 = banVnmG6*vnmN6;
        int dtVnmG7 = banVnmG7*vnmN7;
        int dtVnmG8 = banVnmG8*vnmN8;
        int dtVnmG9 = banVnmG9*vnmN9;
        int dtVnmG10 = banVnmG10*vnmN10;
        int dtVnmG11 = banVnmG11*vnmN11;
        int dtVnmG12 = banVnmG12*vnmN12;
        int dtVnmG13 = banVnmG13*vnmN13;
        int dtVnmG14 = banVnmG14*vnmN14;
        int dtVnmG15 = banVnmG15*vnmN15;
        int dtVnmGNLC = banVnmGNLC*vnmNNLC;

        int dtBlG0 = banBlG0*blN0;
        int dtBlG1 = banBlG1*blN1;
        int dtBlG2 = banBlG2*blN2;
        int dtBlG3 = banBlG3*blN3;
        int dtBlG4 = banBlG4*blN4;
        int dtBlG5 = banBlG5*blN5;
        int dtBlG6 = banBlG6*blN6;
        int dtBlG7 = banBlG7*blN7;
        int dtBlG8 = banBlG8*blN8;
        int dtBlG9 = banBlG9*blN9;
        int dtBlG10 = banBlG10*blN10;
        int dtBlG11 = banBlG11*blN11;
        int dtBlG12 = banBlG12*blN12;
        int dtBlG13 = banBlG13*blN13;
        int dtBlG14 = banBlG14*blN14;
        int dtBlG15 = banBlG15*blN15;
        int dtBlGNLC = banBlGNLC*blNNLC;

        int dtDdgG0 = banDdgG0*ddgN0;
        int dtDdgG1 = banDdgG1*ddgN1;
        int dtDdgG2 = banDdgG2*ddgN2;
        int dtDdgG3 = banDdgG3*ddgN3;
        int dtDdgG4 = banDdgG4*ddgN4;
        int dtDdgG5 = banDdgG5*ddgN5;
        int dtDdgG6 = banDdgG6*ddgN6;
        int dtDdgG7 = banDdgG7*ddgN7;
        int dtDdgG8 = banDdgG8*ddgN8;
        int dtDdgG9 = banDdgG9*ddgN9;
        int dtDdgG10 = banDdgG10*ddgN10;
        int dtDdgG11 = banDdgG11*ddgN11;
        int dtDdgG12 = banDdgG12*ddgN12;
        int dtDdgG13 = banDdgG13*ddgN13;
        int dtDdgG14 = banDdgG14*ddgN14;
        int dtDdgG15 = banDdgG15*ddgN15;
        int dtDdgGNLC = banDdgGNLC*ddgNNLC;
        
        int dtVteTotal = dtVteG0+dtVteG1+dtVteG2+dtVteG3+dtVteG4+dtVteG5+dtVteG6+dtVteG7+dtVteG8+dtVteG9+dtVteG10+dtVteG11+dtVteG12+dtVteG13+dtVteG14+dtVteG15+dtVteGNLC;
        int dtMobiTotal = dtMobiG0+dtMobiG1+dtMobiG2+dtMobiG3+dtMobiG4+dtMobiG5+dtMobiG6+dtMobiG7+dtMobiG8+dtMobiG9+dtMobiG10+dtMobiG11+dtMobiG12+dtMobiG13+dtMobiG14+dtMobiG15+dtMobiGNLC;
        int dtVinaTotal = dtVinaG0+dtVinaG1+dtVinaG2+dtVinaG3+dtVinaG4+dtVinaG5+dtVinaG6+dtVinaG7+dtVinaG8+dtVinaG9+dtVinaG10+dtVinaG11+dtVinaG12+dtVinaG13+dtVinaG14+dtVinaG15+dtVinaGNLC;
        int dtVnmTotal = dtVnmG0+dtVnmG1+dtVnmG2+dtVnmG3+dtVnmG4+dtVnmG5+dtVnmG6+dtVnmG7+dtVnmG8+dtVnmG9+dtVnmG10+dtVnmG11+dtVnmG12+dtVnmG13+dtVnmG14+dtVnmG15+dtVnmGNLC;
        int dtBlTotal = dtBlG0+dtBlG1+dtBlG2+dtBlG3+dtBlG4+dtBlG5+dtBlG6+dtBlG7+dtBlG8+dtBlG9+dtBlG10+dtBlG11+dtBlG12+dtBlG13+dtBlG14+dtBlG15+dtBlGNLC;
        int dtDdgTotal = dtDdgG0+dtDdgG1+dtDdgG2+dtDdgG3+dtDdgG4+dtDdgG5+dtDdgG6+dtDdgG7+dtDdgG8+dtDdgG9+dtDdgG10+dtDdgG11+dtDdgG12+dtDdgG13+dtDdgG14+dtDdgG15+dtDdgGNLC;
        
        int dtTotal = dtVteTotal+dtMobiTotal+dtVinaTotal+dtVnmTotal+dtBlTotal+dtDdgTotal;
        
        data.add(new Object[]{
            "Hướng ["+provider.get(i).getCode()+"] "+provider.get(i).getName(),
            "Doanh thu",
            dtVteG0+"",
            dtVteG1+"",
            dtVteG2+"",
            dtVteG3+"",
            dtVteG4+"",
            dtVteG5+"",
            dtVteG6+"",
            dtVteG7+"",
            dtVteG8+"",
            dtVteG9+"",
            dtVteG10+"",
            dtVteG11+"",
            dtVteG12+"",
            dtVteG13+"",
            dtVteG14+"",
            dtVteG15+"",
            dtVteGNLC+"",
            dtVteTotal+"",
            dtMobiG0+"",
            dtMobiG1+"",
            dtMobiG2+"",
            dtMobiG3+"",
            dtMobiG4+"",
            dtMobiG5+"",
            dtMobiG6+"",
            dtMobiG7+"",
            dtMobiG8+"",
            dtMobiG9+"",
            dtMobiG10+"",
            dtMobiG11+"",
            dtMobiG12+"",
            dtMobiG13+"",
            dtMobiG14+"",
            dtMobiG15+"",
            dtMobiGNLC+"",
            dtMobiTotal+"",
            dtVinaG0+"",
            dtVinaG1+"",
            dtVinaG2+"",
            dtVinaG3+"",
            dtVinaG4+"",
            dtVinaG5+"",
            dtVinaG6+"",
            dtVinaG7+"",
            dtVinaG8+"",
            dtVinaG9+"",
            dtVinaG10+"",
            dtVinaG11+"",
            dtVinaG12+"",
            dtVinaG13+"",
            dtVinaG14+"",
            dtVinaG15+"",
            dtVinaGNLC+"",
            dtVinaTotal+"",
            dtVnmG0+"",
            dtVnmG1+"",
            dtVnmG2+"",
            dtVnmG3+"",
            dtVnmG4+"",
            dtVnmG5+"",
            dtVnmG6+"",
            dtVnmG7+"",
            dtVnmG8+"",
            dtVnmG9+"",
            dtVnmG10+"",
            dtVnmG11+"",
            dtVnmG12+"",
            dtVnmG13+"",
            dtVnmG14+"",
            dtVnmG15+"",
            dtVnmGNLC+"",
            dtVnmTotal+"",
            dtBlG0+"",
            dtBlG1+"",
            dtBlG2+"",
            dtBlG3+"",
            dtBlG4+"",
            dtBlG5+"",
            dtBlG6+"",
            dtBlG7+"",
            dtBlG8+"",
            dtBlG9+"",
            dtBlG10+"",
            dtBlG11+"",
            dtBlG12+"",
            dtBlG13+"",
            dtBlG14+"",
            dtBlG15+"",
            dtBlGNLC+"",
            dtBlTotal+"",
            dtDdgG0+"",
            dtDdgG1+"",
            dtDdgG2+"",
            dtDdgG3+"",
            dtDdgG4+"",
            dtDdgG5+"",
            dtDdgG6+"",
            dtDdgG7+"",
            dtDdgG8+"",
            dtDdgG9+"",
            dtDdgG10+"",
            dtDdgG11+"",
            dtDdgG12+"",
            dtDdgG13+"",
            dtDdgG14+"",
            dtDdgG15+"",
            dtDdgGNLC+"",
            dtDdgTotal+"",
            dtTotal+""
        });

        int cpVteG0 = muaVteD0*vteN0;
        int cpVteG1 = muaVteD1*vteN1;
        int cpVteG2 = muaVteD2*vteN2;
        int cpVteG3 = muaVteD3*vteN3;
        int cpVteG4 = muaVteD4*vteN4;
        int cpVteG5 = muaVteD5*vteN5;
        int cpVteG6 = muaVteD6*vteN6;
        int cpVteG7 = muaVteD7*vteN7;
        int cpVteG8 = muaVteD8*vteN8;
        int cpVteG9 = muaVteD9*vteN9;
        int cpVteG10 = muaVteD10*vteN10;
        int cpVteG11 = muaVteD11*vteN11;
        int cpVteG12 = muaVteD12*vteN12;
        int cpVteG13 = muaVteD13*vteN13;
        int cpVteG14 = muaVteD14*vteN14;
        int cpVteG15 = muaVteD15*vteN15;
        int cpVteGNLC = muaVteDNLC*vteNNLC;
        int cpVteGTotal = cpVteG0+cpVteG1+cpVteG2+cpVteG3+cpVteG4+cpVteG5+cpVteG6+cpVteG7+cpVteG8+cpVteG9+cpVteG10+cpVteG11+cpVteG12+cpVteG13+cpVteG14+cpVteG15+cpVteGNLC;

        int cpMobiG0 = muaMobiG0*mobiN0;
        int cpMobiG1 = muaMobiG1*mobiN1;
        int cpMobiG2 = muaMobiG2*mobiN2;
        int cpMobiG3 = muaMobiG3*mobiN3;
        int cpMobiG4 = muaMobiG4*mobiN4;
        int cpMobiG5 = muaMobiG5*mobiN5;
        int cpMobiG6 = muaMobiG6*mobiN6;
        int cpMobiG7 = muaMobiG7*mobiN7;
        int cpMobiG8 = muaMobiG8*mobiN8;
        int cpMobiG9 = muaMobiG9*mobiN9;
        int cpMobiG10 = muaMobiG10*mobiN10;
        int cpMobiG11 = muaMobiG11*mobiN11;
        int cpMobiG12 = muaMobiG12*mobiN12;
        int cpMobiG13 = muaMobiG13*mobiN13;
        int cpMobiG14 = muaMobiG14*mobiN14;
        int cpMobiG15 = muaMobiG15*mobiN15;
        int cpMobiGNLC = muaMobiGNLC*mobiNNLC;
        int cpMobiGTotal = cpMobiG0+cpMobiG1+cpMobiG2+cpMobiG3+cpMobiG4+cpMobiG5+cpMobiG6+cpMobiG7+cpMobiG8+cpMobiG9+cpMobiG10+cpMobiG11+cpMobiG12+cpMobiG13+cpMobiG14+cpMobiG15+cpMobiGNLC;

        int cpVinaG0 = muaVinaG0*vinaN0;
        int cpVinaG1 = muaVinaG1*vinaN1;
        int cpVinaG2 = muaVinaG2*vinaN2;
        int cpVinaG3 = muaVinaG3*vinaN3;
        int cpVinaG4 = muaVinaG4*vinaN4;
        int cpVinaG5 = muaVinaG5*vinaN5;
        int cpVinaG6 = muaVinaG6*vinaN6;
        int cpVinaG7 = muaVinaG7*vinaN7;
        int cpVinaG8 = muaVinaG8*vinaN8;
        int cpVinaG9 = muaVinaG9*vinaN9;
        int cpVinaG10 = muaVinaG10*vinaN10;
        int cpVinaG11 = muaVinaG11*vinaN11;
        int cpVinaG12 = muaVinaG12*vinaN12;
        int cpVinaG13 = muaVinaG13*vinaN13;
        int cpVinaG14 = muaVinaG14*vinaN14;
        int cpVinaG15 = muaVinaG15*vinaN15;
        int cpVinaGNLC = muaVinaGNLC*vinaNNLC;
        int cpVinaGTotal = cpVinaG0+cpVinaG1+cpVinaG2+cpVinaG3+cpVinaG4+cpVinaG5+cpVinaG6+cpVinaG7+cpVinaG8+cpVinaG9+cpVinaG10+cpVinaG11+cpVinaG12+cpVinaG13+cpVinaG14+cpVinaG15+cpVinaGNLC;

        int cpVnmG0 = muaVnmG0*vnmN0;
        int cpVnmG1 = muaVnmG1*vnmN1;
        int cpVnmG2 = muaVnmG2*vnmN2;
        int cpVnmG3 = muaVnmG3*vnmN3;
        int cpVnmG4 = muaVnmG4*vnmN4;
        int cpVnmG5 = muaVnmG5*vnmN5;
        int cpVnmG6 = muaVnmG6*vnmN6;
        int cpVnmG7 = muaVnmG7*vnmN7;
        int cpVnmG8 = muaVnmG8*vnmN8;
        int cpVnmG9 = muaVnmG9*vnmN9;
        int cpVnmG10 = muaVnmG10*vnmN10;
        int cpVnmG11 = muaVnmG11*vnmN11;
        int cpVnmG12 = muaVnmG12*vnmN12;
        int cpVnmG13 = muaVnmG13*vnmN13;
        int cpVnmG14 = muaVnmG14*vnmN14;
        int cpVnmG15 = muaVnmG15*vnmN15;
        int cpVnmGNLC = muaVnmGNLC*vnmNNLC;
        int cpVnmGTotal = cpVnmG0+cpVnmG1+cpVnmG2+cpVnmG3+cpVnmG4+cpVnmG5+cpVnmG6+cpVnmG7+cpVnmG8+cpVnmG9+cpVnmG10+cpVnmG11+cpVnmG12+cpVnmG13+cpVnmG14+cpVnmG15+cpVnmGNLC;

        int cpBlG0 = muaBlG0*blN0;
        int cpBlG1 = muaBlG1*blN1;
        int cpBlG2 = muaBlG2*blN2;
        int cpBlG3 = muaBlG3*blN3;
        int cpBlG4 = muaBlG4*blN4;
        int cpBlG5 = muaBlG5*blN5;
        int cpBlG6 = muaBlG6*blN6;
        int cpBlG7 = muaBlG7*blN7;
        int cpBlG8 = muaBlG8*blN8;
        int cpBlG9 = muaBlG9*blN9;
        int cpBlG10 = muaBlG10*blN10;
        int cpBlG11 = muaBlG11*blN11;
        int cpBlG12 = muaBlG12*blN12;
        int cpBlG13 = muaBlG13*blN13;
        int cpBlG14 = muaBlG14*blN14;
        int cpBlG15 = muaBlG15*blN15;
        int cpBlGNLC = muaBlGNLC*blNNLC;
        int cpBlGTotal = cpBlG0+cpBlG1+cpBlG2+cpBlG3+cpBlG4+cpBlG5+cpBlG6+cpBlG7+cpBlG8+cpBlG9+cpBlG10+cpBlG11+cpBlG12+cpBlG13+cpBlG14+cpBlG15+cpBlGNLC;

        int cpDdgG0 = muaDdgG0*ddgN0;
        int cpDdgG1 = muaDdgG1*ddgN1;
        int cpDdgG2 = muaDdgG2*ddgN2;
        int cpDdgG3 = muaDdgG3*ddgN3;
        int cpDdgG4 = muaDdgG4*ddgN4;
        int cpDdgG5 = muaDdgG5*ddgN5;
        int cpDdgG6 = muaDdgG6*ddgN6;
        int cpDdgG7 = muaDdgG7*ddgN7;
        int cpDdgG8 = muaDdgG8*ddgN8;
        int cpDdgG9 = muaDdgG9*ddgN9;
        int cpDdgG10 = muaDdgG10*ddgN10;
        int cpDdgG11 = muaDdgG11*ddgN11;
        int cpDdgG12 = muaDdgG12*ddgN12;
        int cpDdgG13 = muaDdgG13*ddgN13;
        int cpDdgG14 = muaDdgG14*ddgN14;
        int cpDdgG15 = muaDdgG15*ddgN15;
        int cpDdgGNLC = muaDdgGNLC*ddgNNLC;
        int cpDdgGTotal = cpDdgG0+cpDdgG1+cpDdgG2+cpDdgG3+cpDdgG4+cpDdgG5+cpDdgG6+cpDdgG7+cpDdgG8+cpDdgG9+cpDdgG10+cpDdgG11+cpDdgG12+cpDdgG13+cpDdgG14+cpDdgG15+cpDdgGNLC;

        int cpTotal = cpVteGTotal+cpMobiGTotal+cpVinaGTotal+cpVnmGTotal+cpBlGTotal+cpDdgGTotal;

        data.add(new Object[]{
            "",
            "Chi phí",
            cpVteG0+"",
            cpVteG1+"",
            cpVteG2+"",
            cpVteG3+"",
            cpVteG4+"",
            cpVteG5+"",
            cpVteG6+"",
            cpVteG7+"",
            cpVteG8+"",
            cpVteG9+"",
            cpVteG10+"",
            cpVteG11+"",
            cpVteG12+"",
            cpVteG13+"",
            cpVteG14+"",
            cpVteG15+"",
            cpVteGNLC+"",
            cpVteGTotal+"",
            cpMobiG0+"",
            cpMobiG1+"",
            cpMobiG2+"",
            cpMobiG3+"",
            cpMobiG4+"",
            cpMobiG5+"",
            cpMobiG6+"",
            cpMobiG7+"",
            cpMobiG8+"",
            cpMobiG9+"",
            cpMobiG10+"",
            cpMobiG11+"",
            cpMobiG12+"",
            cpMobiG13+"",
            cpMobiG14+"",
            cpMobiG15+"",
            cpMobiGNLC+"",
            cpMobiGTotal+"",
            cpVinaG0+"",
            cpVinaG1+"",
            cpVinaG2+"",
            cpVinaG3+"",
            cpVinaG4+"",
            cpVinaG5+"",
            cpVinaG6+"",
            cpVinaG7+"",
            cpVinaG8+"",
            cpVinaG9+"",
            cpVinaG10+"",
            cpVinaG11+"",
            cpVinaG12+"",
            cpVinaG13+"",
            cpVinaG14+"",
            cpVinaG15+"",
            cpVinaGNLC+"",
            cpVinaGTotal+"",
            cpVnmG0+"",
            cpVnmG1+"",
            cpVnmG2+"",
            cpVnmG3+"",
            cpVnmG4+"",
            cpVnmG5+"",
            cpVnmG6+"",
            cpVnmG7+"",
            cpVnmG8+"",
            cpVnmG9+"",
            cpVnmG10+"",
            cpVnmG11+"",
            cpVnmG12+"",
            cpVnmG13+"",
            cpVnmG14+"",
            cpVnmG15+"",
            cpVnmGNLC+"",
            cpVnmGTotal+"",
            cpBlG0+"",
            cpBlG1+"",
            cpBlG2+"",
            cpBlG3+"",
            cpBlG4+"",
            cpBlG5+"",
            cpBlG6+"",
            cpBlG7+"",
            cpBlG8+"",
            cpBlG9+"",
            cpBlG10+"",
            cpBlG11+"",
            cpBlG12+"",
            cpBlG13+"",
            cpBlG14+"",
            cpBlG15+"",
            cpBlGNLC+"",
            cpBlGTotal+"",
            cpDdgG0+"",
            cpDdgG1+"",
            cpDdgG2+"",
            cpDdgG3+"",
            cpDdgG4+"",
            cpDdgG5+"",
            cpDdgG6+"",
            cpDdgG7+"",
            cpDdgG8+"",
            cpDdgG9+"",
            cpDdgG10+"",
            cpDdgG11+"",
            cpDdgG12+"",
            cpDdgG13+"",
            cpDdgG14+"",
            cpDdgG15+"",
            cpDdgGNLC+"",
            cpDdgGTotal+"",
            cpTotal+"",
        });
        
        int lnVteG0 = dtVteG0-cpVteG0;
        int lnVteG1 = dtVteG1-cpVteG1;
        int lnVteG2 = dtVteG2-cpVteG2;
        int lnVteG3 = dtVteG3-cpVteG3;
        int lnVteG4 = dtVteG4-cpVteG4;
        int lnVteG5 = dtVteG5-cpVteG5;
        int lnVteG6 = dtVteG6-cpVteG6;
        int lnVteG7 = dtVteG7-cpVteG7;
        int lnVteG8 = dtVteG8-cpVteG8;
        int lnVteG9 = dtVteG9-cpVteG9;
        int lnVteG10 = dtVteG10-cpVteG10;
        int lnVteG11 = dtVteG11-cpVteG11;
        int lnVteG12 = dtVteG12-cpVteG12;
        int lnVteG13 = dtVteG13-cpVteG13;
        int lnVteG14 = dtVteG14-cpVteG14;
        int lnVteG15 = dtVteG15-cpVteG15;
        int lnVteGNLC = dtVteGNLC-cpVteGNLC;
        int lnVteGTotal = dtVteTotal-cpVteGTotal;

        int lnMobiG0 = dtMobiG0-cpMobiG0;
        int lnMobiG1 = dtMobiG1-cpMobiG1;
        int lnMobiG2 = dtMobiG2-cpMobiG2;
        int lnMobiG3 = dtMobiG3-cpMobiG3;
        int lnMobiG4 = dtMobiG4-cpMobiG4;
        int lnMobiG5 = dtMobiG5-cpMobiG5;
        int lnMobiG6 = dtMobiG6-cpMobiG6;
        int lnMobiG7 = dtMobiG7-cpMobiG7;
        int lnMobiG8 = dtMobiG8-cpMobiG8;
        int lnMobiG9 = dtMobiG9-cpMobiG9;
        int lnMobiG10 = dtMobiG10-cpMobiG10;
        int lnMobiG11 = dtMobiG11-cpMobiG11;
        int lnMobiG12 = dtMobiG12-cpMobiG12;
        int lnMobiG13 = dtMobiG13-cpMobiG13;
        int lnMobiG14 = dtMobiG14-cpMobiG14;
        int lnMobiG15 = dtMobiG15-cpMobiG15;
        int lnMobiGNLC = dtMobiGNLC-cpMobiGNLC;
        int lnMobiGTotal = dtMobiTotal-cpMobiGTotal;

        int lnVinaG0 = dtVinaG0-cpVinaG0;
        int lnVinaG1 = dtVinaG1-cpVinaG1;
        int lnVinaG2 = dtVinaG2-cpVinaG2;
        int lnVinaG3 = dtVinaG3-cpVinaG3;
        int lnVinaG4 = dtVinaG4-cpVinaG4;
        int lnVinaG5 = dtVinaG5-cpVinaG5;
        int lnVinaG6 = dtVinaG6-cpVinaG6;
        int lnVinaG7 = dtVinaG7-cpVinaG7;
        int lnVinaG8 = dtVinaG8-cpVinaG8;
        int lnVinaG9 = dtVinaG9-cpVinaG9;
        int lnVinaG10 = dtVinaG10-cpVinaG10;
        int lnVinaG11 = dtVinaG11-cpVinaG11;
        int lnVinaG12 = dtVinaG12-cpVinaG12;
        int lnVinaG13 = dtVinaG13-cpVinaG13;
        int lnVinaG14 = dtVinaG14-cpVinaG14;
        int lnVinaG15 = dtVinaG15-cpVinaG15;
        int lnVinaGNLC = dtVinaGNLC-cpVinaGNLC;
        int lnVinaGTotal = dtVinaTotal-cpVinaGTotal;

        int lnVnmG0 = dtVnmG0-cpVnmG0;
        int lnVnmG1 = dtVnmG1-cpVnmG1;
        int lnVnmG2 = dtVnmG2-cpVnmG2;
        int lnVnmG3 = dtVnmG3-cpVnmG3;
        int lnVnmG4 = dtVnmG4-cpVnmG4;
        int lnVnmG5 = dtVnmG5-cpVnmG5;
        int lnVnmG6 = dtVnmG6-cpVnmG6;
        int lnVnmG7 = dtVnmG7-cpVnmG7;
        int lnVnmG8 = dtVnmG8-cpVnmG8;
        int lnVnmG9 = dtVnmG9-cpVnmG9;
        int lnVnmG10 = dtVnmG10-cpVnmG10;
        int lnVnmG11 = dtVnmG11-cpVnmG11;
        int lnVnmG12 = dtVnmG12-cpVnmG12;
        int lnVnmG13 = dtVnmG13-cpVnmG13;
        int lnVnmG14 = dtVnmG14-cpVnmG14;
        int lnVnmG15 = dtVnmG15-cpVnmG15;
        int lnVnmGNLC = dtVnmGNLC-cpVnmGNLC;
        int lnVnmGTotal = dtVnmTotal-cpVnmGTotal;

        int lnBlG0 = dtBlG0-cpBlG0;
        int lnBlG1 = dtBlG1-cpBlG1;
        int lnBlG2 = dtBlG2-cpBlG2;
        int lnBlG3 = dtBlG3-cpBlG3;
        int lnBlG4 = dtBlG4-cpBlG4;
        int lnBlG5 = dtBlG5-cpBlG5;
        int lnBlG6 = dtBlG6-cpBlG6;
        int lnBlG7 = dtBlG7-cpBlG7;
        int lnBlG8 = dtBlG8-cpBlG8;
        int lnBlG9 = dtBlG9-cpBlG9;
        int lnBlG10 = dtBlG10-cpBlG10;
        int lnBlG11 = dtBlG11-cpBlG11;
        int lnBlG12 = dtBlG12-cpBlG12;
        int lnBlG13 = dtBlG13-cpBlG13;
        int lnBlG14 = dtBlG14-cpBlG14;
        int lnBlG15 = dtBlG15-cpBlG15;
        int lnBlGNLC = dtBlGNLC-cpBlGNLC;
        int lnBlGTotal = dtBlTotal-cpBlGTotal;

        int lnDdgG0 = dtDdgG0-cpDdgG0;
        int lnDdgG1 = dtDdgG1-cpDdgG1;
        int lnDdgG2 = dtDdgG2-cpDdgG2;
        int lnDdgG3 = dtDdgG3-cpDdgG3;
        int lnDdgG4 = dtDdgG4-cpDdgG4;
        int lnDdgG5 = dtDdgG5-cpDdgG5;
        int lnDdgG6 = dtDdgG6-cpDdgG6;
        int lnDdgG7 = dtDdgG7-cpDdgG7;
        int lnDdgG8 = dtDdgG8-cpDdgG8;
        int lnDdgG9 = dtDdgG9-cpDdgG9;
        int lnDdgG10 = dtDdgG10-cpDdgG10;
        int lnDdgG11 = dtDdgG11-cpDdgG11;
        int lnDdgG12 = dtDdgG12-cpDdgG12;
        int lnDdgG13 = dtDdgG13-cpDdgG13;
        int lnDdgG14 = dtDdgG14-cpDdgG14;
        int lnDdgG15 = dtDdgG15-cpDdgG15;
        int lnDdgGNLC = dtDdgGNLC-cpDdgGNLC;
        int lnDdgGTotal = dtDdgTotal-cpDdgGNLC;

        int lnTotal = lnVteGTotal+lnMobiGTotal+lnVinaGTotal+lnVnmGTotal+lnVnmGTotal+lnBlGTotal+lnDdgGTotal;

        data.add(new Object[]{
            "",
            "Lợi nhuận",
            lnVteG0+"",
            lnVteG1+"",
            lnVteG2+"",
            lnVteG3+"",
            lnVteG4+"",
            lnVteG5+"",
            lnVteG6+"",
            lnVteG7+"",
            lnVteG8+"",
            lnVteG9+"",
            lnVteG10+"",
            lnVteG11+"",
            lnVteG12+"",
            lnVteG13+"",
            lnVteG14+"",
            lnVteG15+"",
            lnVteGNLC+"",
            lnVteGTotal+"",
            lnMobiG0+"",
            lnMobiG1+"",
            lnMobiG2+"",
            lnMobiG3+"",
            lnMobiG4+"",
            lnMobiG5+"",
            lnMobiG6+"",
            lnMobiG7+"",
            lnMobiG8+"",
            lnMobiG9+"",
            lnMobiG10+"",
            lnMobiG11+"",
            lnMobiG12+"",
            lnMobiG13+"",
            lnMobiG14+"",
            lnMobiG15+"",
            lnMobiGNLC+"",
            lnMobiGTotal+"",
            lnVinaG0+"",
            lnVinaG1+"",
            lnVinaG2+"",
            lnVinaG3+"",
            lnVinaG4+"",
            lnVinaG5+"",
            lnVinaG6+"",
            lnVinaG7+"",
            lnVinaG8+"",
            lnVinaG9+"",
            lnVinaG10+"",
            lnVinaG11+"",
            lnVinaG12+"",
            lnVinaG13+"",
            lnVinaG14+"",
            lnVinaG15+"",
            lnVinaGNLC+"",
            lnVinaGTotal+"",
            lnVnmG0+"",
            lnVnmG1+"",
            lnVnmG2+"",
            lnVnmG3+"",
            lnVnmG4+"",
            lnVnmG5+"",
            lnVnmG6+"",
            lnVnmG7+"",
            lnVnmG8+"",
            lnVnmG9+"",
            lnVnmG10+"",
            lnVnmG11+"",
            lnVnmG12+"",
            lnVnmG13+"",
            lnVnmG14+"",
            lnVnmG15+"",
            lnVnmGNLC+"",
            lnVnmGTotal+"",
            lnBlG0+"",
            lnBlG1+"",
            lnBlG2+"",
            lnBlG3+"",
            lnBlG4+"",
            lnBlG5+"",
            lnBlG6+"",
            lnBlG7+"",
            lnBlG8+"",
            lnBlG9+"",
            lnBlG10+"",
            lnBlG11+"",
            lnBlG12+"",
            lnBlG13+"",
            lnBlG14+"",
            lnBlG15+"",
            lnBlGNLC+"",
            lnBlGTotal+"",
            lnDdgG0+"",
            lnDdgG1+"",
            lnDdgG2+"",
            lnDdgG3+"",
            lnDdgG4+"",
            lnDdgG5+"",
            lnDdgG6+"",
            lnDdgG7+"",
            lnDdgG8+"",
            lnDdgG9+"",
            lnDdgG10+"",
            lnDdgG11+"",
            lnDdgG12+"",
            lnDdgG13+"",
            lnDdgG14+"",
            lnDdgG15+"",
            lnDdgGNLC+"",
            lnDdgGTotal+"",
            lnTotal+""
        });
        
        data.add(new Object[]{            
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            ""
        });
    }
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
//            response.setHeader("Content-Disposition", "attachment; filename=Baocao-" + DateProc.createDDMMYYYY() + ".xls");
            response.setHeader("Content-Disposition", "attachment; filename=DoanhThu-" + stRequest+"-"+endRequest + ".xls");
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