<%@page import="gk.myname.vn.entity.DeclareOption"%>
<%@page import="gk.myname.vn.entity.BrandLabel_Declare"%>
<%@page import="gk.myname.vn.entity.OptionVina"%>
<%@page import="gk.myname.vn.entity.Provider"%>
<%@page import="gk.myname.vn.utils.DateProc"%>
<%@page import="gk.myname.vn.utils.SMSUtils"%>
<%@page import="gk.myname.vn.entity.OperProperties"%>
<%@page import="gk.myname.vn.entity.RouteTable"%>
<%@page import="gk.myname.vn.entity.OptionTelco"%>
<%@page import="gk.myname.vn.entity.BrandLabel"%>
<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <%            //---------------Admin
            if (userlogin == null) {
                session.setAttribute("error", "Bạn cần đăng nhập để truy cập hệ thống");
                out.print("<script>top.location='" + request.getContextPath() + "/admin/login.jsp';</script>");
                return;
            }
        %>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/resource/css/jquery-ui-1.8.16.custom.css">
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.core.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.position.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.widget.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.autocomplete.min.js"></script>
        <script type =text/javascript>
            $(document).ready(function () {
                $("#_cpuser").select2({
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
                        var opt = $("#_cpuser option:selected");
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
        <%            if (!userlogin.checkEdit(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập module này!");
                response.sendRedirect(request.getContextPath() + "/admin/brand/index.jsp");
                return;
            }
            int id = RequestTool.getInt(request, "id");
            BrandLabel_Declare oneBrand = new BrandLabel_Declare();
            oneBrand = oneBrand.getById(id);
            if (oneBrand == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/brand/index.jsp");
                return;
            }
            if (request.getParameter("submit") != null) {
                //---------------------------
                int status = Tool.string2Integer(request.getParameter("status"));
                String ownerUser = Tool.validStringRequest(request.getParameter("ownerUser"));
                Account ownerAcc = Account.getAccount(ownerUser);
                if (Tool.checkNull(ownerUser) || ownerAcc == null) {
                    session.setAttribute("mess", "Bạn chưa cấp BRAND cho tài khoản nào hoặc tài khoản ko hợp lệ!");
                } else {
                    oneBrand.setStatus(status);
                    // Danh Rieng Vina Phone
                    if (oneBrand.update(oneBrand)) {
                        session.setAttribute("mess", "Cập nhật dữ liệu thành công!");
                        response.sendRedirect(request.getContextPath() + "/admin/brand-declare/index.jsp");
                        return;
                    } else {
                        session.setAttribute("mess", "Cập nhật dữ liệu lỗi!");
                    }
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
                            <%                                if (session.getAttribute("mess") != null) {
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
                                        <th scope="col" colspan="4" class="rounded-q4 redBoldUp">Cập nhật Brand Khai Báo</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Brand Name: </td>
                                        <td class="boder_right">
                                            <input readonly='readonly' value="<%=oneBrand.getBrandLabel()%>" size="15" type="text" name="brandName"/>
                                        </td>
                                        <td align="left">Cấp cho Account: </td>
                                        <td>
                                            <input type="text" name="ownerUser" value="<%=oneBrand.getUserOwner()%>" readonly='readonly'/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Khai Báo</td>
                                        <td>
                                            <% DeclareOption dcl = oneBrand.getDeclare(); %>
                                            <div style="width: 150px;float: left">
                                                <div style="width: 100px;text-align: center;font-weight: bold;color: red">QC</div>
                                                <div style="width: 100px;float: left">VIETTEL</div><div><%=dcl.isVte_qc()?"<b style='color: orange'>Khai báo</b>":"KO" %></div>
                                                <div style="width: 100px;float: left">MOBI</div><div><%=dcl.isVms_qc()?"<b style='color: orange'>Khai báo</b>":"KO" %></div>
                                                <div style="width: 100px;float: left">VINA</div><div><%=dcl.isGpc_qc()?"<b style='color: orange'>Khai báo</b>":"KO" %></div>
                                                <div style="width: 100px;float: left">VIETNAM MOBI</div><div><%=dcl.isVnm_qc()?"<b style='color: orange'>Khai báo</b>":"KO" %></div>
                                                <div style="width: 100px;float: left">GTEL</div><div><%=dcl.isGtel_qc()?"<b style='color: orange'>Khai báo</b>":"KO" %></div>
                                            </div>
                                        </td>
                                        <td colspan="2">
                                            <div style="width: 150px;float: left">
                                                <div style="width: 100px;text-align: center;font-weight: bold;color: red">CSKH</div>
                                                <div style="width: 100px;float: left">VIETTEL</div><div><%=dcl.isVte()?"<b style='color: orange'>Khai báo</b>":"KO" %></div>
                                                <div style="width: 100px;float: left">MOBI</div><div><%=dcl.isVms()?"<b style='color: orange'>Khai báo</b>":"KO" %></div>
                                                <div style="width: 100px;float: left">VINA</div><div><%=dcl.isGpc()?"<b style='color: orange'>Khai báo</b>":"KO" %></div>
                                                <div style="width: 100px;float: left">VIETNAM MOBI</div><div><%=dcl.isVnm()?"<b style='color: orange'>Khai báo</b>":"KO" %></div>
                                                <div style="width: 100px;float: left">GTEL</div><div><%=dcl.isGtel()?"<b style='color: orange'>Khai báo</b>":"KO" %></div>
                                            </div>
                                            
                                        </td>
                                    </tr>
                                    <tr><td></td>
                                        <td>
                                            Trạng thái:
                                        </td>
                                        <td colspan="3">
                                            <select name="status">
                                                <option <%=oneBrand.getStatus() == BrandLabel.STATUS.WAIT.val ? " selected='selected'" : ""%> value="<%=BrandLabel.STATUS.WAIT.val %>">Chờ Khai Báo</option>
                                                <option <%=oneBrand.getStatus() == BrandLabel.STATUS.PROCESS.val ? " selected='selected'" : ""%> value="<%=BrandLabel.STATUS.PROCESS.val %>">Đang khai báo</option>
                                                <option <%=oneBrand.getStatus() == BrandLabel.STATUS.REJECT.val ? " selected='selected'" : ""%> value="<%=BrandLabel.STATUS.REJECT.val %>">Từ chối</option>
                                                <option <%=oneBrand.getStatus() == BrandLabel.STATUS.ACTIVE.val ? " selected='selected'" : ""%> value="<%=BrandLabel.STATUS.ACTIVE.val %>">Đã Khai Báo</option>
                                            </select>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" align="center">
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/brand-declare/index.jsp"%>'" type="reset" name="reset" value="Hủy"/>
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