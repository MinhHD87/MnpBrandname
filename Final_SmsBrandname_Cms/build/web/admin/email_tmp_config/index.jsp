<%@page import="gk.myname.vn.entity.Email_tmp_config"%>
<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.utils.Tool"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        <%            
            ArrayList<Email_tmp_config> all = null;
            Email_tmp_config edao = new Email_tmp_config();
            int max = 20;
            int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
            if (currentPage < 1) {
                currentPage = 1;
            }
            int id = RequestTool.getInt(request, "id");
            String name = RequestTool.getString(request, "name");
            String des = RequestTool.getString(request, "des");
            String content = RequestTool.getString(request, "content");
            int status = RequestTool.getInt(request, "status", -1);

            all = edao.getAll(currentPage, max, name, des, content, status);
            int totalPage = 0;
            int totalRow = edao.countAll(name, status);
            totalPage = (int) totalRow / max;
            if (totalRow % max != 0) {
                totalPage++;
            }
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <form action="<%=request.getContextPath() + "/admin/email_tmp_config/"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Email_tmp_config</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;<span class="redBold">Tên Công ty </span>
                                            <input value="" id="stRequest" class="dateproc" size="30" type="text" name="name"/>
                                            &nbsp;&nbsp;&nbsp;
                                            Trạng thái
                                            <select name="status">
                                                <option <%=status == -1 ? "selected='selected'" : ""%> value="-1">-Tất cả-</option>
                                                <option <%=status == 1 ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%=status == 0 ? "selected='selected'" : ""%> value="0">Khóa</option>
<!--                                                <option <%=status == 404 ? "selected='selected'" : ""%> value="404">Đã xóa</option>-->
                                            </select>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <%=buildAddControl(request, userlogin, "/admin/email_tmp_config/addNew.jsp")%>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>  
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <!--Content-->
                        <%@include file="/admin/includes/page.jsp" %>
                        <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company">STT</th>
                                    <th scope="col" class="rounded">ID</th>
                                    <th scope="col" class="rounded">Tiêu đề</th>
                                    <th scope="col" class="rounded">Mô tả</th>
                                    <th scope="col" class="rounded">Nội dung</th>
                                    <th scope="col" class="rounded">Trạng thái</th>
                                        <%=buildHeader(request, userlogin, true, true)%>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    for (Iterator<Email_tmp_config> iter = all.iterator(); iter.hasNext();) {
                                        Email_tmp_config oneE = iter.next();
                                                                            %>
                                <tr>
                                    <td class="boder_right"><%=count++%></td>
                                    <td align="left" class="boder_right">
                                        <%=oneE.getId()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=oneE.getName()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%= oneE.getDes()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%= oneE.getContent()%>
                                    </td>
                                    <td class="boder_right">
                                        <%
                                            if (oneE.getStatus() == 1) {
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
                                            "/admin/email_tmp_config/edit.jsp?id=" + oneE.getId(),
                                            "/admin/email_tmp_config/del.jsp?id=" + oneE.getId())%>
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