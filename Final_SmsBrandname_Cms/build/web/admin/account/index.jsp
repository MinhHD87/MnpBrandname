<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        <%           
            String key = RequestTool.getString(request, "key");
            ArrayList all = null;
            Account dao = new Account();
            all = dao.getAllAccount(Account.TYPE.ADMIN.val, key);
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <form action="<%=request.getContextPath() + "/admin/customer/khle/index.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Tìm kiếm tài khoản Quản trị</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Từ khoá</td>
                                        <td>
                                            <input type="text" name="key" size="55"/>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;
                                            <%=buildAddControl(request, userlogin, "/admin/account/add.jsp")%>
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
                        <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company">STT</th>
                                    <th scope="col" class="rounded">ID</th>
                                    <th scope="col" class="rounded">Tên đăng nhập</th>
                                    <th scope="col" class="rounded">Họ tên</th>
                                    <th scope="col" class="rounded">Điện thoại</th>
                                    <th scope="col" class="rounded">Email</th>
                                    <th scope="col" class="rounded">User Type</th>
                                    <th scope="col" class="rounded">Trạng thái</th>
                                    <%if (userlogin.checkEdit(request)) {%><th scope="col" class="rounded">Quyền</th><%}%>
                                        <%=buildHeader(request, userlogin,true,true)%>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    for (Iterator<Account> iter = all.iterator(); iter.hasNext();) {
                                        Account oneAdmin = iter.next();
                                %>
                                <tr>
                                    <td class="boder_right"><%=count++%></td>
                                    <td class="boder_right"><%=oneAdmin.getAccID()%></td>
                                    <td class="boder_right" align="left">
                                        <%=oneAdmin.getUserName()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%= oneAdmin.getFullName()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneAdmin.getPhone()%>
                                    </td>
                                    <td class="boder_right"><%=oneAdmin.getEmail()%></td>
                                    <td class="boder_right"><%=oneAdmin.getUserType() == Account.TYPE.ADMIN.val ? "Quản tri hệ thống" : "Người dùng"%></td>
                                    <td class="boder_right" align="center">
                                        <%
                                            if (oneAdmin.getStatus() == 1) {
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
                                    <%if (userlogin.checkEdit(request)) {%><td class="boder_right"><a href="<%=request.getContextPath() + "/admin/account/role.jsp?id=" + oneAdmin.getAccID()%>">Quyền</a></td><%}%>
                                    <%=buildControl(request, userlogin,
                                            "/admin/account/edit.jsp?id=" + oneAdmin.getAccID(),
                                            "/admin/account/del.jsp?id=" + oneAdmin.getAccID()
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