<%@page import="java.io.InputStreamReader"%><%@page import="java.io.BufferedReader"%><%@page import="java.io.IOException"%><%@page import="org.apache.commons.exec.ExecuteException"%><%@page import="org.apache.commons.exec.DefaultExecutor"%><%@page import="org.apache.commons.exec.CommandLine"%><%@page import="gk.myname.vn.entity.IPManager"%>
<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><%@page contentType="text/html; charset=utf-8" %>
<html>
    <head><%@include file="/admin/includes/header.jsp" %></head>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/resource/css/jquery-ui-1.8.16.custom.css">
    <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.core.min.js"></script>
    <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.position.min.js"></script>
    <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.widget.min.js"></script>
    <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.autocomplete.min.js"></script>
    <script type ='text/javascript'>
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
    <body>
        <%            //--
            if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập trang này!");
                response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
                return;
            }
            IPManager oneProvi = null;
            if (request.getParameter("submit") != null) {
                RequestTool.debugParam(request);
                //---------------------------
                String userSender = RequestTool.getString(request, "userSender");
                String ip = RequestTool.getString(request, "ip");
                String desc = RequestTool.getString(request, "desc");
                int port = RequestTool.getInt(request, "port");
                int type = RequestTool.getInt(request, "type");
                //---
                oneProvi = new IPManager();
                oneProvi.setUserSender(userSender);
                oneProvi.setDesc(desc);
                oneProvi.setIpRequest(ip);
                oneProvi.setPortRequest(port);
                oneProvi.setCreateBy(userlogin.getUserName());
                oneProvi.setType(type);
                //------------
                if (oneProvi.addNew(oneProvi)) {
                    String result = oneProvi.executeAddIPCmd(ip, port);
                    if ("success".equals(result.trim())) {
                        session.setAttribute("mess", "Thêm mới IP thành công!");
                        response.sendRedirect(request.getContextPath() + "/admin/firewall-manager/index.jsp");
                        return;
                    } else {
                        session.setAttribute("mess", "Thêm mới IP lỗi:" + result);
                    }
                } else {
                    session.setAttribute("mess", "Thêm mới IP DB lỗi:");
                }
            }
        %>
        <div id="main_container">&quot;
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <form action="" method="post">
                            <table  align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th style="font-weight: bold" scope="col" class="rounded redBoldUp">Thêm mới IP Firewall</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tên tài khoản: </td>
                                        <td colspan="2">
                                            <select id="_list_customer" style="width: 380px" name="userSender">
                                                <option value="">Tất cả</option>
                                                <%ArrayList<Account> agency = Account.getCPAgentcy();
                                                    for (Account one : agency) {
                                                        if (one.getUserType() != Account.TYPE.AGENCY.val) {
                                                            continue;
                                                        }
                                                %>
                                                <option value="<%=one.getUserName()%>"
                                                        img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >
                                                    <%="[" + one.getUserName() + "] " + one.getFullName()%>
                                                </option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mô tả: </td>
                                        <td colspan="2"><input size="75" type="text" name="desc"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">IP Được cấp: </td>
                                        <td colspan="2"><input size="75" type="text" name="ip"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Port Accept: </td>
                                        <td colspan="2"><input size="75" type="text" name="port"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Type</td>
                                        <td>
                                            <select name="type">
                                                <option value="<%=IPManager.TYPE.ACCEPT.val%>">Kích hoạt</option>
                                                <option value="<%=IPManager.TYPE.BLOCK.val%>">Khoá</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <input class="button" type="submit" name="submit" value="Thêm mới"/>
                                            <input class="button" onclick="window.location.href = '/admin/firewall-manager/index.jsp'" type="reset" name="reset" value="Hủy"/>
                                        </td>
                                    </tr>
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