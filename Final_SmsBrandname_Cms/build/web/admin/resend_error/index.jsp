<%@page import="gk.myname.vn.utils.SMSUtils"%><%@page import="java.util.Iterator"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.entity.ResendEntity"%><%@page import="java.util.ArrayList"%><%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script type="text/javascript" src="<%= request.getContextPath()%>/admin/resource/js/popupWindow.js"></script>
        <script>
            function confirmSend(type) {
                var element = $("#_transId").find('option:selected');
                $.ajax({
                    url: "processConfirm.jsp?type=" + type + "&tid=" + element.val(),
                    type: 'post',
                    success: function (data) {
                        location.reload();
                    }
                });
            }
            $(document).ready(function () {
                $("#_agentcy").select2({
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
                        var opt = $("#_agentcy option:selected");
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
        </script>
    </head>
    <body>
        <%
            if (!userlogin.checkView(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin/");
                return;
            }
            ArrayList<ResendEntity> all = null;
            ResendEntity reDao = new ResendEntity();
            int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
            if (currentPage < 1) {
                currentPage = 1;
            }
            int status = RequestTool.getInt(request, "status", -1);
            String transId = RequestTool.getString(request, "transId");
            String userSender = RequestTool.getString(request, "userSender");

            all = reDao.getAllLog(currentPage, maxRow, userlogin.getUserName(), status, transId);
            int totalPage = 0;
            int totalRow = reDao.countAllLog(userlogin.getUserName(), status);
            totalPage = (int) totalRow / maxRow;
            if (totalRow % maxRow != 0) {
                totalPage++;
            }
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <!-- Tìm kiếm-->
                        <form id="formSearch" action="" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">
                                            DANH SÁCH TIN NHẮN RESEND CHỜ DUYỆT
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Trạng thái</td>
                                        <td colspan="3">
                                            <select name="status">
                                                <option value="-1">--- Tất cả ---</option>
                                                <% for (ResendEntity.STATUS one : ResendEntity.STATUS.values()) {%>
                                                <option <%=(status == one.val) ? "selected ='selected'" : ""%> value="<%=one.val%>"><%=ResendEntity.STATUS.getDesc(one.val)%></option>
                                                <%}%>
                                            </select>
                                            Khách Hàng
                                            <select style="width: 380px" name="userSender" id="_agentcy">
                                                <option value="0">******** Chọn một KH Gửi lại ********</option>
                                                <%
                                                    ArrayList<Account> allCp = Account.getCPAgentcy();
                                                    for (Account oneAcc : allCp) {
                                                        if (oneAcc.getUserType() != Account.TYPE.AGENCY.val) {
                                                            continue;
                                                        }
                                                %>
                                                <option <%=(userSender.equals(oneAcc.getUserName())) ? "selected ='selected'" : ""%>
                                                    value="<%=oneAcc.getUserName()%>"
                                                    img-data="<%=(oneAcc.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=oneAcc.getUserName()%>] <%=oneAcc.getFullName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>TRANS_ID</td>
                                        <td colspan="3">
                                            <%
                                                ArrayList<ResendEntity> listTrans = ResendEntity.getTransIdProcess(userlogin.getUserName());
                                                if (listTrans != null && !listTrans.isEmpty()) {
                                            %>
                                            <select id="_transId" name="transId">
                                                <option value="">******** Tất cả ********</option>
                                                <%
                                                    for (ResendEntity oneTrans : listTrans) {
                                                        if (!Tool.checkNull(oneTrans.getTrandId())) {
                                                %>
                                                <option <%=(transId.equals(oneTrans.getTrandId())) ? "selected ='selected'" : ""%> value="<%=oneTrans.getTrandId()%>"><%=oneTrans.getTrandId()%></option>
                                                <%}
                                                    }
                                                %>
                                            </select>
                                            <%} else {
                                                    out.print("Hiện Không có đơn hàng nào... ");
                                                }%>
                                            &nbsp;&nbsp;&nbsp;&nbsp;<input class="button" onclick="confirmSend('cf')" type="button" name="submit" value="Duyệt gửi"/>
                                            &nbsp;&nbsp;<input class="button" onclick="confirmSend('del')" type="button" name="submit" value="Xoá"/>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
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
                        <form id="formData" action="processConfirm.jsp" method="post">
                            <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company">
                                            STT</th>
                                        <th scope="col" class="rounded">Brand Name</th>
                                        <th scope="col" class="rounded">Partner</th>
                                        <th scope="col" class="rounded">Nhà mạng</th>
                                        <th scope="col" class="rounded">Số nhận tin</th>
                                        <th scope="col" class="rounded">Time Request</th>
                                        <th scope="col" class="rounded">Status</th> 
                                        <th scope="col" class="rounded">Kết quả gửi</th>
                                        <th scope="col" class="rounded">TRANS_ID</th>
                                        <th scope="col" class="rounded">Xem MT</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        int count = 1; //Bien dung de dem so dong
                                        for (Iterator<ResendEntity> iter = all.iterator(); iter.hasNext();) {
                                            ResendEntity oneQueue = iter.next();
                                    %>
                                    <tr>
                                        <td class="boder_right"><%=count++%></td>
                                        <td class="boder_right" style="color: blue;font-weight: bold" align="left">
                                            <%=oneQueue.getLabel()%>
                                        </td>
                                        <td class="boder_right" align="left">
                                            <%=oneQueue.getUserSender() %>
                                        </td>
                                        <td class="boder_right" align="center">
                                            <%=SMSUtils.buildMobileOperator(oneQueue.getPhone())%>
                                        </td>
                                        <td class="boder_right" align="center">
                                            <%=oneQueue.getPhone()%>
                                        </td>
                                        <td class="boder_right" align="left">
                                            <%=oneQueue.getRequestTime()%>
                                        </td>
                                        <td class="boder_right" align="center"><%=oneQueue.getStatus()%>- <%=ResendEntity.STATUS.getDesc(oneQueue.getStatus())%></td>
                                        <td class="boder_right" align="center"><%=oneQueue.getInfo()%></td>
                                        <td class="boder_right" align="center"><%=oneQueue.getTrandId()%></td>
                                        <td class="boder_right" align="center">MT</td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </form>
                    </div><!-- end of right content-->
                    <%@include file="/admin/includes/page.jsp" %>
                </div>   <!--end of center content -->
                <div class="clear"></div>
            </div> <!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html>