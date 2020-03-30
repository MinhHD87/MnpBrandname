<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.EmailConfigManager"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        <%            if (!userlogin.checkEdit(request)) {
                session.setAttribute("mess", "Bạn không có quyền sửa module này!");
                response.sendRedirect(request.getContextPath() + "/admin/email_manager/");
                return;
            }
            int id = RequestTool.getInt(request, "id");
            EmailConfigManager appDao = new EmailConfigManager();
            EmailConfigManager emailConfig = appDao.getConfigById(id);
            if (id <= 0 || emailConfig == null) {
                session.setAttribute("mess", "Nội dung bạn tìm kiếm không tồn tại ! ");
                response.sendRedirect(request.getContextPath() + "/admin/email_manager/");
                return;
            }
            if (request.getParameter("submit") != null) {
                String maildesc = RequestTool.getString(request, "maildesc");
                String fromname = RequestTool.getString(request, "fromname");
                String email = RequestTool.getString(request, "email");
                String passmail = RequestTool.getString(request, "passmail");
                String hostemail = RequestTool.getString(request, "hostemail");
                String portmail = RequestTool.getString(request, "portmail");
                String securentype = RequestTool.getString(request, "securentype");
                int status = RequestTool.getInt(request, "status");

                emailConfig.setEmail(email);
                emailConfig.setFromname(fromname);
                emailConfig.setHostemail(hostemail);
                emailConfig.setMaildesc(maildesc);
                emailConfig.setPassmail(passmail);
                emailConfig.setPortmail(portmail);
                emailConfig.setSecurentype(securentype);
                emailConfig.setStatus(status);

                if (appDao.updateConfig(emailConfig)) {
                    session.setAttribute("mess", "Sửa  thành công");
                    response.sendRedirect(request.getContextPath() + "/admin/email_manager/");
                    return;
                } else {
                    session.setAttribute("mess", "Sửa lỗi");
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
                            <%  if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <form action="" method="post">
                            <table align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th style="font-weight: bold"  scope="col" class="rounded redBoldUp">
                                            Sửa Email : <i><%= emailConfig.getEmail()%></i> 
                                        </th>
                                        <th scope="col" class="rounded"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td align="left"></td>
                                        <td align="left">Mô tả Email:</td>
                                        <td colspan="2">
                                            <input size="50" value="<%=emailConfig.getMaildesc()%>" type="text" name="maildesc"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left"></td>
                                        <td align="left">FromName:</td>
                                        <td colspan="2">
                                            <input size="50" value="<%=emailConfig.getFromname()%>" type="text" name="fromname"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left"></td>
                                        <td align="left">EMAIL:</td>
                                        <td colspan="2">
                                            <input size="50" value="<%=emailConfig.getEmail()%>" type="text" name="email"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left"></td>
                                        <td align="left">PassMail:</td>
                                        <td colspan="2">
                                            <input size="50" value="<%=emailConfig.getPassmail()%>" type="password" name="passmail"/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td align="left"></td>
                                        <td align="left">HostEmail:</td>
                                        <td colspan="2">
                                            <input size="50" readonly="readonly" value="<%=emailConfig.getHostemail()%>" type="text" name="hostemail"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left"></td>
                                        <td align="left">PortMail:</td>
                                        <td colspan="2">
                                            <input size="50" readonly="readonly" value="<%=emailConfig.getPortmail()%>" type="text" name="portmail"/>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td></td>
                                        <td align="left">SECURE_TYPE </td>
                                        <td  colspan="3">
                                            <select  name="securentype">
                                                <option value="None">None</option>
                                                <option value="SSL" >SSL</option>
                                                <option value="TSL" >TSL</option>
                                                <option value="Auto" >Auto</option>
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
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/email_manager/"%>'" type="reset" name="reset" value="Hủy"/>
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