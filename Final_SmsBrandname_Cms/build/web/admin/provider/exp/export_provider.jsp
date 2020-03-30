<%@page import="gk.myname.vn.entity.Provider"%>
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

        ArrayList<Provider> all = null;
        Provider smDao = new Provider();
        int currentPage = RequestTool.getInt(request, "currentPage");
        int max = 50;
        String code = RequestTool.getString(request, "code");
        String name = RequestTool.getString(request, "name");
        all = smDao.getProvider(currentPage, max, code, name);
        
        out.clear();
        out = pageContext.pushBody();
        createExcel(all, response);
        return;
    } catch (Exception ex) {
        System.out.println(ex.getMessage());
    }
%>

<%!
    public static void createExcel(ArrayList<Provider> allMoLog, HttpServletResponse response) {
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(DateProc.createDDMMYYYY().replaceAll("/", ""));

        ArrayList<Object[]> data = new ArrayList();
        data.add(new Object[]{
                "Provider CODE",
                "Provider NAME	",
                "POS",
                "CLASS",
                "Hướng Mua",
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
                "NNLC"
            });

        for (Provider onemo : allMoLog) {
            if (onemo.getVte() == 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "VIETTEL",
                    onemo.getBuy_price().getVte().getGroup1Price()+"",
                    onemo.getBuy_price().getVte().getGroup2Price()+"",
                    onemo.getBuy_price().getVte().getGroup3Price()+"",
                    onemo.getBuy_price().getVte().getGroup4Price()+"",
                    onemo.getBuy_price().getVte().getGroup5Price()+"",
                    onemo.getBuy_price().getVte().getGroup6Price()+"",
                    onemo.getBuy_price().getVte().getGroup7Price()+"",
                    onemo.getBuy_price().getVte().getGroup8Price()+"",
                    onemo.getBuy_price().getVte().getGroup9Price()+"",
                    onemo.getBuy_price().getVte().getGroup10Price()+"",
                    onemo.getBuy_price().getVte().getGroup11Price()+"",
                    onemo.getBuy_price().getVte().getGroup12Price()+"",
                    onemo.getBuy_price().getVte().getGroup13Price()+"",
                    onemo.getBuy_price().getVte().getGroup14Price()+"",
                    onemo.getBuy_price().getVte().getGroup15Price()+"",
                    onemo.getBuy_price().getVte().getGroupLCPrice()+""
                });
            }
            
            if (onemo.getMobi()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "MOBI",
                    onemo.getBuy_price().getMobi().getGroup1Price()+"",
                    onemo.getBuy_price().getMobi().getGroup2Price()+"",
                    onemo.getBuy_price().getMobi().getGroup3Price()+"",
                    onemo.getBuy_price().getMobi().getGroup4Price()+"",
                    onemo.getBuy_price().getMobi().getGroup5Price()+"",
                    onemo.getBuy_price().getMobi().getGroup6Price()+"",
                    onemo.getBuy_price().getMobi().getGroup7Price()+"",
                    onemo.getBuy_price().getMobi().getGroup8Price()+"",
                    onemo.getBuy_price().getMobi().getGroup9Price()+"",
                    onemo.getBuy_price().getMobi().getGroup10Price()+"",
                    onemo.getBuy_price().getMobi().getGroup11Price()+"",
                    onemo.getBuy_price().getMobi().getGroup12Price()+"",
                    onemo.getBuy_price().getMobi().getGroup13Price()+"",
                    onemo.getBuy_price().getMobi().getGroup14Price()+"",
                    onemo.getBuy_price().getMobi().getGroup15Price()+"",
                    onemo.getBuy_price().getMobi().getGroupLCPrice()+""
                });
            }

            if (onemo.getVina()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "VINA",
                    onemo.getBuy_price().getVina().getGroup1Price()+"",
                    onemo.getBuy_price().getVina().getGroup2Price()+"",
                    onemo.getBuy_price().getVina().getGroup3Price()+"",
                    onemo.getBuy_price().getVina().getGroup4Price()+"",
                    onemo.getBuy_price().getVina().getGroup5Price()+"",
                    onemo.getBuy_price().getVina().getGroup6Price()+"",
                    onemo.getBuy_price().getVina().getGroup7Price()+"",
                    onemo.getBuy_price().getVina().getGroup8Price()+"",
                    onemo.getBuy_price().getVina().getGroup9Price()+"",
                    onemo.getBuy_price().getVina().getGroup10Price()+"",
                    onemo.getBuy_price().getVina().getGroup11Price()+"",
                    onemo.getBuy_price().getVina().getGroup12Price()+"",
                    onemo.getBuy_price().getVina().getGroup13Price()+"",
                    onemo.getBuy_price().getVina().getGroup14Price()+"",
                    onemo.getBuy_price().getVina().getGroup15Price()+"",
                    onemo.getBuy_price().getVina().getGroupLCPrice()+""
                });
            }

            if (onemo.getVnm()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "VIET NAM MOBI",
                    onemo.getBuy_price().getVnm().getGroup1Price()+"",
                    onemo.getBuy_price().getVnm().getGroup2Price()+"",
                    onemo.getBuy_price().getVnm().getGroup3Price()+"",
                    onemo.getBuy_price().getVnm().getGroup4Price()+"",
                    onemo.getBuy_price().getVnm().getGroup5Price()+"",
                    onemo.getBuy_price().getVnm().getGroup6Price()+"",
                    onemo.getBuy_price().getVnm().getGroup7Price()+"",
                    onemo.getBuy_price().getVnm().getGroup8Price()+"",
                    onemo.getBuy_price().getVnm().getGroup9Price()+"",
                    onemo.getBuy_price().getVnm().getGroup10Price()+"",
                    onemo.getBuy_price().getVnm().getGroup11Price()+"",
                    onemo.getBuy_price().getVnm().getGroup12Price()+"",
                    onemo.getBuy_price().getVnm().getGroup13Price()+"",
                    onemo.getBuy_price().getVnm().getGroup14Price()+"",
                    onemo.getBuy_price().getVnm().getGroup15Price()+"",
                    onemo.getBuy_price().getVnm().getGroupLCPrice()+""
                });
            }

            if (onemo.getBl()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "Beeline",
                    onemo.getBuy_price().getBl().getGroup1Price()+"",
                    onemo.getBuy_price().getBl().getGroup2Price()+"",
                    onemo.getBuy_price().getBl().getGroup3Price()+"",
                    onemo.getBuy_price().getBl().getGroup4Price()+"",
                    onemo.getBuy_price().getBl().getGroup5Price()+"",
                    onemo.getBuy_price().getBl().getGroup6Price()+"",
                    onemo.getBuy_price().getBl().getGroup7Price()+"",
                    onemo.getBuy_price().getBl().getGroup8Price()+"",
                    onemo.getBuy_price().getBl().getGroup9Price()+"",
                    onemo.getBuy_price().getBl().getGroup10Price()+"",
                    onemo.getBuy_price().getBl().getGroup11Price()+"",
                    onemo.getBuy_price().getBl().getGroup12Price()+"",
                    onemo.getBuy_price().getBl().getGroup13Price()+"",
                    onemo.getBuy_price().getBl().getGroup14Price()+"",
                    onemo.getBuy_price().getBl().getGroup15Price()+"",
                    onemo.getBuy_price().getBl().getGroupLCPrice()+""
                });
            }

            if (onemo.getDdg()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "ITELECOM",
                    onemo.getBuy_price().getDdg().getGroup1Price()+"",
                    onemo.getBuy_price().getDdg().getGroup2Price()+"",
                    onemo.getBuy_price().getDdg().getGroup3Price()+"",
                    onemo.getBuy_price().getDdg().getGroup4Price()+"",
                    onemo.getBuy_price().getDdg().getGroup5Price()+"",
                    onemo.getBuy_price().getDdg().getGroup6Price()+"",
                    onemo.getBuy_price().getDdg().getGroup7Price()+"",
                    onemo.getBuy_price().getDdg().getGroup8Price()+"",
                    onemo.getBuy_price().getDdg().getGroup9Price()+"",
                    onemo.getBuy_price().getDdg().getGroup10Price()+"",
                    onemo.getBuy_price().getDdg().getGroup11Price()+"",
                    onemo.getBuy_price().getDdg().getGroup12Price()+"",
                    onemo.getBuy_price().getDdg().getGroup13Price()+"",
                    onemo.getBuy_price().getDdg().getGroup14Price()+"",
                    onemo.getBuy_price().getDdg().getGroup15Price()+"",
                    onemo.getBuy_price().getDdg().getGroupLCPrice()+""
                });
            }

            if (onemo.getTelemor()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "TELEMOR",
                    onemo.getBuy_price().getTelemor().getGroup1Price()+"",
                    onemo.getBuy_price().getTelemor().getGroup2Price()+"",
                    onemo.getBuy_price().getTelemor().getGroup3Price()+"",
                    onemo.getBuy_price().getTelemor().getGroup4Price()+"",
                    onemo.getBuy_price().getTelemor().getGroup5Price()+"",
                    onemo.getBuy_price().getTelemor().getGroup6Price()+"",
                    onemo.getBuy_price().getTelemor().getGroup7Price()+"",
                    onemo.getBuy_price().getTelemor().getGroup8Price()+"",
                    onemo.getBuy_price().getTelemor().getGroup9Price()+"",
                    onemo.getBuy_price().getTelemor().getGroup10Price()+"",
                    onemo.getBuy_price().getTelemor().getGroup11Price()+"",
                    onemo.getBuy_price().getTelemor().getGroup12Price()+"",
                    onemo.getBuy_price().getTelemor().getGroup13Price()+"",
                    onemo.getBuy_price().getTelemor().getGroup14Price()+"",
                    onemo.getBuy_price().getTelemor().getGroup15Price()+"",
                    onemo.getBuy_price().getTelemor().getGroupLCPrice()+""
                });
            }

            if (onemo.getMovitel()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "MOVITEL",
                    onemo.getBuy_price().getMovitel().getGroup1Price()+"",
                    onemo.getBuy_price().getMovitel().getGroup2Price()+"",
                    onemo.getBuy_price().getMovitel().getGroup3Price()+"",
                    onemo.getBuy_price().getMovitel().getGroup4Price()+"",
                    onemo.getBuy_price().getMovitel().getGroup5Price()+"",
                    onemo.getBuy_price().getMovitel().getGroup6Price()+"",
                    onemo.getBuy_price().getMovitel().getGroup7Price()+"",
                    onemo.getBuy_price().getMovitel().getGroup8Price()+"",
                    onemo.getBuy_price().getMovitel().getGroup9Price()+"",
                    onemo.getBuy_price().getMovitel().getGroup10Price()+"",
                    onemo.getBuy_price().getMovitel().getGroup11Price()+"",
                    onemo.getBuy_price().getMovitel().getGroup12Price()+"",
                    onemo.getBuy_price().getMovitel().getGroup13Price()+"",
                    onemo.getBuy_price().getMovitel().getGroup14Price()+"",
                    onemo.getBuy_price().getMovitel().getGroup15Price()+"",
                    onemo.getBuy_price().getMovitel().getGroupLCPrice()+""
                });
            }

            if (onemo.getUnitel()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "UNITEL",
                    onemo.getBuy_price().getUnitel().getGroup1Price()+"",
                    onemo.getBuy_price().getUnitel().getGroup2Price()+"",
                    onemo.getBuy_price().getUnitel().getGroup3Price()+"",
                    onemo.getBuy_price().getUnitel().getGroup4Price()+"",
                    onemo.getBuy_price().getUnitel().getGroup5Price()+"",
                    onemo.getBuy_price().getUnitel().getGroup6Price()+"",
                    onemo.getBuy_price().getUnitel().getGroup7Price()+"",
                    onemo.getBuy_price().getUnitel().getGroup8Price()+"",
                    onemo.getBuy_price().getUnitel().getGroup9Price()+"",
                    onemo.getBuy_price().getUnitel().getGroup10Price()+"",
                    onemo.getBuy_price().getUnitel().getGroup11Price()+"",
                    onemo.getBuy_price().getUnitel().getGroup12Price()+"",
                    onemo.getBuy_price().getUnitel().getGroup13Price()+"",
                    onemo.getBuy_price().getUnitel().getGroup14Price()+"",
                    onemo.getBuy_price().getUnitel().getGroup15Price()+"",
                    onemo.getBuy_price().getUnitel().getGroupLCPrice()+""
                });
            }

            if (onemo.getMytel()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "MYTEL",
                    onemo.getBuy_price().getMytel().getGroup1Price()+"",
                    onemo.getBuy_price().getMytel().getGroup2Price()+"",
                    onemo.getBuy_price().getMytel().getGroup3Price()+"",
                    onemo.getBuy_price().getMytel().getGroup4Price()+"",
                    onemo.getBuy_price().getMytel().getGroup5Price()+"",
                    onemo.getBuy_price().getMytel().getGroup6Price()+"",
                    onemo.getBuy_price().getMytel().getGroup7Price()+"",
                    onemo.getBuy_price().getMytel().getGroup8Price()+"",
                    onemo.getBuy_price().getMytel().getGroup9Price()+"",
                    onemo.getBuy_price().getMytel().getGroup10Price()+"",
                    onemo.getBuy_price().getMytel().getGroup11Price()+"",
                    onemo.getBuy_price().getMytel().getGroup12Price()+"",
                    onemo.getBuy_price().getMytel().getGroup13Price()+"",
                    onemo.getBuy_price().getMytel().getGroup14Price()+"",
                    onemo.getBuy_price().getMytel().getGroup15Price()+"",
                    onemo.getBuy_price().getMytel().getGroupLCPrice()+""
                });
            }

            if (onemo.getNatcom()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "NATCOM",
                    onemo.getBuy_price().getNatcom().getGroup1Price()+"",
                    onemo.getBuy_price().getNatcom().getGroup2Price()+"",
                    onemo.getBuy_price().getNatcom().getGroup3Price()+"",
                    onemo.getBuy_price().getNatcom().getGroup4Price()+"",
                    onemo.getBuy_price().getNatcom().getGroup5Price()+"",
                    onemo.getBuy_price().getNatcom().getGroup6Price()+"",
                    onemo.getBuy_price().getNatcom().getGroup7Price()+"",
                    onemo.getBuy_price().getNatcom().getGroup8Price()+"",
                    onemo.getBuy_price().getNatcom().getGroup9Price()+"",
                    onemo.getBuy_price().getNatcom().getGroup10Price()+"",
                    onemo.getBuy_price().getNatcom().getGroup11Price()+"",
                    onemo.getBuy_price().getNatcom().getGroup12Price()+"",
                    onemo.getBuy_price().getNatcom().getGroup13Price()+"",
                    onemo.getBuy_price().getNatcom().getGroup14Price()+"",
                    onemo.getBuy_price().getNatcom().getGroup15Price()+"",
                    onemo.getBuy_price().getNatcom().getGroupLCPrice()+""
                });
            }

            if (onemo.getLumitel()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "LUMITEL",
                    onemo.getBuy_price().getLumitel().getGroup1Price()+"",
                    onemo.getBuy_price().getLumitel().getGroup2Price()+"",
                    onemo.getBuy_price().getLumitel().getGroup3Price()+"",
                    onemo.getBuy_price().getLumitel().getGroup4Price()+"",
                    onemo.getBuy_price().getLumitel().getGroup5Price()+"",
                    onemo.getBuy_price().getLumitel().getGroup6Price()+"",
                    onemo.getBuy_price().getLumitel().getGroup7Price()+"",
                    onemo.getBuy_price().getLumitel().getGroup8Price()+"",
                    onemo.getBuy_price().getLumitel().getGroup9Price()+"",
                    onemo.getBuy_price().getLumitel().getGroup10Price()+"",
                    onemo.getBuy_price().getLumitel().getGroup11Price()+"",
                    onemo.getBuy_price().getLumitel().getGroup12Price()+"",
                    onemo.getBuy_price().getLumitel().getGroup13Price()+"",
                    onemo.getBuy_price().getLumitel().getGroup14Price()+"",
                    onemo.getBuy_price().getLumitel().getGroup15Price()+"",
                    onemo.getBuy_price().getLumitel().getGroupLCPrice()+""
                });
            }

            if (onemo.getNexttel()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "NEXTTEL",
                    onemo.getBuy_price().getNexttel().getGroup1Price()+"",
                    onemo.getBuy_price().getNexttel().getGroup2Price()+"",
                    onemo.getBuy_price().getNexttel().getGroup3Price()+"",
                    onemo.getBuy_price().getNexttel().getGroup4Price()+"",
                    onemo.getBuy_price().getNexttel().getGroup5Price()+"",
                    onemo.getBuy_price().getNexttel().getGroup6Price()+"",
                    onemo.getBuy_price().getNexttel().getGroup7Price()+"",
                    onemo.getBuy_price().getNexttel().getGroup8Price()+"",
                    onemo.getBuy_price().getNexttel().getGroup9Price()+"",
                    onemo.getBuy_price().getNexttel().getGroup10Price()+"",
                    onemo.getBuy_price().getNexttel().getGroup11Price()+"",
                    onemo.getBuy_price().getNexttel().getGroup12Price()+"",
                    onemo.getBuy_price().getNexttel().getGroup13Price()+"",
                    onemo.getBuy_price().getNexttel().getGroup14Price()+"",
                    onemo.getBuy_price().getNexttel().getGroup15Price()+"",
                    onemo.getBuy_price().getNexttel().getGroupLCPrice()+""
                });
            }

            if (onemo.getHalotel()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "HALOTEL",
                    onemo.getBuy_price().getHalotel().getGroup1Price()+"",
                    onemo.getBuy_price().getHalotel().getGroup2Price()+"",
                    onemo.getBuy_price().getHalotel().getGroup3Price()+"",
                    onemo.getBuy_price().getHalotel().getGroup4Price()+"",
                    onemo.getBuy_price().getHalotel().getGroup5Price()+"",
                    onemo.getBuy_price().getHalotel().getGroup6Price()+"",
                    onemo.getBuy_price().getHalotel().getGroup7Price()+"",
                    onemo.getBuy_price().getHalotel().getGroup8Price()+"",
                    onemo.getBuy_price().getHalotel().getGroup9Price()+"",
                    onemo.getBuy_price().getHalotel().getGroup10Price()+"",
                    onemo.getBuy_price().getHalotel().getGroup11Price()+"",
                    onemo.getBuy_price().getHalotel().getGroup12Price()+"",
                    onemo.getBuy_price().getHalotel().getGroup13Price()+"",
                    onemo.getBuy_price().getHalotel().getGroup14Price()+"",
                    onemo.getBuy_price().getHalotel().getGroup15Price()+"",
                    onemo.getBuy_price().getHalotel().getGroupLCPrice()+""
                });
            }

            if (onemo.getCellcard()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "CELLCARD",
                    onemo.getBuy_price().getCellcard().getGroup1Price()+"",
                    onemo.getBuy_price().getCellcard().getGroup2Price()+"",
                    onemo.getBuy_price().getCellcard().getGroup3Price()+"",
                    onemo.getBuy_price().getCellcard().getGroup4Price()+"",
                    onemo.getBuy_price().getCellcard().getGroup5Price()+"",
                    onemo.getBuy_price().getCellcard().getGroup6Price()+"",
                    onemo.getBuy_price().getCellcard().getGroup7Price()+"",
                    onemo.getBuy_price().getCellcard().getGroup8Price()+"",
                    onemo.getBuy_price().getCellcard().getGroup9Price()+"",
                    onemo.getBuy_price().getCellcard().getGroup10Price()+"",
                    onemo.getBuy_price().getCellcard().getGroup11Price()+"",
                    onemo.getBuy_price().getCellcard().getGroup12Price()+"",
                    onemo.getBuy_price().getCellcard().getGroup13Price()+"",
                    onemo.getBuy_price().getCellcard().getGroup14Price()+"",
                    onemo.getBuy_price().getCellcard().getGroup15Price()+"",
                    onemo.getBuy_price().getCellcard().getGroupLCPrice()+""
                });
            }

            if (onemo.getBitel()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "BITEL",
                    onemo.getBuy_price().getBitel().getGroup1Price()+"",
                    onemo.getBuy_price().getBitel().getGroup2Price()+"",
                    onemo.getBuy_price().getBitel().getGroup3Price()+"",
                    onemo.getBuy_price().getBitel().getGroup4Price()+"",
                    onemo.getBuy_price().getBitel().getGroup5Price()+"",
                    onemo.getBuy_price().getBitel().getGroup6Price()+"",
                    onemo.getBuy_price().getBitel().getGroup7Price()+"",
                    onemo.getBuy_price().getBitel().getGroup8Price()+"",
                    onemo.getBuy_price().getBitel().getGroup9Price()+"",
                    onemo.getBuy_price().getBitel().getGroup10Price()+"",
                    onemo.getBuy_price().getBitel().getGroup11Price()+"",
                    onemo.getBuy_price().getBitel().getGroup12Price()+"",
                    onemo.getBuy_price().getBitel().getGroup13Price()+"",
                    onemo.getBuy_price().getBitel().getGroup14Price()+"",
                    onemo.getBuy_price().getBitel().getGroup15Price()+"",
                    onemo.getBuy_price().getBitel().getGroupLCPrice()+""
                });
            }

            if (onemo.getMetfone()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "METFONE",
                    onemo.getBuy_price().getMetfone().getGroup1Price()+"",
                    onemo.getBuy_price().getMetfone().getGroup2Price()+"",
                    onemo.getBuy_price().getMetfone().getGroup3Price()+"",
                    onemo.getBuy_price().getMetfone().getGroup4Price()+"",
                    onemo.getBuy_price().getMetfone().getGroup5Price()+"",
                    onemo.getBuy_price().getMetfone().getGroup6Price()+"",
                    onemo.getBuy_price().getMetfone().getGroup7Price()+"",
                    onemo.getBuy_price().getMetfone().getGroup8Price()+"",
                    onemo.getBuy_price().getMetfone().getGroup9Price()+"",
                    onemo.getBuy_price().getMetfone().getGroup10Price()+"",
                    onemo.getBuy_price().getMetfone().getGroup11Price()+"",
                    onemo.getBuy_price().getMetfone().getGroup12Price()+"",
                    onemo.getBuy_price().getMetfone().getGroup13Price()+"",
                    onemo.getBuy_price().getMetfone().getGroup14Price()+"",
                    onemo.getBuy_price().getMetfone().getGroup15Price()+"",
                    onemo.getBuy_price().getMetfone().getGroupLCPrice()+""
                });
            }

            if (onemo.getBeelineCampuchia()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "BEELINE CAMPUCHIA",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup1Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup2Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup3Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup4Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup5Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup6Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup7Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup8Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup9Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup10Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup11Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup12Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup13Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup14Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroup15Price()+"",
                    onemo.getBuy_price().getBeelineCampuchia().getGroupLCPrice()+""
                });
            }

            if (onemo.getSmart()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "SMART",
                    onemo.getBuy_price().getSmart().getGroup1Price()+"",
                    onemo.getBuy_price().getSmart().getGroup2Price()+"",
                    onemo.getBuy_price().getSmart().getGroup3Price()+"",
                    onemo.getBuy_price().getSmart().getGroup4Price()+"",
                    onemo.getBuy_price().getSmart().getGroup5Price()+"",
                    onemo.getBuy_price().getSmart().getGroup6Price()+"",
                    onemo.getBuy_price().getSmart().getGroup7Price()+"",
                    onemo.getBuy_price().getSmart().getGroup8Price()+"",
                    onemo.getBuy_price().getSmart().getGroup9Price()+"",
                    onemo.getBuy_price().getSmart().getGroup10Price()+"",
                    onemo.getBuy_price().getSmart().getGroup11Price()+"",
                    onemo.getBuy_price().getSmart().getGroup12Price()+"",
                    onemo.getBuy_price().getSmart().getGroup13Price()+"",
                    onemo.getBuy_price().getSmart().getGroup14Price()+"",
                    onemo.getBuy_price().getSmart().getGroup15Price()+"",
                    onemo.getBuy_price().getSmart().getGroupLCPrice()+""
                });
            }

            if (onemo.getQbmore()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "QBMORE",
                    onemo.getBuy_price().getQbmore().getGroup1Price()+"",
                    onemo.getBuy_price().getQbmore().getGroup2Price()+"",
                    onemo.getBuy_price().getQbmore().getGroup3Price()+"",
                    onemo.getBuy_price().getQbmore().getGroup4Price()+"",
                    onemo.getBuy_price().getQbmore().getGroup5Price()+"",
                    onemo.getBuy_price().getQbmore().getGroup6Price()+"",
                    onemo.getBuy_price().getQbmore().getGroup7Price()+"",
                    onemo.getBuy_price().getQbmore().getGroup8Price()+"",
                    onemo.getBuy_price().getQbmore().getGroup9Price()+"",
                    onemo.getBuy_price().getQbmore().getGroup10Price()+"",
                    onemo.getBuy_price().getQbmore().getGroup11Price()+"",
                    onemo.getBuy_price().getQbmore().getGroup12Price()+"",
                    onemo.getBuy_price().getQbmore().getGroup13Price()+"",
                    onemo.getBuy_price().getQbmore().getGroup14Price()+"",
                    onemo.getBuy_price().getQbmore().getGroup15Price()+"",
                    onemo.getBuy_price().getQbmore().getGroupLCPrice()+""
                });
            }

            if (onemo.getExcell()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "EXCELL",
                    onemo.getBuy_price().getExcell().getGroup1Price()+"",
                    onemo.getBuy_price().getExcell().getGroup2Price()+"",
                    onemo.getBuy_price().getExcell().getGroup3Price()+"",
                    onemo.getBuy_price().getExcell().getGroup4Price()+"",
                    onemo.getBuy_price().getExcell().getGroup5Price()+"",
                    onemo.getBuy_price().getExcell().getGroup6Price()+"",
                    onemo.getBuy_price().getExcell().getGroup7Price()+"",
                    onemo.getBuy_price().getExcell().getGroup8Price()+"",
                    onemo.getBuy_price().getExcell().getGroup9Price()+"",
                    onemo.getBuy_price().getExcell().getGroup10Price()+"",
                    onemo.getBuy_price().getExcell().getGroup11Price()+"",
                    onemo.getBuy_price().getExcell().getGroup12Price()+"",
                    onemo.getBuy_price().getExcell().getGroup13Price()+"",
                    onemo.getBuy_price().getExcell().getGroup14Price()+"",
                    onemo.getBuy_price().getExcell().getGroup15Price()+"",
                    onemo.getBuy_price().getExcell().getGroupLCPrice()+""
                });
            }

            if (onemo.getTimortelecom()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "TIMORTELECOM",
                    onemo.getBuy_price().getTimortelecom().getGroup1Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroup2Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroup3Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroup4Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroup5Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroup6Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroup7Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroup8Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroup9Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroup10Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroup11Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroup12Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroup13Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroup14Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroup15Price()+"",
                    onemo.getBuy_price().getTimortelecom().getGroupLCPrice()+""
                });
            }

            if (onemo.getMcel()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "MCEL",
                    onemo.getBuy_price().getMcel().getGroup1Price()+"",
                    onemo.getBuy_price().getMcel().getGroup2Price()+"",
                    onemo.getBuy_price().getMcel().getGroup3Price()+"",
                    onemo.getBuy_price().getMcel().getGroup4Price()+"",
                    onemo.getBuy_price().getMcel().getGroup5Price()+"",
                    onemo.getBuy_price().getMcel().getGroup6Price()+"",
                    onemo.getBuy_price().getMcel().getGroup7Price()+"",
                    onemo.getBuy_price().getMcel().getGroup8Price()+"",
                    onemo.getBuy_price().getMcel().getGroup9Price()+"",
                    onemo.getBuy_price().getMcel().getGroup10Price()+"",
                    onemo.getBuy_price().getMcel().getGroup11Price()+"",
                    onemo.getBuy_price().getMcel().getGroup12Price()+"",
                    onemo.getBuy_price().getMcel().getGroup13Price()+"",
                    onemo.getBuy_price().getMcel().getGroup14Price()+"",
                    onemo.getBuy_price().getMcel().getGroup15Price()+"",
                    onemo.getBuy_price().getMcel().getGroupLCPrice()+""
                });
            }

            if (onemo.getEtl()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "ETL",
                    onemo.getBuy_price().getEtl().getGroup1Price()+"",
                    onemo.getBuy_price().getEtl().getGroup2Price()+"",
                    onemo.getBuy_price().getEtl().getGroup3Price()+"",
                    onemo.getBuy_price().getEtl().getGroup4Price()+"",
                    onemo.getBuy_price().getEtl().getGroup5Price()+"",
                    onemo.getBuy_price().getEtl().getGroup6Price()+"",
                    onemo.getBuy_price().getEtl().getGroup7Price()+"",
                    onemo.getBuy_price().getEtl().getGroup8Price()+"",
                    onemo.getBuy_price().getEtl().getGroup9Price()+"",
                    onemo.getBuy_price().getEtl().getGroup10Price()+"",
                    onemo.getBuy_price().getEtl().getGroup11Price()+"",
                    onemo.getBuy_price().getEtl().getGroup12Price()+"",
                    onemo.getBuy_price().getEtl().getGroup13Price()+"",
                    onemo.getBuy_price().getEtl().getGroup14Price()+"",
                    onemo.getBuy_price().getEtl().getGroup15Price()+"",
                    onemo.getBuy_price().getEtl().getGroupLCPrice()+""
                });
            }

            if (onemo.getTango()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "TANGO",
                    onemo.getBuy_price().getTango().getGroup1Price()+"",
                    onemo.getBuy_price().getTango().getGroup2Price()+"",
                    onemo.getBuy_price().getTango().getGroup3Price()+"",
                    onemo.getBuy_price().getTango().getGroup4Price()+"",
                    onemo.getBuy_price().getTango().getGroup5Price()+"",
                    onemo.getBuy_price().getTango().getGroup6Price()+"",
                    onemo.getBuy_price().getTango().getGroup7Price()+"",
                    onemo.getBuy_price().getTango().getGroup8Price()+"",
                    onemo.getBuy_price().getTango().getGroup9Price()+"",
                    onemo.getBuy_price().getTango().getGroup10Price()+"",
                    onemo.getBuy_price().getTango().getGroup11Price()+"",
                    onemo.getBuy_price().getTango().getGroup12Price()+"",
                    onemo.getBuy_price().getTango().getGroup13Price()+"",
                    onemo.getBuy_price().getTango().getGroup14Price()+"",
                    onemo.getBuy_price().getTango().getGroup15Price()+"",
                    onemo.getBuy_price().getTango().getGroupLCPrice()+""
                });
            }

            if (onemo.getLaotel()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "LAOTEL",
                    onemo.getBuy_price().getLaotel().getGroup1Price()+"",
                    onemo.getBuy_price().getLaotel().getGroup2Price()+"",
                    onemo.getBuy_price().getLaotel().getGroup3Price()+"",
                    onemo.getBuy_price().getLaotel().getGroup4Price()+"",
                    onemo.getBuy_price().getLaotel().getGroup5Price()+"",
                    onemo.getBuy_price().getLaotel().getGroup6Price()+"",
                    onemo.getBuy_price().getLaotel().getGroup7Price()+"",
                    onemo.getBuy_price().getLaotel().getGroup8Price()+"",
                    onemo.getBuy_price().getLaotel().getGroup9Price()+"",
                    onemo.getBuy_price().getLaotel().getGroup10Price()+"",
                    onemo.getBuy_price().getLaotel().getGroup11Price()+"",
                    onemo.getBuy_price().getLaotel().getGroup12Price()+"",
                    onemo.getBuy_price().getLaotel().getGroup13Price()+"",
                    onemo.getBuy_price().getLaotel().getGroup14Price()+"",
                    onemo.getBuy_price().getLaotel().getGroup15Price()+"",
                    onemo.getBuy_price().getLaotel().getGroupLCPrice()+""
                });
            }

            if (onemo.getMpt()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "MPT",
                    onemo.getBuy_price().getMpt().getGroup1Price()+"",
                    onemo.getBuy_price().getMpt().getGroup2Price()+"",
                    onemo.getBuy_price().getMpt().getGroup3Price()+"",
                    onemo.getBuy_price().getMpt().getGroup4Price()+"",
                    onemo.getBuy_price().getMpt().getGroup5Price()+"",
                    onemo.getBuy_price().getMpt().getGroup6Price()+"",
                    onemo.getBuy_price().getMpt().getGroup7Price()+"",
                    onemo.getBuy_price().getMpt().getGroup8Price()+"",
                    onemo.getBuy_price().getMpt().getGroup9Price()+"",
                    onemo.getBuy_price().getMpt().getGroup10Price()+"",
                    onemo.getBuy_price().getMpt().getGroup11Price()+"",
                    onemo.getBuy_price().getMpt().getGroup12Price()+"",
                    onemo.getBuy_price().getMpt().getGroup13Price()+"",
                    onemo.getBuy_price().getMpt().getGroup14Price()+"",
                    onemo.getBuy_price().getMpt().getGroup15Price()+"",
                    onemo.getBuy_price().getMpt().getGroupLCPrice()+""
                });
            }

            if (onemo.getOoredo()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "OOREDO",
                    onemo.getBuy_price().getOoredo().getGroup1Price()+"",
                    onemo.getBuy_price().getOoredo().getGroup2Price()+"",
                    onemo.getBuy_price().getOoredo().getGroup3Price()+"",
                    onemo.getBuy_price().getOoredo().getGroup4Price()+"",
                    onemo.getBuy_price().getOoredo().getGroup5Price()+"",
                    onemo.getBuy_price().getOoredo().getGroup6Price()+"",
                    onemo.getBuy_price().getOoredo().getGroup7Price()+"",
                    onemo.getBuy_price().getOoredo().getGroup8Price()+"",
                    onemo.getBuy_price().getOoredo().getGroup9Price()+"",
                    onemo.getBuy_price().getOoredo().getGroup10Price()+"",
                    onemo.getBuy_price().getOoredo().getGroup11Price()+"",
                    onemo.getBuy_price().getOoredo().getGroup12Price()+"",
                    onemo.getBuy_price().getOoredo().getGroup13Price()+"",
                    onemo.getBuy_price().getOoredo().getGroup14Price()+"",
                    onemo.getBuy_price().getOoredo().getGroup15Price()+"",
                    onemo.getBuy_price().getOoredo().getGroupLCPrice()+""
                });
            }

            if (onemo.getTelenor()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "TELENOR",
                    onemo.getBuy_price().getTelenor().getGroup1Price()+"",
                    onemo.getBuy_price().getTelenor().getGroup2Price()+"",
                    onemo.getBuy_price().getTelenor().getGroup3Price()+"",
                    onemo.getBuy_price().getTelenor().getGroup4Price()+"",
                    onemo.getBuy_price().getTelenor().getGroup5Price()+"",
                    onemo.getBuy_price().getTelenor().getGroup6Price()+"",
                    onemo.getBuy_price().getTelenor().getGroup7Price()+"",
                    onemo.getBuy_price().getTelenor().getGroup8Price()+"",
                    onemo.getBuy_price().getTelenor().getGroup9Price()+"",
                    onemo.getBuy_price().getTelenor().getGroup10Price()+"",
                    onemo.getBuy_price().getTelenor().getGroup11Price()+"",
                    onemo.getBuy_price().getTelenor().getGroup12Price()+"",
                    onemo.getBuy_price().getTelenor().getGroup13Price()+"",
                    onemo.getBuy_price().getTelenor().getGroup14Price()+"",
                    onemo.getBuy_price().getTelenor().getGroup15Price()+"",
                    onemo.getBuy_price().getTelenor().getGroupLCPrice()+""
                });
            }

            if (onemo.getDigicel()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "DIGICEL",
                    onemo.getBuy_price().getDigicel().getGroup1Price()+"",
                    onemo.getBuy_price().getDigicel().getGroup2Price()+"",
                    onemo.getBuy_price().getDigicel().getGroup3Price()+"",
                    onemo.getBuy_price().getDigicel().getGroup4Price()+"",
                    onemo.getBuy_price().getDigicel().getGroup5Price()+"",
                    onemo.getBuy_price().getDigicel().getGroup6Price()+"",
                    onemo.getBuy_price().getDigicel().getGroup7Price()+"",
                    onemo.getBuy_price().getDigicel().getGroup8Price()+"",
                    onemo.getBuy_price().getDigicel().getGroup9Price()+"",
                    onemo.getBuy_price().getDigicel().getGroup10Price()+"",
                    onemo.getBuy_price().getDigicel().getGroup11Price()+"",
                    onemo.getBuy_price().getDigicel().getGroup12Price()+"",
                    onemo.getBuy_price().getDigicel().getGroup13Price()+"",
                    onemo.getBuy_price().getDigicel().getGroup14Price()+"",
                    onemo.getBuy_price().getDigicel().getGroup15Price()+"",
                    onemo.getBuy_price().getDigicel().getGroupLCPrice()+""
                });
            }

            if (onemo.getAfricell()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "AFRICELL",
                    onemo.getBuy_price().getAfricell().getGroup1Price()+"",
                    onemo.getBuy_price().getAfricell().getGroup2Price()+"",
                    onemo.getBuy_price().getAfricell().getGroup3Price()+"",
                    onemo.getBuy_price().getAfricell().getGroup4Price()+"",
                    onemo.getBuy_price().getAfricell().getGroup5Price()+"",
                    onemo.getBuy_price().getAfricell().getGroup6Price()+"",
                    onemo.getBuy_price().getAfricell().getGroup7Price()+"",
                    onemo.getBuy_price().getAfricell().getGroup8Price()+"",
                    onemo.getBuy_price().getAfricell().getGroup9Price()+"",
                    onemo.getBuy_price().getAfricell().getGroup10Price()+"",
                    onemo.getBuy_price().getAfricell().getGroup11Price()+"",
                    onemo.getBuy_price().getAfricell().getGroup12Price()+"",
                    onemo.getBuy_price().getAfricell().getGroup13Price()+"",
                    onemo.getBuy_price().getAfricell().getGroup14Price()+"",
                    onemo.getBuy_price().getAfricell().getGroup15Price()+"",
                    onemo.getBuy_price().getAfricell().getGroupLCPrice()+""
                });
            }

            if (onemo.getLacellsu()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "LACELLSU",
                    onemo.getBuy_price().getLacellsu().getGroup1Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroup2Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroup3Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroup4Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroup5Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroup6Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroup7Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroup8Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroup9Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroup10Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroup11Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroup12Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroup13Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroup14Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroup15Price()+"",
                    onemo.getBuy_price().getLacellsu().getGroupLCPrice()+""
                });
            }

            if (onemo.getMtn()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "MTN",
                    onemo.getBuy_price().getMtn().getGroup1Price()+"",
                    onemo.getBuy_price().getMtn().getGroup2Price()+"",
                    onemo.getBuy_price().getMtn().getGroup3Price()+"",
                    onemo.getBuy_price().getMtn().getGroup4Price()+"",
                    onemo.getBuy_price().getMtn().getGroup5Price()+"",
                    onemo.getBuy_price().getMtn().getGroup6Price()+"",
                    onemo.getBuy_price().getMtn().getGroup7Price()+"",
                    onemo.getBuy_price().getMtn().getGroup8Price()+"",
                    onemo.getBuy_price().getMtn().getGroup9Price()+"",
                    onemo.getBuy_price().getMtn().getGroup10Price()+"",
                    onemo.getBuy_price().getMtn().getGroup11Price()+"",
                    onemo.getBuy_price().getMtn().getGroup12Price()+"",
                    onemo.getBuy_price().getMtn().getGroup13Price()+"",
                    onemo.getBuy_price().getMtn().getGroup14Price()+"",
                    onemo.getBuy_price().getMtn().getGroup15Price()+"",
                    onemo.getBuy_price().getMtn().getGroupLCPrice()+""
                });
            }

            if (onemo.getOrange()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "ORANGE",
                    onemo.getBuy_price().getOrange().getGroup1Price()+"",
                    onemo.getBuy_price().getOrange().getGroup2Price()+"",
                    onemo.getBuy_price().getOrange().getGroup3Price()+"",
                    onemo.getBuy_price().getOrange().getGroup4Price()+"",
                    onemo.getBuy_price().getOrange().getGroup5Price()+"",
                    onemo.getBuy_price().getOrange().getGroup6Price()+"",
                    onemo.getBuy_price().getOrange().getGroup7Price()+"",
                    onemo.getBuy_price().getOrange().getGroup8Price()+"",
                    onemo.getBuy_price().getOrange().getGroup9Price()+"",
                    onemo.getBuy_price().getOrange().getGroup10Price()+"",
                    onemo.getBuy_price().getOrange().getGroup11Price()+"",
                    onemo.getBuy_price().getOrange().getGroup12Price()+"",
                    onemo.getBuy_price().getOrange().getGroup13Price()+"",
                    onemo.getBuy_price().getOrange().getGroup14Price()+"",
                    onemo.getBuy_price().getOrange().getGroup15Price()+"",
                    onemo.getBuy_price().getOrange().getGroupLCPrice()+""
                });
            }

            if (onemo.getVodacom()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "VODACOM",
                    onemo.getBuy_price().getVodacom().getGroup1Price()+"",
                    onemo.getBuy_price().getVodacom().getGroup2Price()+"",
                    onemo.getBuy_price().getVodacom().getGroup3Price()+"",
                    onemo.getBuy_price().getVodacom().getGroup4Price()+"",
                    onemo.getBuy_price().getVodacom().getGroup5Price()+"",
                    onemo.getBuy_price().getVodacom().getGroup6Price()+"",
                    onemo.getBuy_price().getVodacom().getGroup7Price()+"",
                    onemo.getBuy_price().getVodacom().getGroup8Price()+"",
                    onemo.getBuy_price().getVodacom().getGroup9Price()+"",
                    onemo.getBuy_price().getVodacom().getGroup10Price()+"",
                    onemo.getBuy_price().getVodacom().getGroup11Price()+"",
                    onemo.getBuy_price().getVodacom().getGroup12Price()+"",
                    onemo.getBuy_price().getVodacom().getGroup13Price()+"",
                    onemo.getBuy_price().getVodacom().getGroup14Price()+"",
                    onemo.getBuy_price().getVodacom().getGroup15Price()+"",
                    onemo.getBuy_price().getVodacom().getGroupLCPrice()+""
                });
            }

            if (onemo.getZantel()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "ZANTEL",
                    onemo.getBuy_price().getZantel().getGroup1Price()+"",
                    onemo.getBuy_price().getZantel().getGroup2Price()+"",
                    onemo.getBuy_price().getZantel().getGroup3Price()+"",
                    onemo.getBuy_price().getZantel().getGroup4Price()+"",
                    onemo.getBuy_price().getZantel().getGroup5Price()+"",
                    onemo.getBuy_price().getZantel().getGroup6Price()+"",
                    onemo.getBuy_price().getZantel().getGroup7Price()+"",
                    onemo.getBuy_price().getZantel().getGroup8Price()+"",
                    onemo.getBuy_price().getZantel().getGroup9Price()+"",
                    onemo.getBuy_price().getZantel().getGroup10Price()+"",
                    onemo.getBuy_price().getZantel().getGroup11Price()+"",
                    onemo.getBuy_price().getZantel().getGroup12Price()+"",
                    onemo.getBuy_price().getZantel().getGroup13Price()+"",
                    onemo.getBuy_price().getZantel().getGroup14Price()+"",
                    onemo.getBuy_price().getZantel().getGroup15Price()+"",
                    onemo.getBuy_price().getZantel().getGroupLCPrice()+""
                });
            }

            if (onemo.getClaro()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "CLARO",
                    onemo.getBuy_price().getClaro().getGroup1Price()+"",
                    onemo.getBuy_price().getClaro().getGroup2Price()+"",
                    onemo.getBuy_price().getClaro().getGroup3Price()+"",
                    onemo.getBuy_price().getClaro().getGroup4Price()+"",
                    onemo.getBuy_price().getClaro().getGroup5Price()+"",
                    onemo.getBuy_price().getClaro().getGroup6Price()+"",
                    onemo.getBuy_price().getClaro().getGroup7Price()+"",
                    onemo.getBuy_price().getClaro().getGroup8Price()+"",
                    onemo.getBuy_price().getClaro().getGroup9Price()+"",
                    onemo.getBuy_price().getClaro().getGroup10Price()+"",
                    onemo.getBuy_price().getClaro().getGroup11Price()+"",
                    onemo.getBuy_price().getClaro().getGroup12Price()+"",
                    onemo.getBuy_price().getClaro().getGroup13Price()+"",
                    onemo.getBuy_price().getClaro().getGroup14Price()+"",
                    onemo.getBuy_price().getClaro().getGroup15Price()+"",
                    onemo.getBuy_price().getClaro().getGroupLCPrice()+""
                });
            }

            if (onemo.getTelefonica()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "TELEFONICA",
                    onemo.getBuy_price().getTelefonica().getGroup1Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroup2Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroup3Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroup4Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroup5Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroup6Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroup7Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroup8Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroup9Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroup10Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroup11Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroup12Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroup13Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroup14Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroup15Price()+"",
                    onemo.getBuy_price().getTelefonica().getGroupLCPrice()+""
                });
            }

            if (onemo.getComcel()== 1) {
                data.add(new Object[]{
                    onemo.getCode(),
                    onemo.getName(),
                    onemo.getPos()+"",
                    onemo.getClassSend(),
                    "COMCEL",
                    onemo.getBuy_price().getComcel().getGroup1Price()+"",
                    onemo.getBuy_price().getComcel().getGroup2Price()+"",
                    onemo.getBuy_price().getComcel().getGroup3Price()+"",
                    onemo.getBuy_price().getComcel().getGroup4Price()+"",
                    onemo.getBuy_price().getComcel().getGroup5Price()+"",
                    onemo.getBuy_price().getComcel().getGroup6Price()+"",
                    onemo.getBuy_price().getComcel().getGroup7Price()+"",
                    onemo.getBuy_price().getComcel().getGroup8Price()+"",
                    onemo.getBuy_price().getComcel().getGroup9Price()+"",
                    onemo.getBuy_price().getComcel().getGroup10Price()+"",
                    onemo.getBuy_price().getComcel().getGroup11Price()+"",
                    onemo.getBuy_price().getComcel().getGroup12Price()+"",
                    onemo.getBuy_price().getComcel().getGroup13Price()+"",
                    onemo.getBuy_price().getComcel().getGroup14Price()+"",
                    onemo.getBuy_price().getComcel().getGroup15Price()+"",
                    onemo.getBuy_price().getComcel().getGroupLCPrice()+""
                });
            }
            
        }

        data.add(new Object[]{
            "",
            "",
            "",
            "",
            ""
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
            response.setHeader("Content-Disposition", "attachment; filename=LogProvider-" + DateProc.createDDMMYYYY() + ".xls");
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