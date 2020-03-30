<%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.utils.StringUtil"%><%@page import="gk.myname.vn.entity.AppConfig" %><%@page import="java.util.ArrayList" %>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <%            if (!userlogin.checkView(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập module này!");
                response.sendRedirect(request.getContextPath() + "/admin");
                return;
            }
        %>
    </head>
    <body>
        <div id="main_container">
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
                        <div align="center" style="height: 20px;margin-bottom: 12px;margin-top: 10px">
                            <%if (userlogin.checkAdd(request)) {%><a href="<%=request.getContextPath() + "/admin/configApp/add.jsp"%>">
                                <img border="0"  src="<%= request.getContextPath()%>/admin/resource/images/add_1.gif"/>
                            </a><%}%>
                        </div>
                        <!--Content-->
                        <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company">ID</th>
                                    <th scope="col" class="rounded">KEY_NAME</th>
                                    <th scope="col" class="rounded">KEY_VALUE</th>
                                    <th scope="col" class="rounded">Mô Tả</th>
                                    <th scope="col" class="rounded">Tạo Bởi</th>
                                    <th scope="col" class="rounded"> Ngày tạo </th>
                                    <th scope="col" class="rounded">Ngày Cập Nhật</th>
                                    <th scope="col" class="rounded">Cập nhật bởi </th>
                                    <%=buildHeader(request, userlogin,true,true)%>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong

                                    AppConfig appConfig = new AppConfig();
                                    ArrayList<AppConfig> listConfig = appConfig.getAll();
                                    if (listConfig.size() > 0)
                                        for (AppConfig oneConfig : listConfig) {
                                %>
                                <tr>
                                    <td class="boder_right"><%=count++%></td>
                                    <td class="boder_right" align="left">
                                        <%=oneConfig.getConfig_key()%>
                                    </td>
                                    <td class="boder_right cnnNumberFormat"  >
                                        <%=oneConfig.getConfig_value().replaceAll(",", "</br>") %>
                                    </td>
                                    <%-- mo ta --%>
                                    <td class="boder_right">
                                        <%= oneConfig.getCf_desc()%>
                                    </td>
                                    <%-- tao boi --%>
                                    <td class="boder_right" >
                                        <%= oneConfig.getCreate_by()%>
                                    </td>
                                    <%-- ngay tao  --%>
                                    <td class="boder_right">
                                        <%= oneConfig.getCreate_date()%>
                                    </td>
                                    <%-- ngay cap nhat : --%>
                                    <td class="boder_right">
                                        <%= oneConfig.getUpdate_date() != "" ? oneConfig.getUpdate_date() : "--"%>
                                    </td>
                                    <%-- cap nhat boi : --%>
                                    <td class="boder_right">
                                        <%= oneConfig.getUpdate_by() != "" ? oneConfig.getUpdate_by() : "--"%>
                                    </td>
                                    <%-- edit --%>
                                    <%=buildControl(request, userlogin,
                                            "/admin/configApp/edit.jsp?key=" + oneConfig.getConfig_key(),
                                            "/admin/configApp/del.jsp?id=" + oneConfig.getID()
                                    )%>
                                    <%
                                        }
                                    else {
                                    %>
                                    <h1 align="center"> Dữ liệu trống ! </h1>
                                    <%
                                        }//end check null
                                    %>
                                </tr>
                            </tbody>
                        </table>
                    </div><!-- end of right content-->
                </div>   <!--end of center content -->
                <div class="clear"></div>
            </div><!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html>