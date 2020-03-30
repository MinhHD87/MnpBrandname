<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.entity.PhoneBlackList"%>
<%@page import="gk.myname.vn.utils.SMSUtils"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><%@page contentType="text/html; charset=utf-8" %>
<html>
    <head><%@include file="/admin/includes/header.jsp" %></head>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/admin/resource/select2/select2.css" />
    <script type="text/javascript" src="<%= request.getContextPath()%>/admin/resource/select2/select2.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/admin/resource/select2/select2_locale_vi.js"></script>
    <script type="text/javascript" language="javascript">
        //------
        $(document).ready(function () {
            $("#_label").select2({
                formatResult: function (item) {
                    return ('<div>' + item.text + '</div>');
                },
                formatSelection: function (item) {
                    return (item.text);
                },
                dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
                escapeMarkup: function (m) {
                    return m;
                }
            });
        });
    </script>
    <body>
        <%            //--
            if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập trang này!");
                response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
                return;
            }
            PhoneBlackList oneKeys = null;
            if (request.getParameter("submit") != null) {
                //---------------------------
                String vte = RequestTool.getString(request, "vte");
                String vms = RequestTool.getString(request, "vms");
                String gpc = RequestTool.getString(request, "gpc");
                String vnm = RequestTool.getString(request, "vnm");
                String bl = RequestTool.getString(request, "bl");
                String ddg = RequestTool.getString(request, "ddg");
                String phone = RequestTool.getString(request, "phone");
                phone = SMSUtils.phoneTo84(phone);
                //---
                if (vte.equals("1")) {
                    oneKeys = new PhoneBlackList();
                    oneKeys.setTelco(SMSUtils.OPER.VIETTEL.val);
                    oneKeys.setNumber(phone);
                    oneKeys.addNew(oneKeys);
                }
                if (vms.equals("1")) {
                    oneKeys = new PhoneBlackList();
                    oneKeys.setTelco(SMSUtils.OPER.MOBI.val);
                    oneKeys.setNumber(phone);
                    oneKeys.addNew(oneKeys);
                }
                if (gpc.equals("1")) {
                    oneKeys = new PhoneBlackList();
                    oneKeys.setTelco(SMSUtils.OPER.VINA.val);
                    oneKeys.setNumber(phone);
                    oneKeys.addNew(oneKeys);
                }
                if (vnm.equals("1")) {
                    oneKeys = new PhoneBlackList();
                    oneKeys.setTelco(SMSUtils.OPER.VNM.val);
                    oneKeys.setNumber(phone);
                    oneKeys.addNew(oneKeys);
                }
                if (bl.equals("1")) {
                    oneKeys = new PhoneBlackList();
                    oneKeys.setTelco(SMSUtils.OPER.BEELINE.val);
                    oneKeys.setNumber(phone);
                    oneKeys.addNew(oneKeys);
                }
                if (ddg.equals("1")) {
                    oneKeys = new PhoneBlackList();
                    oneKeys.setTelco(SMSUtils.OPER.DONGDUONG.val);
                    oneKeys.setNumber(phone);
                    oneKeys.addNew(oneKeys);
                }
                //------------
                session.setAttribute("mess", "Thêm mới dữ liệu thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/phone-blacklist/index.jsp");
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
                                        <th scope="col" class="rounded"></th>
                                        <th style="font-weight: bold" scope="col" class="rounded redBoldUp">Thêm mới Từ Khóa</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Viettel </td>
                                        <td colspan="2">
                                            <input type="checkbox" value="0" onclick="checkBoxClick(this)" name="vte"/>
                                            &nbsp;&nbsp;&nbsp; Mobi
                                            <input type="checkbox" value="0" onclick="checkBoxClick(this)" name="vms"/>
                                            &nbsp;&nbsp;&nbsp; Vina
                                            <input type="checkbox" value="0" onclick="checkBoxClick(this)" name="gpc"/>
                                            &nbsp;&nbsp;&nbsp; Vietnam Mobi
                                            <input type="checkbox" value="0" onclick="checkBoxClick(this)" name="vnm"/>
                                            &nbsp;&nbsp;&nbsp; Gtel
                                            <input type="checkbox" value="0" onclick="checkBoxClick(this)" name="bl"/>
                                            &nbsp;&nbsp;&nbsp; Itelecom
                                            <input type="checkbox" value="0" onclick="checkBoxClick(this)" name="ddg"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            Số Điện thoại: <input size="35" type="text" placeholder="84942492899" name="phone" value=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <input class="button" type="submit" name="submit" value="Thêm mới"/>
                                            <input class="button" onclick="window.location.href = '/admin/phone-blacklist/index.jsp'" type="reset" name="reset" value="Hủy"/>
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