<%@page import="gk.myname.vn.entity.IPManager"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#_list_customer").select2({
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
                        var opt = $("#_list_customer option:selected");
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
        <%  //-          
            if (!userlogin.checkView(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập module này!");
                response.sendRedirect(request.getContextPath() + "/admin");
                return;
            }
            int max = 50;
            ArrayList<IPManager> all = null;
            IPManager pDao = new IPManager();
            int currentPage = RequestTool.getInt(request, "page", 1);
            String user = RequestTool.getString(request, "user");
            String ip = RequestTool.getString(request, "ip");
            int port = RequestTool.getInt(request, "port", 0);
            int type = RequestTool.getInt(request, "type", -1);
            all = pDao.getAll(currentPage, max, user, ip, port, type);
            int totalPage = 0;
            int totalRow = pDao.countAll(user, ip, port, type);
            totalPage = (int) totalRow / max;
            if (totalRow % max != 0) {
                totalPage++;
            }
            if (request.getParameter("Check_Firewall") != null) {
                String result = pDao.checkFirewall();
                if (!Tool.checkNull(result)) {
                    result = result.replaceAll(System.lineSeparator(), "</br>");
                }
                session.setAttribute("mess", result);
            }
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <!-- Tìm kiếm-->
                        <form action="<%=request.getContextPath() + "/admin/firewall-manager/index.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Tìm kiếm Thông Tin IP ĐANG Sử Dụng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Khách hàng </td>
                                        <td>
                                            <select id="_list_customer" style="width: 380px" name="user">
                                                <option value="">Tất cả</option>
                                                <%ArrayList<Account> agency = Account.getCPAgentcy();
                                                    for (Account one : agency) {
                                                        if (one.getUserType() != Account.TYPE.AGENCY.val) {
                                                            continue;
                                                        }
                                                %>
                                                <option img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" 
                                                        value="<%=one.getUserName()%>"><%="[" + one.getUserName() + "] " + one.getFullName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            IP Đại lý:
                                            <input size="15" type="text" name="ip"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            TRẠNG THÁI
                                            <select style="width: 120px" name="type">
                                                <option value="-1">Tất cả</option>
                                                <option value="<%=IPManager.TYPE.ACCEPT.val%>">Active</option>
                                                <option value="<%=IPManager.TYPE.BLOCK.val%>">Block</option>
                                                <option value="<%=IPManager.TYPE.DECLARE.val%>">Khai Báo</option>
                                                <option value="<%=IPManager.TYPE.REJECT.val%>">Từ Chối</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            <%=buildAddControl(request, userlogin, "/admin/firewall-manager/add.jsp")%>
                                            &nbsp;&nbsp;&nbsp;
                                            <input class="button" onclick="location.href = '<%=request.getContextPath() + "/admin/firewall-manager/index.jsp"%>'" type="submit" name="Check_Firewall" value="Check Firewall"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>      
                        <!--End tim kiếm-->
                        <%@include file="/admin/includes/page.jsp" %>
                        <div align="center" style="min-height: 20px;margin-bottom: 2px; color: red;font-weight: bold;text-align: left">
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
                                    <th scope="col" class="rounded">USER</th>
                                    <th scope="col" class="rounded">DESC</th>
                                    <th scope="col" class="rounded">IP</th>
                                    <th scope="col" class="rounded">PORT</th>
                                    <th scope="col" class="rounded">Create Date</th>
                                    <th scope="col" class="rounded">Create By</th>
                                    <th scope="col" class="rounded">UPdate Date</th>
                                    <th scope="col" class="rounded">UPdate By</th>
                                    <th scope="col" class="rounded">Type</th>
                                        <%=buildHeader(request, userlogin, true, true)%>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    for (Iterator<IPManager> iter = all.iterator(); iter.hasNext();) {
                                        IPManager oneIP = iter.next();
                                        int tmp = (currentPage - 1) * 25 + count++;
                                %>
                                <tr>
                                    <td class="boder_right"><%=tmp%></td>
                                    <td class="boder_right" align="left">
                                        <%= Account.checkAccountExist(oneIP.getUserSender()) ? oneIP.getUserSender() : "Unknow:" + oneIP.getUserSender()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneIP.getDesc()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneIP.getIpRequest()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneIP.getPortRequest()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneIP.getCreateDate()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneIP.getCreateBy()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneIP.getUpdateDate()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneIP.getUpdateBy()%>
                                    </td>

                                    <td class="boder_right" align="center">
                                        <%
                                            if (oneIP.isAccept()) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%
                                        } else if (oneIP.isBlock()) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                        <%
                                        } else {
                                        %>
                                        <img width="24" src="<%= request.getContextPath()%>/admin/resource/images/cancel.png"/>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <td class="boder_right">
                                        <%
                                            if (!oneIP.isAccept()) {
                                        %>
                                        <a title="Sửa" href="edit.jsp?id=<%=oneIP.getId()%>">
                                            <img width='24' src='<%=request.getContextPath()%>/admin/resource/images/user_edit.png' alt='' title='Sửa' border='0' /> 
                                        </a>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <%=buildControl(request, userlogin,
                                            null,
                                            "/admin/firewall-manager/del.jsp?id=" + oneIP.getId())%>
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