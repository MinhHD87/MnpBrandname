<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.admin.AccountRole"%><%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
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
        </script>
    </head>
    <body>
        <%
            if (!userlogin.checkEdit(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin/customer/agency/index.jsp");
                return;
            }
            int id = Tool.string2Integer(request.getParameter("id"));
            Account admDao = new Account();
            Account oneAccount = null;
            oneAccount = admDao.getByID(id);

            if (oneAccount == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ. Không lấy được thông tin tài khoản");
                response.sendRedirect(request.getContextPath() + "/admin/customer/agency");
                return;
            }
            PartnerManager partner = PartnerManager.getCacheByCode(oneAccount.getCpCode());
            String cpCode = oneAccount.getCpCode();
//            if (partner == null) {
//                session.setAttribute("mess", "Yêu cầu không hợp lệ. Không lấy được thông tin khách hàng");
//                response.sendRedirect(request.getContextPath() + "/admin/customer/agency");
//                return;
//            }

            if (request.getParameter("submit") != null) {
                //----------Log--------------
                String account = Tool.validStringRequest(request.getParameter("name"));
                String pass = Tool.validStringRequest(request.getParameter("pass"));
                String pass_send = Tool.validStringRequest(request.getParameter("pass_send"));
                String fullname = Tool.validStringRequest(request.getParameter("fullname"));
                String phone = Tool.validStringRequest(request.getParameter("phone"));
                String email = Tool.validStringRequest(request.getParameter("email"));
                String ip_allow = Tool.validStringRequest(request.getParameter("ip_allow"));
                String mobiSend = Tool.validStringRequest(request.getParameter("mobiSend"));
                String desc = Tool.validStringRequest(request.getParameter("desc"));
                String address = Tool.validStringRequest(request.getParameter("address"));
                String addRessRange = Tool.validStringRequest(request.getParameter("addRessRange"));
                String method = Tool.validStringRequest(request.getParameter("method"));
                cpCode = Tool.validStringRequest(request.getParameter("cpCode"));
                int tps = Tool.string2Integer(request.getParameter("tps"));
                int totalsms = Tool.string2Integer(request.getParameter("totalsms"));
                int status = Tool.string2Integer(request.getParameter("status"));
                int parentId = Tool.string2Integer(request.getParameter("parentId"));
                int userType = Tool.string2Integer(request.getParameter("user_type"), Account.TYPE.AGENCY.val);
                boolean createAgentcy = Tool.getBoolean(request.getParameter("createAgentcy"));
                boolean createSubAcc = Tool.getBoolean(request.getParameter("createSubAcc"));
                String phoneOtp = RequestTool.getString(request, "phoneOtp");
                boolean validOtp = RequestTool.getBoolean(request, "validOtp");
                boolean lockLogin = RequestTool.getBoolean(request, "lockLogin");
                
                AccountRole roleEdit = oneAccount.getRole();
                roleEdit.setCreateAgentcy(createAgentcy);
                roleEdit.setCreateSubAcc(createSubAcc);
                roleEdit.setConfirmOTP(validOtp);
                roleEdit.setPhoneOtp(phoneOtp);
                roleEdit.setLockLogin(lockLogin);
                //---
                oneAccount.setParentId(parentId);
                oneAccount.setUserName(account);
                oneAccount.setPassWord(pass);
                oneAccount.setPassSend(pass_send);
                oneAccount.setFullName(fullname);
                oneAccount.setPhone(phone);
                oneAccount.setEmail(email);
                oneAccount.setMaxBrand(totalsms);
                oneAccount.setIp_Allow(ip_allow);
                oneAccount.setPhone_Send(mobiSend);
                oneAccount.setDescription(desc);
                oneAccount.setAddress(address);
                oneAccount.setUpdateBy(userlogin.getUserName());
                oneAccount.setUserType(userType);
                oneAccount.setStatus(status);
                oneAccount.setCpCode(cpCode);
                oneAccount.setAddressRange(addRessRange);
                oneAccount.setMethod(method);
                oneAccount.setRole(roleEdit);
                oneAccount.setTps(tps);
                if (admDao.update(oneAccount)) {
                    session.setAttribute("mess", "Sửa tài khoản thành công");
                    response.sendRedirect(request.getContextPath() + "/admin/customer/agency/index.jsp");
                    return;
                } else {
                    session.setAttribute("mess", "Sửa tài khoản lỗi");
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
                            <%if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }%>
                        </div>
                        <form action="" method="post">
                            <table align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th colspan="4" style="font-weight: bold"  scope="col" class="rounded redBoldUp">Cập nhật thông tin Đại lý </th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Đại Lý:</td>
                                        <td colspan="5">
                                            <%
                                                ArrayList<PartnerManager> allCp = PartnerManager.getAllCache();
                                                if (allCp != null && !allCp.isEmpty()) {
                                            %>
                                            <select style="width: 320px" id="_cp_code" name="cpCode">
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
                                            TPS
                                            <input id="add_tps" size="7" value="<%=oneAccount.getTps() %>" type="text" name="tps"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            Giao Thức kết nối: 
                                            <select name="method">
                                                <option value="HTTP">HTTP</option>
                                                <option value="SMPP">SMPP</option>
                                                <option value="SOAP">SOAP</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left"></td>
                                        <td align="left">User: </td>
                                        <td colspan="5">
                                            <input size="12" value="<%=oneAccount.getUserName()%>" type="text" name="name"/>
                                            &nbsp;&nbsp;&nbsp;
                                            Mật khẩu đăng nhập:
                                            &nbsp;&nbsp;&nbsp;
                                            <input autocomplete="off" size="12" type="password" name="pass"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            MK TK Gửi Brand <span class="redBoldUp">(Cấp cho CP):</span>
                                            <input autocomplete="off" size="20" type="password" name="pass_send"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left"></td>
                                        <td>Tên tài khoản:</td>
                                        <td colspan="2"><input value="<%=oneAccount.getFullName()%>" size="47" type="text" name="fullname"/></td>
                                        <td  class="redBoldUp" align="left">Loại tài khoản:</td>
                                        <td colspan="2">
                                            <select style="width: 146px" id="add_status" name="user_type">
                                                <%
                                                    if (partner != null && partner.hasChild()) {
                                                %>
                                                <option <%=oneAccount.getUserType() == Account.TYPE.AGENCY_MANAGER.val ? "selected=selected" : ""%> value="<%=Account.TYPE.AGENCY_MANAGER.val%>">Quản lý Đại lý</option>
                                                <option <%=oneAccount.getUserType() == Account.TYPE.AGENCY.val ? "selected=selected" : ""%> value="<%=Account.TYPE.AGENCY.val%>">Đại lý</option>
                                                <%
                                                } else {
                                                %>
                                                <option value="<%=Account.TYPE.AGENCY.val%>">Đại lý</option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td align="left"></td>
                                        <td align="left">Mobile: </td>
                                        <td colspan="5">
                                            <input size="12" value="<%=oneAccount.getPhone()%>" type="text" name="phone"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            Email:
                                            <input id="add_email"  value="<%=oneAccount.getEmail()%>" size="20" type="text" name="email"/>
                                            &nbsp;&nbsp;
                                            ADDRESS RANGE:
                                            <input value="<%=oneAccount.getAddressRange()%>" id="add_addRessRange" size="30" type="text" name="addRessRange"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">IP Allow</td>
                                        <td colspan="2">
                                            <textarea cols="40" rows="5" name="ip_allow"><%=oneAccount.getIp_Allow()%></textarea>
                                        </td>
                                        <td align="left">Mô tả </td>
                                        <td colspan="3"><textarea rows="5" cols="40" name="desc"><%=oneAccount.getDescription()%></textarea></td>
                                    </tr>
                                    <tr><td align="left"></td>
                                        <td align="left">Trạng thái: </td>
                                        <td colspan="5">
                                            <select name="status">
                                                <option <%=oneAccount.getStatus() == 1 ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%=oneAccount.getStatus() == 0 ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            Total Message
                                            <input size="10" value="<%=oneAccount.getMaxBrand()%>" type="text" name="totalsms"/>
                                            &nbsp;&nbsp;&nbsp;<b class="redBold">-99: Không gới hạn</b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left"></td>
                                        <td align="left">Trạng thái: </td>
                                        <td colspan="5">
                                            <% AccountRole roleOld = oneAccount.getRole();
                                                if (partner != null && partner.hasChild()) {%>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            Create Agentcy: <input onclick="checkBoxClick(this);" type="checkbox" name="createAgentcy" <%=roleOld.isCreateAgentcy() ? "checked='checked'" : ""%> value="<%=roleOld.isCreateAgentcy() ? "1" : "0"%>"/>
                                            &nbsp;&nbsp;&nbsp;
                                            Create SubAcc: <input onclick="checkBoxClick(this);" type="checkbox" name="createSubAcc" <%=roleOld.isCreateSubAcc() ? "checked='checked'" : ""%> value="<%=roleOld.isCreateSubAcc() ? "1" : "0"%>"/>
                                            <%} else {%>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            Create SubAcc: <input onclick="checkBoxClick(this);" type="checkbox" name="createSubAcc" <%=roleOld.isCreateSubAcc() ? "checked='checked'" : ""%> value="<%=roleOld.isCreateSubAcc() ? "1" : "0"%>"/>
                                            <%}%>
                                            &nbsp;
                                            OTP gửi tin: 
                                            <input value="<%=roleOld.isConfirmOTP() ? "1" : "0"%>" <%=roleOld.isConfirmOTP() ? "checked='checked'" : ""%> size="30" name="validOtp" id="validOtp" type="checkbox" onclick="checkBoxClick(this)" />
                                            &nbsp;&nbsp;
                                            Số nhận OTP: 
                                            <input value="<%=Tool.checkNull(roleOld.getPhoneOtp()) ? "" : roleOld.getPhoneOtp()%>" size="20" name="phoneOtp" <%=Tool.checkNull(roleOld.getPhoneOtp()) ? "" : "readonly='readonly'"%> id="phoneOtp" type="text"/>
                                            &nbsp;&nbsp;
                                            Khóa đăng nhập: 
                                            <input  onclick="checkBoxClick(this);" value="<%=roleOld.isLockLogin() ? "1" : "0"%>" name="lockLogin" <%=roleOld.isLockLogin() ? "checked='checked'" : ""%> id="lockLogin" type="checkbox"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="7" align="center">
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/customer/agency/index.jsp"%>'" type="reset" name="reset" value="Hủy"/>
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