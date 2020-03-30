<%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.utils.SMSUtils"%><%@page import="java.util.Calendar"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.entity.MsgBrandRequest"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script>
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
            $(document).ready(function () {
                $('.ItemPopup').showPopup({
                    top: 100,
                    closeButton: ".close_popup", //khai báo nút close cho popup
                    scroll: 0, //cho phép scroll khi mở popup, mặc định là không cho phép
                    width: 600,
                    height: 'auto',
                    closeOnEscape: true
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
                    var user = selectBr.attr("user_sender");
                    var url = "/admin/statistic/ajax/list-cp.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_userSender");
                    $("#_userSender").select2('val', user);
                } else {
                    var url = "/admin/statistic/ajax/list-cp.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_userSender");
                    $("#_userSender").select2('val', "");
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
                    var url = "/admin/statistic/ajax/listBrand.jsp?user=0";
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_label");
                }
                $("#_label").select2("val", "");
            }
        </script>
        <%            ArrayList<MsgBrandRequest> all = null;
            MsgBrandRequest logDao = new MsgBrandRequest();
            int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
            if (currentPage < 1) {
                currentPage = 1;
            }
            int err_code = RequestTool.getInt(request, "err_code", -1);
            int type = RequestTool.getInt(request, "type", -1);
            int result = RequestTool.getInt(request, "result", -1);
            int bid = RequestTool.getInt(request, "_label");
            BrandLabel brLabel = BrandLabel.getFromCache(bid);
            //--
            String label = "";
            if (brLabel != null) {
                label = brLabel.getBrandLabel();
            }
            String phone = RequestTool.getString(request, "phone");
//            String provider = RequestTool.getString(request, "provider");
            String telco = RequestTool.getString(request, "telco");
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
            String tranId = RequestTool.getString(request, "tranId");
            all = logDao.getAllLog_MsgReq(currentPage, maxRow, userSender, cp_code, label, type, result,  stRequest, endRequest, phone, telco, err_code, tranId);
            int totalPage = 0;
            int totalRow = logDao.countAllLog_MsgReq(userSender, cp_code, label, type, result,  stRequest, endRequest, phone, telco, err_code, tranId);
            totalPage = (int) totalRow / maxRow;
            if (totalRow % maxRow != 0) {
                totalPage++;
            }
            String urlExport = request.getContextPath() + "/admin/statistic/exp/exp_request.jsp?";
            String dataGet = "";
            dataGet += "page=" + currentPage;
            dataGet += "&err_code=" + err_code;
            dataGet += "&type=" + type;
            dataGet += "&result=" + result;
            dataGet += "&_label=" + bid;
            dataGet += "&phone=" + phone;
//            dataGet += "&provider=" + provider;
            dataGet += "&telco=" + telco;
            dataGet += "&stRequest=" + stRequest;
            dataGet += "&endRequest=" + endRequest;
            dataGet += "&totalRow=" + totalRow;
            dataGet += "&cp_code=" + cp_code;
            dataGet += "&userSender=" + userSender;
            dataGet += "&tranId=" + tranId;
            urlExport += dataGet;
        %>
    </head>
    <body>
        <div id="popup_content_view" class="popup"></div>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <!-- Tìm kiếm-->
                        <form onsubmit="return validMonth();"  action="<%=request.getContextPath() + "/admin/statistic/history/request_full.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">
                                            LỊCH SỬ YÊU CẦU TỪ ĐẠI LÝ (KẾT QUẢ NÀY CHỈ LÀ NHẬN THÀNH CÔNG)
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Từ ngày: </td>
                                        <td colspan="3">
                                            <input readonly value="<%=stRequest%>" class="dateproc" size="8" id="stRequest" type="text" name="stRequest"/>
                                            &nbsp;&nbsp;&nbsp;<span class="redBold">Đến </span>
                                            <input readonly value="<%=endRequest%>" class="dateproc" size="8" id="endRequest" type="text" name="endRequest"/>
                                            &nbsp;&nbsp;&nbsp;
                                            Loại tin
                                            <select name="type">
                                                <option value="-1">Tất cả</option>
                                                <option value="0">CSKH</option>
                                                <option value="1">Tin Quảng cáo</option>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;
                                            Kết quả
                                            <select name="result">
                                                <option value="-1">Tất cả</option>
                                                <option value="99">Thành công</option>
                                                <option value="0">Thất bại</option>
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
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Số điện thoại: </td>
                                        <td>
                                            <input size="10" type="text" name="phone"/>
                                            &nbsp;&nbsp;&nbsp;
                                            Nhãn &nbsp;
                                            <select onchange="changeBrand()" style="width: 180px" id="_label" name="_label">
                                                <option value="">******** Tất cả ********</option>
                                                <%   ArrayList<BrandLabel> allLabel = BrandLabel.getAll();
                                                    for (BrandLabel one : allLabel) {
                                                %>
                                                <option user_owner="<%=one.getUserOwner()%>" <%=label.equals(one.getBrandLabel()) && one.getUserOwner().equals(userSender) ? "selected='selected'" : ""%> value="<%=one.getId()%>"><%=one.getBrandLabel()%> - [<%=one.getUserOwner()%>]  <%=one.getStatus() == 1 ? "" : "[Lock]"%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            Đại lý:&nbsp;&nbsp;
                                            <%
                                                ArrayList<PartnerManager> allCp = PartnerManager.getAllCache();
                                                if (allCp != null && !allCp.isEmpty()) {
                                            %>
                                            <select style="width: 420px" id="_agentcy_id" name="cp_code">
                                                <option value="">******** Tất cả ********</option>
                                                <%
                                                    for (PartnerManager onePartner : allCp) {
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
                                        <td>Tài khoản: </td>
                                        <td>
                                            <%
                                                // Lay ra Tai Khoản Dai Ly Hoac Quản Lý Cấp 1
                                                ArrayList<Account> allUser = Account.getAllCP();
                                                if (allUser != null && !allUser.isEmpty()) {
                                            %>
                                            <select style="width: 350px" onchange="changeCP()" id="_userSender" name="userSender">
                                                <option value="">******** Tất cả ********</option>
                                                <%
                                                    for (Account oneUser : allUser) {
                                                %>
                                                <option <%=(userSender.equals(oneUser.getUserName())) ? "selected ='selected'" : ""%>
                                                    value="<%=oneUser.getUserName()%>"
                                                    img-data="<%=(oneUser.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=oneUser.getUserName()%>] <%=oneUser.getFullName()%></option>
                                                <%}
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            Mã Lỗi:
                                            &nbsp;&nbsp;
                                            <input size="8" name="err_code" type="text">
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <input onclick="window.open('<%=urlExport%>')" class="button" type="button" name="button" value="Xuất Excel"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>      
                        <%@include file="/admin/includes/page.jsp" %>
                        <!--End tim kiếm-->
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <!--Content-->
                        <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company">STT</th>
                                    <th scope="col" class="rounded">Brand Name</th>
                                    <th scope="col" class="rounded">Partner</th>
                                    <th scope="col" class="rounded">Nhà mạng</th>
                                    <th scope="col" class="rounded">Số nhận tin</th>
                                    <th scope="col" class="rounded">Total SMS</th>
                                    <th scope="col" class="rounded">Total Price</th>
                                    <th scope="col" class="rounded">Time Request</th>
                                    <!--<th scope="col" class="rounded">Log DB Time</th>--> 
                                    <th scope="col" class="rounded">Kết quả gửi</th> 
                                    <th scope="col" class="rounded">Loại tin</th>
                                    <th scope="col" class="rounded">Xem MT</th>
                                    <!--<th scope="col" class="rounded">GW</th>-->
                                    <!--<th scope="col" class="rounded">Group BR</th>-->
                                    <th scope="col" class="rounded">NODE</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    for (Iterator<MsgBrandRequest> iter = all.iterator(); iter.hasNext();) {
                                        MsgBrandRequest oneBrand = iter.next();
                                %>
                                <tr>
                                    <td class="boder_right"><%=count++%></td>
                                    <td class="boder_right" style="color: blue;font-weight: bold" align="left">
                                        <%=oneBrand.getLabel()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneBrand.getUserSender()%>
                                    </td>
                                    <td class="boder_right" align="center">
                                        <%=oneBrand.getOper()%>
                                    </td>
                                    <td class="boder_right" align="center">
                                        <%=oneBrand.getPhone()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneBrand.getTotalSms()%>
                                    </td>
                                    
                                    <td class="boder_right" align="left">
                                        <%=oneBrand.getPriceSMS()%>
                                    </td>
                                    
                                    <td class="boder_right"><%=DateProc.Timestamp2DDMMYYYYHH24MiSS(oneBrand.getRequestTime())%></td>
                                    <!--<td class="boder_right"><%=DateProc.Timestamp2DDMMYYYYHH24MiSS(oneBrand.getLogTime())%></td>-->
                                    <td class="boder_right" align="left"><span class="redBold"><%=oneBrand.getResult()%></span> &nbsp;(<%=SMSUtils.removePassLog(oneBrand.getErrInfo())%>)</td>
                                    <td class="boder_right" align="center"><%=getType(oneBrand.getType())%></td>
                                    <td class="boder_right">
                                        <a class="ItemPopup" url-data="<%=request.getContextPath() + "/admin/statistic/mt/ViewMT_income.jsp?id=" + oneBrand.getId() + "&date=" + DateProc.Timestamp2DDMMYY(oneBrand.getRequestTime())%>" 
                                           href="#popup_content_view" id="open_popup_view" name="open_popup">Xem MT</a>
                                    </td>
                                    <td align="center"><%=oneBrand.getLbNode()%></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div><!-- end of right content-->
                    <%@include file="/admin/includes/page.jsp" %>
                </div>   <!--end of center content -->
                <div class="clear"></div>
            </div> <!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
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