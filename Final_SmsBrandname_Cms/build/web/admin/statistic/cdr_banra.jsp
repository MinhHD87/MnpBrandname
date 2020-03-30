<%@page import="gk.myname.vn.entity.CDRSubmit"%>
<%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script type="text/javascript" language="javascript">
//            $.noConflict();
            $(document).ready(function () {
                $('#example').DataTable({
                    "order": [[3, "desc"]],
                    "bPaginate": false,
                    "bLengthChange": false,
                    "bFilter": true,
                    "bInfo": false,
                    "bAutoWidth": false
                });
            });
            $(document).ready(function () {
                $('.dateproc').datetimepicker({
                    lang: 'vi',
                    timepicker: false,
                    format: 'd/m/Y',
                    formatDate: 'Y/m/d',
                    minDate: '2017/01/01', // yesterday is minimum date
                    maxDate: '+1970/01/02' // and tommorow is maximum date calendar
                });
            });
            //------
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
                    if (arrstRequest[1] !== arrendRequest[1]) {
                        jAlert("Bạn chỉ thống kê được dữ liệu từng tháng...");
                        return false;
                    }
                    if (arrstRequest[2] !== arrendRequest[2]) {
                        jAlert("Năm bạn chọn không hợp lệ...");
                        return false;
                    }
                }
            }
            
            function changeBrand() {
                var selectBr = $("#_label option:selected");
                if (selectBr.val() !== "") {                    
                    document.getElementById('_agentcy_id').disabled = true;
                    document.getElementById('_userSender').disabled = true;
                    var user = selectBr.attr("user_owner");
                    $("#_userSender").select2('val', user);
                } else {
                    document.getElementById('_agentcy_id').disabled = false;
                    document.getElementById('_userSender').disabled = false;
                    var user = selectBr.attr("user_owner");
                    $("#_userSender").select2('val', user);
                }
            }
            
            function changeKH() {                
                var selectBr = $("#_userSender option:selected");
                if (selectBr.val() !== "") {   
                    document.getElementById('_agentcy_id').disabled = true;
                    document.getElementById('_label').disabled = true;
                } else {                    
                    document.getElementById('_agentcy_id').disabled = false;
                    document.getElementById('_label').disabled = false;
                }                 
            }
            
            function changeDL() {                
                var selectBr = $("#_agentcy_id option:selected");
                if (selectBr.val() !== "") {   
                    document.getElementById('_userSender').disabled = true;
                    document.getElementById('_label').disabled = true;
                } else {                    
                    document.getElementById('_userSender').disabled = false;
                    document.getElementById('_label').disabled = false;
                }                 
            }
            function changeCP() {
                var selectBr = $("#_userSender option:selected");
                var user = selectBr.val();
                if (user !== "") {
                    var url = "/admin/statistic/ajax/listBrand.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_label");
                } else {
                    var url = "/admin/statistic/ajax/listBrand.jsp?user=user";
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_label");
                }
                $("#_label").select2("val", "");
            }
        </script>
    </head>
    <body>
        <%  
            //-
            CDRSubmit dao = new CDRSubmit();
            int type = RequestTool.getInt(request, "type", -1);
            int labelId = RequestTool.getInt(request, "_label");
            BrandLabel brLabel = BrandLabel.getFromCache(labelId);
            //--
            String label = "";
            if (brLabel != null) {
                label = brLabel.getBrandLabel();
            }
            String result = RequestTool.getString(request, "result");
            String oper = RequestTool.getString(request, "oper");
            String groupBr = RequestTool.getString(request, "groupBr");
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
            ArrayList<CDRSubmit> allLog = dao.statisticSale(userSender, cp_code, label, type,  stRequest, endRequest, oper, result, groupBr);
            String urlExport = request.getContextPath() + "/admin/statistic/exp/exp_CDR_ban.jsp?";
            String dataGet = "";
            dataGet += "type=" + type;
            dataGet += "&_label=" + label;
            dataGet += "&oper=" + oper;
            dataGet += "&groupBr=" + groupBr;
            dataGet += "&stRequest=" + stRequest;
            dataGet += "&endRequest=" + endRequest;
            dataGet += "&result=" + result;
            dataGet += "&cp_code=" + cp_code;
            dataGet += "&userSender=" + userSender;

            urlExport += dataGet;
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <!-- Tìm kiếm-->
                        <form onsubmit="return  validMonth();" action="<%=request.getContextPath() + "/admin/statistic/cdr_banra.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Thống kê CDR BÁN RA</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Từ ngày:</td>
                                        <td> 
                                            &nbsp;<span class="redBold"> </span>
                                            <input value="<%=stRequest%>" id="stRequest" class="dateproc" size="8" type="text" name="stRequest"/>
                                            &nbsp;<span class="redBold">Đến ngày </span>
                                            <input value="<%=endRequest%>" id="endRequest" class="dateproc" size="8" type="text" name="endRequest"/>
                                            &nbsp;
                                            Loại tin
                                            <select name="type">
                                                <option <%=type == -1 ? "selected='selected'" : ""%> value="-1">Tất cả</option>
                                                <option <%=type == 0 ? "selected='selected'" : ""%> value="0">Tin CSKH</option>
                                                <option <%=type == 1 ? "selected='selected'" : ""%> value="1">Tin QC</option>
                                            </select>
                                            &nbsp;
                                            <span class="redBold">Kết Quả </span>
                                            <select name="result">
                                                <option value="">=Tất Cả=</option>
                                                <option <%= groupBr.equals("1") ? "selected='selected'" : ""%> value="1">Thành Công</option>
                                                <option <%= groupBr.equals("0") ? "selected='selected'" : ""%> value="0">Thất bại</option>
                                            </select>
                                            &nbsp;
                                            <span class="redBold">Nhóm </span>
                                            <select name="groupBr">
                                                <option value="">-Tất Cả-</option>
                                                <option <%= groupBr.equals("N1") ? "selected='selected'" : ""%> value="N1">Nhóm N1</option>
                                                <option <%= groupBr.equals("N2") ? "selected='selected'" : ""%> value="N2">Nhóm N2</option>
                                                <option <%= groupBr.equals("N3") ? "selected='selected'" : ""%> value="N3">Nhóm N3</option>
                                                <option <%= groupBr.equals("N4") ? "selected='selected'" : ""%> value="N4">Nhóm N4</option>
                                                <option <%= groupBr.equals("N5") ? "selected='selected'" : ""%> value="N5">Nhóm N5</option>
                                                <option <%= groupBr.equals("N6") ? "selected='selected'" : ""%> value="N6">Nhóm N6</option>
                                                <option <%= groupBr.equals("N7") ? "selected='selected'" : ""%> value="N7">Nhóm N7</option>
                                                <option <%= groupBr.equals("N8") ? "selected='selected'" : ""%> value="N8">Nhóm N8</option>
                                                <option <%= groupBr.equals("N9") ? "selected='selected'" : ""%> value="N9">Nhóm N9</option>
                                            </select>
                                            &nbsp;
                                            Telco
                                            <select name="oper">
                                                <option value="">+Tất cả+</option>
                                                <option <%= oper.equalsIgnoreCase("VMS") ? "selected='selected'" : ""%> value="VMS">MOBI</option>
                                                <option <%= oper.equalsIgnoreCase("GPC") ? "selected='selected'" : ""%> value="GPC">VINA PHONE</option>
                                                <option <%= oper.equalsIgnoreCase("VTE") ? "selected='selected'" : ""%> value="VTE">VIETTEL</option>
                                                <option <%= oper.equalsIgnoreCase("VNM") ? "selected='selected'" : ""%> value="VNM">VN MOBI</option>
                                                <option <%= oper.equalsIgnoreCase("BL") ? "selected='selected'" : ""%> value="BL">GTEL</option>
                                                <option <%= oper.equalsIgnoreCase("DDG") ? "selected='selected'" : ""%> value="DDG">ITELECOM</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Nhãn gửi tin</td>
                                        <td>
                                            <select onchange="changeBrand()" style="width: 180px" id="_label" name="_label">
                                                <option brand_id="" user_owner="" value="" img-data="">Tất cả</option>
                                                <%
                                                    ArrayList<BrandLabel> allLabel = BrandLabel.getAll();
                                                    for (BrandLabel one : allLabel) {
                                                %>
                                                <option user_owner="<%=one.getUserOwner()%>" 
                                                        <%=(label.equals(one.getBrandLabel()) && one.getUserOwner().equals(userSender)) ? "selected='selected'" : ""%> 
                                                        value="<%=one.getId()%>"
                                                        img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >
                                                    <%=one.getBrandLabel()%> [<%=one.getUserOwner()%>]
                                                </option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;
                                            Đại lý:
                                            <%
                                                ArrayList<PartnerManager> allAgentCy = PartnerManager.getAllCache();
                                                if (allAgentCy != null && !allAgentCy.isEmpty()) {
                                            %>
                                            <select onchange="changeDL()" style="width: 450px" id="_agentcy_id" name="cp_code">
                                                <option value="">******** Tất cả ********</option>
                                                <%
                                                    for (PartnerManager onePartner : allAgentCy) {
                                                        if (!Tool.checkNull(onePartner.getCode())) {
                                                %>
                                                <option <%=(cp_code.equals(onePartner.getCode())) ? "selected ='selected'" : ""%> 
                                                    value="<%=onePartner.getCode()%>"
                                                    img-data="<%=(onePartner.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=onePartner.getCode()%>] <%=onePartner.getName()%></option>
                                                <%}
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Khách Hàng</td>
                                        <td>
                                            <%
                                                ArrayList<Account> allCp = Account.getAllCP();
                                                if (allCp != null && !allCp.isEmpty()) {
                                            %>
                                            <select style="width: 420px" onchange="changeKH()" id="_userSender" name="userSender">
                                                <option value="">--- Tất cả ---</option>
                                                <%
                                                    for (Account oneAcc : allCp) {
                                                %>
                                                <option <%=(oneAcc.getUserName().equals(userSender)) ? "selected ='selected'" : ""%>
                                                    value="<%=oneAcc.getUserName()%>"
                                                    img-data="<%=(oneAcc.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=oneAcc.getUserName()%>] <%=oneAcc.getFullName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <%
                                                }
                                            %>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Thống kê"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <input onclick="window.open('<%=urlExport%>')" class="button" type="button" name="button" value="Xuất Excel"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>      
                        <!--End tim kiếm-->
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <!--Content-->
                        <!--<table align="center" id="example" class="display" summary="Msc Joint Stock Company" >-->
                        <table id="example" class="display" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company Bold"><b>STT</b></th>
                                    <th scope="col" class="rounded Bold"><b>User Sender</b></th>
                                    <th scope="col" class="rounded Bold"><b>Brand Name</b></th>
                                    <th scope="col" class="rounded Bold"><b>Nhà mạng</b></th>
                                    <th scope="col" class="rounded Bold"><b>Tổng tin nhắn</b></th>
                                    <th scope="col" class="rounded Bold"><b>Nhóm tin</b></th>
                                    <th scope="col" class="rounded Bold"><b>Kết quả gửi</b></th> 
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    int total = 0;
                                    for (Iterator<CDRSubmit> iter = allLog.iterator(); iter.hasNext();) {
                                        CDRSubmit oneBrand = iter.next();
                                        if (oneBrand.getResult()==1) {
                                            total += oneBrand.getTotalMsg();
                                        }
                                %>
                                <tr>
                                    <td class="boder_right boder_left"><%=count++%></td>
                                    <td class="boder_right boder_left"><%=oneBrand.getUser()%></td>
                                    <td class="boder_right" align="left">
                                        <%=oneBrand.getLabel()%>
                                    </td>
                                    <td class="boder_right" align="center">
                                        <%=oneBrand.getOper()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneBrand.getTotalMsg()%>
                                    </td>
                                    <td class="boder_right" align="center"><%=oneBrand.getBrGroup()%></td>
                                    <td class="boder_right" align="left"><span class="redBold"><%=oneBrand.getResult()==1?"Success":"Failed"%></span></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                        <table id="rounded-corner">
                            <tr>
                                <td class="boder_right" colspan="3" style="font-weight: bold;color: blue;width: 352px">Tổng MT thành công</td>
                                <td colspan="5" style="font-weight: bold;color: blue" align="left"><%=total%></td>
                            </tr>
                        </table>
                    </div><!-- end of right content-->
                </div>   <!--end of center content -->
                <div class="clear"></div>
            </div> <!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html>