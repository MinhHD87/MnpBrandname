<%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.entity.MsgBrandSubmit"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head><% session.setAttribute("title", "Thống kê Submit SMS BRAND cms.brand1.xyz"); %>
        <%@include file="/admin/includes/header.jsp" %>       
        <script type="text/javascript" language="javascript">
            $(document).ready(function () {
                $('#dataTable').DataTable({
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
            //--
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
                var user = selectBr.attr("user_owner");
                if (selectBr.val() !== "") {                    
                    document.getElementById('_agentcy_id').disabled = true;
                    document.getElementById('_userSender').disabled = true;
                    $("#_userSender").select2('val', user);
                } else {
                    document.getElementById('_agentcy_id').disabled = false;
                    document.getElementById('_userSender').disabled = false;
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
                window.console.log(selectBr.val());
            }
            
            function changeCP() {
                var selectBr = $("#_userSender option:selected");
                var user = selectBr.val();
                if (user !== "") {
                    var url = "/admin/statistic/ajax/listBrand.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_label");
                } else {
                    var url = "/admin/statistic/ajax/listBrand.jsp?user=0";
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
            ArrayList<MsgBrandSubmit> allLog = null;
            MsgBrandSubmit smDao = new MsgBrandSubmit();
            int type = RequestTool.getInt(request, "type", 0);
            int bid = RequestTool.getInt(request, "_label");
            BrandLabel brLabel = BrandLabel.getFromCache(bid);
            //--
            String label = "";
            if (brLabel != null) {
                label = brLabel.getBrandLabel();
            }
            int result = RequestTool.getInt(request, "result", 0);
            String oper = RequestTool.getString(request, "oper");
            String provider = RequestTool.getString(request, "provider");
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
            allLog = smDao.statisticSubm(userSender, cp_code, label, type, provider, stRequest, endRequest, oper, result, groupBr);
            String urlExport = request.getContextPath() + "/admin/statistic/exp/export_tk_submit.jsp?";
            urlExport += "type=" + type;
            urlExport += "&_label=" + label;
            urlExport += "&result=" + result;
            urlExport += "&oper=" + oper;
            urlExport += "&provider=" + provider;
            urlExport += "&groupBr=" + groupBr;
            urlExport += "&stRequest=" + stRequest;
            urlExport += "&endRequest=" + endRequest;
            urlExport += "&cp_code=" + cp_code;
            urlExport += "&userSender=" + userSender;
            
            String urlExport2 = request.getContextPath() + "/admin/statistic/exp/export_baocao.jsp?";
            urlExport2 += "type=" + type;
            urlExport2 += "&_label=" + label;
            urlExport2 += "&result=" + result;
            urlExport2 += "&oper=" + oper;
            urlExport2 += "&provider=" + provider;
            urlExport2 += "&groupBr=" + groupBr;
            urlExport2 += "&stRequest=" + stRequest;
            urlExport2 += "&endRequest=" + endRequest;
            urlExport2 += "&cp_code=" + cp_code;
            urlExport2 += "&userSender=" + userSender;
            
            String urlExport3 = request.getContextPath() + "/admin/statistic/exp/export_doanhthu.jsp?";
            urlExport3 += "type=" + type;
            urlExport3 += "&_label=" + label;
            urlExport3 += "&result=" + result;
            urlExport3 += "&oper=" + oper;
            urlExport3 += "&provider=" + provider;
            urlExport3 += "&groupBr=" + groupBr;
            urlExport3 += "&stRequest=" + stRequest;
            urlExport3 += "&endRequest=" + endRequest;
            urlExport3 += "&cp_code=" + cp_code;
            urlExport3 += "&userSender=" + userSender;

        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <!-- Tìm kiếm-->
                        <form onsubmit="return  validMonth();" action="<%=request.getContextPath() + "/admin/statistic/thongke_submit.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Thống kê Log Submit</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Từ ngày:</td>
                                        <td> 
                                            <input value="<%=stRequest%>" id="stRequest" class="dateproc" size="8" type="text" name="stRequest"/>
                                            &nbsp;&nbsp;<span class="redBold">Đến </span>
                                            <input value="<%=endRequest%>" id="endRequest" class="dateproc" size="8" type="text" name="endRequest"/>
                                            &nbsp;&nbsp;
                                            Loại
                                            <select id="type" name="type">
                                                <option <%=type == -1 ? "selected='selected'" : ""%> value="-1">Tất cả</option>
                                                <option <%=type == 0 ? "selected='selected'" : ""%> value="0">Tin CSKH</option>
                                                <option <%=type == 1 ? "selected='selected'" : ""%> value="1">Tin QC</option>
                                            </select>
                                            &nbsp;&nbsp;
                                            <span class="redBold">Kết Quả </span>
                                            <select id="result" name="result">
                                                <option value="">= Tất Cả =</option>
                                                <option <%=result == 1 ? "selected='selected'" : ""%> value="1">Thành Công</option>
                                                <option <%=result == -1 ? "selected='selected'" : ""%> value="-1">Thất bại</option>
                                            </select>
                                            &nbsp;&nbsp;
                                            Telco
                                            <select id="oper" name="oper">
                                                <option value="">+ Tất cả +</option>
                                                <option <%= oper.equalsIgnoreCase("VMS") ? "selected='selected'" : ""%> value="VMS">MOBI</option>
                                                <option <%= oper.equalsIgnoreCase("GPC") ? "selected='selected'" : ""%> value="GPC">VINA PHONE</option>
                                                <option <%= oper.equalsIgnoreCase("VTE") ? "selected='selected'" : ""%> value="VTE">VIETTEL</option>
                                                <option <%= oper.equalsIgnoreCase("VNM") ? "selected='selected'" : ""%> value="VNM">VIETNAM MOBI</option>
                                                <option <%= oper.equalsIgnoreCase("BL") ? "selected='selected'" : ""%> value="BL">GTEL</option>
                                                <option <%= oper.equalsIgnoreCase("DDG") ? "selected='selected'" : ""%> value="DDG">ITELECOM</option>
                                            </select>
                                            &nbsp;&nbsp;
                                            <span class="redBold">Nhóm: </span>
                                            <select id="groupBr" name="groupBr">
                                                <option value="">Chọn nhóm</option>
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
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Nhãn gửi</td>
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
                                            <select onchange="changeDL()" style="width: 520px" id="_agentcy_id" name="cp_code">
                                                <option value="" >******** Tất cả ********</option>
                                                <%
                                                    for (PartnerManager onePartner : allAgentCy) {
                                                        if (!Tool.checkNull(onePartner.getCode())) {
                                                %>
                                                <option <%=(cp_code.equals(onePartner.getCode())) ? "selected ='selected'" : ""%> 
                                                    value="<%=onePartner.getCode()%>"
                                                    img-data="<%=(onePartner.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=onePartner.getCode()%>] <%=onePartner.getName()%></option>
                                                <% }
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Tài khoản</td>
                                        <td>
                                            <%
                                                ArrayList<Account> allCp = Account.getAllCP();
                                                if (allCp != null && !allCp.isEmpty()) {
                                            %>
                                            <select onchange="changeKH()" style="width: 400px" id="_userSender" name="userSender">
                                                <option value="" >--- Tất cả ---</option>
                                                <%
                                                    for (Account oneAcc : allCp) {
                                                %>
                                                <option <%=(userSender.equals(oneAcc.getUserName())) ? "selected ='selected'" : ""%> 
                                                    value="<%=oneAcc.getUserName()%>" 
                                                    img-data="<%=(oneAcc.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >
                                                    [<%=oneAcc.getUserName()%>] <%=oneAcc.getFullName()%> 
                                                </option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <%
                                                }
                                            %>
                                            <%
                                                ArrayList<Provider> allPrv = Provider.getALL();
                                                if (allPrv != null && !allPrv.isEmpty()) {
                                            %>
                                            &nbsp;&nbsp;
                                            Hướng
                                            <select onchange="changeDL()" id="provider" name="provider">
                                                <option value="">--- Tất cả ---</option>
                                                <%
                                                    for (Provider one : allPrv) {
                                                %>
                                                <option <%=(provider.equals(one.getCode())) ? "selected ='selected'" : ""%> value="<%=one.getCode()%>"><%=one.getName()%></option>
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
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <input onclick="window.open('<%=urlExport2%>')" class="button" type="button" name="button" value="Xuất Báo cáo"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <input class="button" id="xdthu" type="button" name="xdthu" value="Xuất Doanh Thu"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <input class="button" id="btnDS" type="button" name="exDs" value="Xuất Đối soát"/>
                                        </td>
<script type="text/javascript" language="javascript">
        $(function () {
            $("#xdthu").click(function () {
                var choiceAgen = $("select#_agentcy_id").children("option:selected").val();
                var d = new Date();
                var cMonth = d.getMonth() + 1;
                var cYear = d.getYear() + 1900;
                var stRequest = $("#stRequest").val();
                var endRequest = $("#endRequest").val();
                var arrstRequest = stRequest.split("/");
                var arrendRequest = endRequest.split("/");
                var urlOrg = $(location).attr('origin');
                var uri = $(location).attr('pathname');
                var arrUri = uri.split('/');
                var conTextPath = arrUri[1];
                if (choiceAgen === "") {
                    jAlert("Hãy chọn đại lý để xuất doanh thu");
                    return false;
                } else if (choiceAgen !== "") {
                    if (stRequest !== "" && stRequest !== null) {
                        if (endRequest === "" || endRequest === null) {
                            jAlert("Bạn cần chọn ngày kết thúc...");
                            return false;
                        } else if (arrstRequest[1] !== arrendRequest[1]) {
                            jAlert("Bạn chỉ thống kê được dữ liệu từng tháng...");
                            return false;
                        } else if (arrstRequest[2] !== arrendRequest[2]) {
                            jAlert("Năm bạn chọn không hợp lệ...");
                            return false;
                        } else if ((arrstRequest[1] >= cMonth || arrendRequest[1] >= cMonth) && (arrstRequest[2] >= cYear || arrendRequest[2] >= cYear)) {
                            jAlert("Tháng xuất doanh thu phải nhỏ hơn tháng hiện tại");
                            return false;
                        } else if (arrstRequest[2] > cYear || arrendRequest[2] > cYear) {
                            jAlert("Năm xuất doanh thu phải nhỏ hoặc bằng năm hiện tại");
                            return false;
                        } else {
                            var startD = "01";
                            var endD = "";
                            switch (arrstRequest[1]) {
                                case "01":
                                case "03":
                                case "05":
                                case "07":
                                case "08":
                                case "10":
                                case "12":
                                    endD = "31";
                                    break;
                                case "04":
                                case "06":
                                case "09":
                                case "11":
                                    endD = "30";
                                    break;
                                case "02":
                                {
                                    if (parseInt(arrstRequest[2]) % 4 === 0) {
                                        endD = "29";
                                        break;
                                    } else {
                                        endD = "28";
                                        break;
                                    }
                                }
                            }
                            var urlExportDS = urlOrg + "/" + conTextPath + "/admin/statistic/exp/export_doanhthu.jsp?";
                            urlExportDS += "type=" + $("select#type").children("option:selected").val();
                            urlExportDS += "&_label=" + $("select#_label").children("option:selected").val();
                            urlExportDS += "&result=" + $("select#result").children("option:selected").val();
                            urlExportDS += "&oper=" + $("select#oper").children("option:selected").val();
                            urlExportDS += "&provider=" + $("select#provider").children("option:selected").val();
                            urlExportDS += "&groupBr=" + $("select#groupBr").children("option:selected").val();
                            urlExportDS += "&stRequest=" + startD + "/" + arrstRequest[1] + "/" + arrstRequest[2];
                            urlExportDS += "&endRequest=" + endD + "/" + arrstRequest[1] + "/" + arrstRequest[2];
                            urlExportDS += "&cp_code=" + $("select#_agentcy_id").children("option:selected").val();
                            urlExportDS += "&userSender=" + $("select#_userSender").children("option:selected").val();
                            
                            window.open(urlExportDS);
                        }
                    }
                } 
            });
        });
    </script>
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
                        <table align="center" id="dataTable" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company">STT</th>
                                    <th scope="col" class="rounded">CP CODE</th>
                                    <th scope="col" class="rounded">Brand Name</th>
                                    <th scope="col" class="rounded">Nhà mạng</th>
                                    <th scope="col" class="rounded">Tổng tin</th>
                                    <th scope="col" class="rounded">Kết quả</th> 
                                    <th scope="col" class="rounded">Loại tin</th>
                                    <th scope="col" class="rounded">Hướng gửi</th>
                                    <th scope="col" class="rounded">Nhóm</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    int total = 0;
                                    for (Iterator<MsgBrandSubmit> iter = allLog.iterator(); iter.hasNext();) {
                                        MsgBrandSubmit oneBrand = iter.next();
                                        if (oneBrand.getResult() == 1) {
                                            total += oneBrand.getTotalSms();
                                        }
                                %>
                                <tr>
                                    <td class="boder_right boder_left"><%=count++%></td>
                                    <td class="boder_right" align="left">
                                        <%=oneBrand.getCpCode()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneBrand.getLabel()%>
                                    </td>
                                    <td class="boder_right" align="center">
                                        <%=oneBrand.getOper()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneBrand.getTotalSms()%>
                                    </td>
                                    <td class="boder_right" align="left"><span class="redBold"><%=oneBrand.getResult()%></span> &nbsp;(<%=oneBrand.getResult() == 1 ? "SUCCESS" : "ERROR"%>)</td>
                                    <td class="boder_right" align="center"><%=getType(oneBrand.getType())%></td>
                                    <td class="boder_right" align="left"><%=oneBrand.getSendTo()%></td>
                                    <td align="center"><%=oneBrand.getBrGroup()%></td>
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
    <script type="text/javascript" language="javascript">
        $(function () {
            //doan code xu ly xuat doi soat bang JS
            //Lay ra cac tham so, url, ngay thang sau do xu ly
            //Ngay se duoc lay tu ngay dau thang den ngay cuoi thang

            $("#btnDS").click(function () {
                var choiceAcc = $("select#_userSender").children("option:selected").val();
                var choiceAgen = $("select#_agentcy_id").children("option:selected").val();
                var choiceLB = $("select#_label").children("option:selected").val();
                var d = new Date();
                var cMonth = d.getMonth() + 1;
                var cYear = d.getYear() + 1900;
                var stRequest = $("#stRequest").val();
                var endRequest = $("#endRequest").val();
                var arrstRequest = stRequest.split("/");
                var arrendRequest = endRequest.split("/");
                //Lấy url
                var urlOrg = $(location).attr('origin');
                var uri = $(location).attr('pathname');
                var arrUri = uri.split('/');
                //Lấy Context path
                var conTextPath = arrUri[1];


                //Chỉ xuất ds cho đại lý hoặc user, vì đại lý có nhiều user nên sẽ xuất tất cả tin của các user 
                // thuộc đại lý ấy
                //Chọn đại lý và chọn user giống hệt nhau chỉ khác chọn đại lý vẫn kèm theo giá trị user
                if (choiceAcc === "" && choiceAgen === "") {
                    jAlert("Hãy chọn tài khoản hoặc đại lý để xuất đối soát (không chọn cả 2)");
                } else if (choiceAcc !== "" && choiceAgen !== "") {
                    jAlert("Hãy chọn tài khoản hoặc đại lý để xuất đối soát (không chọn cả 2)");
                } else if (choiceLB !== "") {

                    jAlert("Không chọn nhãn gửi - Hãy chọn tài khoản hoặc đại lý để xuất đối soát");
                } else if (choiceAcc === "" && choiceAgen !== "") {
                    //CHọn đại lý không chọn user
                    if (stRequest !== "" && stRequest !== null) {
                        if (endRequest === "" || endRequest === null) {
                            jAlert("Bạn cần chọn ngày kết thúc...");
                            return false;
                        } else if (arrstRequest[1] !== arrendRequest[1]) {
                            jAlert("Bạn chỉ thống kê được dữ liệu từng tháng...");
                            return false;
                        } else if (arrstRequest[2] !== arrendRequest[2]) {
                            jAlert("Năm bạn chọn không hợp lệ...");
                            return false;
                        } else if ((arrstRequest[1] >= cMonth || arrendRequest[1] >= cMonth) && (arrstRequest[2] >= cYear || arrendRequest[2] >= cYear)) {
                            jAlert("Tháng xuất đối soát phải nhỏ hơn tháng hiện tại");
                            return false;

                        } else if (arrstRequest[2] > cYear || arrendRequest[2] > cYear) {
                            jAlert("Năm xuất đối soát phải nhỏ hoặc bằng năm hiện tại");
                            return false;

                        } else {
                            //Lay ngay dau va cuoi thang
                            var startD = "01";
                            var endD = "";
                            switch (arrstRequest[1]) {
                                case "01":
                                case "03":
                                case "05":
                                case "07":
                                case "08":
                                case "10":
                                case "12":
                                    endD = "31";
                                    break;
                                case "04":
                                case "06":
                                case "09":
                                case "11":
                                    endD = "30";
                                    break;
                                case "02":
                                {
                                    if (parseInt(arrstRequest[2]) % 4 == 0) {
                                        endD = "29";
                                        break;
                                    } else {
                                        endD = "28";
                                        break;
                                    }
                                }
                            }

                            var urlExportDS = urlOrg + "/" + conTextPath + "/admin/statistic/exp/exportds_tk_submit.jsp?";
                            urlExportDS += "type=" + $("select#type").children("option:selected").val();
                            urlExportDS += "&result=" + $("select#result").children("option:selected").val();
                            urlExportDS += "&oper=" + $("select#oper").children("option:selected").val();
                            urlExportDS += "&groupBr=" + $("select#groupBr").children("option:selected").val();
                            urlExportDS += "&stRequest=" + startD + "/" + arrstRequest[1] + "/" + arrstRequest[2];
                            urlExportDS += "&endRequest=" + endD + "/" + arrstRequest[1] + "/" + arrstRequest[2];
                            urlExportDS += "&cp_code=" + $("select#_agentcy_id").children("option:selected").val();
                            urlExportDS += "&userSender=" + $("select#_userSender").children("option:selected").val();

//                            alert(urlExportDS);
//                            var cf = confirm("Đối soát sẽ được xuất từ ngày đầu tháng đến ngày cuối tháng bạn chọn. Bạn chắc chắn xuất đối soát?");
//                            if (cf == true) {
                                window.open(urlExportDS);
//                            }
                        }
                    }
                } else {
                    //CHọn user không chọn đại lý
                    if (stRequest !== "" && stRequest !== null) {
                        if (endRequest === "" || endRequest === null) {
                            jAlert("Bạn cần chọn ngày kết thúc...");
                            return false;
                        } else if (arrstRequest[1] !== arrendRequest[1]) {
                            jAlert("Bạn chỉ thống kê được dữ liệu từng tháng...");
                            return false;
                        } else if (arrstRequest[2] !== arrendRequest[2]) {
                            jAlert("Năm bạn chọn không hợp lệ...");
                            return false;
                        } else if ((arrstRequest[1] >= cMonth || arrendRequest[1] >= cMonth) && (arrstRequest[2] >= cYear || arrendRequest[2] >= cYear)) {
                            jAlert("Tháng xuất đối soát phải nhỏ hơn tháng hiện tại");
                            return false;

                        } else if (arrstRequest[2] > cYear || arrendRequest[2] > cYear) {
                            jAlert("Năm xuất đối soát phải nhỏ hoặc bằng năm hiện tại");
                            return false;

                        } else {
                            //Lay ngay dau va cuoi thang
                            var startD = "01";
                            var endD = "";
                            switch (arrstRequest[1]) {
                                case "01":
                                case "03":
                                case "05":
                                case "07":
                                case "08":
                                case "10":
                                case "12":
                                    endD = "31";
                                    break;
                                case "04":
                                case "06":
                                case "09":
                                case "11":
                                    endD = "30";
                                    break;
                                case "02":
                                {
                                    if (parseInt(arrstRequest[2]) % 4 == 0) {
                                        endD = "29";
                                        break;
                                    } else {
                                        endD = "28";
                                        break;
                                    }
                                }
                            }

                            var urlExportDS = urlOrg + "/" + conTextPath + "/admin/statistic/exp/exportds_tk_submit.jsp?";
                            urlExportDS += "type=" + $("select#type").children("option:selected").val();
                            urlExportDS += "&result=" + $("select#result").children("option:selected").val();
                            urlExportDS += "&oper=" + $("select#oper").children("option:selected").val();
                            urlExportDS += "&groupBr=" + $("select#groupBr").children("option:selected").val();
                            urlExportDS += "&stRequest=" + startD + "/" + arrstRequest[1] + "/" + arrstRequest[2];
                            urlExportDS += "&endRequest=" + endD + "/" + arrstRequest[1] + "/" + arrstRequest[2];
//                            urlExportDS += "&cp_code=" + $("select#_agentcy_id").children("option:selected").val();
                            urlExportDS += "&userSender=" + $("select#_userSender").children("option:selected").val();

//                            alert(urlExportDS);
//                            var cf = confirm("Đối soát sẽ được xuất từ ngày đầu tháng đến ngày cuối tháng bạn chọn. Bạn chắc chắn xuất đối soát?");
//                            if (cf == true) {
                                window.open(urlExportDS);
//                            }
                        }
                    }
                }
            });


        });
    </script>
</html>
<%!    private String getType(int type) {
        if (type == BrandLabel.TYPE.CSKH.val) {
            return "CSKH";
        } else if (type == BrandLabel.TYPE.QC.val) {
            return "Tin QC";
        } else {
            return type + "";
        }
    }
%>