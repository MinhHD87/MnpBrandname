<%@page import="gk.myname.vn.utils.SMSUtils"%>
<%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.entity.KPI_Request"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head><% session.setAttribute("title", "Thống kê KPI Request SMS BRAND cms.brand1.xyz"); %>
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
                    var url = "/admin/statistic/ajax/listBrand.jsp?user=user";
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_label");
                }
                $("#_label").select2("val", "");
            }
        </script>
    </head>
    <body>
        <%           //-
            KPI_Request dao = new KPI_Request();
            ArrayList<KPI_Request> allBrand = null;
            String stRequest = RequestTool.getString(request, "stRequest");
            if (Tool.checkNull(stRequest)) {
                stRequest = DateProc.Timestamp2DDMMYYYY(DateProc.getNextDateN(DateProc.createTimestamp(),-1));
            }
            String endRequest = RequestTool.getString(request, "endRequest");
            if (Tool.checkNull(endRequest)) {
                endRequest = DateProc.Timestamp2DDMMYYYY(DateProc.getNextDateN(DateProc.createTimestamp(),-1));
            }
            String userSender = RequestTool.getString(request, "userSender");
            int total_Count = RequestTool.getInt(request, "total_Count");
            String result = RequestTool.getString(request, "result");
            String oper = RequestTool.getString(request, "oper");
            String cp_code = RequestTool.getString(request, "cp_code");
            int currentPage = RequestTool.getInt(request, "page", 1);
            allBrand = dao.staticKPI_Request(currentPage, maxRow, userSender, oper, cp_code, result, stRequest, endRequest);
            int totalPage = 0;
            int totalRow = dao.countAll(userSender,oper,cp_code,result,stRequest,endRequest);
           
            totalPage = (int) totalRow / maxRow;
            if (totalRow % maxRow != 0) {
                totalPage++;
            }
            RequestTool.debugParam(request);
            ArrayList<KPI_Request> allLog = dao.staticKPI_Request(currentPage, maxRow, userSender, oper, cp_code, result, stRequest, endRequest);
            String urlExport = request.getContextPath() + "/admin/statistic/exp/export_kpi_request.jsp?";
            String dataGet = "";
            dataGet += "page=" + currentPage;
            dataGet += "&stRequest=" + stRequest;
            dataGet += "&endRequest=" + endRequest;
            dataGet += "&userSender=" + userSender;
            dataGet += "&total_Count" + total_Count;
            dataGet += "&result=" + result;
            dataGet += "&oper=" + oper;
            dataGet += "&cp_code=" + cp_code;

            urlExport += dataGet;
        %>

        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <!-- Tìm kiếm-->
                        <form onsubmit="return  validMonth();" action="<%=request.getContextPath() + "/admin/statistic/kpi_request.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">KPI_REQUEST</th>
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
                                            <span class="redBold">Kết Quả </span>
                                            <select name="result">
                                                <option value="">=Tất Cả=</option>
                                                <option <%= result.equals("SUCCESS") ? "selected='selected'" : ""%> value="SUCCESS">Thành Công</option>
                                                <option <%= result.equals("FAILD") ? "selected='selected'" : ""%> value="FAILD">Thất bại</option>
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
                                            &nbsp;&nbsp;&nbsp;&nbsp;
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
                            <%                                
                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <%@include file="/admin/includes/page.jsp" %>
                        <!--Content-->
                        <table id="example" class="display" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company Bold"><b>STT</b></th>
                                    <th scope="col" class="rounded Bold"><b>Ngày Gửi</b></th>
                                    <th scope="col" class="rounded Bold"><b>Người Gửi</b></th>
                                    <th scope="col" class="rounded Bold"><b>Tổng </b></th>

                                    <th scope="col" class="rounded Bold"><b>Kết quả gửi</b></th> 
                                    <!--<th scope="col" class="rounded Bold"><b>Loại tin</b></th>-->
                                    <th scope="col" class="rounded Bold"><b>Nhà Mạng</b></th>

                                </tr>
                            </thead>
                            <%                                
                                int count = 1; //Bien dung de dem so dong
                                int total = 0;
                                for (Iterator<KPI_Request> iter = allLog.iterator(); iter.hasNext();) {
                                    KPI_Request oneBrand = iter.next();
                                    if (oneBrand.getResult().equalsIgnoreCase(SMSUtils.CODE.SUCCESS.val+"")) {
                                        total += oneBrand.getTotal_Count();
                                    }
                                    int tmp = (currentPage - 1) * maxRow + count++;
                            %>
                            <tr>
                                <td class="boder_right"><%=tmp%></td>
        
                                <td class="boder_right" align="center">
                                    <%=DateProc.Timestamp2DDMMYYYY(oneBrand.getLog_Date()) %>
                                </td>
                                <td class="boder_right" align="left">
                                    <%=oneBrand.getUserSender()%>
                                </td>
                                <td class="boder_right" align="left">
                                    <%=oneBrand.getTotal_Count()%>
                                </td>
                                <td class="boder_right" align="left">
                                    <%=oneBrand.getResult()%>
                                </td>
                                <td class="boder_right" align="center">
                                    <%=oneBrand.getOper()%>
                                </td>
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