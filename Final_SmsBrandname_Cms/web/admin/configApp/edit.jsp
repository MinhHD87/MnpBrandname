<%@page import="gk.myname.vn.entity.AppConfig"%>
<%@page import="gk.myname.vn.utils.Tool"%>
<%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        <%            if (!userlogin.checkEdit(request)) {
                session.setAttribute("mess", "Bạn không có quyền sửa module này!");
                response.sendRedirect(request.getContextPath() + "/admin/configApp/");
                return;
            }
            String key = request.getParameter("key").trim();
            Tool.debug("configApp.key="+key);
            AppConfig app = new AppConfig();
            AppConfig appConfig = app.getConfigByKey(key);
            if (appConfig == null ||  Tool.checkNull(appConfig.getConfig_key())) {
                session.setAttribute("mess", "Nội dung bạn tìm kiếm không tồn tại ! ");
                response.sendRedirect(request.getContextPath() + "/admin/configApp/");
                return;
            }
            if (request.getParameter("submit") != null) {
                String configValue = Tool.validStringRequest(request.getParameter("config_value"));
                String cf_desc = Tool.validStringRequest(request.getParameter("cf_desc"));

                appConfig.setConfig_value(configValue);
                appConfig.setCf_desc(cf_desc);
                appConfig.setUpdate_by(userlogin.getUserName());

                if (app.updateConfig(appConfig)) {
                    session.setAttribute("mess", "Sửa  thành công");
                    response.sendRedirect(request.getContextPath() + "/admin/configApp/");
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
                                            Sửa CONFIG_KEY : <i><%= appConfig.getConfig_key()%></i> 
                                        </th>
                                        <th scope="col" class="rounded-q4"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td align="left"></td>
                                        <td align="left">CONFIG_VALUE</td>
                                        <td colspan="2">
                                            <input size="75" value="<%=appConfig.getConfig_value()%>" type="text" name="config_value"/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td align="left"></td>
                                        <td align="left">Thông tin</td>
                                        <td colspan="2">
                                            <input size="75" value="<%=appConfig.getCf_desc()%>" type="text" name="cf_desc"
                                        </td>
                                    </tr>

                                    <tr>
                                        <%-- tao boi --%>
                                        <td align="left"></td>
                                        <td align="left">Tạo bởi</td>
                                        <td> <%= appConfig.getCreate_by()%></td>
                                    </tr>

                                    <tr>
                                        <%-- ngay cap nhat --%>
                                        <td align="left"></td>
                                        <td align="left">Ngày tạo </td>
                                        <td><%= appConfig.getCreate_date()%></td>
                                    </tr>
                                    <tr>
                                        <%-- ngay cap nhat : --%>
                                        <td align="left"></td>
                                        <td align="left">Ngày cập nhật </td>
                                        <td> <%= appConfig.getUpdate_date() != "" ? appConfig.getUpdate_date() : "--"%></td>
                                    </tr>

                                    <tr>
                                        <%-- cap nhat boi : --%>
                                        <td align="left"></td>
                                        <td align="left">Cập nhật bởi </td>
                                        <Td><%= appConfig.getUpdate_by() != "" ? appConfig.getUpdate_by() : "--"%></td>
                                    </tr>

                                    <tr>
                                        <td colspan="4" align="center">
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/configApp/"%>'" type="reset" name="reset" value="Hủy"/>
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