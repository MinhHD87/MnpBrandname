<%@page import="gk.myname.vn.admin.Groups"%>
<%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
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
            Groups dao = new Groups();
            all = dao.listAllGroups();
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <form name="search" method="post" action="/admin/group/group.jsp">
                            <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th colspan="2" scope="col" class="rounded-q4"><span style="text-align: center;font-weight: bold;color: blueviolet;margin-right: 10px">QUẢN LÝ NHÓM QUẢN TRỊ</span></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Tên nhóm</td>
                                        <td><input size="70" type="text" value="" name="name"/></td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            <input class="button" onclick="window.location.href='<%=request.getContextPath() + "/admin/group/addGroup.jsp"%>'" type="button" name="button" value="Thêm mới"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%
                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                                boolean rightDel = userlogin.checkDel(request);
                                boolean rightEdit = userlogin.checkEdit(request);
                            %>
                        </div>
                        <!--Content-->
                        <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company">STT</th>
                                    <th scope="col" class="rounded">Group Name</th>
                                    <th scope="col" class="rounded">Group Desc</th>
                                    <th scope="col" class="rounded">Trạng thái</th>
                                    <th scope="col" class="rounded">Users</th>
                                    <th scope="col" class="rounded">Role</th>
                                    <%if (rightEdit) {%><th scope="col" class="rounded">Edit</th><%}%>
                                    <%if (rightDel) {%><th scope="col" class="rounded-q4">Delete</th><%}%>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    for (Iterator<Groups> iter = all.iterator(); iter.hasNext();) {
                                        Groups oneGroup = iter.next();
                                %>
                                <tr>
                                    <td><%=count++%></td>
                                    <td align="center">
                                        <%=oneGroup.getName()%>
                                    </td>
                                    <td align="center">
                                        <%= oneGroup.getDescription()%>
                                    </td>
                                    <td align="center"><%
                                        if (oneGroup.getStatus()) {
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
                                    <td><a href="<%="/admin/group/showAcc.jsp?id=" + oneGroup.getGroupID()%>">User</a></td>
                                    <td><a href="<%="/admin/group/permission.jsp?id=" + oneGroup.getGroupID()%>">Quyền</a></td>
                                    <%if (rightEdit) {%><td><a href="<%="/admin/group/editGroup.jsp?id=" + oneGroup.getGroupID()%>"><img width="24px" src="<%= request.getContextPath()%>/admin/resource/images/user_edit.png" alt="" title="" border="0" /></a></td><%}%>
                                    <%if (rightDel) {%><td><a href="<%="/admin/group/delgroup.jsp?id=" + oneGroup.getGroupID()%>" class="ask"><img src="<%= request.getContextPath()%>/admin/resource/images/remove.png" alt="" title="" border="0" /></a></td><%}%>
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