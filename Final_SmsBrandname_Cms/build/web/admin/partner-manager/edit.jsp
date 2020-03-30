<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.entity.PartnerManager"%>
<%@page import="gk.myname.vn.utils.Tool"%>
<%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/resource/css/jquery-ui-1.8.16.custom.css">
        <script>
            function checkPartnerCode() {
                var pn_code = $("#_partnerCode").val();
                var reg = /^[A-Za-z0-9]+$/;
                if (isBlank(pn_code) || pn_code.length > 16) {
                    jAlert("Bạn chưa nhập PARTNER CODE hoặc Partner Code dài hơn 16 ký tự");
                    return false;
                }
                if (!reg.test(pn_code)) {
                    jAlert("PARTNER CODE chỉ bao gồm số 0->9 và chữ từ A->Z không dấu !");
                    return false;
                }
            }
            $(document).ready(function () {
                $("#_agentcy").select2({
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
                        var opt = $("#_agentcy option:selected");
                        var valOpt = opt.attr("img-data");
                        var befor_code = opt.attr("cp_code");
                        if (!isBlank(befor_code)) {
                            $("#_befor_code").html(befor_code + "_");
                        } else {
                            $("#_befor_code").html("");
                        }

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
                session.setAttribute("mess", "Bạn không có quyền sửa module này!");
                response.sendRedirect(request.getContextPath() + "/admin/partner-manager/");
                return;
            }
            int id = Tool.string2Integer(request.getParameter("id"));

            PartnerManager admDao = new PartnerManager();
            PartnerManager editPartner = null;
            editPartner = admDao.getByID(id);
            if (id == 0 || editPartner == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ...!");
                response.sendRedirect(request.getContextPath() + "/admin/partner-manager/");
                return;
            }
            if (request.getParameter("submit") != null) {
                //----------Log--------------
                String name = Tool.validStringRequest(request.getParameter("name"));
                String addr = Tool.validStringRequest(request.getParameter("addr"));
                String phone = Tool.validStringRequest(request.getParameter("phone"));
                String email = Tool.validStringRequest(request.getParameter("email"));
                String desc = Tool.validStringRequest(request.getParameter("desc"));
                String code = Tool.validStringRequest(request.getParameter("code"));
                String businessCode = Tool.validStringRequest(request.getParameter("businessCode"));
                String bankAcc = Tool.validStringRequest(request.getParameter("bankAcc"));
                String bankAdd = Tool.validStringRequest(request.getParameter("bankAdd"));
                int status = Tool.string2Integer(request.getParameter("status"));
                RequestTool.debugParam(request);
                if (!Tool.checkNull(code) && code.length() <= 16) {
                    int parentId = Tool.string2Integer(request.getParameter("parentId"));
                    if (parentId != 0) {
                        PartnerManager parent = PartnerManager.getCacheById(parentId);
                        if (parent != null && !code.startsWith(parent.getCode() + "_")) {
                            code = parent.getCode() + "_" + code;
                        }
                    }
                    //---
                    editPartner.setName(name);
                    editPartner.setAddress(addr);
                    editPartner.setPhone(phone);
                    editPartner.setEmail(email);
                    editPartner.setDesc(desc);
                    editPartner.setCode(code.toUpperCase());
                    editPartner.setBusinessCode(businessCode);
                    editPartner.setBankAcc(bankAcc);
                    editPartner.setBankAdd(bankAdd);
                    editPartner.setParentId(parentId);
                    editPartner.setStatus(status);
                    if (admDao.edit(editPartner)) {
                        session.setAttribute("mess", "Sửa dữ liệu thành công");
                        response.sendRedirect(request.getContextPath() + "/admin/partner-manager/");
                        return;
                    } else {
                        session.setAttribute("mess", "Sửa dữ liệu lỗi");
                    }
                } else {
                    session.setAttribute("mess", "Bạn chưa nhập PARTNER CODE hoặc PARTNER CODE >16 ký tự!");
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
                        <form onsubmit="return checkPartnerCode()" action="" method="post">
                            <table  align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th align="center" style="font-weight: bold" scope="col" class="rounded redBoldUp">
                                            Cập nhật đối tác</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Trực thuộc Đại Lý:</td>
                                        <td colspan="2">
                                            <%
                                                ArrayList<PartnerManager> allCp = PartnerManager.getAllCache();
                                                String[] arrCode = {""};
                                                if (allCp != null && !allCp.isEmpty()) {
                                            %>
                                            <select style="width: 420px" id="_agentcy" name="parentId">
                                                <option cp_code="" value="0">******** Là đại lý  ********</option>
                                                <%
                                                    for (PartnerManager onePartner : allCp) {
                                                        if (!Tool.checkNull(onePartner.getCode())) {
                                                            String editPNCode = editPartner.getCode();

                                                            if (!Tool.checkNull(editPNCode) && editPNCode.contains("_")) {
                                                                arrCode = editPNCode.split("_");
                                                            }
                                                %>
                                                <option cp_code="<%=onePartner.getCode()%>" <%= onePartner.getCode().equals(arrCode[0]) ? "selected=selected" : ""%>
                                                        value="<%=onePartner.getId()%>"
                                                        img-data="<%=(onePartner.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=onePartner.getCode()%>] <%=onePartner.getName()%></option>
                                                <%}
                                                        }
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">PARTNER CODE:</td>
                                        <td><span class="redBoldUp" id="_befor_code"></span><input readonly value="<%=(arrCode != null && arrCode.length == 2) ? arrCode[1] : editPartner.getCode()%>" id="_partnerCode" size="20" type="text" name="code"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tên đối tác: </td>
                                        <td><input value="<%=editPartner.getName()%>" id="add_name" autocomplete="off" size="50" type="text" name="name"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Địa chỉ: </td>
                                        <td><input value="<%=editPartner.getAddress() %>" autocomplete="off" size="50" type="text" name="addr"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Điện thoại: </td>
                                        <td><input value="<%=editPartner.getPhone()%>" autocomplete="off" size="50" type="text" name="phone"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Email: </td>
                                        <td><input value="<%=editPartner.getEmail()%>" autocomplete="off" size="50" type="text" name="email"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>MST</td>
                                        <td><input value="<%=editPartner.getBusinessCode()%>" type="text" name="businessCode"/>
                                            &nbsp;&nbsp;
                                            Tài khoản NH
                                            <input value="<%=editPartner.getBankAcc()%>" type="text" name="bankAcc"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Bank Address</td>
                                        <td><input value="<%=editPartner.getBankAdd()%>" size="50" type="text" name="bankAdd"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mô tả</td>
                                        <td>
                                            <textarea cols="57" name="desc"><%=editPartner.getDesc()%></textarea>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td></td>
                                        <td align="left">STATUS:</td>
                                        <td>
                                            <select name="status">
                                                <option <%=editPartner.getStatus() == 1 ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%=editPartner.getStatus() == 0 ? "selected='selected'" : ""%> value="0">Khóa</option>
                                                <option <%=editPartner.getStatus() == 404 ? "selected='selected'" : ""%> value="404">Đã Xóa</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center">
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/partner-manager/"%>'" type="reset" name="reset" value="Hủy"/>
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