<%@page import="gk.myname.vn.entity.CalculatedByRequest"%>
<%@page import="gk.myname.vn.entity.UserAction"%>
<%@page import="gk.myname.vn.entity.OptionCheckDuplicate"%><%@page import="gk.myname.vn.entity.OptionVina"%><%@page import="gk.myname.vn.entity.OptionTelco"%><%@page import="gk.myname.vn.utils.SMSUtils"%><%@page import="gk.myname.vn.entity.OperProperties"%><%@page import="gk.myname.vn.entity.RouteTable"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.BrandLabel.TYPE"%><%@page import="java.util.Enumeration"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/resource/css/jquery-ui-1.8.16.custom.css">
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.core.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.position.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.widget.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.autocomplete.min.js"></script>
        <script type ='text/javascript'>
                    $(document).ready(function () {
            $("#_cpuser").select2({
            formatResult: function (item) {
            var valOpt = $(item.element).attr('img-data');
                    if (!valOpt) {
            return ('<div><b>' + item.text + '</b></div>');
            } else {
            return ('<div><span><b style="color: red">' + item.text + '<b> <img src="' + valOpt + '" class="img-flag" /></span></div>');
            }
            },
                    formatSelection: function (item) {
                    //  load page or selected
                    var opt = $("#_cpuser option:selected");
                            var valOpt = opt.attr("img-data");
                            if (!valOpt) {
                    return ('<b>' + item.text + '</b>');
                    } else {
                    return ('<div><span><b style="color: red">' + item.text + '</b> <img src="' + valOpt + '" class="img-flag" /></span></div>');
                    }
                    },
                    dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
                    escapeMarkup: function (m) {
                    return m;
                    }
            });
            });</script>
    </head>

    <body>
        <%  //--          
            if (!userlogin.checkAdd(request)) {
                //CongNX: Ghi log action vao db
                UserAction log = new UserAction(userlogin.getUserName(),
                        UserAction.TABLE.brand_label.val,
                        UserAction.TYPE.ADD.val,
                        UserAction.RESULT.REJECT.val,
                        "Permit deny!");
                log.logAction(request);
                //CongNX: ket thuc ghi log db voi action thao tac tu web
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin/brand/index.jsp");
                return;
            }
            BrandLabel oneBrand = null;
            int owner_id = Tool.string2Integer(request.getParameter("owner_id"), 0);
            Tool.debug("owner_id:" + owner_id);
            if (request.getParameter("submit") != null) {
                //---------------------------
                String vnp_lbid = Tool.validStringRequest(request.getParameter("vnp_lbid"));
                String vnp_tmpid = Tool.validStringRequest(request.getParameter("vnp_tmpid"));
                String vnp_lbusername = Tool.validStringRequest(request.getParameter("vnp_lbusername"));
//                Việt Nam
                int checkDuplicateVte = Tool.string2Integer(request.getParameter("checkDuplicateVte"));
                int checkDuplicateVms = Tool.string2Integer(request.getParameter("checkDuplicateVms"));
                int checkDuplicateGpc = Tool.string2Integer(request.getParameter("checkDuplicateGpc"));
                int checkDuplicateVnm = Tool.string2Integer(request.getParameter("checkDuplicateVnm"));
                int checkDuplicateBl = Tool.string2Integer(request.getParameter("checkDuplicateBl"));
                int checkDuplicateDdg = Tool.string2Integer(request.getParameter("checkDuplicateDdg"));
//                CalculatedByRequest

                int checkRequest_viettel = RequestTool.getInt(request, "checkRequest_viettel");
                int checkRequest_mobifone = RequestTool.getInt(request, "checkRequest_mobifone");
                int checkRequest_vinafone = RequestTool.getInt(request, "checkRequest_vinafone");
                int checkRequest_vietnammobi = RequestTool.getInt(request, "checkRequest_vietnammobi");
                int checkRequest_BEELINE = RequestTool.getInt(request, "checkRequest_BEELINE");
                int checkRequest_ITELECOM = RequestTool.getInt(request, "checkRequest_ITELECOM");
//                Campuchia
                int checkDuplicateCellcard = Tool.string2Integer(request.getParameter("checkDuplicateCellcard"));
                int checkDuplicateMetfone = Tool.string2Integer(request.getParameter("checkDuplicateMetfone"));
                int checkDuplicateBeelineCampuchia = Tool.string2Integer(request.getParameter("checkDuplicateBeelineCampuchia"));
                int checkDuplicateSmart = Tool.string2Integer(request.getParameter("checkDuplicateSmart"));
                int checkDuplicateQbmore = Tool.string2Integer(request.getParameter("checkDuplicateQbmore"));
                int checkDuplicateExcell = Tool.string2Integer(request.getParameter("checkDuplicateExcell"));
//                 CalculatedByRequest
                int checkRequest_CELLCARD = RequestTool.getInt(request, "checkRequest_CELLCARD");
                int checkRequest_METFONE = RequestTool.getInt(request, "checkRequest_METFONE");
                int checkRequest_BeelineCampuchia = RequestTool.getInt(request, "checkRequest_BeelineCampuchia");
                int checkRequest_Smart = RequestTool.getInt(request, "checkRequest_Smart");
                int checkRequest_Qbmore = RequestTool.getInt(request, "checkRequest_Qbmore");
                int checkRequest_Excell = RequestTool.getInt(request, "checkRequest_Excell");
//                Đông Timor
                int checkDuplicateTelemor = Tool.string2Integer(request.getParameter("checkDuplicateTelemor"));
                int checkDuplicateTimortelecom = Tool.string2Integer(request.getParameter("checkDuplicateTimortelecom"));
//                CalculatedByRequest
                int checkRequest_Telemor = RequestTool.getInt(request, "checkRequest_Telemor");
                int checkRequest_TimorTelecom = RequestTool.getInt(request, "checkRequest_TimorTelecom");
//                    Mozambique
                int checkDuplicateMovitel = Tool.string2Integer(request.getParameter("checkDuplicateMovitel"));
                int checkDuplicateMcel = Tool.string2Integer(request.getParameter("checkDuplicateMcel"));
//                  CalculatedByRequest
                int checkRequest_Movitel = RequestTool.getInt(request, "checkRequest_Movitel");
                int checkRequest_Mcel = RequestTool.getInt(request, "checkRequest_Mcel");
//                Lào
                int checkDuplicateUnitel = Tool.string2Integer(request.getParameter("checkDuplicateUnitel"));
                int checkDuplicateEtl = Tool.string2Integer(request.getParameter("checkDuplicateEtl"));
                int checkDuplicateTango = Tool.string2Integer(request.getParameter("checkDuplicateTango"));
                int checkDuplicateLaotel = Tool.string2Integer(request.getParameter("checkDuplicateLaotel"));
//                CalculatedByRequest
                int checkRequest_Unitel = RequestTool.getInt(request, "checkRequest_Unitel");
                int checkRequest_Etl = RequestTool.getInt(request, "checkRequest_Etl");
                int checkRequest_Tango = RequestTool.getInt(request, "checkRequest_Tango");
                int checkRequest_Laotel = RequestTool.getInt(request, "checkRequest_Laotel");
//                Myanmar
                int checkDuplicateMytel = Tool.string2Integer(request.getParameter("checkDuplicateMytel"));
                int checkDuplicateMpt = Tool.string2Integer(request.getParameter("checkDuplicateMpt"));
                int checkDuplicateOoredo = Tool.string2Integer(request.getParameter("checkDuplicateOoredo"));
                int checkDuplicateTelenor = Tool.string2Integer(request.getParameter("checkDuplicateTelenor"));
//                 CalculatedByRequest
                int checkRequest_Mytel = RequestTool.getInt(request, "checkRequest_Mytel");
                int checkRequest_Mpt = RequestTool.getInt(request, "checkRequest_Mpt");
                int checkRequest_Ooredo = RequestTool.getInt(request, "checkRequest_Ooredo");
                int checkRequest_Telenor = RequestTool.getInt(request, "checkRequest_Telenor");
//                Haiti
                int checkDuplicateNatcom = Tool.string2Integer(request.getParameter("checkDuplicateNatcom"));
                int checkDuplicateDicicel = Tool.string2Integer(request.getParameter("checkDuplicateDicicel"));
                int checkDuplicateComcel = Tool.string2Integer(request.getParameter("checkDuplicateComcel"));
//                CalculatedByRequest
                int checkRequest_Natcom = RequestTool.getInt(request, "checkRequest_Natcom");
                int checkRequest_Digicel = RequestTool.getInt(request, "checkRequest_Digicel");
                int checkRequest_Comcel = RequestTool.getInt(request, "checkRequest_Comcel");
//                Burundi
                int checkDuplicateLumitel = Tool.string2Integer(request.getParameter("checkDuplicateLumitel"));
                int checkDuplicateAfricell = Tool.string2Integer(request.getParameter("checkDuplicateAfricell"));
                int checkDuplicateLacellsu = Tool.string2Integer(request.getParameter("checkDuplicateLacellsu"));
//                 CalculatedByRequest
                int checkRequest_Lumitel = RequestTool.getInt(request,"checkRequest_Lumitel");
                int checkRequest_Africell = RequestTool.getInt(request,"checkRequest_Africell");
                int checkRequest_Lacellsu =  RequestTool.getInt(request,"checkRequest_Lacellsu");
//                
                
//                Cameron
                int checkDuplicateNexttel = Tool.string2Integer(request.getParameter("checkDuplicateNexttel"));
                int checkDuplicateMtn = Tool.string2Integer(request.getParameter("checkDuplicateMtn"));
                int checkDuplicateOrange = Tool.string2Integer(request.getParameter("checkDuplicateOrange"));
//                 CalculatedByRequest
                int checkRequest_Nexttel =  RequestTool.getInt(request,"checkRequest_Nexttel");
                int checkRequest_Mtn =RequestTool.getInt(request,"checkRequest_Mtn");
                int checkRequest_Orange = RequestTool.getInt(request,"checkRequest_Orange");
               
//                Tanzania
                int checkDuplicateHalotel = Tool.string2Integer(request.getParameter("checkDuplicateHalotel"));
                int checkDuplicateVodacom = Tool.string2Integer(request.getParameter("checkDuplicateVodacom"));
                int checkDuplicateZantel = Tool.string2Integer(request.getParameter("checkDuplicateZantel"));
//                  CalculatedByRequest
                int checkRequest_Halotel = RequestTool.getInt(request, "checkRequest_Halotel");
                int checkRequest_Vodacom =RequestTool.getInt(request,"checkRequest_Vodacom");
                int checkRequest_Zantel = RequestTool.getInt(request,"checkRequest_Zantel");
//                Peru
                int checkDuplicateBitel = Tool.string2Integer(request.getParameter("checkDuplicateBitel"));
                int checkDuplicateClaro = Tool.string2Integer(request.getParameter("checkDuplicateClaro"));
                int checkDuplicateTelefonica = Tool.string2Integer(request.getParameter("checkDuplicateTelefonica"));
//                  CalculatedByRequest
                int checkRequest_Bitel = RequestTool.getInt(request,"checkRequest_Bitel");
                int checkRequest_Claro =  RequestTool.getInt(request,"checkRequest_Claro");
                int checkRequest_Telefonica = RequestTool.getInt(request,"checkRequest_Telefonica");

                String brandName = Tool.validStringRequest(request.getParameter("brandName"));
                System.out.println("brandName:" + brandName);
                String template = Tool.validStringRequest(request.getParameter("template"));
                int price = Tool.string2Integer(request.getParameter("price"));
                int priority = Tool.string2Integer(request.getParameter("priority"));
                int status = Tool.string2Integer(request.getParameter("status"));
                int checktemp = Tool.string2Integer(request.getParameter("checktemp"));

                Account accOwner = Account.getAccount(owner_id);
                if (owner_id <= 0 || accOwner == null) {
                    //CongNX: Ghi log action vao db
                    UserAction log = new UserAction(userlogin.getUserName(),
                            UserAction.TABLE.brand_label.val,
                            UserAction.TYPE.ADD.val,
                            UserAction.RESULT.REJECT.val,
                            "Brandname " + brandName + " not in this account(" + accOwner.getUserName() + ")!");
                    log.logAction(request);
                    //CongNX: ket thuc ghi log db voi action thao tac tu web
                    session.setAttribute("mess", "Bạn chưa cấp BRAND cho tài khoản nào hoặc tài khoản ko hợp lệ!");
                } else {
                    // Danh Rieng Vina Phone
                    OptionTelco option = new OptionTelco();
                    OptionVina vina_opt = option.getVinaphone();
                    vina_opt.setLabelId(vnp_lbid);
                    vina_opt.setTmpId(vnp_tmpid);
                    vina_opt.setLabelUser(vnp_lbusername);
                    // Check trung tin cho tung nha mang
                    OptionCheckDuplicate checkDuplicateTelco = option.getCheckDuplicate();

                    checkDuplicateTelco.setVte(checkDuplicateVte);
                    checkDuplicateTelco.setMobi(checkDuplicateVms);
                    checkDuplicateTelco.setVina(checkDuplicateGpc);
                    checkDuplicateTelco.setVnm(checkDuplicateVnm);
                    checkDuplicateTelco.setBl(checkDuplicateBl);
                    checkDuplicateTelco.setDdg(checkDuplicateDdg);

                    checkDuplicateTelco.setCellcard(checkDuplicateCellcard);
                    checkDuplicateTelco.setMetfone(checkDuplicateMetfone);
                    checkDuplicateTelco.setBeelineCampuchia(checkDuplicateBeelineCampuchia);
                    checkDuplicateTelco.setSmart(checkDuplicateSmart);
                    checkDuplicateTelco.setQbmore(checkDuplicateQbmore);
                    checkDuplicateTelco.setExcell(checkDuplicateExcell);

                    checkDuplicateTelco.setTelemor(checkDuplicateTelemor);
                    checkDuplicateTelco.setTimortelecom(checkDuplicateTimortelecom);

                    checkDuplicateTelco.setMovitel(checkDuplicateMovitel);
                    checkDuplicateTelco.setMcel(checkDuplicateMcel);

                    checkDuplicateTelco.setUnitel(checkDuplicateUnitel);
                    checkDuplicateTelco.setEtl(checkDuplicateEtl);
                    checkDuplicateTelco.setTango(checkDuplicateTango);
                    checkDuplicateTelco.setLaotel(checkDuplicateLaotel);

                    checkDuplicateTelco.setMytel(checkDuplicateMytel);
                    checkDuplicateTelco.setMpt(checkDuplicateMpt);
                    checkDuplicateTelco.setOoredo(checkDuplicateOoredo);
                    checkDuplicateTelco.setTelemor(checkDuplicateTelemor);

                    checkDuplicateTelco.setNatcom(checkDuplicateNatcom);
                    checkDuplicateTelco.setDigicel(checkDuplicateDicicel);
                    checkDuplicateTelco.setComcel(checkDuplicateComcel);

                    checkDuplicateTelco.setLumitel(checkDuplicateLumitel);
                    checkDuplicateTelco.setAfricell(checkDuplicateAfricell);
                    checkDuplicateTelco.setLacellsu(checkDuplicateLacellsu);

                    checkDuplicateTelco.setNexttel(checkDuplicateNexttel);
                    checkDuplicateTelco.setMtn(checkDuplicateMtn);
                    checkDuplicateTelco.setOrange(checkDuplicateOrange);

                    checkDuplicateTelco.setHalotel(checkDuplicateHalotel);
                    checkDuplicateTelco.setVodacom(checkDuplicateVodacom);
                    checkDuplicateTelco.setZantel(checkDuplicateZantel);

                    checkDuplicateTelco.setBitel(checkDuplicateBitel);
                    checkDuplicateTelco.setClaro(checkDuplicateClaro);
                    checkDuplicateTelco.setTelefonical(checkDuplicateTelefonica);

                    //--- Route Table
                    RouteTable route = new RouteTable();

                    // VIETTEL
                    String qcvte = RequestTool.getString(request, "qcvte");
                    String cskhvte = RequestTool.getString(request, "cskhvte");
                    String groupVte = RequestTool.getString(request, "groupVte");
                    String vt_stt = RequestTool.getString(request, "vt_stt");
                    OperProperties vte = route.getVte();
                    vte.setOperCode(SMSUtils.OPER.VIETTEL.val);
                    vte.setRoute_CSKH(cskhvte);
                    vte.setRoute_QC(qcvte);
                    vte.setGroup(groupVte);
                    vte.setStt(vt_stt);

                    //--MOBI
                    String qcmobi = RequestTool.getString(request, "qcmobi");
                    String cskhmobi = RequestTool.getString(request, "cskhmobi");
                    String groupVms = RequestTool.getString(request, "groupVms");
                    String mbf_stt = RequestTool.getString(request, "mbf_stt");
                    OperProperties mobi = route.getMobi();
                    mobi.setOperCode(SMSUtils.OPER.MOBI.val);
                    mobi.setRoute_QC(qcmobi);
                    mobi.setRoute_CSKH(cskhmobi);
                    mobi.setGroup(groupVms);
                    mobi.setStt(mbf_stt);

                    //-- VINA
                    String qcvina = RequestTool.getString(request, "qcvina");
                    String cskhvina = RequestTool.getString(request, "cskhvina");
                    String groupGpc = RequestTool.getString(request, "groupGpc");
                    String vnp_stt = RequestTool.getString(request, "vnp_stt");
                    OperProperties vina = route.getVina();
                    vina.setOperCode(SMSUtils.OPER.VINA.val);
                    vina.setRoute_QC(qcvina);
                    vina.setRoute_CSKH(cskhvina);
                    vina.setGroup(groupGpc);
                    vina.setStt(vnp_stt);

                    //-- VNM
                    String qcvnm = RequestTool.getString(request, "qcvnm");
                    String cskhvnm = RequestTool.getString(request, "cskhvnm");
                    String groupVnm = RequestTool.getString(request, "groupVnm");
                    String vnm_stt = RequestTool.getString(request, "vnm_stt");
                    OperProperties vnm = route.getVnm();
                    vnm.setOperCode(SMSUtils.OPER.VNM.val);
                    vnm.setRoute_QC(qcvnm);
                    vnm.setRoute_CSKH(cskhvnm);
                    vnm.setGroup(groupVnm);
                    vnm.setStt(vnm_stt);

                    //-- BEELINE
                    String qcbl = RequestTool.getString(request, "qcbl");
                    String cskhbl = RequestTool.getString(request, "cskhbl");
                    String groupBl = RequestTool.getString(request, "groupBl");
                    String bl_stt = RequestTool.getString(request, "bl_stt");
                    OperProperties bl = route.getBl();
                    bl.setOperCode(SMSUtils.OPER.BEELINE.val);
                    bl.setRoute_QC(qcbl);
                    bl.setRoute_CSKH(cskhbl);
                    bl.setGroup(groupBl);
                    bl.setStt(bl_stt);

                    //-- DONGDUONG
                    String qcddg = RequestTool.getString(request, "qcddg");
                    String cskhddg = RequestTool.getString(request, "cskhddg");
                    String groupDdg = RequestTool.getString(request, "groupDdg");
                    String itelecom_stt = RequestTool.getString(request, "itelecom_stt");
                    OperProperties ddg = route.getDdg();
                    ddg.setOperCode(SMSUtils.OPER.DONGDUONG.val);
                    ddg.setRoute_QC(qcddg);
                    ddg.setRoute_CSKH(cskhddg);
                    ddg.setGroup(groupDdg);
                    ddg.setStt(itelecom_stt);

                    //-- CAMPUCHIA
                    //-- CELLCARD
                    String qcCellcard = RequestTool.getString(request, "qcCellcard");
                    String cskhCellcard = RequestTool.getString(request, "cskhCellcard");
                    String groupCellcard = RequestTool.getString(request, "groupCellcard");
                    String sttCellcard = RequestTool.getString(request, "sttCellcard");
                    OperProperties cellcard = route.getCellcard();
                    cellcard.setOperCode(SMSUtils.OPER.CELLCARD.val);
                    cellcard.setRoute_QC(qcCellcard);
                    cellcard.setRoute_CSKH(cskhCellcard);
                    cellcard.setGroup(groupCellcard);
                    cellcard.setStt(sttCellcard);

                    //-- METFONE
                    String qcMetfone = RequestTool.getString(request, "qcMetfone");
                    String cskhMetfone = RequestTool.getString(request, "cskhMetfone");
                    String groupMetfone = RequestTool.getString(request, "groupMetfone");
                    String sttMetfone = RequestTool.getString(request, "sttMetfone");
                    OperProperties metfone = route.getMetfone();
                    metfone.setOperCode(SMSUtils.OPER.METFONE.val);
                    metfone.setRoute_QC(qcMetfone);
                    metfone.setRoute_CSKH(cskhMetfone);
                    metfone.setGroup(groupMetfone);
                    metfone.setStt(sttMetfone);

                    //-- BEELINE CAMPUCHIA
                    String qcBeelineCampuchia = RequestTool.getString(request, "qcBeelineCampuchia");
                    String cskhBeelineCampuchia = RequestTool.getString(request, "cskhBeelineCampuchia");
                    String groupBeelineCampuchia = RequestTool.getString(request, "groupBeelineCampuchia");
                    String sttBeelineCampuchia = RequestTool.getString(request, "sttBeelineCampuchia");
                    OperProperties beelineCampuchia = route.getBeelineCampuchia();
                    beelineCampuchia.setOperCode(SMSUtils.OPER.BEELINECAMPUCHIA.val);
                    beelineCampuchia.setRoute_QC(qcBeelineCampuchia);
                    beelineCampuchia.setRoute_CSKH(cskhBeelineCampuchia);
                    beelineCampuchia.setGroup(groupBeelineCampuchia);
                    beelineCampuchia.setStt(sttBeelineCampuchia);

                    //-- SMART
                    String qcSmart = RequestTool.getString(request, "qcSmart");
                    String cskhSmart = RequestTool.getString(request, "cskhSmart");
                    String groupSmart = RequestTool.getString(request, "groupSmart");
                    String sttSmart = RequestTool.getString(request, "sttSmart");
                    OperProperties smart = route.getSmart();
                    smart.setOperCode(SMSUtils.OPER.SMART.val);
                    smart.setRoute_QC(qcSmart);
                    smart.setRoute_CSKH(cskhSmart);
                    smart.setGroup(groupSmart);
                    smart.setStt(sttSmart);

                    //-- QBMORE
                    String qcQbmore = RequestTool.getString(request, "qcQbmore");
                    String cskhQbmore = RequestTool.getString(request, "cskhQbmore");
                    String groupQbmore = RequestTool.getString(request, "groupQbmore");
                    String sttQbmore = RequestTool.getString(request, "sttQbmore");
                    OperProperties qbmore = route.getQbmore();
                    qbmore.setOperCode(SMSUtils.OPER.QBMORE.val);
                    qbmore.setRoute_QC(qcQbmore);
                    qbmore.setRoute_CSKH(cskhQbmore);
                    qbmore.setGroup(groupQbmore);
                    qbmore.setStt(sttQbmore);

                    //-- EXCELL
                    String qcExcell = RequestTool.getString(request, "qcExcell");
                    String cskhExcell = RequestTool.getString(request, "cskhExcell");
                    String groupExcell = RequestTool.getString(request, "groupExcell");
                    String sttExcell = RequestTool.getString(request, "sttExcell");
                    OperProperties excell = route.getExcell();
                    excell.setOperCode(SMSUtils.OPER.EXCELL.val);
                    excell.setRoute_QC(qcExcell);
                    excell.setRoute_CSKH(cskhExcell);
                    excell.setGroup(groupExcell);
                    excell.setStt(sttExcell);

                    //--Đông Timor
                    //-- Telemor
                    String qcTelemor = RequestTool.getString(request, "qcTelemor");
                    String cskhTelemor = RequestTool.getString(request, "cskhTelemor");
                    String groupTelemor = RequestTool.getString(request, "groupTelemor");
                    String sttTelemor = RequestTool.getString(request, "sttTelemor");
                    OperProperties telemor = route.getTelemor();
                    telemor.setOperCode(SMSUtils.OPER.TELEMOR.val);
                    telemor.setRoute_QC(qcTelemor);
                    telemor.setRoute_CSKH(cskhTelemor);
                    telemor.setGroup(groupTelemor);
                    telemor.setStt(sttTelemor);

                    //-- Timortelecom
                    String qcTimortelecom = RequestTool.getString(request, "qcTimortelecom");
                    String cskhTimortelecom = RequestTool.getString(request, "cskhTimortelecom");
                    String groupTimortelecom = RequestTool.getString(request, "groupTimortelecom");
                    String sttTimortelecom = RequestTool.getString(request, "sttTimortelecom");
                    OperProperties timortelecom = route.getTimortelecom();
                    timortelecom.setOperCode(SMSUtils.OPER.TIMORTELECOM.val);
                    timortelecom.setRoute_QC(qcTimortelecom);
                    timortelecom.setRoute_CSKH(cskhTimortelecom);
                    timortelecom.setGroup(groupTimortelecom);
                    timortelecom.setStt(sttTimortelecom);

                    //-- Mozambique
                    //-- Movitel
                    String qcMovitel = RequestTool.getString(request, "qcMovitel");
                    String cskhMovitel = RequestTool.getString(request, "cskhMovitel");
                    String groupMovitel = RequestTool.getString(request, "groupMovitel");
                    String sttMovitel = RequestTool.getString(request, "sttMovitel");
                    OperProperties movitel = route.getMovitel();
                    movitel.setOperCode(SMSUtils.OPER.MOVITEL.val);
                    movitel.setRoute_QC(qcMovitel);
                    movitel.setRoute_CSKH(cskhMovitel);
                    movitel.setGroup(groupMovitel);
                    movitel.setStt(sttMovitel);

                    //-- Mcel
                    String qcMcel = RequestTool.getString(request, "qcMcel");
                    String cskhMcel = RequestTool.getString(request, "cskhMcel");
                    String groupMcel = RequestTool.getString(request, "groupMcel");
                    String sttMcel = RequestTool.getString(request, "sttMcel");
                    OperProperties mcel = route.getMcel();
                    mcel.setOperCode(SMSUtils.OPER.MCEL.val);
                    mcel.setRoute_QC(qcMcel);
                    mcel.setRoute_CSKH(cskhMcel);
                    mcel.setGroup(groupMcel);
                    mcel.setStt(sttMcel);

                    //-- Lao
                    //-- Unitel
                    String qcUnitel = RequestTool.getString(request, "qcUnitel");
                    String cskhUnitel = RequestTool.getString(request, "cskhUnitel");
                    String groupUnitel = RequestTool.getString(request, "groupUnitel");
                    String sttUnitel = RequestTool.getString(request, "sttUnitel");
                    OperProperties unitel = route.getUnitel();
                    unitel.setOperCode(SMSUtils.OPER.UNITEL.val);
                    unitel.setRoute_QC(qcUnitel);
                    unitel.setRoute_CSKH(cskhUnitel);
                    unitel.setGroup(groupUnitel);
                    unitel.setStt(sttUnitel);

                    //-- ETL
                    String qcEtl = RequestTool.getString(request, "qcEtl");
                    String cskhEtl = RequestTool.getString(request, "cskhEtl");
                    String groupEtl = RequestTool.getString(request, "groupEtl");
                    String sttEtl = RequestTool.getString(request, "sttEtl");
                    OperProperties etl = route.getEtl();
                    etl.setOperCode(SMSUtils.OPER.ETL.val);
                    etl.setRoute_QC(qcEtl);
                    etl.setRoute_CSKH(cskhEtl);
                    etl.setGroup(groupEtl);
                    etl.setStt(sttEtl);

                    //-- Tango
                    String qcTango = RequestTool.getString(request, "qcTango");
                    String cskhTango = RequestTool.getString(request, "cskhTango");
                    String groupTango = RequestTool.getString(request, "groupTango");
                    String sttTango = RequestTool.getString(request, "sttTango");
                    OperProperties tango = route.getTango();
                    tango.setOperCode(SMSUtils.OPER.TANGO.val);
                    tango.setRoute_QC(qcTango);
                    tango.setRoute_CSKH(cskhTango);
                    tango.setGroup(groupTango);
                    tango.setStt(sttTango);

                    //-- Laotel
                    String qcLaotel = RequestTool.getString(request, "qcLaotel");
                    String cskhLaotel = RequestTool.getString(request, "cskhLaotel");
                    String groupLaotel = RequestTool.getString(request, "groupLaotel");
                    String sttLaotel = RequestTool.getString(request, "sttLaotel");
                    OperProperties laotel = route.getLaotel();
                    laotel.setOperCode(SMSUtils.OPER.LAOTEL.val);
                    laotel.setRoute_QC(qcLaotel);
                    laotel.setRoute_CSKH(cskhLaotel);
                    laotel.setGroup(groupLaotel);
                    laotel.setStt(sttLaotel);

                    //--Myanmar
                    //-- Mytel
                    String qcMytel = RequestTool.getString(request, "qcMytel");
                    String cskhMytel = RequestTool.getString(request, "cskhMytel");
                    String groupMytel = RequestTool.getString(request, "groupMytel");
                    String sttMytel = RequestTool.getString(request, "sttMytel");
                    OperProperties mytel = route.getMytel();
                    mytel.setOperCode(SMSUtils.OPER.MYTEL.val);
                    mytel.setRoute_QC(qcMytel);
                    mytel.setRoute_CSKH(cskhMytel);
                    mytel.setGroup(groupMytel);
                    mytel.setStt(sttMytel);

                    //-- Mpt
                    String qcMpt = RequestTool.getString(request, "qcMpt");
                    String cskhMpt = RequestTool.getString(request, "cskhMpt");
                    String groupMpt = RequestTool.getString(request, "groupMpt");
                    String sttMpt = RequestTool.getString(request, "sttMpt");
                    OperProperties mpt = route.getMpt();
                    mpt.setOperCode(SMSUtils.OPER.MPT.val);
                    mpt.setRoute_QC(qcMpt);
                    mpt.setRoute_CSKH(cskhMpt);
                    mpt.setGroup(groupMpt);
                    mpt.setStt(sttMpt);

                    //-- Ooredo
                    String qcOoredo = RequestTool.getString(request, "qcOoredo");
                    String cskhOoredo = RequestTool.getString(request, "cskhOoredo");
                    String groupOoredo = RequestTool.getString(request, "groupOoredo");
                    String sttOoredo = RequestTool.getString(request, "sttOoredo");
                    OperProperties ooredo = route.getOoredo();
                    ooredo.setOperCode(SMSUtils.OPER.OOREDO.val);
                    ooredo.setRoute_QC(qcOoredo);
                    ooredo.setRoute_CSKH(cskhOoredo);
                    ooredo.setGroup(groupOoredo);
                    ooredo.setStt(sttOoredo);

                    //-- Telenor
                    String qcTelenor = RequestTool.getString(request, "qcTelenor");
                    String cskhTelenor = RequestTool.getString(request, "cskhTelenor");
                    String groupTelenor = RequestTool.getString(request, "groupTelenor");
                    String sttTelenor = RequestTool.getString(request, "sttTelenor");
                    OperProperties telonor = route.getTelenor();
                    telonor.setOperCode(SMSUtils.OPER.TELENOR.val);
                    telonor.setRoute_QC(qcTelenor);
                    telonor.setRoute_CSKH(cskhTelenor);
                    telonor.setGroup(groupTelenor);
                    telonor.setStt(sttTelenor);

                    //-- Haiti
                    //-- Natcom
                    String qcNatcom = RequestTool.getString(request, "qcNatcom");
                    String cskhNatcom = RequestTool.getString(request, "cskhNatcom");
                    String groupNatcom = RequestTool.getString(request, "groupNatcom");
                    String sttNatcom = RequestTool.getString(request, "sttNatcom");
                    OperProperties natcom = route.getNatcom();
                    natcom.setOperCode(SMSUtils.OPER.NATCOM.val);
                    natcom.setRoute_QC(qcNatcom);
                    natcom.setRoute_CSKH(cskhNatcom);
                    natcom.setGroup(groupNatcom);
                    natcom.setStt(sttNatcom);

                    //-- Digicel
                    String qcDigicel = RequestTool.getString(request, "qcDigicel");
                    String cskhDigicel = RequestTool.getString(request, "cskhDigicel");
                    String groupDigicel = RequestTool.getString(request, "groupDigicel");
                    String sttDigicel = RequestTool.getString(request, "sttDigicel");
                    OperProperties digicel = route.getDigicel();
                    digicel.setOperCode(SMSUtils.OPER.DIGICEL.val);
                    digicel.setRoute_QC(qcDigicel);
                    digicel.setRoute_CSKH(cskhDigicel);
                    digicel.setGroup(groupDigicel);
                    digicel.setStt(sttDigicel);

                    //-- Comcel
                    String qcComcel = RequestTool.getString(request, "qcComcel");
                    String cskhComcel = RequestTool.getString(request, "cskhComcel");
                    String groupComcel = RequestTool.getString(request, "groupComcel");
                    String sttComcel = RequestTool.getString(request, "sttComcel");
                    OperProperties comcel = route.getComcel();
                    comcel.setOperCode(SMSUtils.OPER.COMCEL.val);
                    comcel.setRoute_QC(qcComcel);
                    comcel.setRoute_CSKH(cskhComcel);
                    comcel.setGroup(groupComcel);
                    comcel.setStt(sttComcel);

                    //-- Burundi
                    //-- Lumitel
                    String qcLumitel = RequestTool.getString(request, "qcLumitel");
                    String cskhLumitel = RequestTool.getString(request, "cskhLumitel");
                    String groupLumitel = RequestTool.getString(request, "groupLumitel");
                    String sttLumitel = RequestTool.getString(request, "sttLumitel");
                    OperProperties lumitel = route.getLumitel();
                    lumitel.setOperCode(SMSUtils.OPER.LUMITEL.val);
                    lumitel.setRoute_QC(qcLumitel);
                    lumitel.setRoute_CSKH(cskhLumitel);
                    lumitel.setGroup(groupLumitel);
                    lumitel.setStt(sttLumitel);

                    //-- Africell
                    String qcAfricell = RequestTool.getString(request, "qcAfricell");
                    String cskhAfricell = RequestTool.getString(request, "cskhAfricell");
                    String groupAfricell = RequestTool.getString(request, "groupAfricell");
                    String sttAfricell = RequestTool.getString(request, "sttAfricell");
                    OperProperties africell = route.getAfricell();
                    africell.setOperCode(SMSUtils.OPER.AFRICELL.val);
                    africell.setRoute_QC(qcAfricell);
                    africell.setRoute_CSKH(cskhAfricell);
                    africell.setGroup(groupAfricell);
                    africell.setStt(sttAfricell);

                    //-- Lacellsu
                    String qcLacellsu = RequestTool.getString(request, "qcLacellsu");
                    String cskhLacellsu = RequestTool.getString(request, "cskhLacellsu");
                    String groupLacellsu = RequestTool.getString(request, "groupLacellsu");
                    String sttLacellsu = RequestTool.getString(request, "sttLacellsu");
                    OperProperties lacellsu = route.getLacellsu();
                    lacellsu.setOperCode(SMSUtils.OPER.LACELLSU.val);
                    lacellsu.setRoute_QC(qcLacellsu);
                    lacellsu.setRoute_CSKH(cskhLacellsu);
                    lacellsu.setGroup(groupLacellsu);
                    lacellsu.setStt(sttLacellsu);

                    //-- Cameron
                    //-- Nexttel
                    String qcNexttel = RequestTool.getString(request, "qcNexttel");
                    String cskhNexttel = RequestTool.getString(request, "cskhNexttel");
                    String groupNexttel = RequestTool.getString(request, "groupNexttel");
                    String sttNexttel = RequestTool.getString(request, "sttNexttel");
                    OperProperties nexttel = route.getNexttel();
                    nexttel.setOperCode(SMSUtils.OPER.NEXTTEL.val);
                    nexttel.setRoute_QC(qcNexttel);
                    nexttel.setRoute_CSKH(cskhNexttel);
                    nexttel.setGroup(groupNexttel);
                    nexttel.setStt(sttNexttel);

                    //-- Mtn
                    String qcMtn = RequestTool.getString(request, "qcMtn");
                    String cskhMtn = RequestTool.getString(request, "cskhMtn");
                    String groupMtn = RequestTool.getString(request, "groupMtn");
                    String sttMtn = RequestTool.getString(request, "sttMtn");
                    OperProperties mtn = route.getMtn();
                    mtn.setOperCode(SMSUtils.OPER.MTN.val);
                    mtn.setRoute_QC(qcMtn);
                    mtn.setRoute_CSKH(cskhMtn);
                    mtn.setGroup(groupMtn);
                    mtn.setStt(sttMtn);

                    //-- Orange
                    String qcOrange = RequestTool.getString(request, "qcOrange");
                    String cskhOrange = RequestTool.getString(request, "cskhOrange");
                    String groupOrange = RequestTool.getString(request, "groupOrange");
                    String sttOrange = RequestTool.getString(request, "sttOrange");
                    OperProperties orange = route.getOrange();
                    orange.setOperCode(SMSUtils.OPER.ORANGE.val);
                    orange.setRoute_QC(qcOrange);
                    orange.setRoute_CSKH(cskhOrange);
                    orange.setGroup(groupOrange);
                    orange.setStt(sttOrange);

                    //-- Tanzania
                    //-- Halotel
                    String qcHalotel = RequestTool.getString(request, "qcHalotel");
                    String cskhHalotel = RequestTool.getString(request, "cskhHalotel");
                    String groupHalotel = RequestTool.getString(request, "groupHalotel");
                    String sttHalotel = RequestTool.getString(request, "sttHalotel");
                    OperProperties halotel = route.getHalotel();
                    halotel.setOperCode(SMSUtils.OPER.HALOTEL.val);
                    halotel.setRoute_QC(qcHalotel);
                    halotel.setRoute_CSKH(cskhHalotel);
                    halotel.setGroup(groupHalotel);
                    halotel.setStt(sttHalotel);

                    //-- Vodacom
                    String qcVodacom = RequestTool.getString(request, "qcVodacom");
                    String cskhVodacom = RequestTool.getString(request, "cskhVodacom");
                    String groupVodacom = RequestTool.getString(request, "groupVodacom");
                    String sttVodacom = RequestTool.getString(request, "sttVodacom");
                    OperProperties vodacom = route.getVodacom();
                    vodacom.setOperCode(SMSUtils.OPER.VODACOM.val);
                    vodacom.setRoute_QC(qcVodacom);
                    vodacom.setRoute_CSKH(cskhVodacom);
                    vodacom.setGroup(groupVodacom);
                    vodacom.setStt(sttVodacom);

                    //-- Zantel
                    String qcZantel = RequestTool.getString(request, "qcZantel");
                    String cskhZantel = RequestTool.getString(request, "cskhZantel");
                    String groupZantel = RequestTool.getString(request, "groupZantel");
                    String sttZantel = RequestTool.getString(request, "sttZantel");
                    OperProperties zantel = route.getZantel();
                    zantel.setOperCode(SMSUtils.OPER.ZANTEL.val);
                    zantel.setRoute_QC(qcZantel);
                    zantel.setRoute_CSKH(cskhZantel);
                    zantel.setGroup(groupZantel);
                    zantel.setStt(sttZantel);

                    //-- Peru
                    //-- Bitel
                    String qcBitel = RequestTool.getString(request, "qcBitel");
                    String cskhBitel = RequestTool.getString(request, "cskhBitel");
                    String groupBitel = RequestTool.getString(request, "groupBitel");
                    String sttBitel = RequestTool.getString(request, "sttBitel");
                    OperProperties bitel = route.getBitel();
                    bitel.setOperCode(SMSUtils.OPER.BITEL.val);
                    bitel.setRoute_QC(qcBitel);
                    bitel.setRoute_CSKH(cskhBitel);
                    bitel.setGroup(groupBitel);
                    bitel.setStt(sttBitel);

                    //-- Claro
                    String qcClaro = RequestTool.getString(request, "qcClaro");
                    String cskhClaro = RequestTool.getString(request, "cskhClaro");
                    String groupClaro = RequestTool.getString(request, "groupClaro");
                    String sttClaro = RequestTool.getString(request, "sttClaro");
                    OperProperties claro = route.getClaro();
                    claro.setOperCode(SMSUtils.OPER.CLARO.val);
                    claro.setRoute_QC(qcClaro);
                    claro.setRoute_CSKH(cskhClaro);
                    claro.setGroup(groupClaro);
                    claro.setStt(sttClaro);

                    //-- Telefonica
                    String qcTelefonica = RequestTool.getString(request, "qcTelefonica");
                    String cskhTelefonica = RequestTool.getString(request, "cskhTelefonica");
                    String groupTelefonica = RequestTool.getString(request, "groupTelefonica");
                    String sttTelefonica = RequestTool.getString(request, "sttTelefonica");
                    OperProperties telefonica = route.getTelefonia();
                    telefonica.setOperCode(SMSUtils.OPER.TELEFONIA.val);
                    telefonica.setRoute_QC(qcTelefonica);
                    telefonica.setRoute_CSKH(cskhTelefonica);
                    telefonica.setGroup(groupTelefonica);
                    telefonica.setStt(sttTelefonica);
                    // CalculatedByRequest
                    CalculatedByRequest calculatedByRequest = new CalculatedByRequest();
//               
                    OptionCheckDuplicate checkDuplicateTelco2 = calculatedByRequest.getCalculatedByRequest();

                    checkDuplicateTelco2.setVte(checkRequest_viettel);
                    checkDuplicateTelco2.setMobi(checkRequest_mobifone);
                    checkDuplicateTelco2.setVina(checkRequest_vinafone);
                    checkDuplicateTelco2.setVnm(checkRequest_vietnammobi);
                    checkDuplicateTelco2.setBl(checkRequest_BEELINE);
                    checkDuplicateTelco2.setDdg(checkRequest_ITELECOM);

                    checkDuplicateTelco2.setCellcard(checkRequest_CELLCARD);
                    checkDuplicateTelco2.setMetfone(checkRequest_METFONE);
                    checkDuplicateTelco2.setBeelineCampuchia(checkRequest_BeelineCampuchia);
                    checkDuplicateTelco2.setSmart(checkRequest_Smart);
                    checkDuplicateTelco2.setQbmore(checkRequest_Qbmore);
                    checkDuplicateTelco2.setExcell(checkRequest_Excell);

                    checkDuplicateTelco2.setTelemor(checkRequest_Telemor);
                    checkDuplicateTelco2.setTimortelecom(checkRequest_TimorTelecom);

                    checkDuplicateTelco2.setMovitel(checkRequest_Movitel);
                    checkDuplicateTelco2.setMcel(checkRequest_Mcel);

                    checkDuplicateTelco2.setUnitel(checkRequest_Unitel);
                    checkDuplicateTelco2.setEtl(checkRequest_Etl);
                    checkDuplicateTelco2.setTango(checkRequest_Tango);
                    checkDuplicateTelco2.setLaotel(checkRequest_Laotel);

                    checkDuplicateTelco2.setMytel(checkRequest_Mytel);
                    checkDuplicateTelco2.setMpt(checkRequest_Mpt);
                    checkDuplicateTelco2.setOoredo(checkRequest_Ooredo);
                    checkDuplicateTelco2.setTelemor(checkRequest_Telenor);

                    checkDuplicateTelco2.setNatcom(checkRequest_Natcom);
                    checkDuplicateTelco2.setDigicel(checkRequest_Digicel);
                    checkDuplicateTelco2.setComcel(checkRequest_Comcel);

                    checkDuplicateTelco2.setLumitel(checkRequest_Lumitel);
                    checkDuplicateTelco2.setAfricell(checkRequest_Africell);
                    checkDuplicateTelco2.setLacellsu(checkRequest_Lacellsu);

                    checkDuplicateTelco2.setNexttel(checkRequest_Nexttel);
                    checkDuplicateTelco2.setMtn(checkRequest_Mtn);
                    checkDuplicateTelco2.setOrange(checkRequest_Orange);

                    checkDuplicateTelco2.setHalotel(checkRequest_Halotel);
                    checkDuplicateTelco2.setVodacom(checkRequest_Vodacom);
                    checkDuplicateTelco2.setZantel(checkRequest_Zantel);

                    checkDuplicateTelco2.setBitel(checkRequest_Bitel);
                    checkDuplicateTelco2.setClaro(checkRequest_Claro);
                    checkDuplicateTelco2.setTelefonical(checkRequest_Telefonica);

                    //--
                    oneBrand = new BrandLabel();
                    oneBrand.setBrandLabel(brandName);
                    oneBrand.setUserOwner(accOwner.getUserName());               // NEW
                    oneBrand.setCp_code(accOwner.getCpCode());                   // NEW
                    oneBrand.setCreateBy(userlogin.getAccID());
                    oneBrand.setStatus(status);
                    oneBrand.setFormTemplate(template);
                    oneBrand.setRoute(route);
                    oneBrand.setPrice(price);
                    oneBrand.setPriority(priority);
                    oneBrand.setOptionTelco(option.toJson());// New
                    oneBrand.setCheckTemp(checktemp);// New
                    oneBrand.setSendBrandFollowRequest(calculatedByRequest.toJson());// New

//                    System.out.println("calculatedByRequest.toJson():--------------" + calculatedByRequest.toJson());
//                    Tool.debug(RouteTable.toStringJson(route));
                    //------------
                    BrandLabel brandDao = new BrandLabel();
                    if (brandDao.addNew(oneBrand)) {
                        //CongNX: Ghi log action vao db
                        UserAction log = new UserAction(userlogin.getUserName(),
                                UserAction.TABLE.brand_label.val,
                                UserAction.TYPE.ADD.val,
                                UserAction.RESULT.SUCCESS.val,
                                "Brandname " + brandName + " with account(" + accOwner.getUserName() + ")!");
                        log.logAction(request);
                        //CongNX: ket thuc ghi log db voi action thao tac tu web
                        session.setAttribute("mess", "Thêm mới dữ liệu thành công!");
                        response.sendRedirect(request.getContextPath() + "/admin/brand/index.jsp");
                        return;
                    } else {
                        //CongNX: Ghi log action vao db
                        UserAction log = new UserAction(userlogin.getUserName(),
                                UserAction.TABLE.brand_label.val,
                                UserAction.TYPE.ADD.val,
                                UserAction.RESULT.FAIL.val,
                                "Brandname " + brandName + " with account(" + accOwner.getUserName() + ")!");
                        log.logAction(request);
                        //CongNX: ket thuc ghi log db voi action thao tac tu web
                        session.setAttribute("mess", "Thêm mới dữ liệu lỗi!");
                    }
                }
            }
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <form action="" method="post">
                            <table  align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th align="center" scope="col" colspan="7" class="rounded-q4 redBoldUp">Thêm mới Brand [DEV]</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td colspan="2" align="left">Brand Name: </td>
                                        <td class="boder_right" colspan="2">
                                            <input size="15" type="text" name="brandName"/>
                                        </td>
                                        <td align="left">Account: </td>
                                        <td colspan="3">
                                            <select style="width: 400px" name="owner_id" id="_cpuser">
                                                <option value="0">-- Chọn tài khoản Sở hữu --</option>
                                                <%
                                                    ArrayList<Account> allCp = Account.getAllCP();
                                                    for (Account one : allCp) {
                                                        if (one.getStatus() != Account.STATUS.ACTIVE.val) {
                                                            continue;
                                                        };
                                                %>
                                                <option <%=(owner_id == one.getAccID() ? "selected='selected'" : "")%> 
                                                    value="<%=one.getAccID()%>" 
                                                    img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" > [<%=one.getUserName()%>] <%=one.getFullName()%> </option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="left">Mức độ ưu tiên</td>
                                        <td class="boder_right" colspan="2">
                                            <select name="priority">
                                                <option value="1">Cấp độ 1</option>
                                                <option value="2">Cấp độ 2</option>
                                                <option value="3">Cấp độ 3</option>
                                                <option value="4">Cấp độ 4</option>
                                            </select>
                                        </td>
                                        <td>
                                            Trạng thái:
                                        </td>
                                        <td colspan="1">
                                            <select name="status">
                                                <option value="1">Kích hoạt</option>
                                                <option value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>
                                            Check Temp:
                                        </td>
                                        <td colspan="1">
                                            <select name="checktemp">
                                                <option  value="1">Có</option>
                                                <option  value="0">Không</option>
                                            </select>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="background: #60c8f2 none repeat" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN VIỆT NAM</td>
                                        <td style="background: #60c8f2 none repeat" colspan="1" id="addCampuchia" align="center">

                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="boder_right">
                                            VIETTEL
                                            <select name="vt_stt" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateVte">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>

                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhvte">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getVte() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupVte">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>



                                            <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);" id="checkRequest_viettel" name="checkRequest_viettel">
                                            <input type="hidden"/>
                                            <label class="form-check-label" for="checkRequest_viettel">
                                                <span class="redBoldUp">Tính Request</span>
                                            </label>


                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcvte">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getVte() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="boder_right">
                                            MOBI FONE
                                            <select name="mbf_stt" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateVms">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhmobi">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMobi() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupVms">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_mobifone"name="checkRequest_mobifone">
                                            <label class="form-check-label" for="checkRequest_mobifone">
                                                <span class="redBoldUp">Tính Request</span>
                                            </label>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcmobi">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMobi() == 1 && one.getStatus() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="boder_right">
                                            VINA PHONE
                                            <select name="vnp_stt" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateGpc">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhvina">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getVina() == 1 && one.getStatus() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupGpc">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <br/><br/>
                                            <span class="redBoldUp">VNP ID Label: </span>
                                            <input type="text" size="8" name="vnp_lbid" value="0"/><br/>
                                            <span class="redBoldUp">Username of Label: </span>
                                            <input type="text" size="15" name="vnp_lbusername" value="Nhập username"/>

                                            <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);" id="checkRequest_vinafone"name="checkRequest_vinafone">
                                            <label class="form-check-label" for="checkRequest_vinafone">
                                                <span class="redBoldUp">Tính Request</span>
                                            </label>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcvina">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getVina() == 1 && one.getStatus() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            <br/><br/>
                                            <span class="redBoldUp">VNP ID Temp: </span><input type="text" size="8" name="vnp_tmpid" value="0"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="boder_right">
                                            VIETNAM MOBI
                                            <select name="vnm_stt" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateVnm">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhvnm">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getVnm() == 1 && one.getStatus() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupVnm">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_vietnammobi"name="checkRequest_vietnammobi">
                                            <label class="form-check-label" for="checkRequest_vietnammobi">
                                                <span class="redBoldUp">Tính Request</span>
                                            </label>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcvnm">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getVnm() == 1 && one.getStatus() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="boder_right">
                                            BEELINE
                                            <select name="bl_stt" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateBl">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhbl">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getBl() == 1 && one.getStatus() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupBl">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>

                                            <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_BEELINE"name="checkRequest_BEELINE">
                                            <label class="form-check-label" for="checkRequest_BEELINE">
                                                <span class="redBoldUp">Tính Request</span>
                                            </label>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcbl">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getBl() == 1 && one.getStatus() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td colspan="2" class="boder_right">
                                            ITELECOM
                                            <select name="itelecom_stt" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateDdg">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhddg">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getDdg() == 1 && one.getStatus() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupDdg">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_ITELECOM"name="checkRequest_ITELECOM">
                                            <label class="form-check-label" for="checkRequest_ITELECOM">
                                                <span class="redBoldUp">Tính Request</span>
                                            </label>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcddg">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getDdg() == 1 && one.getStatus() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!--Campuchia-->

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN CAMPUCHIA</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="2" id="addCampu" align="right">
                                            <INPUT type="button" value="Show" onclick="addDTGT('Campu')" />
                                        </td>
                                        <td colspan="2" id="delCampu" style="background: #60c8f2 none repeat;display: none;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Campu')" />
                                        </td>
                                    </tr>
                                    <!--Cellcard-->
                                    <tr class="dtgtCampu" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            CELLCARD
                                            <select name="sttCellcard" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateCellcard">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhCellcard">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getCellcard() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupCellcard">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check">  <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_CELLCARD"name="checkRequest_CELLCARD">
                                                <label class="form-check-label" for="checkRequest_CELLCARD">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcCellcard">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getCellcard() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--METFONE-->
                                    <tr class="dtgtCampu" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            METFONE
                                            <select name="sttMetfone" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateMetfone">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhMetfone">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMetfone() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupMetfone">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_METFONE"name="checkRequest_METFONE">
                                                <label class="form-check-label" for="checkRequest_METFONE">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcMetfone">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMetfone() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--BeelineCampuchia-->
                                    <tr class="dtgtCampu" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            BeelineCampuchia
                                            <select name="sttBeelineCampuchia" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateBeelineCampuchia">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhBeelineCampuchia">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getBeelineCampuchia() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupBeelineCampuchia">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"><input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_BeelineCampuchia"name="checkRequest_BeelineCampuchia">
                                                <label class="form-check-label" for="checkRequest_BeelineCampuchia">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcBeelineCampuchia">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getBeelineCampuchia() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Smart-->
                                    <tr class="dtgtCampu" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Smart
                                            <select name="sttSmart" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateSmart">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhSmart">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getSmart() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupSmart">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Smart"name="checkRequest_Smart">
                                                <label class="form-check-label" for="checkRequest_Smart">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcSmart">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getSmart() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Qbmore-->
                                    <tr class="dtgtCampu" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Qbmore
                                            <select name="sttQbmore" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateQbmore">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhQbmore">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getQbmore() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupQbmore">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Qbmore"name="checkRequest_Qbmore">
                                                <label class="form-check-label" for="checkRequest_Qbmore">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcQbmore">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getQbmore() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Excell-->
                                    <tr class="dtgtCampu" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Excell
                                            <select name="sttExcell" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateExcell">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhExcell">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getExcell() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupExcell">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Excell"name="checkRequest_Excell">
                                                <label class="form-check-label" for="checkRequest_Excell">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcExcell">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getExcell() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!--Dong Timor-->

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN ĐÔNG TIMOR</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="2" id="addDongtimor" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Dongtimor')" />
                                        </td>
                                        <td colspan="2" id="delDongtimor" style="background: #60c8f2 none repeat;display: none;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Dongtimor')" />
                                        </td>
                                    </tr>
                                    <!--Telemor-->
                                    <tr class="dtgtDongtimor" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Telemor
                                            <select name="sttTelemor" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateTelemor">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhTelemor">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTelemor() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupTelemor">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Telemor"name="checkRequest_Telemor">
                                                <label class="form-check-label" for="checkRequest_Telemor">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcTelemor">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTelemor() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--TimorTelecom-->
                                    <tr class="dtgtDongtimor" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            TimorTelecom
                                            <select name="sttTimortelecom" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateTimortelecom">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhTimortelecom">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTimortelecom() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupTimortelecom">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_TimorTelecom"name="checkRequest_TimorTelecom">
                                                <label class="form-check-label" for="checkRequest_TimorTelecom">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcTimortelecom">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTimortelecom() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Mozambique-->

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN MOZAMBIQUE</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="2" id="addMozambique" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Mozambique')" />
                                        </td>
                                        <td colspan="2" id="delMozambique" style="background: #60c8f2 none repeat;display: none;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Mozambique')" />
                                        </td>
                                    </tr>
                                    <!--Movitel-->
                                    <tr class="dtgtMozambique" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Movitel
                                            <select name="sttMovitel" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateMovitel">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhMovitel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMovitel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupMovitel">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Movitel"name="checkRequest_Movitel">
                                                <label class="form-check-label" for="checkRequest_Movitel">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcMovitel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMovitel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Mcel-->
                                    <tr class="dtgtMozambique" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Mcel
                                            <select name="sttMcel" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateMcel">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhMcel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMcel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupMcel">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Mcel"name="checkRequest_Mcel">
                                                <label class="form-check-label" for="checkRequest_Mcel">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcMcel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMcel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!--Lào-->

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN LÀO</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="2" id="addLao" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Lao')" />
                                        </td>
                                        <td colspan="2" id="delLao" style="display: none;background: #60c8f2 none repeat;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Lao')" />
                                        </td>
                                    </tr>
                                    <!--Unitel-->
                                    <tr class="dtgtLao" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Unitel
                                            <select name="sttUnitel" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateUnitel">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhUnitel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getUnitel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupUnitel">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Unitel"name="checkRequest_Unitel">
                                                <label class="form-check-label" for="checkRequest_Unitel">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcUnitel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getUnitel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Etl-->
                                    <tr class="dtgtLao" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Etl
                                            <select name="sttEtl" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateEtl">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhEtl">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getEtl() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupEtl">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Etl"name="checkRequest_Etl">
                                                <label class="form-check-label" for="checkRequest_Etl">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcEtl">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getEtl() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Tango-->
                                    <tr class="dtgtLao" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Tango
                                            <select name="sttTango" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateTango">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhTango">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTango() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupTango">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Tango"name="checkRequest_Tango">
                                                <label class="form-check-label" for="checkRequest_Tango">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcTango">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTango() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Laotel-->
                                    <tr class="dtgtLao" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Laotel
                                            <select name="sttLaotel" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateLaotel">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhLaotel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getLaotel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupLaotel">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Laotel"name="checkRequest_Laotel">
                                                <label class="form-check-label" for="checkRequest_Laotel">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcLaotel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getLaotel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!--Mianma-->
                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN MIANMA</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="1" id="addMianma" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Mianma')" />
                                        </td>
                                        <td colspan="1" id="delMianma" style="display: none;background: #60c8f2 none repeat;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Mianma')" />
                                        </td>
                                    </tr>

                                    <!--mytel-->
                                    <tr class="dtgtMianma" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Mytel
                                            <select name="sttMytel" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateMytel">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhMytel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMytel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupMytel">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Mytel"name="checkRequest_Mytel">
                                                <label class="form-check-label" for="checkRequest_Mytel">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcMytel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMytel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Mpt-->
                                    <tr class="dtgtMianma" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Mpt
                                            <select name="sttMpt" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateMpt">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhMpt">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMpt() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupMpt">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Mpt"name="checkRequest_Mpt">
                                                <label class="form-check-label" for="checkRequest_Mpt">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcMpt">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMpt() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Ooredo-->
                                    <tr class="dtgtMianma" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Ooredo
                                            <select name="sttOoredo" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateOoredo">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhOoredo">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getOoredo() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupOoredo">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Ooredo"name="checkRequest_Ooredo">
                                                <label class="form-check-label" for="checkRequest_Ooredo">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcOoredo">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getOoredo() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Telenor-->
                                    <tr class="dtgtMianma" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Telenor
                                            <select name="sttTelenor" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateTelenor">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhTelenor">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTelenor() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupTelenor">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Telenor"name="checkRequest_Telenor">
                                                <label class="form-check-label" for="checkRequest_Telenor">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcTelenor">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTelenor() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!--Haiti-->

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN HAITI</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="1" id="addHaiti" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Haiti')" />
                                        </td>
                                        <td colspan="1" id="delHaiti" style="display: none;background: #60c8f2 none repeat;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Haiti')" />
                                        </td>
                                    </tr>
                                    <!--Natcom-->
                                    <tr class="dtgtHaiti" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Natcom
                                            <select name="sttNatcom" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateNatcom">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhNatcom">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getNatcom() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupNatcom">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Natcom"name="checkRequest_Natcom">
                                                <label class="form-check-label" for="checkRequest_Natcom">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcNatcom">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getNatcom() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Digicel-->
                                    <tr class="dtgtHaiti" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Digicel
                                            <select name="sttDigicel" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateDigicel">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhDigicel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getDigicel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupDigicel">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Digicel"name="checkRequest_Digicel">
                                                <label class="form-check-label" for="checkRequest_Digicel">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcDigicel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getDigicel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Comcel-->
                                    <tr class="dtgtHaiti" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Comcel
                                            <select name="sttComcel" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateComcel">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhComcel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getComcel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupComcel">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Comcel"name="checkRequest_Comcel">
                                                <label class="form-check-label" for="checkRequest_Comcel">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcComcel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getComcel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!--Burundi--> 

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN BURUNDI</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="1" id="addBurundi" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Burundi')" />
                                        </td>
                                        <td colspan="1" id="delBurundi" style="display: none;background: #60c8f2 none repeat;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Burundi')" />
                                        </td>
                                    </tr>
                                    <!--Lumitel-->
                                    <tr class="dtgtBurundi" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Lumitel
                                            <select name="sttLumitel" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateLumitel">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhLumitel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getLumitel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupLumitel">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Lumitel"name="checkRequest_Lumitel">
                                                <label class="form-check-label" for="checkRequest_Lumitel">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcLumitel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getLumitel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Africell-->
                                    <tr class="dtgtBurundi" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Africell
                                            <select name="sttAfricell" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateAfricell">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhAfricell">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getAfricell() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupAfricell">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Africell"name="checkRequest_Africell">
                                                <label class="form-check-label" for="checkRequest_Africell">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcAfricell">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getAfricell() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Lacellsu-->
                                    <tr class="dtgtBurundi" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Lacellsu
                                            <select name="sttLacellsu" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateLacellsu">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhLacellsu">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getLacellsu() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupLacellsu">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Lacellsu"name="checkRequest_Lacellsu">
                                                <label class="form-check-label" for="checkRequest_Lacellsu">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcLacellsu">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getLacellsu() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!--CAMERO0N--> 

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN CAMERO0N</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="1" id="addCameron" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Cameron')" />
                                        </td>
                                        <td colspan="1" id="delCameron" style="display: none;background: #60c8f2 none repeat;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Cameron')" />
                                        </td>
                                    </tr>
                                    <!--Nexttel-->
                                    <tr class="dtgtCameron" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Nexttel
                                            <select name="sttNexttel" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateNexttel">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhNexttel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getNexttel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupNexttel">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Nexttel"name="checkRequest_Nexttel">
                                                <label class="form-check-label" for="checkRequest_Nexttel">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcNexttel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getNexttel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Mtn-->
                                    <tr class="dtgtCameron" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Mtn
                                            <select name="sttMtn" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateMtn">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhMtn">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMtn() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupMtn">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Mtn"name="checkRequest_Mtn">
                                                <label class="form-check-label" for="checkRequest_Mtn">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcMtn">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMtn() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Orange-->
                                    <tr class="dtgtCameron" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Orange
                                            <select name="sttOrange" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateOrange">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhOrange">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getOrange() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupOrange">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Orange"name="checkRequest_Orange">
                                                <label class="form-check-label" for="checkRequest_Orange">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcOrange">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getOrange() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!-- Tanzania --> 

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN TANZANIA</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="1" id="addTanzania" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Tanzania')" />
                                        </td>
                                        <td colspan="1" id="delTanzania" style="display: none;background: #60c8f2 none repeat;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Tanzania')" />
                                        </td>
                                    </tr>
                                    <!--Halotel-->
                                    <tr class="dtgtTanzania" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Halotel
                                            <select name="sttHalotel" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateHalotel">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhHalotel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getHalotel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupHalotel">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Halotel"name="checkRequest_Halotel">
                                                <label class="form-check-label" for="checkRequest_Halotel">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcHalotel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getHalotel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Vodacom-->
                                    <tr class="dtgtTanzania" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Vodacom
                                            <select name="sttVodacom" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateVodacom">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhVodacom">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getVodacom() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupVodacom">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Vodacom"name="checkRequest_Vodacom">
                                                <label class="form-check-label" for="checkRequest_Vodacom">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcVodacom">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getVodacom() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Zantel-->
                                    <tr class="dtgtTanzania" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Zantel
                                            <select name="sttZantel" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateZantel">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhZantel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getZantel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupZantel">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Zantel"name="checkRequest_Zantel">
                                                <label class="form-check-label" for="checkRequest_Zantel">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcZantel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getZantel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!-- PERU --> 

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN PERU</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="1" id="addPeru" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Peru')" />
                                        </td>
                                        <td colspan="1" id="delPeru" style="display: none;background: #60c8f2 none repeat;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Peru')" />
                                        </td>
                                    </tr>
                                    <!--                                    Bitel-->
                                    <tr class="dtgtPeru" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Bitel
                                            <select name="sttBitel" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateBitel">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhBitel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getBitel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupBitel">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Bitel"name="checkRequest_Bitel">
                                                <label class="form-check-label" for="checkRequest_Bitel">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcBitel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getBitel() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Claro-->
                                    <tr class="dtgtPeru" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Claro
                                            <select name="sttClaro" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateClaro">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhClaro">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getClaro() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupClaro">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Claro"name="checkRequest_Claro">
                                                <label class="form-check-label" for="checkRequest_Claro">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcClaro">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getClaro() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Telefonica-->
                                    <tr class="dtgtPeru" style="display:none">
                                        <td colspan="2" class="boder_right">
                                            Telefonica
                                            <select name="sttTelefonica" >
                                                <option value="0">Khóa</option>
                                                <option value="2">Chờ kích hoạt</option>
                                                <option value="3">Đang kích hoạt</option>
                                                <option value="1">Kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateTelefonica">
                                                <option value="0">Đồng ý</option>
                                                <option value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhTelefonica">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTelefonica() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupTelefonica">
                                                <option value="0">NHÓM</option>
                                                <option value="N1">Nhóm N1</option>
                                                <option value="N2">Nhóm N2</option>
                                                <option value="N3">Nhóm N3</option>
                                                <option value="N4">Nhóm N4</option>
                                                <option value="N5">Nhóm N5</option>
                                                <option value="N6">Nhóm N6</option>
                                                <option value="N7">Nhóm N7</option>
                                                <option value="N8">Nhóm N8</option>
                                                <option value="N9">Nhóm N9</option>
                                                <option value="N10">Nhóm N10</option>
                                                <option value="N11">Nhóm N11</option>
                                                <option value="N12">Nhóm N12</option>
                                                <option value="N13">Nhóm N13</option>
                                                <option value="N14">Nhóm N14</option>
                                                <option value="N15">Nhóm N15</option>
                                                <option value="NLC">Nhóm NLC</option>
                                            </select>
                                            <div class="form-check"> <input class="form-check-input" type="checkbox" value="0" onclick="checkBoxClick(this);"  id="checkRequest_Telefonica"name="checkRequest_Telefonica">
                                                <label class="form-check-label" for="checkRequest_Telefonica">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                            </div>
                                        </td>
                                        <td>QC</td>
                                        <td>
                                            <select name="qcTelefonica">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTelefonica() == 1) {
                                                            out.print("<option value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                <SCRIPT language="javascript">
                                            function addDTGT(name) {
                                            for (let el of document.querySelectorAll('.dtgt' + name)) el.style.display = '';
                                                    document.getElementById('add' + name).style.display = 'none';
                                                    document.getElementById('del' + name).style.display = '';
                                            }

                                    function deleteDTGT(name) {
                                    for (let el of document.querySelectorAll('.dtgt' + name)) el.style.display = 'none';
                                            document.getElementById('add' + name).style.display = '';
                                            document.getElementById('del' + name).style.display = 'none';
                                    }

                                </SCRIPT>
                                </tr>
                                <tr>
                                    <td colspan="8" align="center">
                                        <input class="button" type="submit" name="submit" value="Thêm mới"/>
                                        <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/brand/index.jsp"%>'" type="reset" name="reset" value="Hủy"/>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </form>

                    </div><!-- end of right content-->
                </div>   <!--end of center content -->
                <div class="clear"></div>
            </div> <!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
        </div>

    </body>


</html>