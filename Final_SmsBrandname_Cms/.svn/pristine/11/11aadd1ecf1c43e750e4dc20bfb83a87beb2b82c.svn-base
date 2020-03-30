<%@page import="gk.myname.vn.admin.AccountRole"%>
<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        <%            if (!userlogin.checkView(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin/");
                return;
            }
            String key = RequestTool.getString(request, "key");
            int status = RequestTool.getInt(request, "status",-1);
            if(status==-1){
                status=1;//Mac dinh se lay cac tai khoan active
            }
            ArrayList all = null;
            Account dao = new Account();
            int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
            if (currentPage < 1) {
                currentPage = 1;
            }
            maxRow = 50;
            int totalPage = 0;
            //int totalRow = dao.countAllUser(key);
            int totalRow = dao.countAllUserAndStatus(key,status);
            totalPage = (int) totalRow / maxRow;
            if (totalRow % maxRow != 0) {
                totalPage++;
            }
            //all = dao.getAllUser(currentPage, maxRow, key);
            all = dao.getAllUserWithStatus(currentPage, maxRow, key, status);
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
                                        <th scope="col" class="rounded-q4 redBoldUp">Tìm kiếm tài khoản khách hàng lẻ</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Từ khoá</td>
                                        <td>
                                            <input type="text" name="key" size="55" value="<%=key%>"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Trạng thái</td>
                                        <td>
                                            <select name="status">
                                                <option <%=status == 1 ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%=status == 0 ? "selected='selected'" : ""%> value="0">Khóa</option>
                                                <option <%=status == 404 ? "selected='selected'" : ""%> value="404">Đã xoá</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;
                                            <%=buildAddControl(request, userlogin, "/admin/customer/khle/add.jsp")%>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                        <!--End tim kiếm-->
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
                                    <th scope="col" class="rounded">ID TK</th>
                                    <th scope="col" class="rounded">CP CODE</th>
                                    <th scope="col" class="rounded">Tên đăng nhập</th>
                                    <th scope="col" class="rounded">Họ tên</th>
                                    <th scope="col" class="rounded">Điện thoại</th>
                                    <th scope="col" class="rounded">Email</th>
                                    <th scope="col" class="rounded">Quata</th>
                                    <th scope="col" class="rounded">Đăng nhập</th>
                                    <th scope="col" class="rounded">API</th>
                                        <%=buildHeader(request, userlogin, true, true)%>
                                </tr>
                            </thead>
                            <tbody>
                                <%                                    int count = 1; //Bien dung de dem so dong
                                    for (Iterator<Account> iter = all.iterator(); iter.hasNext();) {
                                        Account oneAdmin = iter.next();
                                        int index = (currentPage - 1) * maxRow + count++;
                                %>
                                <tr>
                                    <td class="boder_right"><%=index%></td>
                                    <td align="left" class="boder_right">
                                        <%=oneAdmin.getAccID()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=oneAdmin.getCpCode()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=oneAdmin.getUserName()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%= oneAdmin.getFullName()%>
                                    </td>
                                    <td align="center" class="boder_right">
                                        <%=oneAdmin.getPhone()%>
                                    </td>
                                    <td class="boder_right"><%=Tool.checkNull(oneAdmin.getEmail()) ? "" : oneAdmin.getEmail().replaceAll(",", "<br/>")%></td>

                                    <td class="boder_right"><%=oneAdmin.getMaxBrand()%></td>
                                    <% AccountRole roleOne = oneAdmin.getRole(); %>
                                    <td align="center" class="boder_right">
                                        <%
                                            if (!roleOne.isLockLogin()) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%
                                        } else {
                                        %>
                                        <img width="16" src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <td align="center" class="boder_right">
                                        <%
                                            if (oneAdmin.getStatus() == 1) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%
                                        } else if (oneAdmin.getStatus() == 404) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/remove.png"/>
                                        <%
                                        } else {
                                        %>
                                        <img width="16" src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <%=buildControl(request, userlogin,
                                            "/admin/customer/khle/edit.jsp?id=" + oneAdmin.getAccID(),
                                            (oneAdmin.getStatus() == 404) ? "javascript:void(0)" : "/admin/customer/khle/del.jsp?id=" + oneAdmin.getAccID()
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