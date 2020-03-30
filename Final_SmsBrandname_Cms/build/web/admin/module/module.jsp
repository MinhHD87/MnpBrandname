<%@page import="gk.myname.vn.admin.Modules"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        <%
            if (!userlogin.checkView(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập trang này!");
                response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
                return;
            }
            ArrayList all = null;
            Modules dao = new Modules();
            all = dao.listAllModule();
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
                        <div align="center" style="height: 20px;margin-bottom: 12px;margin-top: 10px">
                            <span style="font-weight: bold;color: blueviolet;margin-right: 10px">QUẢN LÝ MODULE HỆ THỐNG</span>
                            <%=buildAddControl(request, userlogin, "/admin/module/addModule.jsp")%>
                        </div>
                        <!--Content-->
                        <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company">STT</th>
                                    <th scope="col" class="rounded">Module ID</th>
                                    <th scope="col" class="rounded">Module Name</th>
                                    <th scope="col" class="rounded">Module Resource</th>
                                    <th scope="col" class="rounded">Trạng thái</th>                                    
                                    <%=buildHeader(request, userlogin,true,true)%>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    for (Iterator<Modules> iter = all.iterator(); iter.hasNext();) {
                                        Modules oneModule = iter.next();
                                %>
                                <tr>
                                    <td class="boder_right"><%=count++%></td>
                                    <td  class="boder_right" align="left">
                                        <%=oneModule.getModulID()%>
                                    </td>
                                    <td  class="boder_right" align="left">
                                        <%=oneModule.getName()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%= oneModule.getResource()%>
                                    </td>
                                    <td class="boder_right" align="center"><%
                                        if (oneModule.getStatus() == 1) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%
                                        } else {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                        <%
                                            }
                                        %>
                                    </td>  
                                    <%=buildControl(request, userlogin,
                                            "/admin/module/editModule.jsp?id=" + oneModule.getModulID(),
                                            "/admin/module/delModule.jsp?id=" + oneModule.getModulID()
                                    )%>
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