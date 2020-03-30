<%@page import="gk.myname.vn.utils.Md5"%><%@page import="gk.myname.vn.admin.AccountRole"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/resource/css/jquery-ui-1.8.16.custom.css">
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.core.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.position.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.widget.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.autocomplete.min.js"></script>
        <script type ='text/javascript'>
            $(document).ready(function () {
                $("#_cp_code").select2({
                    formatResult: function (item) {
                        var valOpt = $(item.element).attr('img-data');
                        if (!valOpt) {
                            return ('<div><b>' + item.text + '</b></div>');
                        } else {
                            return ('<div><span><b style="color: red">' + item.text + '<b> <img src="' + valOpt + '" class="img-flag" /></span></div>');
                        }
                    },
                    formatSelection: function (item) {
                        //  load page or selected
                        var opt = $("#_cp_code option:selected");
                        var valOpt = opt.attr("img-data");
                        if (!valOpt) {
                            return ('<b>' + item.text + '</b>');
                        } else {
                            return ('<div><span><b style="color: red">' + item.text + '</b> <img src="' + valOpt + '" class="img-flag" /></span></div>');
                        }
                    },
                    dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
                    escapeMarkup: function (m) {
                        return m;
                    }
                });
            });
            function validForm() {
                var pn_code = $("#_cp_code  option:selected").val();
                if (isBlank(pn_code)) {
                    jAlert("Bạn chưa chọn một đại lý quản lý tài khoản này !");
                    return false;
                }
                var reg = /^[a-zA-Z0-9]+$/;
                var user = $("#add_name").val();
                if (!reg.test(user)) {
                    jAlert("Tên đăng nhập chỉ bao gồm số 0->9 và chữ từ A->Z không dấu !"+user);
                    return false;
                }
                var err_username = $("#err_username").attr("value");
                if (err_username == 1) {
                    jAlert("Tên đăng nhập đã tồn tại !");
                    return false;
                }
            }
            $(document).ready(function () {
                $('#add_name').keyup(function () {
                    var user = $(this).val();
                    $.ajax({
                        type: "POST",
                        url: '<%=request.getContextPath() + "/admin/customer/khle/checkuser.jsp"%>',
                        data: "user=" + user,
                        success: function (data) {
                            if (data == 1) {
                                $("#err_username").html('<b>Đã tồn tại<b>');
                                $("#err_username").attr("value", "1");
                            } else {
                                $("#err_username").html('<img width=\"16\" src=\"<%=request.getContextPath()%>/admin/resource/images/active.png\"/>');
                                $("#err_username").attr("value", "0");
                            }
                        }
                    });
                });
            });
        </script>
    </head>
    <body>
        <%
            if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin/customer/khle/index.jsp");
                return;
            }
            // -- Lay CP CODE CUA QUAN LY DAI LY
            String cpCode = RequestTool.getString(request, "cpCode");
            if (request.getParameter("submit") != null) {
                if (Tool.checkNull(cpCode)) {
                    session.setAttribute("mess", "Bạn chưa chọn đại lý trực thuộc!");
                    response.sendRedirect(request.getContextPath() + "/admin/customer/khle/index.jsp");
                    return;
                }
                //---------------------------
                String account = Tool.validStringRequest(request.getParameter("name"));
                String fullname = Tool.validStringRequest(request.getParameter("fullname"));
                String pass_send = Md5.encryptMD5ForDownLoad(Tool.getRandomString(12));
                String pass = Tool.validStringRequest(request.getParameter("pass"));

                String phone = Tool.validStringRequest(request.getParameter("phone"));
                String email = Tool.validStringRequest(request.getParameter("email"));
                String ip_allow = "0";
                String mobiSend = "0";
                String desc = Tool.validStringRequest(request.getParameter("desc"));
                String address = Tool.validStringRequest(request.getParameter("address"));

                int totalsms = Tool.string2Integer(request.getParameter("totalsms"));
                int status = Tool.string2Integer(request.getParameter("status"));
                String phoneOtp = RequestTool.getString(request, "phoneOtp");
                boolean validOtp = RequestTool.getBoolean(request, "validOtp");
                boolean lockLogin = RequestTool.getBoolean(request, "lockLogin");

                AccountRole roleAdd = new AccountRole();
                roleAdd.setConfirmOTP(validOtp);
                roleAdd.setPhoneOtp(phoneOtp);
                roleAdd.setLockLogin(lockLogin);
                int userType = Account.TYPE.USER.val;
                //---
                Account oneAdmin = new Account();
                oneAdmin.setUserName(account);
                oneAdmin.setPassWord(pass);
                oneAdmin.setPassSend(pass_send);
                oneAdmin.setFullName(fullname);
                oneAdmin.setPhone(phone);
                oneAdmin.setEmail(email);
                oneAdmin.setMaxBrand(totalsms);
                oneAdmin.setIp_Allow(ip_allow);
                oneAdmin.setPhone_Send(mobiSend);
                oneAdmin.setDescription(desc);
                oneAdmin.setAddress(address);
                oneAdmin.setUserType(userType);
                oneAdmin.setCreateBy(userlogin.getUserName());
                oneAdmin.setUpdateBy(userlogin.getUserName());
                oneAdmin.setStatus(status);
                oneAdmin.setCpCode(cpCode);
                oneAdmin.setRole(roleAdd);
                //------------
                Account admDao = new Account();
                if (admDao.addNew(oneAdmin)) {
                    session.setAttribute("mess", "Thêm mới tài khoản thành công!");
                } else {
                    session.setAttribute("mess", "Thêm mới dữ liệu lỗi!");
                }
                response.sendRedirect(request.getContextPath() + "/admin/customer/khle/index.jsp");
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
                            <%if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }%>
                        </div>
                        <form onsubmit="return validForm()" action="" method="post">
                            <table  align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th colspan="2" style="font-weight: bold" scope="col" class="rounded redBoldUp">Thêm mới khách hàng lẻ</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr><td></td>
                                        <td>Đại Lý:</td>
                                        <td colspan="5">
                                            <%
                                                ArrayList<PartnerManager> allCp = PartnerManager.getAllCache();
                                                if (allCp != null && !allCp.isEmpty()) {
                                            %>
                                            <select style="width: 420px" id="_cp_code" name="cpCode">
                                                <option value="">******** Tất cả ********</option>
                                                <%
                                                    for (PartnerManager onePartner : allCp) {
                                                        if (!Tool.checkNull(onePartner.getCode())) {
                                                %>
                                                <option
                                                    value="<%=onePartner.getCode()%>" <%=onePartner.getCode().equals(cpCode) ? "selected=selected" : ""%>
                                                    img-data="<%=(onePartner.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=onePartner.getCode()%>] <%=onePartner.getName()%></option>
                                                <%}
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            Total Message
                                            <input size="10" value="5000" type="text" name="totalsms"/>
                                            &nbsp;&nbsp;&nbsp;<b class="redBold">-99: Không gới hạn</b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tên đăng nhập: </td>
                                        <td colspan="3">
                                            <input id="add_name" autocomplete="off" size="20" type="text" name="name"/>
                                            <span class="redBold" id="err_username" value="0"></span>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            Mật khẩu đăng nhập:
                                            <input id="add_pass" autocomplete="off" size="20" type="password" name="pass"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Tên khách hàng:</td>
                                        <td colspan="3">
                                            <input type="text" value="" size="33" name="fullname"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            Mobile:
                                            <input id="add_phone" size="20" type="text" name="phone"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            Email:
                                            <input id="add_email" size="20" type="text" name="email"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mô tả: </td>
                                        <td colspan="1">
                                            <textarea id="add_desc" cols="40" name="desc"></textarea>
                                        </td>
                                        <td align="left">Address: </td>
                                        <td colspan="1">
                                            <textarea id="add_address" cols="40" name="address"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Trạng thái API: </td>
                                        <td colspan="3">
                                            <select id="add_status" name="status">
                                                <option value="1">Kích hoạt</option>
                                                <option value="0">Khóa</option>
                                            </select>
                                            &nbsp;
                                            OTP gửi tin: 
                                            <input value="1" checked="checked" size="30" name="validOtp" id="validOtp" type="checkbox" onclick="checkBoxClick(this)" />
                                            &nbsp;&nbsp;
                                            Số nhận OTP: 
                                            <input value="" size="30" name="phoneOtp" id="phoneOtp" type="text"/>
                                            &nbsp;&nbsp;
                                            Khóa đăng nhập: 
                                            <input  onclick="checkBoxClick(this);" value="0" name="lockLogin" id="lockLogin" type="checkbox"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" align="center">
                                            <input class="button" type="submit" name="submit" value="Thêm mới"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/customer/khle/index.jsp"%>'" type="reset" name="reset" value="Hủy"/>
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