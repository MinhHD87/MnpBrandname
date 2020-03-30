<%@page import="gk.myname.vn.entity.Subsidiary"%><%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        <%    if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin/subsidiary/");
                return;
            }
            if (request.getParameter("submit") != null) {
                //---------------------------
                String name = Tool.validStringRequest(request.getParameter("name"));
                String address = Tool.validStringRequest(request.getParameter("address"));
                String bank_acc = Tool.validStringRequest(request.getParameter("bank_acc"));
                String bank_add = Tool.validStringRequest(request.getParameter("bank_add"));
                String business_code = Tool.validStringRequest(request.getParameter("business_code"));
                String phone = Tool.validStringRequest(request.getParameter("phone"));
                String fax = Tool.validStringRequest(request.getParameter("fax"));
                String manager = Tool.validStringRequest(request.getParameter("manager"));
                int status = Tool.string2Integer(request.getParameter("status"));

                Subsidiary sub = new Subsidiary();
                sub.setName(name);
                sub.setAddress(address);
                sub.setBank_acc(bank_acc);
                sub.setBank_add(bank_add);
                sub.setBusiness_code(business_code);
                sub.setPhone(phone);
                sub.setFax(fax);
                sub.setManager(manager);
                sub.setStatus(status);
                //------------
                Subsidiary subsidiary = new Subsidiary();
                if (subsidiary.add(sub)) {
                    session.setAttribute("mess", "Thêm mới đối tác thành công!");
                } else {
                    session.setAttribute("mess", "Thêm mới dữ liệu lỗi!");
                }
                response.sendRedirect(request.getContextPath() + "/admin/subsidiary/");
                return;
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
                                        <th align="center" style="font-weight: bold" scope="col" class="rounded redBoldUp">
                                            Thêm mới đối tác</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tên Công Ty: </td>
                                        <td><input autocomplete="off" size="50" type="text" name="name"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Địa Chỉ: </td>
                                        <td><textarea autocomplete="off" cols="40" rows="5" type="text" name="address"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tài Khoản Ngân Hàng: </td>
                                        <td><input autocomplete="off" size="50" type="text" name="bank_acc"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Địa Chỉ Ngân Hàng: </td>
                                        <td><textarea autocomplete="off" cols="40" rows="5" type="text" name="bank_add"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mã Số Doanh Nghiệp (MST): </td>
                                        <td><input autocomplete="off" size="50" type="text" name="business_code"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Điện thoại: </td>
                                        <td><input autocomplete="off" size="50" type="text" name="phone"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Fax: </td>
                                        <td><input autocomplete="off" size="50" type="text" name="fax"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Quản Lý:</td>
                                        <td><input autocomplete="off" size="50" type="text" name="manager"/></td>
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
                                        <td colspan="3" align="center">
                                            <input class="button" type="submit" name="submit" value="Thêm mới"/>
                                            <input class="button" onclick="window.location.href = '<%= request.getContextPath() + "/admin/subsidiary/"%>'" type="reset" name="reset" value="Hủy"/>
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