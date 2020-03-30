    <%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.SMSUtils"%><%@page import="gk.myname.vn.entity.MsgBrandAds"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="java.io.File"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.entity.Campaign"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script type="text/javascript" src="<%= request.getContextPath()%>/admin/resource/js/jquery.blockUI.js"></script>
        <script type="text/javascript">
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
            $(document).ready(function () {
                $('.ItemPopup').showPopup({
                    top: 100,
                    closeButton: ".close_popup", //khai báo nút close cho popup
                    scroll: 0, //cho phép scroll khi mở popup, mặc định là không cho phép
                    width: 500,
                    height: 'auto',
                    closeOnEscape: true
                });
            });
            function changeBrand() {
                var selectBr = $("#_label option:selected");
                if (selectBr.val() !== "") {
                    var user = selectBr.attr("user_owner");
                    var url = "/admin/statistic/ajax/list-cp.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_userSender");
                    $("#_userSender").select2('val', user);
                } else {
                    var url = "/admin/statistic/ajax/list-cp.jsp?user=" + 0;
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
    </head>
    <body>
        <%  //---         
            String campaignId = RequestTool.getString(request, "campaignId");
            String phone = RequestTool.getString(request, "phone");
            String telco = RequestTool.getString(request, "telco");
            String label = RequestTool.getString(request, "_label");
            String startTime = RequestTool.getString(request, "startTime");
//            if (Tool.checkNull(startTime)) {
//                startTime = DateProc.createDDMMYYYY();
//            }
            int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
            if (currentPage < 1) {
                currentPage = 1;
            }
            String endTime = RequestTool.getString(request, "endTime");
            String userSender = RequestTool.getString(request, "userSender");
            String result = RequestTool.getString(request, "result");

            MsgBrandAds gDao = new MsgBrandAds();
            ArrayList<MsgBrandAds> allCampaign = gDao.findByAll(currentPage, maxRow, campaignId, phone, startTime, endTime, result, userSender, telco, label);
            int totalPage = 0;
            int totalRow = gDao.countByAll(campaignId, phone, startTime, endTime, result, userSender, telco, label);
            totalPage = (int) totalRow / maxRow;
            if (totalRow % maxRow != 0) {
                totalPage++;
            }
        %>
        <div id="popup_content_edit" class="popup"></div>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <form action="<%=request.getContextPath() + "/admin/campaign/detail.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Tìm kiếm đơn hàng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td class="redBold">Mã Chiến dịch:</td>
                                        <td> 
                                            <input value="" size="12" type="text" name="campaignId"/>
                                            &nbsp;<span class="redBold">Từ ngày: </span>
                                            <input readonly  class="dateproc" value="<%=!Tool.checkNull(startTime) ? startTime : ""%>" size="10" id="stRequest" type="text" name="startTime"/>
                                            &nbsp;<span class="redBold">Đến </span>
                                            <input readonly class="dateproc" value="<%=!Tool.checkNull(endTime) ? endTime : ""%>" size="10" id="endRequest" type="text" name="endTime"/>
                                            &nbsp;&nbsp;&nbsp;
                                            Kết quả
                                            <select name="result">
                                                <option value="">-Tất cả-</option>
                                                <option <%=result.equalsIgnoreCase("Success") ? "selected='selected'" : ""%> value="Success">Thành công</option>
                                                <option <%=result.equalsIgnoreCase("Failed") ? "selected='selected'" : ""%> value="Failed">Thất bại</option>
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
                                        <td>TK Khách hàng: </td>
                                        <td>
                                            <%
                                                // Lay ra Tai Khoản Dai Ly Hoac Quản Lý Cấp 1
                                                ArrayList<Account> allUser = Account.getAllCP();
                                            %>
                                            <select style="min-width: 250px" onchange="changeCP()" id="_userSender" name="userSender">
                                                <option value="">******** Tất cả ********</option>
                                                <%
                                                    for (Account oneUser : allUser) {
                                                %>
                                                <option user_sender="<%=oneUser.getAccID()%>" <%=(userSender.equals(oneUser.getUserName())) ? "selected ='selected'" : ""%> 
                                                        value="<%=oneUser.getUserName()%>" 
                                                        img-data="<%=(oneUser.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=oneUser.getUserName()%>] <%=oneUser.getFullName()%></option>
                                                <%}%>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;
                                            Nhãn Gửi &nbsp;
                                            <select onchange="changeBrand()" style="width: 200px" id="_label" name="_label">
                                                <option value="">******** Tất cả ********</option>
                                                <%   ArrayList<BrandLabel> allLabel = BrandLabel.getAll();
                                                    for (BrandLabel one : allLabel) {
                                                %>
                                                <option user_owner="<%=one.getUserOwner()%>" 
                                                        <%=label.equals(one.getBrandLabel()) && one.getUserOwner().equals(userSender) ? "selected='selected'" : ""%>
                                                        value="<%=one.getId()%>"
                                                        img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" ><%=one.getBrandLabel()%> - [<%=one.getUserOwner()%>]</option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <%=buildAddControl(request, userlogin, "/admin/partner-manager/add.jsp")%>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                            
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>  
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <!--Content-->
                        <%@include file="/admin/includes/page.jsp" %>
                        <form id="uploadForm" name="uploadForm">
                            <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded">STT</th>
                                        <th scope="col" class="rounded">User Sender</th>
                                        <th scope="col" class="rounded">Label</th>
                                        <th scope="col" class="rounded">Message</th>
                                        <th scope="col" class="rounded">PHONE</th>
                                        <th scope="col" class="rounded">Ngày gửi</th>
                                        <th scope="col" class="rounded">Total Msg</th>
                                        <th scope="col" class="rounded">Kết quả</th>
                                        <th scope="col" class="rounded">Oper</th>
                                            <%=buildHeader(request, userlogin, true, true)%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%  //
                                        int count = 1;
                                        for (Iterator<MsgBrandAds> iter = allCampaign.iterator(); iter.hasNext();) {
                                            int index = (currentPage - 1) * maxRow + count++;
                                            MsgBrandAds oneCP = iter.next();
                                    %>
                                    <tr>
                                        <td align="left" class="boder_right"><%=index%></td>
                                        <td align="left" class="boder_right"><%=oneCP.getUserSender()%></td>
                                        <td align="left" class="boder_right"><%=oneCP.getLabel()%></td>
                                        <td align="left" class="boder_right"><%=oneCP.getMessage()%></td>
                                        <td align="left" class="boder_right"><%=oneCP.getPhone()%></td>
                                        <td align="left" class="boder_right"><%=oneCP.getTimeSend()%></td>
                                        <td align="left" class="boder_right"><%=oneCP.getTotalMsg()%></td>
                                        <td align="left" class="boder_right"><%=oneCP.getStatus() == 0 ? "Thất bại" : "Thành Công"%></td>
                                        <td align="left" class="boder_right"><%=oneCP.getOper()%></td>
                                        <%=buildControl(request, userlogin,
                                                "/admin/campaign/edit.jsp?id=" + oneCP.getId(),
                                                "/admin/campaign/del.jsp?id=" + oneCP.getId())%>
                                    </tr>
                                    <%
                                        }
                                    %>
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