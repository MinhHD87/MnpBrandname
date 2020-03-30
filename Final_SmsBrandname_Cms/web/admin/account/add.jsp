<%@page import="gk.myname.vn.entity.UserAction"%>
<%@page import="gk.myname.vn.utils.Tool"%>
<%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head><%@include file="/admin/includes/header.jsp" %></head>
    <body>
        <%            if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                
                //CongNX: Ghi log action vao db
                UserAction log = new UserAction(userlogin.getUserName(),
                                UserAction.TABLE.accounts.val,
                                UserAction.TYPE.ADD.val,
                                UserAction.RESULT.REJECT.val,
                                "Permit deny!");
                log.logAction(request);
                //CongNX: ket thuc ghi log db voi action thao tac tu web
                response.sendRedirect(request.getContextPath() + "/admin/module/module.jsp");
                return;
            }
            Account oneAdmin = null;
            if (request.getParameter("submit") != null) {
                //---------------------------
                String account = Tool.validStringRequest(request.getParameter("name"));
                String pass = Tool.validStringRequest(request.getParameter("pass"));
                String fullname = Tool.validStringRequest(request.getParameter("fullname"));
                String phone = Tool.validStringRequest(request.getParameter("phone"));
                String email = Tool.validStringRequest(request.getParameter("email"));
                String desc = Tool.validStringRequest(request.getParameter("desc"));
                String address = Tool.validStringRequest(request.getParameter("address"));
                int status = Tool.string2Integer(request.getParameter("status"));
                int userType = Tool.string2Integer(request.getParameter("userType"));
                //---
                oneAdmin = new Account();
                oneAdmin.setUserName(account);
                oneAdmin.setPassWord(pass);
                oneAdmin.setFullName(fullname);
                oneAdmin.setPhone(phone);
                oneAdmin.setEmail(email);
                oneAdmin.setDescription(desc);
                oneAdmin.setAddress(address);
                oneAdmin.setUserType(userType);
                oneAdmin.setCreateBy(userlogin.getUserName());
                oneAdmin.setUpdateBy(userlogin.getUserName());
                oneAdmin.setStatus(status);
                //------------
                Account admDao = new Account();
                if (admDao.addNew(oneAdmin)) {
                    session.setAttribute("mess", "Thêm mới dữ liệu thành công!");
                    //CongNX: Ghi log action vao db
                    UserAction log = new UserAction(userlogin.getUserName(),
                                UserAction.TABLE.accounts.val,
                                UserAction.TYPE.ADD.val,
                                UserAction.RESULT.SUCCESS.val,
                                "user=" + oneAdmin.getUserName());
                    log.logAction(request);
                    //CongNX: ket thuc ghi log db voi action thao tac tu web
                    response.sendRedirect(request.getContextPath() + "/admin/account/index.jsp");
                    return;
                } else {
                    session.setAttribute("mess", "Thêm mới dữ liệu lỗi!");
                    //CongNX: Ghi log action vao db
                    UserAction log = new UserAction(userlogin.getUserName(),
                                UserAction.TABLE.accounts.val,
                                UserAction.TYPE.ADD.val,
                                UserAction.RESULT.FAIL.val,
                                "user=" + oneAdmin.getUserName());
                    log.logAction(request);
                    //CongNX: ket thuc ghi log db voi action thao tac tu web
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
                                        <th style="font-weight: bold" scope="col" class="rounded redBoldUp">Thêm mới quản trị</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tên đăng nhập: </td>
                                        <td colspan="2"><input autocomplete="off" size="75" type="text" name="name"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mật khẩu: </td>
                                        <td colspan="2"><input autocomplete="off" size="75" type="password" name="pass"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tên thật: </td>
                                        <td colspan="2"><input size="75" type="text" name="fullname"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mobile: </td>
                                        <td colspan="2"><input size="75" type="text" name="phone"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Email: </td>
                                        <td colspan="2"><input size="75" type="text" name="email"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mô tả: </td>
                                        <td colspan="2"><textarea cols="55" name="desc"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Address: </td>
                                        <td colspan="2"><textarea cols="55" name="address"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">USER TYPE: </td>
                                        <td colspan="2">
                                            <select name="userType">
                                                <option value="<%=Account.TYPE.ADMIN.val%>">Quản trị hệ thống</option>
                                                <option value="<%=Account.TYPE.USER.val%>">Tài khoản người dùng</option>
                                            </select>
                                        </td>
                                    </tr>   
                                    <tr>
                                        <td></td>
                                        <td align="left">Trạng thái: </td>
                                        <td colspan="2">
                                            <select name="status">
                                                <option value="1">Kích hoạt</option>
                                                <option value="0">Khóa</option>
                                            </select>
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td colspan="4" align="center">
                                            <input class="button" type="submit" name="submit" value="Thêm mới"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/account/index.jsp"%>'" type="reset" name="reset" value="Hủy"/>
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