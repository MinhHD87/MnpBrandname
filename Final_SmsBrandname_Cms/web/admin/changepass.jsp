<%@page import="gk.myname.vn.utils.Tool"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        <%            Account admDao = new Account();
            if (request.getParameter("submit") != null) {
                String newpass = Tool.validStringRequest(request.getParameter("newpass"));
                String cfnewpass = Tool.validStringRequest(request.getParameter("cfnewpass"));
                if (newpass != null && newpass.equals(cfnewpass)) {
                    if (admDao.updatePass(userlogin.getAccID(), newpass)) {
                        response.sendRedirect("/admin/index.jsp");
                        return;
                    } else {
                        session.setAttribute("mess", "Sửa dữ liệu lỗi");
                    }
                } else {
                    session.setAttribute("mess", "Mật khẩu mới và mật khẩu xác thực không khớp!");
                }
            }
        %>
        <div id="main_container">
            <div class="header">
                <div class="logo"><a href="#"><img src="<%= request.getContextPath()%>/admin/resource/images/logo.gif" alt="" title="" border="0" /></a></div>
                <div class="right_header">Welcome: <a href="<%= request.getContextPath()%>/admin/changepass.jsp"><b><%=(userlogin.getUserName()!= null) ? userlogin.getUserName(): ""%></b></a> | <a href="<%= request.getContextPath()%>/admin/out.jsp" class="logout">Thoát</a></div>
                <div id="clock_a"></div>
            </div>
            <div class="main_content">

                <%@include file="/admin/includes/menu.jsp" %>

                <div class="center_content">  

                    <div class="right_content">
                        <div align="center" style="height: 20px;margin-bottom: 2px">
                            <%
                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <form action="" method="post">
                            <table align="center" style="margin-left: 250px" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded"></th>
                                        <th style="font-weight: bold"  scope="col" class="rounded">Đổi mật khẩu</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td align="left">Tên đăng nhập: </td>
                                        <td colspan="2"><input size="50" readonly="readonly" value="<%=userlogin.getUserName()%>" type="text" name="name"/></td>
                                    </tr>
                                    <tr>
                                        <td align="left">Mật khẩu mới: </td>
                                        <td colspan="2"><input size="50" value="" type="text" name="newpass"/></td>
                                    </tr>
                                    <tr>
                                        <td align="left">Xác nhận mật khẩu mới: </td>
                                        <td colspan="2"><input size="50" value="" type="text" name="cfnewpass"/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center">
                                            <input type="submit" name="submit" value="Cập nhật"/>
                                            <input  onclick="window.location.href = 'index.jsp'" type="reset" name="reset" value="Hủy"/>
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