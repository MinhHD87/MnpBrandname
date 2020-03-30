<%@page import="gk.myname.vn.utils.DateProc"%>
<%@page import="gk.myname.vn.entity.OptionCheckDuplicate"%>
<%@page import="gk.myname.vn.entity.OptionVina"%>
<%@page import="gk.myname.vn.entity.OptionTelco"%>
<%@page import="gk.myname.vn.utils.SMSUtils"%><%@page import="gk.myname.vn.entity.RouteTable"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script type="text/javascript" language="javascript">
            $(document).ready(function () {
                $('.dateproc').datetimepicker({
                    lang: 'vi',
                    timepicker: false,
                    format: 'd/m/Y',
                    formatDate: 'Y/m/d',
                    minDate: '2016/12/01', // yesterday is minimum date
                    maxDate: '+1970/01/02' // and tommorow is maximum date calendar
                });
                 $('.ItemPopup').showPopup({
                    top: 100,
                    closeButton: ".close_popup", //khai báo nút close cho popup
                    scroll: 0, //cho phép scroll khi mở popup, mặc định là không cho phép
                    width: 500,
                    height: 'auto',
                    closeOnEscape: true
                });
                $("#_provider").select2({
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
                        var opt = $("#_provider option:selected");
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
                
            });
            function validMonth() {
                var stRequest = $("#stRequest").val();
                var endRequest = $("#endRequest").val();
                var arrstRequest = stRequest.split("/");
                var arrendRequest = endRequest.split("/");
                if (stRequest !== "" && stRequest !== null) {
                    if (endRequest === "" || endRequest === null) {
                        jAlert("Bạn cần chọn ngày kết thúc...");
                        return false;
                    }
//                    if (arrstRequest[1] !== arrendRequest[1]) {
//                        jAlert("Bạn chỉ thống kê được dữ liệu từng tháng...");
//                        return false;
//                    }
                    if (arrstRequest[2] !== arrendRequest[2]) {
                        jAlert("Năm bạn chọn không hợp lệ...");
                        return false;
                    }
                }
            }
            
            $(document).ready(function () {
                $('#_dataTable').DataTable({
                    "order": [[0, "asc"]],
                    "bPaginate": false,
                    "bLengthChange": false,
                    "bFilter": true,
                    "bInfo": false,
                    "bAutoWidth": false
                });
            });
            $(document).ready(function () {
                $('.ask').jConfirmAction();
            });
            function checkallMove() {
                var chk = document.getElementById("checkall");
                if (chk.checked) {
                    var chkmove = document.getElementsByName("chkmove");
                    for (var i = 0; i < chkmove.length; i++)
                        chkmove[i].checked = true;
                } else {
                    var chkmove = document.getElementsByName("chkmove");
                    for (var i = 0; i < chkmove.length; i++)
                        chkmove[i].checked = false;
                }
            }
            function CheckMove() {
                var chkmove = document.getElementsByName("chkmove");
                for (var i = 0; i < chkmove.length; i++) {
                    if (chkmove[i].checked) {
                        return true;
                    }
                }
                alert("Bạn cần chọn ít nhất một nội dung để chuyển chuyên mục");
                return false;
            }
            function  delChoice() {
                var supertarget = '<%=request.getContextPath() + "/admin/brand/delallBrand.jsp"%>'
                var theForm = document.getElementById("mainForm");
                theForm.action = supertarget;
                theForm.submit();
                // $("#mainForm").submit();
            }
        </script>
    </head>
    <body>
        <%
            ArrayList<BrandLabel> allBrand = null;
            BrandLabel dao = new BrandLabel();
            int currentPage = RequestTool.getInt(request, "page", 1);
            int status = RequestTool.getInt(request, "status", 1);
            String _label = RequestTool.getString(request, "_label");
            String stRequest = RequestTool.getString(request, "stRequest");
            if (Tool.checkNull(stRequest)) {
                stRequest = "01/12/2016";
            }
            String endRequest = RequestTool.getString(request, "endRequest");
            if (Tool.checkNull(endRequest)) {
                endRequest = DateProc.createDDMMYYYY();
            }
            String telco = RequestTool.getString(request, "telco");
            String groupBr = RequestTool.getString(request, "groupBr");
            String providerCode = RequestTool.getString(request, "providerCode");
            String cpuser = RequestTool.getString(request, "cpuser", "0");
            //--
//            allBrand = dao.getAll(currentPage, maxRow, _label, cpuser, status, providerCode, telco);
//            int totalPage = 0;
//            int totalRow = dao.countAll(_label, cpuser, status, providerCode, telco);
            allBrand = dao.getAll(currentPage, maxRow, _label, cpuser, status, providerCode, telco, groupBr, stRequest, endRequest);
            int totalPage = 0;
            int totalRow = dao.countAll(_label, cpuser, status, providerCode, telco, groupBr, stRequest, endRequest);
            totalPage = (int) totalRow / maxRow;
            if (totalRow % maxRow != 0) {
                totalPage++;
            }
            RequestTool.debugParam(request);
            String urlExport = request.getContextPath() + "/admin/brand/exportBrand.jsp?";
            String dataGet = "";
            dataGet += "page=" + currentPage;
            dataGet += "&status=" + status;
            dataGet += "&_label=" + _label;
            dataGet += "&telco=" + telco;
            dataGet += "&groupBr=" + groupBr;
            dataGet += "&providerCode=" + providerCode;
            dataGet += "&cpuser=" + cpuser;
            dataGet += "&stRequest=" + stRequest;
            dataGet += "&endRequest=" + endRequest;
            urlExport += dataGet;
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <!-- Tìm kiếm-->
                        <form action="<%=request.getContextPath() + "/admin/brand/index.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">HỆ THỐNG QUẢN LÝ BRAND NAME</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Brand Label</td>
                                        <td>
                                            <select style="width: 180px" id="_label" name="_label">
                                                <option value="">Tất cả</option>
                                                <%ArrayList<BrandLabel> allLabel = BrandLabel.getAll();
                                                    for (BrandLabel one : allLabel) {
                                                %>
                                                <option id="_<%=one.getId()%>" status="_<%=one.getStatus()%>" <%=_label.equals(one.getBrandLabel()) ? "selected='selected'" : ""%> value="<%=one.getBrandLabel()%>"><%=one.getBrandLabel()%> - [<%=one.getUserOwner()%>] <%=one.getStatus() == 1 ? "" : "[Lock]"%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            Trạng thái:
                                            <select name="status">
                                                <option <%=(status == 1 ? "selected='selected'" : "")%> value="1">Đã duyệt</option>
                                                <option <%=(status == 0 ? "selected='selected'" : "")%> value="0">Khóa</option>
                                                <option <%=(status == 404 ? "selected='selected'" : "")%> value="404">Xóa</option>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;
                                            <span class="redBold">Telco</span>
                                            <select name="telco">
                                                <option value="">---Tất cả---</option>
                                                <option <%=telco.equals(SMSUtils.OPER.VIETTEL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.VIETTEL.val%>">VIETTEL</option>
                                                <option <%=telco.equals(SMSUtils.OPER.VINA.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.VINA.val%>">VINA PHONE</option>
                                                <option <%=telco.equals(SMSUtils.OPER.MOBI.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.MOBI.val%>">MOBI PHONE</option>
                                                <option <%=telco.equals(SMSUtils.OPER.BEELINE.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.BEELINE.val%>">BEELINE</option>
                                                <option <%=telco.equals(SMSUtils.OPER.VNM.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.VNM.val%>">VIETNAMMOBIE</option>
                                                <option <%=telco.equals(SMSUtils.OPER.DONGDUONG.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.DONGDUONG.val%>">ITELECOM</option>
                                                
                                                <option <%=telco.equals(SMSUtils.OPER.CELLCARD.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.CELLCARD.val%>">CELLCARD</option>
                                                <option <%=telco.equals(SMSUtils.OPER.METFONE.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.METFONE.val%>">METFONE</option>
                                                <option <%=telco.equals(SMSUtils.OPER.BEELINECAMPUCHIA.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.BEELINECAMPUCHIA.val%>">BEELINECAMPUCHIA</option>
                                                <option <%=telco.equals(SMSUtils.OPER.SMART.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.SMART.val%>">SMART</option>
                                                <option <%=telco.equals(SMSUtils.OPER.QBMORE.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.QBMORE.val%>">QBMORE</option>
                                                <option <%=telco.equals(SMSUtils.OPER.EXCELL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.EXCELL.val%>">EXCELL</option>
                                                
                                                <option <%=telco.equals(SMSUtils.OPER.TELEMOR.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.TELEMOR.val%>">TELEMOR</option>
                                                <option <%=telco.equals(SMSUtils.OPER.TIMORTELECOM.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.TIMORTELECOM.val%>">TIMORTELECOM</option>
                                                
                                                <option <%=telco.equals(SMSUtils.OPER.MOVITEL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.MOVITEL.val%>">MOVITEL</option>
                                                <option <%=telco.equals(SMSUtils.OPER.MCEL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.MCEL.val%>">MCEL</option>
                                                
                                                <option <%=telco.equals(SMSUtils.OPER.UNITEL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.UNITEL.val%>">UNITEL</option>
                                                <option <%=telco.equals(SMSUtils.OPER.ETL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.ETL.val%>">ETL</option>
                                                <option <%=telco.equals(SMSUtils.OPER.TANGO.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.TANGO.val%>">TANGO</option>
                                                <option <%=telco.equals(SMSUtils.OPER.LAOTEL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.LAOTEL.val%>">LAOTEL</option>
                                                
                                                <option <%=telco.equals(SMSUtils.OPER.MYTEL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.MYTEL.val%>">MYTEL</option>
                                                <option <%=telco.equals(SMSUtils.OPER.MPT.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.MPT.val%>">MPT</option>
                                                <option <%=telco.equals(SMSUtils.OPER.OOREDO.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.OOREDO.val%>">OOREDO</option>
                                                <option <%=telco.equals(SMSUtils.OPER.TELENOR.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.TELENOR.val%>">TELENOR</option>
                                                
                                                <option <%=telco.equals(SMSUtils.OPER.NATCOM.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.NATCOM.val%>">NATCOM</option>
                                                <option <%=telco.equals(SMSUtils.OPER.DIGICEL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.DIGICEL.val%>">DIGICEL</option>
                                                <option <%=telco.equals(SMSUtils.OPER.COMCEL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.COMCEL.val%>">COMCEL</option>
                                                
                                                <option <%=telco.equals(SMSUtils.OPER.LUMITEL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.LUMITEL.val%>">LUMITEL</option>
                                                <option <%=telco.equals(SMSUtils.OPER.AFRICELL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.AFRICELL.val%>">AFRICELL</option>
                                                <option <%=telco.equals(SMSUtils.OPER.LACELLSU.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.LACELLSU.val%>">LACELLSU</option>
                                                
                                                <option <%=telco.equals(SMSUtils.OPER.NEXTTEL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.NEXTTEL.val%>">NEXTTEL</option>
                                                <option <%=telco.equals(SMSUtils.OPER.MTN.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.MTN.val%>">MTN</option>
                                                <option <%=telco.equals(SMSUtils.OPER.ORANGE.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.ORANGE.val%>">ORANGE</option>
                                                
                                                <option <%=telco.equals(SMSUtils.OPER.HALOTEL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.HALOTEL.val%>">HALOTEL</option>
                                                <option <%=telco.equals(SMSUtils.OPER.VODACOM.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.VODACOM.val%>">VODACOM</option>
                                                <option <%=telco.equals(SMSUtils.OPER.ZANTEL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.ZANTEL.val%>">ZANTEL</option>
                                                
                                                <option <%=telco.equals(SMSUtils.OPER.BITEL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.BITEL.val%>">BITEL</option>
                                                <option <%=telco.equals(SMSUtils.OPER.CLARO.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.CLARO.val%>">CLARO</option>
                                                <option <%=telco.equals(SMSUtils.OPER.TELEFONIA.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.TELEFONIA.val%>">TELEFONIA</option>
                                            </select>
                                            <span class="redBold">Nhóm: </span>
                                            <select name="groupBr">
                                                <option value="">Chọn nhóm</option>
                                                <option <%= groupBr.equals("N9") ? "selected='selected'" : ""%> value="N0">Nhóm N0</option>
                                                <option <%= groupBr.equals("N1") ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%= groupBr.equals("N2") ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%= groupBr.equals("N3") ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                                <option <%= groupBr.equals("N4") ? "selected='selected'" : ""%> value="N4">Nhóm N4</option>
                                                <option <%= groupBr.equals("N5") ? "selected='selected'" : ""%> value="N5">Nhóm N5</option>
                                                <option <%= groupBr.equals("N6") ? "selected='selected'" : ""%> value="N6">Nhóm N6</option>
                                                <option <%= groupBr.equals("N7") ? "selected='selected'" : ""%> value="N7">Nhóm N7</option>
                                                <option <%= groupBr.equals("N8") ? "selected='selected'" : ""%> value="N8">Nhóm N8</option>
                                                <option <%= groupBr.equals("N9") ? "selected='selected'" : ""%> value="N9">Nhóm N9</option>
                                                <option <%= groupBr.equals("N9") ? "selected='selected'" : ""%> value="N10">Nhóm N10</option>
                                                <option <%= groupBr.equals("N9") ? "selected='selected'" : ""%> value="N11">Nhóm N11</option>
                                                <option <%= groupBr.equals("N9") ? "selected='selected'" : ""%> value="N12">Nhóm N12</option>
                                                <option <%= groupBr.equals("N9") ? "selected='selected'" : ""%> value="N13">Nhóm N13</option>
                                                <option <%= groupBr.equals("N9") ? "selected='selected'" : ""%> value="N14">Nhóm N14</option>
                                                <option <%= groupBr.equals("N9") ? "selected='selected'" : ""%> value="N15">Nhóm N15</option>
                                                <option <%= groupBr.equals("N9") ? "selected='selected'" : ""%> value="NNLC">Nhóm NNLC</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><span> Từ:</span></td>
                                        <td>
                                               
                                            <input readonly value="<%=stRequest%>" class="dateproc" size="8" id="stRequest" type="text" name="stRequest"/>
                                            &nbsp;&nbsp;&nbsp;<span class="redBold">Đến </span>
                                            <input readonly value="<%=endRequest%>" class="dateproc" size="8" id="endRequest" type="text" name="endRequest"/>
                                            &nbsp;&nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Nhà Cung Cấp:</td>
                                        <td>
                                            <select style="width: 300px" name="providerCode" id="_agentcy_id">
                                                <option value="">***** Chọn nhà cung cấp*****</option>
                                                <%
                                                    ArrayList<Provider> allpro = Provider.getCACHE();
                                                    for (Provider one : allpro) {
                                                        if(one.getStatus() != 1) continue;
                                                %>
                                                <option value="<%=one.getCode()%>" <%=(one.getCode().equals(providerCode)) ? "selected ='selected'" : ""%> 
                                                        img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" ><%=one.getName()%> <%= one.getStatus() == 1 ? "" : "[LOCK]"%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            Khách hàng 
                                            <select style="width: 400px" name="cpuser" id="_userSender">
                                                <option value="0">***** Tất cả *****</option>
                                                <%
                                                    ArrayList<Account> allCp = Account.getAllCP();
                                                    for (Account one : allCp) {
                                                %>
                                                <option <%=(one.getUserName().equals(cpuser) ? "selected='selected'" : "")%> 
                                                    value="<%=one.getUserName()%>" 
                                                    img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" > [<%=one.getUserName()%>] <%=one.getFullName()%> </option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="btnsearch" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;
                                            <%=buildAddControl(request, userlogin, "/admin/brand/addBrand.jsp")%>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <input onclick="window.open('<%=urlExport%>')" class="button" type="button" name="btnExport" value="Xuất Excel"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>      
                        <!--End tim kiếm-->
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%
                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <!--                        <div style="margin-left: 30px;margin-bottom: 10px">
                                                    <input onclick="delChoice()" class="button" type="button" name="delchoice" value="Xoá chọn"/>
                                                </div>-->
                        <%@include file="/admin/includes/page.jsp" %>
                        <!--Content-->
                        <form action="" name="mainForm" id="mainForm">
                            <!--<table align="center" class="display" id="_dataTable" summary="Msc Joint Stock Company" >-->
                            <table style="font-size: 11px" id="_dataTable" class="display" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded">STT</th>
                                        <th scope="col" class="rounded">Brand Name</th>
                                        <th scope="col" class="rounded">Tài khoản</th>
                                        <th scope="col" class="rounded">Định Tuyến</th>
                                        <th scope="col" class="rounded">Nhóm</th>
                                        <th scope="col" class="rounded">Create Date</th>
                                        <th scope="col" class="rounded">Create By</th>
                                        <th scope="col" class="rounded">Hồ sơ</th>
                                        <!--<th scope="col" class="rounded">Update By</th>-->
                                        <!--<th scope="col" class="rounded">Max SMS</th>--> 
                                        <th scope="col" class="rounded">Trạng thái</th>
                                            <%=buildHeader(request, userlogin, true, true)%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%      //Bien dung de dem so dong
                                        int count = 1;
                                        for (Iterator<BrandLabel> iter = allBrand.iterator(); iter.hasNext();) {
                                            BrandLabel oneBrand = iter.next();
                                            int tmp = (currentPage - 1) * maxRow + count++;

                                            OptionTelco opt = oneBrand.buildOption();
                                            OptionVina opt_vina;
                                            OptionCheckDuplicate opt_CheckDuplicateTelco;
                                            if (opt == null) {
                                                opt_vina = new OptionVina();
                                                opt_CheckDuplicateTelco = new OptionCheckDuplicate();
                                            } else {
                                                opt_vina = opt.getVinaphone();
                                                opt_CheckDuplicateTelco = opt.getCheckDuplicate();
                                            }
                                            String labelId = opt_vina.getLabelId();
                                            String tmpId = opt_vina.getTmpId();

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
                                            int checkDuplicateTimorTelecom = opt_CheckDuplicateTelco.getTimortelecom();
                                            
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
                                            int checkDuplicateTelefonia = opt_CheckDuplicateTelco.getTelefonical();   
                                    %>
                                    <tr>
                                        <td class="boder_right"><%=tmp%></td>
                                        <td class="boder_right" align="left">
                                            <b><%=oneBrand.getBrandLabel()%></b>
                                        </td>
                                        <td class="boder_right" align="left">
                                            <%
                                                String checkTempString = "";
                                                if(oneBrand.getCheckTemp()==1){
                                                    checkTempString = "(<b style='color:blue;'>Check Temp</b>)";
                                                }
                                            %>
                                            <%=oneBrand.getUserOwner()+checkTempString%>
                                            
                                        </td>
                                        <td class="boder_right" style="width: 180px" align="left">
                                            <%
                                                RouteTable route = oneBrand.getRoute();
                                            %>
                                            <SCRIPT language="javascript">
                                                function addDTGT(name) {
//                                                    for (let el of document.querySelectorAll('.dt'+name)) el.style.display = '';
                                                    document.getElementById('dt'+name).style.display = '';
                                                    document.getElementById('add'+name).style.display = 'none';
                                                    document.getElementById('del'+name).style.display = '';
                                                }

                                                function deleteDTGT(name) {
//                                                    for (let el of document.querySelectorAll('.dt'+name)) el.style.display = 'none';
                                                    document.getElementById('dt'+name).style.display = 'none';
                                                    document.getElementById('add'+name).style.display = '';
                                                    document.getElementById('del'+name).style.display = 'none';
                                                }                                                
                                            </SCRIPT>
                                                <div colspan="1" id="<%="add" + oneBrand.getBrandLabel() + oneBrand.getUserOwner()%>" align="center">
                                                    <img onclick="addDTGT('<%=oneBrand.getBrandLabel() + oneBrand.getUserOwner()%>')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/></a>
                                                </div>
                                                <div colspan="1" id="<%="del" + oneBrand.getBrandLabel() + oneBrand.getUserOwner()%>" style="display: none" align="center">
                                                    <img style="width: 16px;height: 16px;" onclick="deleteDTGT('<%=oneBrand.getBrandLabel() + oneBrand.getUserOwner()%>')" src="<%= request.getContextPath()%>/admin/resource/images/delete.jpg"/></a>
                                                </div>
                                            <div id="<%="dt" + oneBrand.getBrandLabel() + oneBrand.getUserOwner() %>" style="display: none">
                                                <% if (!route.getVte().getStt().equals("0")) { %>
                                                    <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 180px">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VIETTEL</div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getVte().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getVte().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getVte().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getVte().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateVte == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getVte().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getVte().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getVte().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getVte().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getMobi().getStt().equals("0")) { %>
                                                    <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 180px">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px;">MOBI</div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getMobi().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getMobi().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getMobi().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getMobi().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateVms == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getMobi().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getMobi().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getMobi().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getMobi().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getVina().getStt().equals("0")) { %>
                                                    <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 180px">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VINA</div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getVina().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getVina().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getVina().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getVina().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateGpc == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getVina().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getVina().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getVina().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getVina().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getVnm().getStt().equals("0")) { %>
                                                    <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 180px">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VN MOBI</div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getVnm().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getVnm().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getVnm().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getVnm().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateVnm == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getVnm().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getVnm().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getVnm().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getVnm().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getBl().getStt().equals("0")) { %>
                                                    <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 180px">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">BEELINE</div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getBl().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getBl().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getBl().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getBl().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateBl == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getBl().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getBl().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getBl().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getBl().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>   
                                                <% } %>
                                                <% if (!route.getDdg().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">ITELECOM</div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getDdg().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getDdg().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getDdg().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getDdg().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateDdg == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getDdg().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getDdg().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getDdg().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getDdg().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getCellcard().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">CELLCARD</div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getCellcard().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getCellcard().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getCellcard().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getCellcard().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateCellcard == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getCellcard().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getCellcard().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getCellcard().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getCellcard().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getMetfone().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">METFONE</div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getMetfone().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getMetfone().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getMetfone().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getMetfone().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateMetfone == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getMetfone().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getMetfone().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getMetfone().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getMetfone().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getBeelineCampuchia().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">BEELINE CAMPUCHIA</div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getBeelineCampuchia().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getBeelineCampuchia().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getBeelineCampuchia().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getBeelineCampuchia().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateBeelineCampuchia == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getBeelineCampuchia().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getBeelineCampuchia().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getBeelineCampuchia().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getBeelineCampuchia().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getSmart().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">SMART </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getSmart().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getSmart().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getSmart().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getSmart().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateSmart == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getSmart().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getSmart().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getSmart().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getSmart().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getQbmore().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">QBMORE </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getQbmore().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getQbmore().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getQbmore().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getQbmore().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateQbmore == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getQbmore().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getQbmore().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getQbmore().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getQbmore().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getExcell().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">EXCELL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getExcell().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getExcell().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getExcell().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getExcell().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateExcell == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getExcell().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getExcell().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getExcell().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getExcell().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getTelemor().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">TELEMOR </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getTelemor().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getTelemor().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getTelemor().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getTelemor().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateTelemor == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getTelemor().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getTelemor().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getTelemor().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getTelemor().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getTimortelecom().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">TIMORTELECOM </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getTimortelecom().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getTimortelecom().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getTimortelecom().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getTimortelecom().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateTimorTelecom == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getTimortelecom().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getTimortelecom().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getTimortelecom().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getTimortelecom().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getMovitel().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">MOVITEL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getMovitel().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getMovitel().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getMovitel().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getMovitel().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateMovitel == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getMovitel().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getMovitel().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getMovitel().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getMovitel().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getMcel().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">MCEL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getMcel().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getMcel().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getMcel().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getMcel().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateMcel == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getMcel().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getMcel().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getMcel().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getMcel().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getUnitel().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">UNITEL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getUnitel().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getUnitel().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getUnitel().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getUnitel().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateUnitel == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getUnitel().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getUnitel().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getUnitel().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getUnitel().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getEtl().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">ETL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getEtl().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getEtl().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getEtl().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getEtl().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateEtl == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getEtl().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getEtl().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getEtl().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getEtl().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getTango().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">TANGO </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getTango().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getTango().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getTango().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getTango().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateTango == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getTango().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getTango().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getTango().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getTango().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getLaotel().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">LAOTEL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getLaotel().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getLaotel().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getLaotel().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getLaotel().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateLaotel == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getLaotel().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getLaotel().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getLaotel().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getLaotel().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getMytel().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">MYTEL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getMytel().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getMytel().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getMytel().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getMytel().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateMytel == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getMytel().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getMytel().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getMytel().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getMytel().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getMpt().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">MPT </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getMpt().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getMpt().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getMpt().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getMpt().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateMpt == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getMpt().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getMpt().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getMpt().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getMpt().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getOoredo().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">OOREDO </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getOoredo().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getOoredo().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getOoredo().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getOoredo().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateOoredo == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getOoredo().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getOoredo().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getOoredo().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getOoredo().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getTelenor().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">TELENOR </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getTelenor().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getTelenor().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getTelenor().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getTelenor().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateTelenor == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getTelenor().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getTelenor().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getTelenor().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getTelenor().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getNatcom().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">NATCOM </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getNatcom().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getNatcom().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getNatcom().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getNatcom().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateNatcom == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getNatcom().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getNatcom().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getNatcom().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getNatcom().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getDigicel().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">DIGICEL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getDigicel().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getDigicel().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getDigicel().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getDigicel().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateDigicel == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getDigicel().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getDigicel().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getDigicel().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getDigicel().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getComcel().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">COMCEL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getComcel().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getComcel().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getComcel().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getComcel().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateComcel == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getComcel().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getComcel().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getComcel().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getComcel().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getLumitel().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">LUMITEL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getLumitel().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getLumitel().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getLumitel().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getLumitel().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateLumitel == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getLumitel().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getLumitel().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getLumitel().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getLumitel().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getAfricell().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">AFRICELL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getAfricell().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getAfricell().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getAfricell().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getAfricell().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateAfricell == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getAfricell().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getAfricell().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getAfricell().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getAfricell().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getLacellsu().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">LACELLSU </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getLacellsu().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getLacellsu().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getLacellsu().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getLacellsu().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateLacellsu == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getLacellsu().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getLacellsu().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getLacellsu().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getLacellsu().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getNexttel().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">NEXTTEL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getNexttel().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getNexttel().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getNexttel().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getNexttel().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateNexttel == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getNexttel().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getNexttel().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getNexttel().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getNexttel().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getMtn().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">MTN </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getMtn().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getMtn().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getMtn().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getMtn().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateMtn == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getMtn().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getMtn().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getMtn().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getMtn().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getOrange().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">ORANGE </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getOrange().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getOrange().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getOrange().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getOrange().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateOrange == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getOrange().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getOrange().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getOrange().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getOrange().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getHalotel().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">HALOTEL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getHalotel().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getHalotel().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getHalotel().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getHalotel().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateHalotel == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getHalotel().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getHalotel().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getHalotel().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getHalotel().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getVodacom().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VODACOM </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getVodacom().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getVodacom().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getVodacom().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getVodacom().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateVodacom == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getVodacom().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getVodacom().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getVodacom().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getVodacom().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getZantel().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">ZANTEL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getZantel().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getZantel().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getZantel().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getZantel().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateZantel == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getZantel().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getZantel().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getZantel().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getZantel().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getBitel().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">BITEL </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getBitel().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getBitel().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getBitel().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getBitel().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateBitel == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getBitel().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getBitel().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getBitel().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getBitel().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getClaro().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">CLARO </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getClaro().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getClaro().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getClaro().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getClaro().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateClaro == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getClaro().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getClaro().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getClaro().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getClaro().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                                <% if (!route.getTelefonia().getStt().equals("0")) { %>
                                                    <div style="float: left">
                                                        <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">TELEFONIA </div><br/>
                                                        <div style="float: left">
                                                            CSKH => <%=route.getTelefonia().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getTelefonia().getRoute_CSKH() + "</span>"%>
                                                            <br/>
                                                            QC => <%=route.getTelefonia().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: fuchsia;font-weight: bold'>" + route.getTelefonia().getRoute_QC() + "</span>"%>
                                                            <br/>
                                                            Chặn trùng => <%= checkDuplicateTelefonia == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
                                                            <br/>
                                                            Status => 
                                                            <%=route.getTelefonia().getStt().equals("0") ? "<span style='color: red;font-weight: bold'>Khóa</span>" : ""%>
                                                            <%=route.getTelefonia().getStt().equals("1") ? "<span style='color: red;font-weight: bold'>Kích hoạt</span>" : ""%>
                                                            <%=route.getTelefonia().getStt().equals("2") ? "<span style='color: red;font-weight: bold'>Chờ kích hoạt</span>" : ""%>
                                                            <%=route.getTelefonia().getStt().equals("3") ? "<span style='color: red;font-weight: bold'>Đang kích hoạt</span>" : ""%>
                                                        </div>
                                                    </div>
                                                <% } %>
                                            </div>
                                        </td>  
                                        <td class="boder_right">
                                            
                                            <% if (!route.getVte().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VIETTEL:</div>
                                                    <div style="float: left">
                                                        <%=route.getVte().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                            
                                            <% if (!route.getMobi().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">MOBI:</div>
                                                    <div style="float: left">
                                                        <%=route.getMobi().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                            
                                            <% if (!route.getVina().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VINA:</div>
                                                    <div style="float: left">
                                                        <%=route.getVina().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                            
                                            <% if (!route.getVnm().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VN MOBI:</div>
                                                    <div style="float: left">
                                                        <%=route.getVnm().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                            
                                            <% if (!route.getBl().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">BEELINE:</div>
                                                    <div style="float: left">
                                                        <%=route.getBl().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                            
                                            <% if (!route.getDdg().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">ITELECOM:</div>
                                                    <div style="float: left">
                                                        <%=route.getDdg().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %> 
                                                                                        
                                            <% if (!route.getCellcard().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">CELLCARD:</div>
                                                    <div style="float: left">
                                                        <%=route.getCellcard().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                               
                                            <% if (!route.getMetfone().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">METFONE:</div>
                                                    <div style="float: left">
                                                        <%=route.getMetfone().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                               
                                            <% if (!route.getBeelineCampuchia().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">BEELINE CAMPUCHIA:</div>
                                                    <div style="float: left">
                                                        <%=route.getBeelineCampuchia().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                               
                                            <% if (!route.getSmart().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">SMART:</div>
                                                    <div style="float: left">
                                                        <%=route.getSmart().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                               
                                            <% if (!route.getQbmore().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">QBMORE:</div>
                                                    <div style="float: left">
                                                        <%=route.getQbmore().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                               
                                            <% if (!route.getExcell().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">EXCELL:</div>
                                                    <div style="float: left">
                                                        <%=route.getExcell().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>   
                                                                                         
                                            <% if (!route.getTelemor().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">TELEMOR:</div>
                                                    <div style="float: left">
                                                        <%=route.getTelemor().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getTimortelecom().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">TIMOR TELECOM:</div>
                                                    <div style="float: left">
                                                        <%=route.getTimortelecom().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>   
                                                                                         
                                            <% if (!route.getMovitel().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">MOVITEL</div>
                                                    <div style="float: left">
                                                        <%=route.getMovitel().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getMcel().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">MCEL:</div>
                                                    <div style="float: left">
                                                        <%=route.getMcel().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>   
                                                                                         
                                            <% if (!route.getUnitel().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">UNITEL:</div>
                                                    <div style="float: left">
                                                        <%=route.getUnitel().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getEtl().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">ETL:</div>
                                                    <div style="float: left">
                                                        <%=route.getEtl().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getTango().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">TANGO:</div>
                                                    <div style="float: left">
                                                        <%=route.getTango().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getLaotel().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">LAOTEL:</div>
                                                    <div style="float: left">
                                                        <%=route.getLaotel().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>   
                                                                                         
                                            <% if (!route.getMytel().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">MYTEL:</div>
                                                    <div style="float: left">
                                                        <%=route.getMytel().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getMpt().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">MPT:</div>
                                                    <div style="float: left">
                                                        <%=route.getMpt().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getOoredo().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">OOREDO:</div>
                                                    <div style="float: left">
                                                        <%=route.getOoredo().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getTelenor().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">TELENOR:</div>
                                                    <div style="float: left">
                                                        <%=route.getTelenor().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>   
                                                                                         
                                            <% if (!route.getNatcom().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">NATCOM:</div>
                                                    <div style="float: left">
                                                        <%=route.getNatcom().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getDigicel().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">DIGICEL:</div>
                                                    <div style="float: left">
                                                        <%=route.getDigicel().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getComcel().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">COMCEL:</div>
                                                    <div style="float: left">
                                                        <%=route.getComcel().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>   
                                                                                         
                                            <% if (!route.getLumitel().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">LUMITEL:</div>
                                                    <div style="float: left">
                                                        <%=route.getLumitel().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getAfricell().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">AFRICELL:</div>
                                                    <div style="float: left">
                                                        <%=route.getAfricell().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getLacellsu().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">LACELLSU:</div>
                                                    <div style="float: left">
                                                        <%=route.getLacellsu().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>   
                                                                                         
                                            <% if (!route.getNexttel().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">NEXTTEL:</div>
                                                    <div style="float: left">
                                                        <%=route.getNexttel().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getMtn().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">MTN:</div>
                                                    <div style="float: left">
                                                        <%=route.getMtn().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getOrange().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">ORANGE:</div>
                                                    <div style="float: left">
                                                        <%=route.getOrange().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>   
                                                                                         
                                            <% if (!route.getHalotel().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">HALOTEL:</div>
                                                    <div style="float: left">
                                                        <%=route.getHalotel().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getVodacom().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VODACOM:</div>
                                                    <div style="float: left">
                                                        <%=route.getVodacom().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getZantel().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">ZANTEL:</div>
                                                    <div style="float: left">
                                                        <%=route.getZantel().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>   
                                                                                         
                                            <% if (!route.getBitel().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">BITEL:</div>
                                                    <div style="float: left">
                                                        <%=route.getBitel().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getClaro().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">CLARO:</div>
                                                    <div style="float: left">
                                                        <%=route.getClaro().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>                                                
                                            <% if (!route.getTelefonia().getStt().equals("0")) { %>
                                                <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">TELEFONIA:</div>
                                                    <div style="float: left">
                                                        <%=route.getTelefonia().getGroup()%>
                                                    </div>
                                                </div>
                                            <% } %>   
                                        </td>
                                        <td class="boder_right" align="center">
                                            <%=oneBrand.getCreateDate()%>
                                        </td>
                                        <td class="boder_right"><%=Account.getNameById(oneBrand.getCreateBy())%></td>
                                        <td class="boder_right" align="center">
                                            <a href="addDocument.jsp?bid=<%=oneBrand.getId()%>">
                                                <img src="<%=webPath%>/resources/images/preview.png" title="Xem File Hồ sơ" alt="Xem"/>
                                            </a>
                                            <%=oneBrand.checkHasFile() ? "<b style='color:blue'>Có</b>" : "<b style='color:red'>Không</b>"%>
                                        </td>
                                        <td class="boder_right" align="center">
                                            <%if (oneBrand.getStatus() == 1) {%>
                                            <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                            <%} else if (oneBrand.getStatus() == Tool.STATUS.DEL.val) {
                                            %> <img width="16" src="<%= request.getContextPath()%>/admin/resource/images/shutdown.png"/><%
                                            } else {%>
                                            <img width="32" src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                            <%}%>
                                        </td>
                                        <%=buildControl(request, userlogin,
                                                "/admin/brand/editBrand.jsp?id=" + oneBrand.getId(),
                                                (oneBrand.getStatus() == 404) ? "/admin/brand/del_ever.jsp?id=" + oneBrand.getId() : "/admin/brand/delBrand.jsp?id=" + oneBrand.getId())%>
                                    </tr>
                                    <%}%>
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