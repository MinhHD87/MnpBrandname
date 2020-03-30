<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.entity.EmailConfigManager" %><%@page import="java.util.LinkedList" %><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head><%@include file="/admin/includes/header.jsp" %></head>
    <body>
        <%    if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin/email_manager/");
                return;
            }
            EmailConfigManager oneConfig = null;
            if (request.getParameter("submit") != null) {
                //---------------------------
                String maildesc = RequestTool.getString(request, "maildesc");
                String fromname = RequestTool.getString(request, "fromname");
                String email = RequestTool.getString(request, "email");
                String passmail = RequestTool.getString(request, "passmail");
                String hostemail = RequestTool.getString(request, "hostemail");
                String portmail = RequestTool.getString(request, "portmail");
                String securentype = RequestTool.getString(request, "securentype");
                int status = RequestTool.getInt(request, "status");

                //---
                oneConfig = new EmailConfigManager();
                oneConfig.setEmail(email);
                oneConfig.setFromname(fromname);
                oneConfig.setHostemail(hostemail);
                oneConfig.setMaildesc(maildesc);
                oneConfig.setPassmail(passmail);
                oneConfig.setPortmail(portmail);
                oneConfig.setSecurentype(securentype);
                oneConfig.setStatus(status);
                //------------
                EmailConfigManager admDao = new EmailConfigManager();
                if (admDao.insertConfig(oneConfig)) {
                    session.setAttribute("mess", "Thêm mới dữ liệu thành công!");
                    response.sendRedirect(request.getContextPath() + "/admin/email_manager/");
                    return;
                } else {
                    session.setAttribute("mess", "Thêm mới dữ liệu lỗi!, có thể do bị trùng, xin thử lại sau  ! ");
                }
            }
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%
                                if (session.getAttribute("mess") != null) {
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
                                        <th colspan="3" style="font-weight: bold" scope="col" class="rounded-q4 redBoldUp">Thêm mới cài đặt</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mô tả Email </td>
                                        <td colspan="2"><input placeholder="Hỗ trợ brand HTC" size="59"  type="text" name="maildesc"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Gửi từ</td>
                                        <td colspan="2"><input placeholder="From Name" size="50" type="text" name="fromname"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">EMAIL </td>
                                        <td colspan="2"><input size="50" type="text" name="email"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mật khẩu </td>
                                        <td colspan="2"><input size="50" type="password" name="passmail"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">HOST_MAIL </td>
                                        <td colspan="2"><input value="mail.htcjsc.vn" readonly="readonly" size="50" type="text" name="hostemail"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">PORT_MAIL </td>
                                        <td colspan="2"><input readonly="readonly" value="465" size="50" type="text" name="portmail"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">SECURE_TYPE </td>
                                        <td colspan="3">
                                            <select name="securentype">
                                                <option >None</option>
                                                <option  >SSL</option>
                                                <option  >TSL</option>
                                                <option  >Auto</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">STATUS </td>
                                       <td colspan="2">
                                            <select name="status">
                                                <option value="1" >Active </option>
                                                <option value="0" >Block </option>
                                               
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <input class="button" type="submit" name="submit" value="Thêm mới"/>
                                            <input class="button" type="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/email_manager/"%>'" value="Hủy" />
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