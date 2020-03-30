<%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.entity.AppConfig" %><%@page import="java.util.LinkedList" %><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head><%@include file="/admin/includes/header.jsp" %></head>
    <body>
        <%    if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin/configApp/");
                return;
            }
            AppConfig oneConfig = null;
            if (request.getParameter("submit") != null) {
                //---------------------------
                String config_key = Tool.validStringRequest(request.getParameter("config_key").trim() );
                String config_value = Tool.validStringRequest(request.getParameter("config_value").trim());
                String cf_desc = Tool.validStringRequest(request.getParameter("cf_desc").trim());
                
                //---
                oneConfig = new AppConfig();
                oneConfig.setCf_desc(cf_desc);
                oneConfig.setConfig_key(config_key);
                oneConfig.setConfig_value(config_value);
                oneConfig.setCreate_by(userlogin.getUserName());
                
                //------------
                AppConfig admDao = new AppConfig();
                if (admDao.insertConfig(oneConfig)) {
                    session.setAttribute("mess", "Thêm mới dữ liệu thành công!");
                    response.sendRedirect(request.getContextPath() + "/admin/configApp/");
                    return;
                } else {
                    session.setAttribute("mess", "Thêm mới dữ liệu lỗi!, có thể do CONFIG_VALUE bị trùng, xin thử lại sau  ! ");
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
                                        <th scope="col" class="rounded"></th>
                                        <th style="font-weight: bold" scope="col" class="rounded redBoldUp">Thêm mới cài đặt</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left"> CONFIG_KEY </td>
                                        <td colspan="2"><input  type="text" name="config_key"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left"> CONFIG_VALUE</td>
                                        <td colspan="2"><input size="75" type="text" name="config_value"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Chú thích </td>
                                        <td colspan="2"><input size="75" type="text" name="cf_desc"/></td>
                                    </tr>
                                                             
                                    <tr>
                                        <td colspan="4" align="center">
                                            <input class="button" type="submit" name="submit" value="Thêm mới"/>
                                            <input class="button" onclick="window.location.href ='<%=request.getContextPath()+"/admin/configApp/" %>'" value="Hủy" />
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