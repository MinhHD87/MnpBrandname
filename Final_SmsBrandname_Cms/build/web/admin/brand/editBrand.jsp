<%@page import="gk.myname.vn.entity.CalculatedByRequest"%>
<%@page import="gk.myname.vn.entity.UserAction"%>
<%@page import="gk.myname.vn.entity.OptionCheckDuplicate"%>
<%@page import="gk.myname.vn.entity.OptionVina"%><%@page import="gk.myname.vn.entity.OptionTelco"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.utils.SMSUtils"%><%@page import="gk.myname.vn.entity.OperProperties"%><%@page import="gk.myname.vn.entity.RouteTable"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.entity.BrandLabel.TYPE"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="java.util.Enumeration"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <%            //---------------Admin
            if (userlogin == null) {
                //CongNX: Ghi log action vao db
                UserAction log = new UserAction(userlogin.getUserName(),
                        UserAction.TABLE.brand_label.val,
                        UserAction.TYPE.EDIT.val,
                        UserAction.RESULT.REJECT.val,
                        "Permit deny!");
                log.logAction(request);
                //CongNX: ket thuc ghi log db voi action thao tac tu web
                session.setAttribute("error", "Bạn cần đăng nhập để truy cập hệ thống");
                out.print("<script>top.location='" + request.getContextPath() + "/admin/login.jsp';</script>");
                return;
            }
        %>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/resource/css/jquery-ui-1.8.16.custom.css">
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.core.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.position.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.widget.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.autocomplete.min.js"></script>
        <script type =text/javascript>
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
        <%            if (!userlogin.checkEdit(request)) {
                //CongNX: Ghi log action vao db
                UserAction log = new UserAction(userlogin.getUserName(),
                        UserAction.TABLE.brand_label.val,
                        UserAction.TYPE.EDIT.val,
                        UserAction.RESULT.REJECT.val,
                        "Permit deny!");
                log.logAction(request);
                //CongNX: ket thuc ghi log db voi action thao tac tu web
                session.setAttribute("mess", "Bạn không có quyền truy cập module này!");
                response.sendRedirect(request.getContextPath() + "/admin/brand/index.jsp");
                return;
            }
            int id = RequestTool.getInt(request, "id");
            BrandLabel oneBrand = new BrandLabel();
            oneBrand = oneBrand.getById(id);
            if (oneBrand == null) {
                //CongNX: Ghi log action vao db
                UserAction log = new UserAction(userlogin.getUserName(),
                        UserAction.TABLE.brand_label.val,
                        UserAction.TYPE.EDIT.val,
                        UserAction.RESULT.REJECT.val,
                        "Request not valid");
                log.logAction(request);
                //CongNX: ket thuc ghi log db voi action thao tac tu web
                session.setAttribute("mess", "Yêu cầu không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/brand/index.jsp");
                return;
            }

            String valueOjectOld = oneBrand.toStringJson();
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

                int checkcalcalculateVte = RequestTool.getInt(request, "checkcalcalculateVte");
                int checkcalcalculateVms = RequestTool.getInt(request, "checkcalcalculateVms");
                int checkcalcalculateGpc = RequestTool.getInt(request, "checkcalcalculateGpc");
                int checkcalcalculateVnm = RequestTool.getInt(request, "checkcalcalculateVnm");
                int checkcalcalculateBl = RequestTool.getInt(request, "checkcalcalculateBl");
                int checkcalcalculateDdg = RequestTool.getInt(request, "checkcalcalculateDdg");
//                Campuchia
                int checkDuplicateCellcard = Tool.string2Integer(request.getParameter("checkDuplicateCellcard"));
                int checkDuplicateMetfone = Tool.string2Integer(request.getParameter("checkDuplicateMetfone"));
                int checkDuplicateBeelineCampuchia = Tool.string2Integer(request.getParameter("checkDuplicateBeelineCampuchia"));
                int checkDuplicateSmart = Tool.string2Integer(request.getParameter("checkDuplicateSmart"));
                int checkDuplicateQbmore = Tool.string2Integer(request.getParameter("checkDuplicateQbmore"));
                int checkDuplicateExcell = Tool.string2Integer(request.getParameter("checkDuplicateExcell"));
//                 CalculatedByRequest
                int checkcalcalculateCellcard = RequestTool.getInt(request, "checkcalcalculateCellcard");
                int ccheckcalcalculateMetfone = RequestTool.getInt(request, "ccheckcalcalculateMetfone");
                int checkcalcalculateBeelineCampuchia = RequestTool.getInt(request, "checkcalcalculateBeelineCampuchia");
                int checkcalcalculateSmart = RequestTool.getInt(request, "checkcalcalculateSmart");
                int checkcalcalculateQbmore = RequestTool.getInt(request, "checkcalcalculateQbmore");
                int checkcalcalculateExcell = RequestTool.getInt(request, "checkcalcalculateExcell");
//                Đông Timor
                int checkDuplicateTelemor = Tool.string2Integer(request.getParameter("checkDuplicateTelemor"));
                int checkDuplicateTimortelecom = Tool.string2Integer(request.getParameter("checkDuplicateTimortelecom"));
//                CalculatedByRequest
                int checkcalcalculateTelemor = RequestTool.getInt(request, "checkcalcalculateTelemor");
                int checkcalcalculateTimortelecom = RequestTool.getInt(request, "checkcalcalculateTimortelecom");
//                    Mozambique
                int checkDuplicateMovitel = Tool.string2Integer(request.getParameter("checkDuplicateMovitel"));
                int checkDuplicateMcel = Tool.string2Integer(request.getParameter("checkDuplicateMcel"));
//                  CalculatedByRequest
                int checkcalcalculateMovitel = RequestTool.getInt(request, "checkcalcalculateMovitel");
                int checkcalcalculateMcel = RequestTool.getInt(request, "checkcalcalculateMcel");
//                Lào
                int checkDuplicateUnitel = Tool.string2Integer(request.getParameter("checkDuplicateUnitel"));
                int checkDuplicateEtl = Tool.string2Integer(request.getParameter("checkDuplicateEtl"));
                int checkDuplicateTango = Tool.string2Integer(request.getParameter("checkDuplicateTango"));
                int checkDuplicateLaotel = Tool.string2Integer(request.getParameter("checkDuplicateLaotel"));
//                CalculatedByRequest
                int checkcalcalculateUnitel = RequestTool.getInt(request, "checkcalcalculateUnitel");
                int checkcalcalculateEtl = RequestTool.getInt(request, "checkcalcalculateEtl");
                int checkcalcalculateTango = RequestTool.getInt(request, "checkcalcalculateTango");
                int checkcalcalculateLaotel = RequestTool.getInt(request, "checkcalcalculateLaotel");
//                Myanmar
                int checkDuplicateMytel = Tool.string2Integer(request.getParameter("checkDuplicateMytel"));
                int checkDuplicateMpt = Tool.string2Integer(request.getParameter("checkDuplicateMpt"));
                int checkDuplicateOoredo = Tool.string2Integer(request.getParameter("checkDuplicateOoredo"));
                int checkDuplicateTelenor = Tool.string2Integer(request.getParameter("checkDuplicateTelenor"));
//                 CalculatedByRequest
                int checkcalcalculateMytel = RequestTool.getInt(request, "checkcalcalculateMytel");
                int checkcalcalculateMpt = RequestTool.getInt(request, "checkcalcalculateMpt");
                int ccheckcalcalculateOoredo = RequestTool.getInt(request, "ccheckcalcalculateOoredo");
                int checkcalcalculateTelenor = RequestTool.getInt(request, "checkcalcalculateTelenor");
//                Haiti
                int checkDuplicateNatcom = Tool.string2Integer(request.getParameter("checkDuplicateNatcom"));
                int checkDuplicateDicicel = Tool.string2Integer(request.getParameter("checkDuplicateDicicel"));
                int checkDuplicateComcel = Tool.string2Integer(request.getParameter("checkDuplicateComcel"));
//                CalculatedByRequest
                int checkcalcalculateNatcom = RequestTool.getInt(request, "checkcalcalculateNatcom");
                int checkcalcalculateDigicel = RequestTool.getInt(request, "checkcalcalculateDigicel");
                int checkcalcalculateComcel = RequestTool.getInt(request, "checkcalcalculateComcel");
//                Burundi
                int checkDuplicateLumitel = Tool.string2Integer(request.getParameter("checkDuplicateLumitel"));
                int checkDuplicateAfricell = Tool.string2Integer(request.getParameter("checkDuplicateAfricell"));
                int checkDuplicateLacellsu = Tool.string2Integer(request.getParameter("checkDuplicateLacellsu"));
//                 CalculatedByRequest
                int checkcalcalculateLumitel = RequestTool.getInt(request, "checkcalcalculateLumitel");
                int checkcalcalculateAfricell = RequestTool.getInt(request, "checkcalcalculateAfricell");
                int checkcalcalculateLacellsu = RequestTool.getInt(request, "checkcalcalculateLacellsu");
//                

//                Cameron
                int checkDuplicateNexttel = Tool.string2Integer(request.getParameter("checkDuplicateNexttel"));
                int checkDuplicateMtn = Tool.string2Integer(request.getParameter("checkDuplicateMtn"));
                int checkDuplicateOrange = Tool.string2Integer(request.getParameter("checkDuplicateOrange"));
//                 CalculatedByRequest
                int checkcalcalculateNexttel = RequestTool.getInt(request, "checkcalcalculateNexttel");
                int checkcalcalculateMtn = RequestTool.getInt(request, "checkcalcalculateMtn");
                int checkcalcalculateOrange = RequestTool.getInt(request, "checkcalcalculateOrange");

//                Tanzania
                int checkDuplicateHalotel = Tool.string2Integer(request.getParameter("checkDuplicateHalotel"));
                int checkDuplicateVodacom = Tool.string2Integer(request.getParameter("checkDuplicateVodacom"));
                int checkDuplicateZantel = Tool.string2Integer(request.getParameter("checkDuplicateZantel"));
//                  CalculatedByRequest
                int checkcalcalculateHalotel = RequestTool.getInt(request, "checkcalcalculateHalotel");
                int checkcalcalculateVodacom = RequestTool.getInt(request, "checkcalcalculateVodacom");
                int checkcalcalculateZantel = RequestTool.getInt(request, "checkcalcalculateZantel");
//                Peru
                int checkDuplicateBitel = Tool.string2Integer(request.getParameter("checkDuplicateBitel"));
                int checkDuplicateClaro = Tool.string2Integer(request.getParameter("checkDuplicateClaro"));
                int checkDuplicateTelefonica = Tool.string2Integer(request.getParameter("checkDuplicateTelefonica"));
//                  CalculatedByRequest
                int checkcalcalculateBitel = RequestTool.getInt(request, "checkcalcalculateBitel");
                int checkcalcalculateClaro = RequestTool.getInt(request, "checkcalcalculateClaro");
                int checkcalcalculateTelefonica = RequestTool.getInt(request, "checkcalcalculateTelefonica");

                String brandName = Tool.validStringRequest(request.getParameter("brandName"));
                String template = RequestTool.getString(request, "template");
                int price = Tool.string2Integer(request.getParameter("price"));
                int priority = Tool.string2Integer(request.getParameter("priority"));
                int status = Tool.string2Integer(request.getParameter("status"));
                int checktemp = Tool.string2Integer(request.getParameter("checktemp"));
                String ownerUser = Tool.validStringRequest(request.getParameter("ownerUser"));
                Account ownerAcc = Account.getAccount(ownerUser);
                if (Tool.checkNull(ownerUser) || ownerAcc == null) {
                    session.setAttribute("mess", "Bạn chưa cấp BRAND cho tài khoản nào hoặc tài khoản ko hợp lệ!");
                } else {
                    // Danh Rieng Vina Phone
                    OptionTelco option = new OptionTelco();
                    OptionVina vina_opt = option.getVinaphone();
                    vina_opt.setLabelId(vnp_lbid);
                    vina_opt.setTmpId(vnp_tmpid);
                    vina_opt.setLabelUser(vnp_lbusername);
                    // check trung tin nhan
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
                    checkDuplicateTelco.setTelemor(checkDuplicateTelenor);

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

                    //End check trung tin nhan
                    //--- Route Table
                    RouteTable route = oneBrand.getRoute();
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

                    //--
                    //--
                    // CalculatedByRequest
                    CalculatedByRequest calculatedByRequest = new CalculatedByRequest();
//               
                    OptionCheckDuplicate checkDuplicateTelco2 = calculatedByRequest.getCalculatedByRequest();

                    checkDuplicateTelco2.setVte(checkcalcalculateVte);
                    checkDuplicateTelco2.setMobi(checkcalcalculateVms);
                    checkDuplicateTelco2.setVina(checkcalcalculateGpc);
                    checkDuplicateTelco2.setVnm(checkcalcalculateVnm);
                    checkDuplicateTelco2.setBl(checkcalcalculateBl);
                    checkDuplicateTelco2.setDdg(checkcalcalculateDdg);

                    checkDuplicateTelco2.setCellcard(checkcalcalculateCellcard);
                    checkDuplicateTelco2.setMetfone(ccheckcalcalculateMetfone);
                    checkDuplicateTelco2.setBeelineCampuchia(checkcalcalculateBeelineCampuchia);
                    checkDuplicateTelco2.setSmart(checkcalcalculateSmart);
                    checkDuplicateTelco2.setQbmore(checkcalcalculateQbmore);
                    checkDuplicateTelco2.setExcell(checkcalcalculateExcell);

                    checkDuplicateTelco2.setTelemor(checkcalcalculateTelemor);
                    checkDuplicateTelco2.setTimortelecom(checkcalcalculateTimortelecom);

                    checkDuplicateTelco2.setMovitel(checkcalcalculateMovitel);
                    checkDuplicateTelco2.setMcel(checkcalcalculateMcel);

                    checkDuplicateTelco2.setUnitel(checkcalcalculateUnitel);
                    checkDuplicateTelco2.setEtl(checkcalcalculateEtl);
                    checkDuplicateTelco2.setTango(checkcalcalculateTango);
                    checkDuplicateTelco2.setLaotel(checkcalcalculateLaotel);

                    checkDuplicateTelco2.setMytel(checkcalcalculateMytel);
                    checkDuplicateTelco2.setMpt(checkcalcalculateMpt);
                    checkDuplicateTelco2.setOoredo(ccheckcalcalculateOoredo);
                    checkDuplicateTelco2.setTelenor(checkcalcalculateTelenor);

                    checkDuplicateTelco2.setNatcom(checkcalcalculateNatcom);
                    checkDuplicateTelco2.setDigicel(checkcalcalculateDigicel);
                    checkDuplicateTelco2.setComcel(checkcalcalculateComcel);

                    checkDuplicateTelco2.setLumitel(checkcalcalculateLumitel);
                    checkDuplicateTelco2.setAfricell(checkcalcalculateAfricell);
                    checkDuplicateTelco2.setLacellsu(checkcalcalculateLacellsu);

                    checkDuplicateTelco2.setNexttel(checkcalcalculateNexttel);
                    checkDuplicateTelco2.setMtn(checkcalcalculateMtn);
                    checkDuplicateTelco2.setOrange(checkcalcalculateOrange);

                    checkDuplicateTelco2.setHalotel(checkcalcalculateHalotel);
                    checkDuplicateTelco2.setVodacom(checkcalcalculateVodacom);
                    checkDuplicateTelco2.setZantel(checkcalcalculateZantel);

                    checkDuplicateTelco2.setBitel(checkcalcalculateBitel);
                    checkDuplicateTelco2.setClaro(checkcalcalculateClaro);
                    checkDuplicateTelco2.setTelefonical(checkcalcalculateTelefonica);

                    //--
                    oneBrand.setBrandLabel(brandName);
                    oneBrand.setUserOwner(ownerAcc.getUserName());               // NEW
                    oneBrand.setCp_code(ownerAcc.getCpCode());                   // NEW
                    oneBrand.setCreateBy(userlogin.getAccID());
                    oneBrand.setStatus(status);
                    oneBrand.setFormTemplate(template);
                    oneBrand.setRoute(route);
                    oneBrand.setPrice(price);
                    oneBrand.setPriority(priority);
                    oneBrand.setUpdateDate(DateProc.createTimestamp());
                    oneBrand.setUpdateBy(userlogin.getAccID());
                    oneBrand.setOptionTelco(option.toJson());// New
                    oneBrand.setCheckTemp(checktemp);// New
                    oneBrand.setSendBrandFollowRequest(calculatedByRequest.toJson());// New

                    System.out.println("option:" + option);
                    //------------
                    BrandLabel brandDao = new BrandLabel();
                    String valueOjectNew = oneBrand.toStringJson();
                    if (brandDao.update(oneBrand)) {
                        //CongNX: Ghi log action vao db

                        UserAction log = new UserAction(userlogin.getUserName(),
                                UserAction.TABLE.brand_label.val,
                                UserAction.TYPE.EDIT.val,
                                UserAction.RESULT.SUCCESS.val,
                                "OLD= " + valueOjectOld + ", NEW=" + valueOjectNew);
                        log.logAction(request);
                        //CongNX: ket thuc ghi log db voi action thao tac tu web
                        session.setAttribute("mess", "Cập nhật dữ liệu thành công!");
                        response.sendRedirect(request.getContextPath() + "/admin/brand/index.jsp");
                        return;
                    } else {
                        //CongNX: Ghi log action vao db
                        UserAction log = new UserAction(userlogin.getUserName(),
                                UserAction.TABLE.brand_label.val,
                                UserAction.TYPE.EDIT.val,
                                UserAction.RESULT.FAIL.val,
                                "Brandname= " + oneBrand.getBrandLabel());
                        log.logAction(request);
                        //CongNX: ket thuc ghi log db voi action thao tac tu web
                        session.setAttribute("mess", "Cập nhật dữ liệu lỗi!");
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
                            <%
                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <form action="" method="post">
                            <%
                                Tool.debug("Opt String:" + oneBrand.getOptionTelco());
                                Tool.debug("Opt String:" + oneBrand.getSendBrandFollowRequest());
                                OptionTelco opt = oneBrand.buildOption();
                                CalculatedByRequest cbr = oneBrand.buildCalculatedRequest();
                                OptionVina opt_vina;
                                OptionCheckDuplicate opt_CheckDuplicateTelco;
                                OptionCheckDuplicate opt_CheckDuplicateTelco2;
//                                OptionCheckDuplicate calculatedCheckRequest;
                                if (opt == null) {
                                    opt_vina = new OptionVina();
                                    opt_CheckDuplicateTelco = new OptionCheckDuplicate();
                                    opt_CheckDuplicateTelco2 = new OptionCheckDuplicate();

                                } else {
                                    opt_vina = opt.getVinaphone();
                                    opt_CheckDuplicateTelco = opt.getCheckDuplicate();
                                    opt_CheckDuplicateTelco2 = cbr.getCalculatedByRequest();
                                }

                                String labelId = opt_vina.getLabelId();
                                String tmpId = opt_vina.getTmpId();
                                String lbUser = opt_vina.getLabelUser();

                                int checkDuplicateVte = opt_CheckDuplicateTelco.getVte();
                                int checkDuplicateVms = opt_CheckDuplicateTelco.getMobi();
                                int checkDuplicateGpc = opt_CheckDuplicateTelco.getVina();
                                int checkDuplicateVnm = opt_CheckDuplicateTelco.getVnm();
                                int checkDuplicateBl = opt_CheckDuplicateTelco.getBl();
                                int checkDuplicateDdg = opt_CheckDuplicateTelco.getDdg();

                                int checkDuplicateCellcard = opt_CheckDuplicateTelco.getCellcard();
                                int checkDuplicateMetfone = opt_CheckDuplicateTelco.getMetfone();
                                int checkDuplicateBeelineCampuchia = opt_CheckDuplicateTelco.getBeelineCampuchia();
                                int checkDuplicateSmart = opt_CheckDuplicateTelco.getSmart();
                                int checkDuplicateQbmore = opt_CheckDuplicateTelco.getQbmore();
                                int checkDuplicateExcell = opt_CheckDuplicateTelco.getExcell();

                                int checkDuplicateTelemor = opt_CheckDuplicateTelco.getTelemor();
                                int checkDuplicateTimortelecom = opt_CheckDuplicateTelco.getTimortelecom();

                                int checkDuplicateMovitel = opt_CheckDuplicateTelco.getMovitel();
                                int checkDuplicateMcel = opt_CheckDuplicateTelco.getMcel();

                                int checkDuplicateUnitel = opt_CheckDuplicateTelco.getUnitel();
                                int checkDuplicateEtl = opt_CheckDuplicateTelco.getEtl();
                                int checkDuplicateTango = opt_CheckDuplicateTelco.getTango();
                                int checkDuplicateLaotel = opt_CheckDuplicateTelco.getLaotel();

                                int checkDuplicateMytel = opt_CheckDuplicateTelco.getMytel();
                                int checkDuplicateMpt = opt_CheckDuplicateTelco.getMpt();
                                int checkDuplicateOoredo = opt_CheckDuplicateTelco.getOoredo();
                                int checkDuplicateTelenor = opt_CheckDuplicateTelco.getTelenor();

                                int checkDuplicateNatcom = opt_CheckDuplicateTelco.getNatcom();
                                int checkDuplicateDigicel = opt_CheckDuplicateTelco.getDigicel();
                                int checkDuplicateComcel = opt_CheckDuplicateTelco.getComcel();

                                int checkDuplicateLumitel = opt_CheckDuplicateTelco.getLumitel();
                                int checkDuplicateAfricell = opt_CheckDuplicateTelco.getAfricell();
                                int checkDuplicateLacellsu = opt_CheckDuplicateTelco.getLacellsu();

                                int checkDuplicateNexttel = opt_CheckDuplicateTelco.getNexttel();
                                int checkDuplicateMtn = opt_CheckDuplicateTelco.getMtn();
                                int checkDuplicateOrange = opt_CheckDuplicateTelco.getOrange();

                                int checkDuplicateHalotel = opt_CheckDuplicateTelco.getHalotel();
                                int checkDuplicateVodacom = opt_CheckDuplicateTelco.getVodacom();
                                int checkDuplicateZantel = opt_CheckDuplicateTelco.getZantel();

                                int checkDuplicateBitel = opt_CheckDuplicateTelco.getBitel();
                                int checkDuplicateClaro = opt_CheckDuplicateTelco.getClaro();
                                int checkDuplicateTelefonica = opt_CheckDuplicateTelco.getTelefonical();

//                                calculatedCheckRequest
                                int checkcalcalculateVte = opt_CheckDuplicateTelco2.getVte();
                                int checkcalcalculateVms = opt_CheckDuplicateTelco2.getMobi();
                                int checkcalcalculateGpc = opt_CheckDuplicateTelco2.getVina();
                                int checkcalcalculateVnm = opt_CheckDuplicateTelco2.getVnm();
                                int checkcalcalculateBl = opt_CheckDuplicateTelco2.getBl();
                                int checkcalcalculateDdg = opt_CheckDuplicateTelco2.getDdg();

                                int checkcalcalculateCellcard = opt_CheckDuplicateTelco2.getCellcard();
                                int ccheckcalcalculateMetfone = opt_CheckDuplicateTelco2.getMetfone();
                                int checkcalcalculateBeelineCampuchia = opt_CheckDuplicateTelco2.getBeelineCampuchia();
                                int checkcalcalculateSmart = opt_CheckDuplicateTelco2.getSmart();
                                int checkcalcalculateQbmore = opt_CheckDuplicateTelco2.getQbmore();
                                int checkcalcalculateExcell = opt_CheckDuplicateTelco2.getExcell();

                                int checkcalcalculateTelemor = opt_CheckDuplicateTelco2.getTelemor();
                                int checkcalcalculateTimortelecom = opt_CheckDuplicateTelco2.getTimortelecom();

                                int checkcalcalculateMovitel = opt_CheckDuplicateTelco2.getMovitel();
                                int checkcalcalculateMcel = opt_CheckDuplicateTelco2.getMcel();

                                int checkcalcalculateUnitel = opt_CheckDuplicateTelco2.getUnitel();
                                int checkcalcalculateEtl = opt_CheckDuplicateTelco2.getEtl();
                                int checkcalcalculateTango = opt_CheckDuplicateTelco2.getTango();
                                int checkcalcalculateLaotel = opt_CheckDuplicateTelco2.getLaotel();

                                int checkcalcalculateMytel = opt_CheckDuplicateTelco2.getMytel();
                                int checkcalcalculateMpt = opt_CheckDuplicateTelco2.getMpt();
                                int ccheckcalcalculateOoredo = opt_CheckDuplicateTelco2.getOoredo();
                                int checkcalcalculateTelenor = opt_CheckDuplicateTelco2.getTelenor();
                                out.print(ccheckcalcalculateOoredo);
                                out.print(ccheckcalcalculateOoredo);
                                out.print(ccheckcalcalculateOoredo);
                                out.print(checkcalcalculateTelenor);
                                out.print(checkcalcalculateTelenor);
                                out.print(checkcalcalculateTelenor);
                                out.print(checkcalcalculateTelenor);
                                out.print(checkcalcalculateTelenor);
                                out.print(checkcalcalculateTelenor);
                                out.print(checkcalcalculateTelenor);
                                out.print(checkcalcalculateTelenor);

                                int checkcalcalculateNatcom = opt_CheckDuplicateTelco2.getNatcom();
                                int checkcalcalculateDigicel = opt_CheckDuplicateTelco2.getDigicel();
                                int checkcalcalculateComcel = opt_CheckDuplicateTelco2.getComcel();

                                int checkcalcalculateLumitel = opt_CheckDuplicateTelco2.getLumitel();
                                int checkcalcalculateAfricell = opt_CheckDuplicateTelco2.getAfricell();
                                int checkcalcalculateLacellsu = opt_CheckDuplicateTelco2.getLacellsu();

                                int checkcalcalculateNexttel = opt_CheckDuplicateTelco2.getNexttel();
                                int checkcalcalculateMtn = opt_CheckDuplicateTelco2.getMtn();
                                int checkcalcalculateOrange = opt_CheckDuplicateTelco2.getOrange();

                                int checkcalcalculateHalotel = opt_CheckDuplicateTelco2.getHalotel();
                                int checkcalcalculateVodacom = opt_CheckDuplicateTelco2.getVodacom();
                                int checkcalcalculateZantel = opt_CheckDuplicateTelco2.getZantel();

                                int checkcalcalculateBitel = opt_CheckDuplicateTelco2.getBitel();
                                int checkcalcalculateClaro = opt_CheckDuplicateTelco2.getClaro();
                                int checkcalcalculateTelefonica = opt_CheckDuplicateTelco2.getTelefonical();

                            %>
                            <table  align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" colspan="7" class="rounded-q4 redBoldUp">Cập nhật Brand</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td colspan="2" align="left">Brand Name: </td>
                                        <td colspan="2" class="boder_right">
                                            <input value="<%=oneBrand.getBrandLabel()%>" size="15" type="text" name="brandName"/>
                                        </td>
                                        <td align="left">Account: </td>
                                        <td colspan="3">
                                            <select style="width: 400px" name="ownerUser" id="_cpuser">
                                                <option value="0">-- Chọn tài khoản Sở hữu --</option>
                                                <%
                                                    ArrayList<Account> allCp = Account.getAllCP();
                                                    for (Account one : allCp) {
                                                %>
                                                <option <%=(oneBrand.getUserOwner().equals(one.getUserName()) ? "selected='selected'" : "")%> 
                                                    value="<%=one.getUserName()%>" 
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
                                                <option <%=oneBrand.getPriority() == 1 ? " selected='selected'" : ""%> value="1">Cấp độ 1</option>
                                                <option <%=oneBrand.getPriority() == 2 ? " selected='selected'" : ""%> value="2">Cấp độ 2</option>
                                                <option <%=oneBrand.getPriority() == 3 ? " selected='selected'" : ""%> value="3">Cấp độ 3</option>
                                                <option <%=oneBrand.getPriority() == 4 ? " selected='selected'" : ""%> value="4">Cấp độ 4</option>
                                            </select>
                                        </td>
                                        <td>
                                            Trạng thái:
                                        </td>
                                        <td colspan="1">
                                            <select name="status">
                                                <option <%=oneBrand.getStatus() == 1 ? " selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%=oneBrand.getStatus() == 0 ? " selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>

                                        </td>
                                        <td>
                                            Check Temp:
                                        </td>
                                        <td colspan="1">
                                            <select name="checktemp">
                                                <option <%=oneBrand.getCheckTemp() == 1 ? " selected='selected'" : ""%> value="1">Có</option>
                                                <option <%=oneBrand.getCheckTemp() == 0 ? " selected='selected'" : ""%> value="0">Không</option>
                                            </select>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="background: #60c8f2 none repeat" class="redBoldUp" colspan="8" align="center">ĐỊNH TUYẾN GỬI TIN</td>
                                    </tr>
                                    <tr>
                                        <%
                                            RouteTable route = oneBrand.getRoute();
                                        %>
                                        <td colspan="2" class="boder_right">
                                            VIETTEL
                                            <select name="vt_stt" >
                                                <option <%="3".equals(route.getVte().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getVte().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getVte().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                                <option <%="2".equals(route.getVte().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateVte">
                                                <option <%= checkDuplicateVte == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateVte == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>

                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhvte">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getVte() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getVte().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupVte">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                                <option <%="N4".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N4">Nhóm N4</option>
                                                <option <%="N5".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N5">Nhóm N5</option>
                                                <option <%="N6".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N6">Nhóm N6</option>
                                                <option <%="N7".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N7">Nhóm N7</option>
                                                <option <%="N8".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N8">Nhóm N8</option>
                                                <option <%="N9".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N9">Nhóm N9</option>
                                                <option <%="N10".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N10">Nhóm N10</option>
                                                <option <%="N11".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N11">Nhóm N11</option>
                                                <option <%="N12".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N12">Nhóm N12</option>
                                                <option <%="N13".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N13">Nhóm N13</option>
                                                <option <%="N14".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N14">Nhóm N14</option>
                                                <option <%="N15".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="N15">Nhóm N15</option>
                                                <option <%="NLC".equals(route.getVte().getGroup()) ? "selected='selected'" : ""%> value="NLC">Nhóm NLC</option>
                                            </select>
                                            <input <%=checkcalcalculateVte == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateVte" value="<%=checkcalcalculateVte == 1 ? "1" : "0"%>" id="checkcalcalculateVte"/>

                                            <label class="form-check-label" for="checkcalcalculateVte">
                                                <span class="redBoldUp">Tính Request</span>
                                            </label>
                                        </td>
                                        <td>Hướng QC</td>
                                        <td>
                                            <select name="qcvte">
                                                <option value="0">Không cho Phép</option>
                                                <% for (Provider one : Provider.CACHE) {
                                                        if (one.getVte() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getVte().getRoute_QC()) ? "selected='selected'" : "") + "  value='" + one.getCode() + " '>" + one.getName() + "</option>");
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
                                                <option <%="2".equals(route.getMobi().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getMobi().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getMobi().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getMobi().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateVms">
                                                <option <%= checkDuplicateVms == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateVms == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhmobi">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMobi() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getMobi().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupVms">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                                <option <%="N4".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N4">Nhóm N4</option>
                                                <option <%="N5".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N5">Nhóm N5</option>
                                                <option <%="N6".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N6">Nhóm N6</option>
                                                <option <%="N7".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N7">Nhóm N7</option>
                                                <option <%="N8".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N8">Nhóm N8</option>
                                                <option <%="N9".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N9">Nhóm N9</option>
                                                <option <%="N10".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N10">Nhóm N10</option>
                                                <option <%="N11".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N11">Nhóm N11</option>
                                                <option <%="N12".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N12">Nhóm N12</option>
                                                <option <%="N13".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N13">Nhóm N13</option>
                                                <option <%="N14".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N14">Nhóm N14</option>
                                                <option <%="N15".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="N15">Nhóm N15</option>
                                                <option <%="NLC".equals(route.getMobi().getGroup()) ? "selected='selected'" : ""%> value="NLC">Nhóm NLC</option>
                                            </select>
                                            
                                                <input <%=checkcalcalculateVms == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateVms" value="<%=checkcalcalculateVms == 1 ? "1" : "0"%>" id="checkcalcalculateVms"/>
                                                <label class="form-check-label" for="checkcalcalculateVms">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                         
                                        </td>
                                        <td>Hướng QC</td>
                                        <td>
                                            <select name="qcmobi">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMobi() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getMobi().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="boder_right">VINA PHONE

                                            <select name="vnp_stt" >
                                                <option <%="2".equals(route.getVina().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getVina().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getVina().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getVina().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select></td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateGpc">
                                                <option <%= checkDuplicateGpc == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateGpc == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhvina">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getVina() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getVina().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupGpc">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                                <option <%="N4".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N4">Nhóm N4</option>
                                                <option <%="N5".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N5">Nhóm N5</option>
                                                <option <%="N6".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N6">Nhóm N6</option>
                                                <option <%="N7".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N7">Nhóm N7</option>
                                                <option <%="N8".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N8">Nhóm N8</option>
                                                <option <%="N9".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N9">Nhóm N9</option>
                                                <option <%="N10".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N10">Nhóm N10</option>
                                                <option <%="N11".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N11">Nhóm N11</option>
                                                <option <%="N12".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N12">Nhóm N12</option>
                                                <option <%="N13".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N13">Nhóm N13</option>
                                                <option <%="N14".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N14">Nhóm N14</option>
                                                <option <%="N15".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="N15">Nhóm N15</option>
                                                <option <%="NLC".equals(route.getVina().getGroup()) ? "selected='selected'" : ""%> value="NLC">Nhóm NLC</option>
                                            </select>
                                            <br/><br/>
                                            <span class="redBoldUp">VNP ID Label: </span>
                                            <input type="text" size="8" name="vnp_lbid" value="<%= Tool.checkNull(labelId) ? "" : labelId%>"/>
                                            <br/>
                                            <span class="redBoldUp">Username of Label: </span>
                                            <input type="text" size="15" name="vnp_lbusername" value="<%= Tool.checkNull(lbUser) ? "" : lbUser%>"/>
                                            
                                                <input <%=checkcalcalculateGpc == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateGpc" value="<%=checkcalcalculateGpc == 1 ? "1" : "0"%>" id="checkcalcalculateGpc"/>
                                                <label class="form-check-label" for="checkcalcalculateGpc">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                        </td>
                                        <td>Hướng QC</td>
                                        <td>
                                            <select name="qcvina">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getVina() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getVina().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            <br/><br/>
                                            <span class="redBoldUp">VNP ID Temp: </span>
                                            <input type="text" size="8" name="vnp_tmpid" value="<%= Tool.checkNull(tmpId) ? "" : tmpId%>"/>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="boder_right">VIETNAM MOBI
                                            <select name="vnm_stt" >
                                                <option <%="2".equals(route.getVnm().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getVnm().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getVnm().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getVnm().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select></td>

                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateVnm">
                                                <option <%= checkDuplicateVnm == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateVnm == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhvnm">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getVnm() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getVnm().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupVnm">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                                <option <%="N4".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N4">Nhóm N4</option>
                                                <option <%="N5".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N5">Nhóm N5</option>
                                                <option <%="N6".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N6">Nhóm N6</option>
                                                <option <%="N7".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N7">Nhóm N7</option>
                                                <option <%="N8".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N8">Nhóm N8</option>
                                                <option <%="N9".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N9">Nhóm N9</option>
                                                <option <%="N10".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N10">Nhóm N10</option>
                                                <option <%="N11".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N11">Nhóm N11</option>
                                                <option <%="N12".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N12">Nhóm N12</option>
                                                <option <%="N13".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N13">Nhóm N13</option>
                                                <option <%="N14".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N14">Nhóm N14</option>
                                                <option <%="N15".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="N15">Nhóm N15</option>
                                                <option <%="NLC".equals(route.getVnm().getGroup()) ? "selected='selected'" : ""%> value="NLC">Nhóm NLC</option>
                                            </select>
                                            
                                                <input <%=checkcalcalculateVnm == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateVnm" value="<%=checkcalcalculateVnm == 1 ? "1" : "0"%>" id="checkcalcalculateVnm"/>
                                                <label class="form-check-label" for="checkcalcalculateVnm">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                        </td>
                                        <td>Hướng QC</td>
                                        <td>
                                            <select name="qcvnm">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getVnm() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getVnm().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="boder_right">BEELINE
                                            <select name="bl_stt" >
                                                <option <%="2".equals(route.getBl().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getBl().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getBl().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getBl().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select></td>

                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateBl">
                                                <option <%= checkDuplicateBl == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateBl == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhbl">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
//                                                        System.out.println(one.getCode()+"---------------"+route.getBl().getRoute_CSKH());
                                                        if (one.getBl() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getBl().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupBl">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                                <option <%="N4".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N4">Nhóm N4</option>
                                                <option <%="N5".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N5">Nhóm N5</option>
                                                <option <%="N6".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N6">Nhóm N6</option>
                                                <option <%="N7".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N7">Nhóm N7</option>
                                                <option <%="N8".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N8">Nhóm N8</option>
                                                <option <%="N9".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N9">Nhóm N9</option>
                                                <option <%="N10".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N10">Nhóm N10</option>
                                                <option <%="N11".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N11">Nhóm N11</option>
                                                <option <%="N12".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N12">Nhóm N12</option>
                                                <option <%="N13".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N13">Nhóm N13</option>
                                                <option <%="N14".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N14">Nhóm N14</option>
                                                <option <%="N15".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="N15">Nhóm N15</option>
                                                <option <%="NLC".equals(route.getBl().getGroup()) ? "selected='selected'" : ""%> value="NLC">Nhóm NLC</option>
                                            </select>
                                             <input <%=checkcalcalculateBl == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateBl" value="<%=checkcalcalculateBl == 1 ? "1" : "0"%>" id="checkcalcalculateBl"/>
                                                <label class="form-check-label" for="checkcalcalculateBl">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                        </td>
                                        <td>Hướng QC</td>
                                        <td>
                                            <select name="qcbl">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getBl() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getBl().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="2" class="boder_right">ITELECOM
                                            <select name="itelecom_stt" >
                                                <option <%="2".equals(route.getDdg().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getDdg().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getDdg().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getDdg().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select></td>

                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateDdg">
                                                <option <%= checkDuplicateDdg == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateDdg == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhddg">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getDdg() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getDdg().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupDdg">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                                <option <%="N4".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N4">Nhóm N4</option>
                                                <option <%="N5".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N5">Nhóm N5</option>
                                                <option <%="N6".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N6">Nhóm N6</option>
                                                <option <%="N7".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N7">Nhóm N7</option>
                                                <option <%="N8".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N8">Nhóm N8</option>
                                                <option <%="N9".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N9">Nhóm N9</option>
                                                <option <%="N10".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N10">Nhóm N10</option>
                                                <option <%="N11".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N11">Nhóm N11</option>
                                                <option <%="N12".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N12">Nhóm N12</option>
                                                <option <%="N13".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N13">Nhóm N13</option>
                                                <option <%="N14".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N14">Nhóm N14</option>
                                                <option <%="N15".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="N15">Nhóm N15</option>
                                                <option <%="NLC".equals(route.getDdg().getGroup()) ? "selected='selected'" : ""%> value="NLC">Nhóm NLC</option>
                                            </select>
                                               <input <%=checkcalcalculateDdg == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateDdg" value="<%=checkcalcalculateDdg == 1 ? "1" : "0"%>" id="checkcalcalculateDdg"/>
                                                <label class="form-check-label" for="checkcalcalculateDdg">
                                                    <span class="redBoldUp">Tính Request</span>
                                                </label>
                                        </td>
                                        <td>Hướng QC</td>
                                        <td>
                                            <select name="qcddg">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getDdg() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getDdg().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
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
                                    <tr class="dtgtCampu" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Cellcard
                                            <select name="sttCellcard" >
                                                <option <%="2".equals(route.getCellcard().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getCellcard().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getCellcard().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getCellcard().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                            
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateCellcard">
                                                <option <%= checkDuplicateCellcard == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateCellcard == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhCellcard">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getCellcard() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getCellcard().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupCellcard">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getCellcard().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getCellcard().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getCellcard().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                             <div class="form-check">
                                             <input <%=checkcalcalculateCellcard == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateCellcard" value="<%=checkcalcalculateCellcard == 1 ? "1" : "0"%>" id="checkcalcalculateCellcard"/>
                                                <label class="form-check-label" for="checkcalcalculateCellcard">
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
                                                        if (one.getCellcard() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getCellcard().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Metfone-->
                                    <tr class="dtgtCampu" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Metfone
                                            <select name="sttMetfone" >
                                                <option <%="2".equals(route.getMetfone().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getMetfone().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getMetfone().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getMetfone().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateMetfone">
                                                <option <%= checkDuplicateMetfone == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateMetfone == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhMetfone">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMetfone() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getMetfone().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupMetfone">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getMetfone().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getMetfone().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getMetfone().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=ccheckcalcalculateMetfone == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="ccheckcalcalculateMetfone" value="<%=ccheckcalcalculateMetfone == 1 ? "1" : "0"%>" id="ccheckcalcalculateMetfone"/>
                                                <label class="form-check-label" for="ccheckcalcalculateMetfone">
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
                                                        if (one.getMetfone() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getMetfone().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--BeelineCampuchia-->
                                    <tr class="dtgtCampu" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            BeelineCampuchia
                                            <select name="sttBeelineCampuchia" >
                                                <option <%="2".equals(route.getBeelineCampuchia().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getBeelineCampuchia().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getBeelineCampuchia().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getBeelineCampuchia().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateBeelineCampuchia">
                                                <option <%= checkDuplicateBeelineCampuchia == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateBeelineCampuchia == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhBeelineCampuchia">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getBeelineCampuchia() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getBeelineCampuchia().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupBeelineCampuchia">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getBeelineCampuchia().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getBeelineCampuchia().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getBeelineCampuchia().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateBeelineCampuchia == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateBeelineCampuchia" value="<%=checkcalcalculateBeelineCampuchia == 1 ? "1" : "0"%>" id="checkcalcalculateBeelineCampuchia"/>
                                                <label class="form-check-label" for="checkcalcalculateBeelineCampuchia">
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
                                                        if (one.getBeelineCampuchia() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getBeelineCampuchia().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Smart-->
                                    <tr class="dtgtCampu" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Smart
                                            <select name="sttSmart" >
                                                <option <%="2".equals(route.getSmart().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getSmart().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getSmart().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getSmart().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateSmart">
                                                <option <%= checkDuplicateSmart == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateSmart == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhSmart">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getSmart() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getSmart().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupSmart">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getSmart().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getSmart().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getSmart().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                             <div class="form-check">
                                             <input <%=checkcalcalculateSmart == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateSmart" value="<%=checkcalcalculateSmart == 1 ? "1" : "0"%>" id="checkcalcalculateSmart"/>
                                                <label class="form-check-label" for="checkcalcalculateSmart">
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
                                                        if (one.getSmart() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getSmart().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Qbmore-->
                                    <tr class="dtgtCampu" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Qbmore
                                            <select name="sttQbmore" >
                                                <option <%="2".equals(route.getQbmore().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getQbmore().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getQbmore().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getQbmore().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateQbmore">
                                                <option <%= checkDuplicateQbmore == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateQbmore == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhQbmore">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getQbmore() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getQbmore().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupQbmore">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getQbmore().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getQbmore().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getQbmore().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateQbmore == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateQbmore" value="<%=checkcalcalculateQbmore == 1 ? "1" : "0"%>" id="checkcalcalculateQbmore"/>
                                                <label class="form-check-label" for="checkcalcalculateQbmore">
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
                                                        if (one.getQbmore() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getQbmore().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Excell-->
                                    <tr class="dtgtCampu" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Excell
                                            <select name="sttExcell" >
                                                <option <%="2".equals(route.getExcell().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getExcell().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getExcell().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getExcell().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateExcell">
                                                <option <%= checkDuplicateExcell == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateExcell == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhExcell">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getExcell() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getExcell().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupExcell">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getExcell().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getExcell().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getExcell().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateExcell == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateExcell" value="<%=checkcalcalculateExcell == 1 ? "1" : "0"%>" id="checkcalcalculateExcell"/>
                                                <label class="form-check-label" for="checkcalcalculateExcell">
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
                                                        if (one.getExcell() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getExcell().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!--Dong Timor-->

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN DONG TIMOR</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="2" id="addDongtimor" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Dongtimor')" />
                                        </td>
                                        <td colspan="2" id="delDongtimor" style="background: #60c8f2 none repeat;display: none;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Dongtimor')" />
                                        </td>
                                    </tr>
                                    <!--Telemor-->
                                    <tr class="dtgtDongtimor" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Telemor
                                            <select name="sttTelemor" >
                                                <option <%="2".equals(route.getTelemor().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getTelemor().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getTelemor().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getTelemor().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateTelemor">
                                                <option <%= checkDuplicateTelemor == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateTelemor == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhTelemor">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTelemor() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getTelemor().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupTelemor">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getTelemor().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getTelemor().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getTelemor().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateTelemor == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateTelemor" value="<%=checkcalcalculateTelemor == 1 ? "1" : "0"%>" id="checkcalcalculateTelemor"/>
                                                <label class="form-check-label" for="checkcalcalculateTelemor">
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
                                                        if (one.getTelemor() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getTelemor().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Timortelecom-->
                                    <tr class="dtgtDongtimor" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Timortelecom
                                            <select name="sttTimortelecom" >
                                                <option <%="2".equals(route.getTimortelecom().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getTimortelecom().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getTimortelecom().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getTimortelecom().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateTimortelecom">
                                                <option <%= checkDuplicateTimortelecom == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateTimortelecom == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhTimortelecom">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTimortelecom() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getTimortelecom().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupTimortelecom">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getTimortelecom().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getTimortelecom().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getTimortelecom().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateTimortelecom == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateTimortelecom" value="<%=checkcalcalculateTimortelecom == 1 ? "1" : "0"%>" id="checkcalcalculateTimortelecom"/>
                                                <label class="form-check-label" for="checkcalcalculateTimortelecom">
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
                                                        if (one.getTimortelecom() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getTimortelecom().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
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
                                    <tr class="dtgtMozambique" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Movitel
                                            <select name="sttMovitel" >
                                                <option <%="2".equals(route.getMovitel().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getMovitel().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getMovitel().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getMovitel().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateMovitel">
                                                <option <%= checkDuplicateMovitel == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateMovitel == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhMovitel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMovitel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getMovitel().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupMovitel">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getMovitel().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getMovitel().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getMovitel().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateMovitel == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateMovitel" value="<%=checkcalcalculateMovitel == 1 ? "1" : "0"%>" id="checkcalcalculateMovitel"/>
                                                <label class="form-check-label" for="checkcalcalculateMovitel">
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
                                                        if (one.getMovitel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getMovitel().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Mcel-->
                                    <tr class="dtgtMozambique" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Mcel
                                            <select name="sttMcel" >
                                                <option <%="2".equals(route.getMcel().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getMcel().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getMcel().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getMcel().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateMcel">
                                                <option <%= checkDuplicateMcel == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateMcel == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhMcel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMcel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getMcel().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupMcel">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getMcel().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getMcel().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getMcel().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateMcel == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateMcel" value="<%=checkcalcalculateMcel == 1 ? "1" : "0"%>" id="checkcalcalculateMcel"/>
                                                <label class="form-check-label" for="checkcalcalculateMcel">
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
                                                        if (one.getMcel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getMcel().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
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
                                        <td colspan="2" id="delLao" style="background: #60c8f2 none repeat;display: none;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Lao')" />
                                        </td>
                                    </tr>
                                    <!--Unitel-->
                                    <tr class="dtgtLao" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Unitel
                                            <select name="sttUnitel" >
                                                <option <%="2".equals(route.getUnitel().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getUnitel().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getUnitel().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getUnitel().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateUnitel">
                                                <option <%= checkDuplicateUnitel == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateUnitel == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhUnitel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getUnitel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getUnitel().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupUnitel">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getUnitel().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getUnitel().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getUnitel().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateUnitel == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateUnitel" value="<%=checkcalcalculateUnitel == 1 ? "1" : "0"%>" id="checkcalcalculateUnitel"/>
                                                <label class="form-check-label" for="checkcalcalculateUnitel">
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
                                                        if (one.getUnitel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getUnitel().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Etl-->
                                    <tr class="dtgtLao" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Etl
                                            <select name="sttEtl" >
                                                <option <%="2".equals(route.getEtl().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getEtl().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getEtl().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getEtl().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateEtl">
                                                <option <%= checkDuplicateEtl == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateEtl == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhEtl">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getEtl() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getEtl().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupEtl">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getEtl().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getEtl().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getEtl().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateEtl == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateEtl" value="<%=checkcalcalculateEtl == 1 ? "1" : "0"%>" id="checkcalcalculateEtl"/>
                                                <label class="form-check-label" for="checkcalcalculateEtl">
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
                                                        if (one.getEtl() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getEtl().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Tango-->
                                    <tr class="dtgtLao" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Tango
                                            <select name="sttTango" >
                                                <option <%="2".equals(route.getTango().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getTango().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getTango().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getTango().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateTango">
                                                <option <%= checkDuplicateTango == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateTango == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhTango">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTango() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getTango().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupTango">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getTango().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getTango().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getTango().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateTango == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateTango" value="<%=checkcalcalculateTango == 1 ? "1" : "0"%>" id="checkcalcalculateTango"/>
                                                <label class="form-check-label" for="checkcalcalculateTango">
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
                                                        if (one.getTango() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getTango().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Laotel-->
                                    <tr class="dtgtLao" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Laotel
                                            <select name="sttLaotel" >
                                                <option <%="2".equals(route.getLaotel().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getLaotel().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getLaotel().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getLaotel().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateLaotel">
                                                <option <%= checkDuplicateLaotel == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateLaotel == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhLaotel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getLaotel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getLaotel().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupLaotel">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getLaotel().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getLaotel().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getLaotel().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                             <div class="form-check">
                                             <input <%=checkcalcalculateLaotel == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateLaotel" value="<%=checkcalcalculateLaotel == 1 ? "1" : "0"%>" id="checkcalcalculateLaotel"/>
                                                <label class="form-check-label" for="checkcalcalculateLaotel">
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
                                                        if (one.getLaotel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getLaotel().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
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
                                        <td colspan="1" id="delMianma" style="background: #60c8f2 none repeat;display: none;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Mianma')" />
                                        </td>
                                    </tr>
                                    <!--Mytel-->
                                    <tr class="dtgtMianma" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Mytel
                                            <select name="sttMytel" >
                                                <option <%="2".equals(route.getMytel().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getMytel().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getMytel().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getMytel().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateMytel">
                                                <option <%= checkDuplicateMytel == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateMytel == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhMytel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMytel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getMytel().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupMytel">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getMytel().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getMytel().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getMytel().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                              <div class="form-check">
                                             <input <%=checkcalcalculateMytel == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateMytel" value="<%=checkcalcalculateMytel == 1 ? "1" : "0"%>" id="checkcalcalculateMytel"/>
                                                <label class="form-check-label" for="checkcalcalculateMytel">
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
                                                        if (one.getMytel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getMytel().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Mpt-->
                                    <tr class="dtgtMianma" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Mpt
                                            <select name="sttMpt" >
                                                <option <%="2".equals(route.getMpt().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getMpt().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getMpt().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getMpt().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateMpt">
                                                <option <%= checkDuplicateMpt == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateMpt == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhMpt">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMpt() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getMpt().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupMpt">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getMpt().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getMpt().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getMpt().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                              <div class="form-check">
                                             <input <%=checkcalcalculateMpt == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateMpt" value="<%=checkcalcalculateMpt == 1 ? "1" : "0"%>" id="checkcalcalculateMpt"/>
                                                <label class="form-check-label" for="checkcalcalculateMpt">
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
                                                        if (one.getMpt() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getMpt().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Ooredo-->
                                    <tr class="dtgtMianma" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Ooredo
                                            <select name="sttOoredo" >
                                                <option <%="2".equals(route.getOoredo().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getOoredo().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getOoredo().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getOoredo().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateOoredo">
                                                <option <%= checkDuplicateOoredo == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateOoredo == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhOoredo">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getOoredo() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getOoredo().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupOoredo">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getOoredo().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getOoredo().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getOoredo().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                              <div class="form-check">
                                             <input <%=ccheckcalcalculateOoredo == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="ccheckcalcalculateOoredo" value="<%=ccheckcalcalculateOoredo == 1 ? "1" : "0"%>" id="ccheckcalcalculateOoredo"/>
                                                <label class="form-check-label" for="ccheckcalcalculateOoredo">
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
                                                        if (one.getOoredo() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getOoredo().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Telenor-->
                                    <tr class="dtgtMianma" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Telenor
                                            <select name="sttTelenor" >
                                                <option <%="2".equals(route.getTelenor().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getTelenor().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getTelenor().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getTelenor().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateTelenor">
                                                <option <%= checkDuplicateTelenor == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateTelenor == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhTelenor">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTelenor() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getTelenor().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupTelenor">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getTelenor().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getTelenor().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getTelenor().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                              <div class="form-check">
                                             <input <%=checkcalcalculateTelenor == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateTelenor" value="<%=checkcalcalculateTelenor == 1 ? "1" : "0"%>" id="checkcalcalculateTelenor"/>
                                                <label class="form-check-label" for="checkcalcalculateTelenor">
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
                                                        if (one.getTelenor() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getTelenor().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!--Haiti-->

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN Haiti</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="1" id="addHaiti" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Haiti')" />
                                        </td>
                                        <td colspan="1" id="delHaiti" style="background: #60c8f2 none repeat;display: none;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Haiti')" />
                                        </td>
                                    </tr>
                                    <!--Natcom-->
                                    <tr class="dtgtHaiti" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Natcom
                                            <select name="sttNatcom" >
                                                <option <%="2".equals(route.getNatcom().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getNatcom().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getNatcom().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getNatcom().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateNatcom">
                                                <option <%= checkDuplicateNatcom == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateNatcom == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhNatcom">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getNatcom() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getNatcom().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupNatcom">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getNatcom().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getNatcom().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getNatcom().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateNatcom == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateNatcom" value="<%=checkcalcalculateNatcom == 1 ? "1" : "0"%>" id="checkcalcalculateNatcom"/>
                                                <label class="form-check-label" for="checkcalcalculateNatcom">
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
                                                        if (one.getNatcom() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getNatcom().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Digicel-->
                                    <tr class="dtgtHaiti" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Digicel
                                            <select name="sttDigicel" >
                                                <option <%="2".equals(route.getDigicel().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getDigicel().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getDigicel().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getDigicel().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateDigicel">
                                                <option <%= checkDuplicateDigicel == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateDigicel == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhDigicel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getDigicel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getDigicel().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupDigicel">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getDigicel().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getDigicel().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getDigicel().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                             <div class="form-check">
                                             <input <%=checkcalcalculateDigicel == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateDigicel" value="<%=checkcalcalculateDigicel == 1 ? "1" : "0"%>" id="checkcalcalculateDigicel"/>
                                                <label class="form-check-label" for="checkcalcalculateDigicel">
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
                                                        if (one.getDigicel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getDigicel().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Comcel-->
                                    <tr class="dtgtHaiti" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Comcel
                                            <select name="sttComcel" >
                                                <option <%="2".equals(route.getComcel().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getComcel().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getComcel().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getComcel().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateComcel">
                                                <option <%= checkDuplicateComcel == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateComcel == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhComcel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getComcel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getComcel().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupComcel">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getComcel().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getComcel().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getComcel().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateComcel == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateComcel" value="<%=checkcalcalculateComcel == 1 ? "1" : "0"%>" id="checkcalcalculateComcel"/>
                                                <label class="form-check-label" for="checkcalcalculateComcel">
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
                                                        if (one.getComcel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getComcel().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!--Burundi-->

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN Burundi</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="1" id="addBurundi" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Burundi')" />
                                        </td>
                                        <td colspan="1" id="delBurundi" style="background: #60c8f2 none repeat;display: none;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Burundi')" />
                                        </td>
                                    </tr>
                                    <!--Lumitel-->
                                    <tr class="dtgtBurundi" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Lumitel
                                            <select name="sttLumitel" >
                                                <option <%="2".equals(route.getLumitel().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getLumitel().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getLumitel().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getLumitel().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateLumitel">
                                                <option <%= checkDuplicateLumitel == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateLumitel == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhLumitel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getLumitel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getLumitel().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupLumitel">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getLumitel().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getLumitel().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getLumitel().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateLumitel == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateLumitel" value="<%=checkcalcalculateLumitel == 1 ? "1" : "0"%>" id="checkcalcalculateLumitel"/>
                                                <label class="form-check-label" for="checkcalcalculateLumitel">
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
                                                        if (one.getLumitel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getLumitel().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Africell-->
                                    <tr class="dtgtBurundi" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Africell
                                            <select name="sttAfricell" >
                                                <option <%="2".equals(route.getAfricell().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getAfricell().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getAfricell().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getAfricell().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateAfricell">
                                                <option <%= checkDuplicateAfricell == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateAfricell == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhAfricell">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getAfricell() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getAfricell().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupAfricell">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getAfricell().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getAfricell().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getAfricell().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                             <div class="form-check">
                                             <input <%=checkcalcalculateAfricell == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateAfricell" value="<%=checkcalcalculateAfricell == 1 ? "1" : "0"%>" id="checkcalcalculateAfricell"/>
                                                <label class="form-check-label" for="checkcalcalculateAfricell">
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
                                                        if (one.getAfricell() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getAfricell().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Lacellsu-->
                                    <tr class="dtgtBurundi" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Lacellsu
                                            <select name="sttLacellsu" >
                                                <option <%="2".equals(route.getLacellsu().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getLacellsu().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getLacellsu().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getLacellsu().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateLacellsu">
                                                <option <%= checkDuplicateLacellsu == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateLacellsu == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhLacellsu">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getLacellsu() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getLacellsu().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupLacellsu">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getLacellsu().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getLacellsu().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getLacellsu().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateLacellsu == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateLacellsu" value="<%=checkcalcalculateLacellsu == 1 ? "1" : "0"%>" id="checkcalcalculateLacellsu"/>
                                                <label class="form-check-label" for="checkcalcalculateLacellsu">
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
                                                        if (one.getLacellsu() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getLacellsu().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!--Cameron-->

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN Cameron</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="1" id="addCameron" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Cameron')" />
                                        </td>
                                        <td colspan="1" id="delCameron" style="background: #60c8f2 none repeat;display: none;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Cameron')" />
                                        </td>
                                    </tr>
                                    <!--Nexttel-->
                                    <tr class="dtgtCameron" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Nexttel
                                            <select name="sttNexttel" >
                                                <option <%="2".equals(route.getNexttel().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getNexttel().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getNexttel().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getNexttel().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateNexttel">
                                                <option <%= checkDuplicateNexttel == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateNexttel == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhNexttel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getNexttel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getNexttel().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupNexttel">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getNexttel().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getNexttel().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getNexttel().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateNexttel == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateNexttel" value="<%=checkcalcalculateNexttel == 1 ? "1" : "0"%>" id="checkcalcalculateNexttel"/>
                                                <label class="form-check-label" for="checkcalcalculateNexttel">
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
                                                        if (one.getNexttel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getNexttel().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Mtn-->
                                    <tr class="dtgtCameron" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Mtn
                                            <select name="sttMtn" >
                                                <option <%="2".equals(route.getMtn().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getMtn().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getMtn().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getMtn().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateMtn">
                                                <option <%= checkDuplicateMtn == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateMtn == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhMtn">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getMtn() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getMtn().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupMtn">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getMtn().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getMtn().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getMtn().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                             <div class="form-check">
                                             <input <%=checkcalcalculateMtn == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateMtn" value="<%=checkcalcalculateMtn == 1 ? "1" : "0"%>" id="checkcalcalculateMtn"/>
                                                <label class="form-check-label" for="checkcalcalculateMtn">
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
                                                        if (one.getMtn() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getMtn().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Orange-->
                                    <tr class="dtgtCameron" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Orange
                                            <select name="sttOrange" >
                                                <option <%="2".equals(route.getOrange().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getOrange().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getOrange().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getOrange().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateOrange">
                                                <option <%= checkDuplicateOrange == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateOrange == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhOrange">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getOrange() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getOrange().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupOrange">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getOrange().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getOrange().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getOrange().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateOrange == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateOrange" value="<%=checkcalcalculateOrange == 1 ? "1" : "0"%>" id="checkcalcalculateOrange"/>
                                                <label class="form-check-label" for="checkcalcalculateOrange">
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
                                                        if (one.getOrange() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getOrange().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!--Tanzania-->

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN Tanzania</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="1" id="addTanzania" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Tanzania')" />
                                        </td>
                                        <td colspan="1" id="delTanzania" style="background: #60c8f2 none repeat;display: none;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Tanzania')" />
                                        </td>
                                    </tr>
                                    <!--Halotel-->
                                    <tr class="dtgtTanzania" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Halotel
                                            <select name="sttHalotel" >
                                                <option <%="2".equals(route.getHalotel().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getHalotel().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getHalotel().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getHalotel().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateHalotel">
                                                <option <%= checkDuplicateHalotel == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateHalotel == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhHalotel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getHalotel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getHalotel().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupHalotel">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getHalotel().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getHalotel().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getHalotel().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateHalotel == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateHalotel" value="<%=checkcalcalculateHalotel == 1 ? "1" : "0"%>" id="checkcalcalculateHalotel"/>
                                                <label class="form-check-label" for="checkcalcalculateHalotel">
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
                                                        if (one.getHalotel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getHalotel().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Vodacom-->
                                    <tr class="dtgtTanzania" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Vodacom
                                            <select name="sttVodacom" >
                                                <option <%="2".equals(route.getVodacom().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getVodacom().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getVodacom().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getVodacom().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateVodacom">
                                                <option <%= checkDuplicateVodacom == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateVodacom == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhVodacom">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getVodacom() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getVodacom().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupVodacom">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getVodacom().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getVodacom().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getVodacom().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                             <div class="form-check">
                                             <input <%=checkcalcalculateVodacom == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateVodacom" value="<%=checkcalcalculateVodacom == 1 ? "1" : "0"%>" id="checkcalcalculateVodacom"/>
                                                <label class="form-check-label" for="checkcalcalculateVodacom">
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
                                                        if (one.getVodacom() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getVodacom().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Zantel-->
                                    <tr class="dtgtTanzania" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Zantel
                                            <select name="sttZantel" >
                                                <option <%="2".equals(route.getZantel().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getZantel().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getZantel().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getZantel().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateZantel">
                                                <option <%= checkDuplicateZantel == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateZantel == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhZantel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getZantel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getZantel().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupZantel">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getZantel().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getZantel().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getZantel().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                            <div class="form-check">
                                             <input <%=checkcalcalculateZantel == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateZantel" value="<%=checkcalcalculateZantel == 1 ? "1" : "0"%>" id="checkcalcalculateZantel"/>
                                                <label class="form-check-label" for="checkcalcalculateZantel">
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
                                                        if (one.getZantel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getZantel().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <!--Peru-->

                                    <tr>
                                        <td style="background: #60c8f2 none repeat;" class="redBoldUp" colspan="7" align="center">ĐỊNH TUYẾN GỬI TIN Peru</td>
                                        <td style="background: #60c8f2 none repeat;" colspan="1" id="addPeru" align="right">
                                            <INPUT type="button"  value="Show" onclick="addDTGT('Peru')" />
                                        </td>
                                        <td colspan="1" id="delPeru" style="background: #60c8f2 none repeat;display: none;" align="right">
                                            <INPUT type="button" value="Hidden" onclick="deleteDTGT('Peru')" />
                                        </td>
                                    </tr>
                                    <!--Bitel-->
                                    <tr class="dtgtPeru" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Bitel
                                            <select name="sttBitel" >
                                                <option <%="2".equals(route.getBitel().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getBitel().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getBitel().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getBitel().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateBitel">
                                                <option <%= checkDuplicateBitel == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateBitel == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhBitel">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getBitel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getBitel().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupBitel">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getBitel().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getBitel().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getBitel().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                             <div class="form-check">
                                             <input <%=checkcalcalculateBitel == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateBitel" value="<%=checkcalcalculateBitel == 1 ? "1" : "0"%>" id="checkcalcalculateBitel"/>
                                                <label class="form-check-label" for="checkcalcalculateBitel">
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
                                                        if (one.getBitel() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getBitel().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Claro-->
                                    <tr class="dtgtPeru" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Claro
                                            <select name="sttClaro" >
                                                <option <%="2".equals(route.getClaro().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getClaro().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getClaro().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getClaro().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateClaro">
                                                <option <%= checkDuplicateClaro == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateClaro == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhClaro">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getClaro() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getClaro().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupClaro">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getClaro().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getClaro().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getClaro().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                             <div class="form-check">
                                             <input <%=checkcalcalculateClaro == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateClaro" value="<%=checkcalcalculateClaro == 1 ? "1" : "0"%>" id="checkcalcalculateClaro"/>
                                                <label class="form-check-label" for="checkcalcalculateClaro">
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
                                                        if (one.getClaro() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getClaro().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <!--Telefonica-->
                                    <tr class="dtgtPeru" style="display: none">
                                        <td colspan="2" class="boder_right">
                                            Telefonica
                                            <select name="sttTelefonica" >
                                                <option <%="2".equals(route.getTelefonia().getStt()) ? "selected='selected'" : ""%> value="2">Chờ kích hoạt</option>
                                                <option <%="3".equals(route.getTelefonia().getStt()) ? "selected='selected'" : ""%> value="3">Đang kích hoạt</option>
                                                <option <%="1".equals(route.getTelefonia().getStt()) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%="0".equals(route.getTelefonia().getStt()) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                        <td>Chặn trùng</td>
                                        <td class="boder_right">
                                            <select name="checkDuplicateTelefonica">
                                                <option <%= checkDuplicateTelefonica == 0 ? " selected='selected'" : ""%> value="0">Đồng ý</option>
                                                <option <%= checkDuplicateTelefonica == 1 ? " selected='selected'" : ""%> value="1">Từ chối</option>
                                            </select>
                                        </td>
                                        <td>CSKH</td>
                                        <td class="boder_right">
                                            <select name="cskhTelefonica">
                                                <option value="0">Không cho Phép</option>
                                                <%
                                                    for (Provider one : Provider.CACHE) {
                                                        if (one.getTelefonica() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getTelefonia().getRoute_CSKH()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <select name="groupTelefonica">
                                                <option value="0">NHÓM</option>
                                                <option <%="N1".equals(route.getTelefonia().getGroup()) ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%="N2".equals(route.getTelefonia().getGroup()) ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%="N3".equals(route.getTelefonia().getGroup()) ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                            </select>
                                             <div class="form-check">
                                             <input <%=checkcalcalculateTelefonica == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="checkcalcalculateTelefonica" value="<%=checkcalcalculateTelefonica == 1 ? "1" : "0"%>" id="checkcalcalculateTelefonica"/>
                                                <label class="form-check-label" for="checkcalcalculateTelefonica">
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
                                                        if (one.getTelefonica() == 1 && one.getStatus() == 1) {
                                                            out.print("<option " + (one.getCode().equals(route.getTelefonia().getRoute_QC()) ? "selected='selected'" : "") + " value='" + one.getCode() + " '>" + one.getName() + "</option>");
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
                                        <input class="button" type="submit" name="submit" value="Cập nhật"/>
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