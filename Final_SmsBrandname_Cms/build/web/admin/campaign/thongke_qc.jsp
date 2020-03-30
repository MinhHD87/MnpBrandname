<%@page import="gk.myname.vn.entity.MsgBrandAds"%>
<%@page import="gk.myname.vn.entity.Campaign"%><%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script type="text/javascript" language="javascript">
//            $.noConflict();
            $(document).ready(function () {
                $('#example').DataTable({
                    "order": [[0, "DESC"]],
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
                    minDate: '2014/01/01', // yesterday is minimum date
                });
            });
            //------
            function validMonth() {
                var stRequest = $("#stRequest").val();
                var endRequest = $("#endRequest").val();
                var arrstRequest = stRequest.split("/");
                var arrendRequest = endRequest.split("/");
                if (stRequest !== "" && stRequest !== null) {
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
        <%            //-
            MsgBrandAds msgDao = new MsgBrandAds();
            String startTime = RequestTool.getString(request, "stRequest");
//            if (Tool.checkNull(startTime)) {
//                startTime = DateProc.createDDMMYYYY_Start01();
//            }
            String endTime = RequestTool.getString(request, "endRequest");
            
            String label = RequestTool.getString(request, "_label");
            String userSender = RequestTool.getString(request, "userSender");
            String result = RequestTool.getString(request, "result");
            ArrayList<MsgBrandAds> allLog = msgDao.staticAll(startTime, endTime, result, userSender, label);
            String urlExport = request.getContextPath() + "/admin/campaign/exp/export_tk_CDR.jsp?";
            urlExport += "&startTime=" + startTime;
            urlExport += "&endTime=" + endTime;
            urlExport += "&result=" + result;
            urlExport += "&userSender=" + userSender;
            urlExport += "&label=" + label;
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <!-- Tìm kiếm-->
                        <form onsubmit="return  validMonth();" action="<%=request.getContextPath() + "/admin/campaign/thongke_qc.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Thống kê TIN QUẢNG CÁO</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Từ ngày:</td>
                                        <td> 
                                            &nbsp;<span class="redBold"> </span>
                                            <input value="<%=startTime%>" id="stRequest" class="dateproc" size="12" type="text" name="stRequest"/>
                                            &nbsp;<span class="redBold">Đến ngày </span>
                                            <input value="<%=endTime%>" id="endRequest" class="dateproc" size="12" type="text" name="endRequest"/>
                                            Trạng thái
                                            <select name="result">
                                                <option value="">-- Tất cả --</option>
                                                <option value="Success">Thành Công</option>
                                                <option value="Failed">Thất bại</option>
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
                                            <select style="width: 420px" onchange="changeCP()" id="_userSender" name="userSender">
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
                        <table id="example" class="display" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company Bold">Ngày</th>
                                    <th scope="col" class="rounded Bold">Brand Name</th>
                                    <th scope="col" class="rounded Bold">User</th>
                                    <th scope="col" class="rounded Bold">Mạng</th>
                                    <th scope="col" class="rounded Bold">Tổng tin</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (Iterator<MsgBrandAds> iter = allLog.iterator(); iter.hasNext();) {
                                        MsgBrandAds oneBrand = iter.next();

                                %>
                                <tr>
                                    <td class="boder_right">
                                        <%=oneBrand.getTimeSend()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneBrand.getLabel()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneBrand.getUserSender()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneBrand.getOper()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneBrand.getTotalMsg()%>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div><!-- end of right content-->
                </div>   <!--end of center content -->
                <div class="clear"></div>
            </div> <!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html>