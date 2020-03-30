<%@page import="gk.myname.vn.entity.Template_sms"%>
<%@page import="gk.myname.vn.entity.Provider"%>
<%@page import="gk.myname.vn.entity.Provider_Telco"%>
<%@page import="gk.myname.vn.admin.PriceTelco"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.DataOutputStream"%>
<%@page import="javax.ws.rs.core.MediaType"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="gk.myname.vn.entity.JSONUtil"%>
<%@page import="com.fasterxml.jackson.core.JsonGenerator"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="gk.myname.vn.admin.BillingAcc"%>
<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.admin.AccountRole"%>
<%@page import="gk.myname.vn.entity.PartnerManager"%>
<%@page import="gk.myname.vn.utils.Tool"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
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
        <script type="text/javascript">
            $(document).ready(function () {
                $("#providerCode").select2({
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
                        var opt = $("#providerCode option:selected");
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
                response.sendRedirect(request.getContextPath() + "/admin/template_sms/list_acc_temp.jsp");
                return;
            }
            String account = Tool.validStringRequest(request.getParameter("account"));
            BillingAcc admDao = new BillingAcc();
            BillingAcc oneAccount = null;
            oneAccount = admDao.getByUsername(account);

            if (oneAccount == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ. Không lấy được thông tin tài khoản");
                response.sendRedirect(request.getContextPath() + "/admin/template_sms/list_acc_temp.jsp");
                return;
            }

            if (request.getParameter("submit") != null) {
                //----------Log--------------
                String accountname = Tool.validStringRequest(request.getParameter("accountname"));
                int id_template = Tool.string2Integer(request.getParameter("id_template"), 0);

                oneAccount.setId_template(id_template);

                if (admDao.addTemp(oneAccount)) {
                    session.setAttribute("mess", "Sửa tài khoản thành công");
                    response.sendRedirect(request.getContextPath() + "/admin/template_sms/list_acc_temp.jsp");
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
                                        <th colspan="4" style="font-weight: bold"  scope="col" class="rounded redBoldUp">Cấp hướng gửi tin nhắn mẫu </th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tài khoản:</td>
                                        <td colspan="5">
                                            <input readonly type="text" name="accountname" value="<%=oneAccount.getUsername()%>"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Hướng gửi đến:</td>
                                        <td colspan="5">
                                            <select style="width: 300px" name="id_template" id="providerCode">
                                                <option value="">***** Chọn mã tin nhắn mẫu *****</option>
                                                <%
                                                    ArrayList<Template_sms> allpro = Template_sms.getCACHE();
                                                    for (Template_sms one : allpro) {
                                                %>
                                                <option value="<%=one.getId_template_send()%>" 
                                                        img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=one.getId_template_send()%>][<%=one.getDescription()%>] <%= one.getStatus() == 1 ? "" : "[LOCK]"%></option>
                                                <%
                                                    }
                                                %>
                                            </select>

                                        </td>
                                    </tr>
                                    </div>
                                    </td>
                                    </tr>
                                    <tr>
                                        <td colspan="7" align="center">
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/template_sms/list_acc_temp.jsp"%>'" type="reset" name="reset" value="Hủy"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>
                </div>   
                <div class="clear"></div>
            </div>
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html> 