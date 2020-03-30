<%@page import="gk.myname.vn.admin.GroupAccDetail"%><%@page import="gk.myname.vn.admin.Groups"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <script>
        function checkallMove() {
            var chk = document.getElementById("checkall");
            if (chk.checked) {
                var chkmove = document.getElementsByName("chkmove");
                for (var i = 0; i < chkmove.length; i++)
                    chkmove[i].checked = true;
            } else {
                var chkmove = document.getElementsByName("chkmove");
                for (var i = 0; i < chkmove.length; i++)
                    chkmove[i].checked = false;
            }
        }
        function CheckMove() {
            var chkmove = document.getElementsByName("chkmove");
            for (var i = 0; i < chkmove.length; i++) {
                if (chkmove[i].checked) {
                    return true;
                }
            }
            alert("Bạn cần chọn ít nhất một tài khoản để đưa vào Group");
            return false;
        }
        function submitFrm() {
            document.forms['frmChoice'].submit();
        }
    </script>
    <body>
        <%if (!userlogin.checkEdit(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập trang này!");
                response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
                return;
            }
            int groupId = RequestTool.getInt(request, "id");
            String key = RequestTool.getString(request, "key");
            ArrayList all = null;
            Account dao = new Account();
            all = dao.getAllAccount(Account.TYPE.ADMIN.val, key);
            Groups g = Groups.CACHE_ALL.get(groupId);
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <form name="search" method="post" action="">
                            <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th colspan="2" scope="col" class="rounded-q4">Tìm kiếm: 
                                            <span style="font-weight: bold;color: blueviolet;margin-right: 10px">
                                                THÊM QUẢN TRỊ VÀO NHÓM: </span> 
                                            <span class="redBold"><%=g.getName()%></span>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Username or Full Name</td>
                                        <td><input size="70" type="text" value="" name="key"/></td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="3">
                                            <input class="button" type="hidden" value="<%=groupId%>" name="id"/>
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            <input onclick="window.location.href='<%=request.getContextPath() + "/admin/group/addGroup.jsp"%>'" class="button" type="submit" name="submit" value="Thêm mới"/>
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
                            %>
                        </div>
                        <!--Content-->
                        <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company">
                                        <input type="checkbox" id="checkall" name="checkall" onclick="checkallMove()"/>
                                    </th>
                                    <th scope="col" class="rounded">Tên đăng nhập</th>
                                    <th scope="col" class="rounded">Họ tên</th>
                                    <th scope="col" class="rounded">Điện thoại</th>
                                    <th scope="col" class="rounded">Email</th>
                                    <th scope="col" class="rounded">Add 2 Group</th>
                                    <th scope="col" class="rounded">Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (Iterator<Account> iter = all.iterator(); iter.hasNext();) {
                                        Account oneAdmin = iter.next();
                                %>
                                <tr>
                                    <td>
                                        <input value="<%=oneAdmin.getAccID()%>" type="checkbox" name="chkmove" />
                                    </td>
                                    <td align="center"><%=oneAdmin.getUserName()%></td>
                                    <td align="center"><%= oneAdmin.getFullName()%></td>
                                    <td align="center"><%=oneAdmin.getPhone()%></td>
                                    <td><%=oneAdmin.getEmail()%></td>
                                    <td align="center">
                                        <%if (GroupAccDetail.checkExitAcc(oneAdmin.getAccID(), g)) {
                                                out.print("<a href='" + request.getContextPath() + "/admin/group/removeAcc.jsp?gid=" + groupId + "&uid=" + oneAdmin.getAccID() + "' class='ask'><img title='Remove From Group' src='/admin/resource/images/remove.png'/></a>");
                                            } else {%>
                                        <a class="ask" href="<%=request.getContextPath() + "/admin/group/map-user.jsp?gid=" + groupId + "&uid=" + oneAdmin.getAccID()%>">Add to Group</a>
                                        <%}%>
                                    </td>
                                    <td align="center">
                                        <%if (oneAdmin.getStatus() == 1) {%>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%} else {%>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                        <%}%>
                                    </td>
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