<%@page import="gk.myname.vn.admin.BillingAcc"%>
<%@page import="gk.myname.vn.entity.TransActionBilling"%>
<%@page import="java.text.DecimalFormat"%>
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
        <%            ArrayList<TransActionBilling> all = null;
            TransActionBilling logDao = new TransActionBilling();
            int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
            if (currentPage < 1) {
                currentPage = 1;
            }
            int err_code = RequestTool.getInt(request, "err_code", -1);
            String type = RequestTool.getString(request, "type");
            
            String transBillingID = RequestTool.getString(request, "transBillingID");
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
            String userSender = RequestTool.getString(request, "userSender");
            System.out.println("currentPage"+currentPage);
            System.out.println("maxRow"+maxRow);
            System.out.println("userSender"+userSender);
            System.out.println("type"+type);
            System.out.println("stRequest"+stRequest);
            System.out.println("endRequest"+endRequest);
            System.out.println("transBillingID"+transBillingID);
            System.out.println("telco"+telco);
            all = logDao.getAllTransActionBilling(currentPage, maxRow, userSender,  type,   stRequest, endRequest, transBillingID, telco);
            int totalPage = 0;
            int totalRow = logDao.countAllTransActionBilling(userSender, type, stRequest, endRequest, transBillingID, telco);
            totalPage = (int) totalRow / maxRow;
            if (totalRow % maxRow != 0) {
                totalPage++;
            }
            String urlExport = request.getContextPath() + "/admin/billing/exp_billing.jsp?";
            String dataGet = "";
            dataGet += "page=" + currentPage;
            dataGet += "&type=" + type;
            dataGet += "&transBillingID=" + transBillingID;
//            dataGet += "&provider=" + provider;
            dataGet += "&telco=" + telco;
            dataGet += "&stRequest=" + stRequest;
            dataGet += "&endRequest=" + endRequest;
            dataGet += "&totalRow=" + totalRow;
            dataGet += "&userSender=" + userSender;
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
                        <form onsubmit="return validMonth();"  action="<%=request.getContextPath() + "/admin/billing/billingTrans.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">
                                            GIAO DỊCH BILLING CHI TIẾT
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
                                            Loại billing
                                            <select name="type">
                                                <option value="-1">Tất cả</option>
                                                <option value="CHARG">Cước tin nhắn</option>
                                                <option value="REFUND">Hoàn cước</option>
                                                <option value="TOPUP">Nạp tiền</option>
                                                <option value="MONTHLY">Phí duy trì</option>
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
                                        <td>Mã giao dịch: </td>
                                        <td>
                                            <input size="10" type="text" name="transBillingID"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <span class="redBold">Tài khoản</span>
                                            <%
                                                // Lay ra Tai Khoản Dai Ly Hoac Quản Lý Cấp 1
                                                ArrayList<BillingAcc> allUser = BillingAcc.getAllPrepaid();
                                                if (allUser != null && !allUser.isEmpty()) {
                                            %>
                                            <select style="width: 350px" onchange="changeCP()" id="_userSender" name="userSender">
                                                <option value="">******** Tất cả ********</option>
                                                <%
                                                    for (BillingAcc oneUser : allUser) {
                                                %>
                                                <option <%=(userSender.equals(oneUser.getUsername())) ? "selected ='selected'" : ""%>
                                                    value="<%=oneUser.getUsername()%>"
                                                    img-data="<%=(oneUser.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=oneUser.getUsername()%>] <%=oneUser.getFullname()%></option>
                                                <%}
                                                    }
                                                %>
                                            </select>
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
                                    
                                    <th scope="col" class="rounded">Loại GD</th>
                                    <th scope="col" class="rounded">Đơn giá</th>
                                    <th scope="col" class="rounded">Số lượng</th>
                                    <th scope="col" class="rounded">Số dư trước GD</th>
                                    <th scope="col" class="rounded">Số tiền GD</th>
                                    <th scope="col" class="rounded">Số dư sau GD</th>
                                    <th scope="col" class="rounded">Time Request</th>
                                    <th scope="col" class="rounded">Đặt lệnh</th> 
                                    <th scope="col" class="rounded">Nhà mạng</th>
                                    <th scope="col" class="rounded">On Account</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    for (Iterator<TransActionBilling> iter = all.iterator(); iter.hasNext();) {
                                        TransActionBilling oneBilTrans = iter.next();
                                        DecimalFormat format = new DecimalFormat("$,000");
                                %>
                                <tr>
                                    
                                    <td class="boder_right" style="color: blue;font-weight: bold" align="left">
                                        <%=oneBilTrans.getType_trans()%>
                                    </td>
                                    <td class="boder_right" align="center">
                                        <%=oneBilTrans.getUnit_price()%>
                                    </td>
                                    <td class="boder_right" align="center">
                                        <%=oneBilTrans.getNumber_unit()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=format.format(oneBilTrans.getBalance_before())%>
                                    </td>
                                    <td class="boder_right"  align="left">
                                        <%=oneBilTrans.getMoney_trans()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=format.format(oneBilTrans.getBalance_trans())%>
                                    </td>
                                    
                                    <td class="boder_right" align="left">
                                        <%=oneBilTrans.getTime_action()%>
                                    </td>
                                    
                                    <td class="boder_right" align="left">
                                        <%=oneBilTrans.getAction_account()%>
                                    </td>
                                    
                                    <td class="boder_right" align="left">
                                        <%=oneBilTrans.getTelco()%>
                                    </td>
                                    
                                    <td class="boder_right" align="left">
                                        <%=oneBilTrans.getAccount_name()%>
                                    </td>
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