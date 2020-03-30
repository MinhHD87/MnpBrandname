<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.utils.StringUtil"%><%@page import="gk.myname.vn.entity.EmailConfigManager" %><%@page import="java.util.ArrayList" %>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
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
                        <%
                            String email = "";
                            if (!Tool.checkNull(request.getParameter("email"))) {
                                email = request.getParameter("email").trim();
                            }
                            String fromname = "";
                            if (!Tool.checkNull(request.getParameter("fromname"))) {
                                fromname = request.getParameter("fromname").trim();
                            }
                            String securentype = "";
                            if (!Tool.checkNull(request.getParameter("securentype"))) {
                                securentype = request.getParameter("securentype").trim();
                            }
                            int status = RequestTool.getInt(request, "status", -1);

                        %>
                        <form action="<%=request.getContextPath() + "/admin/email_manager/"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Tìm Kiếm Email</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td class="redBold">Email:</td>
                                        <td> 
                                            <input value="" id="stRequest" class="dateproc" size="30" type="text" name="email" placeholder="Nhập Email"/>
                                            &nbsp;&nbsp;&nbsp;<span class="redBold">SecurenType </span>
                                            <select name="securentype">
                                                <option value="">Tất cả</option>
                                                <option  value="None">None</option>
                                                <option  value="SSl">SSl</option>
                                                <option  value="TSL">TSL</option>
                                                <option value="Auto">Auto</option>
                                            </select>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td class="redBold">Fromname:</td>
                                        <td>
                                            <input value="" id="stRequest" class="dateproc" size="30" type="text" name="fromname"  placeholder="Nhập FromName"/>
                                            &nbsp;&nbsp;&nbsp;
                                            <span class="redBold">Status: </span>
                                            <select name="status" style="margin-left: 10px">
                                                <option <%=status == -1 ? "selected='selected'" : ""%> value="-1">-Tất cả-</option>
                                                <option <%=status == 1 ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%=status == 0 ? "selected='selected'" : ""%> value="0">Khóa</option>
                                                <option <%=status == 404 ? "selected='selected'" : ""%> value="404">Đã xóa</option>
                                            </select>

                                        </td>
                                    </tr>

                                    <tr align="center">
                                        <td colspan="3">
                                            <%if (userlogin.checkAdd(request)) {%>
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/> &nbsp;&nbsp;&nbsp;

                                            <input class="button" value="Thêm mới" type="button" border="0"  onclick="location.href = '<%=request.getContextPath() + "/admin/email_manager/add.jsp"%>'"/>
                                            <%}%>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                            <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                                <%                                if (session.getAttribute("mess") != null) {
                                        out.print(session.getAttribute("mess"));
                                        session.removeAttribute("mess");
                                    }
                                %>
                            </div>
                        </form>  
                        <!--Content-->
                        <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company">ID</th>
                                    <th scope="col" class="rounded">Email</th>
                                    <th scope="col" class="rounded">FromName</th>
                                    <th scope="col" class="rounded">HostEmail</th>
                                    <th scope="col" class="rounded">MailDesc</th>
                                    <th scope="col" class="rounded">PassMail</th>
                                    <th scope="col" class="rounded">PortMail</th>
                                    <th scope="col" class="rounded">SecurenType</th>
                                    <th scope="col" class="rounded">Status</th>
                                        <%=buildHeader(request, userlogin, true, true)%>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong

                                    EmailConfigManager appConfig = new EmailConfigManager();
                                    int pages = 1;

                                    ArrayList<EmailConfigManager> listConfig = appConfig.getAll(pages, email, fromname, securentype, status);
                                    if (listConfig.size() > 0)
                                        for (EmailConfigManager oneConfig : listConfig) {
                                %>
                                <tr>
                                    <td class="boder_right"><%=count++%></td>
                                    <td class="boder_right" align="left">
                                        <%=oneConfig.getEmail()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneConfig.getFromname()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneConfig.getHostemail()%>
                                    </td>
                                    <td class="boder_right cnnNumberFormat"  >
                                        <%=oneConfig.getMaildesc()%>
                                    </td>
                                    <td class="boder_right">
                                        <input type="password" style="width: 50px" id="password" name="password" readonly="true" value="<%= oneConfig.getPassmail()%>"/>
                                    </td>
                                    <td  class="boder_right">
                                        <%= oneConfig.getPortmail()%>
                                    </td>
                                    <td class="boder_right">
                                        <%= oneConfig.getSecurentype()%>
                                    </td>
                                    <td align="center" class="boder_right">
                                        <%
                                            if (oneConfig.getStatus() == 1) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%
                                        } else if (oneConfig.getStatus() == 404) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/Full_Recycle_Bin.png"/>
                                        <%
                                        } else {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <%-- edit --%>
                                    <%=buildControl(request, userlogin,
                                            "/admin/email_manager/edit.jsp?id=" + oneConfig.getId(),
                                            "/admin/email_manager/del.jsp?id=" + oneConfig.getId()
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