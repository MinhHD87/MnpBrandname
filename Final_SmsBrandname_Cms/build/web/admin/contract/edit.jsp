<%@page import="gk.myname.vn.entity.PartnerManager"%>
<%@page import="gk.myname.vn.entity.Subsidiary"%>
<%@page import="gk.myname.vn.entity.EmailConfigManager"%>
<%@page import="gk.myname.vn.utils.DateProc"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="gk.myname.vn.entity.Contract"%>
<%@page import="gk.myname.vn.utils.Tool"%>
<%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/resource/css/jquery-ui-1.8.16.custom.css">
        <script>
            $(document).ready(function () {
                $('.dateproc').datetimepicker({
                    lang: 'vi',
                    timepicker: false,
                    format: 'd/m/Y',
                    formatDate: 'Y/m/d'
                });
                $('.select2').select2();
            });
        </script>
    </head>
    <body>
        <%
            if (!userlogin.checkEdit(request)) {
                session.setAttribute("mess", "Bạn không có quyền sửa module này!");
                response.sendRedirect(request.getContextPath() + "/admin/contract/");
                return;
            }
            int subID = Integer.parseInt(request.getParameter("subid"));
            int partnerID = Integer.parseInt(request.getParameter("partnerid"));
            String contractNo = request.getParameter("contractno");

            Contract contr = new Contract();
            Contract editContr = null;
            editContr = contr.getID(subID, partnerID, contractNo);

            if (editContr == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ...!");
                response.sendRedirect(request.getContextPath() + "/admin/contract/");
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
                        <form action="<%=request.getContextPath()%>/EditServlet" method="post" enctype="multipart/form-data">
                            <table  align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th align="center" style="font-weight: bold" scope="col" class="rounded redBoldUp">
                                            Cập nhật hợp đồng</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><input value="<%=editContr.getSub_id()%>" autocomplete="off" size="50" type="hidden" name="subID"/></td>
                                        <td align="left">Chi Nhánh: </td>
                                        <%
                                            Subsidiary sub = new Subsidiary();
                                            ArrayList<Subsidiary> arr = sub.listID();
                                            boolean live = false;
                                            if (arr != null && !arr.isEmpty()) {
                                                for (Subsidiary oneAcc : arr) {
                                                    if (oneAcc.getId() == editContr.getSub_id()) {
                                                        live = true;
                                                    }
                                                }
                                                if (live == true) {
                                        %>
                                        <td><input value="<%=editContr.getName_sub()%>" autocomplete="off" size="50" type="text" disabled/></td>
                                            <%
                                            } else {
                                            %>
                                        <td>
                                            <select style="width: 400px" class="select2"  id="subID" name="subID_new">
                                                <option value="">--- Tất cả ---</option>
                                                <%
                                                    for (Subsidiary oneAcc : arr) {
                                                %>
                                                <option value="<%=oneAcc.getId()%>" ><%=oneAcc.getName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <%
                                                    }
                                                }
                                            %>
                                        </td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><input value="<%=editContr.getPartner_id()%>"autocomplete="off" size="50" type="hidden" name="partnerID"/></td>
                                        <td align="left">Đối Tác: </td>
                                        <%
                                            Account dao = new Account();
                                                    ArrayList<Account> dts = dao.getKHAccount();
                                            boolean died = false;
                                            if (arr != null && !arr.isEmpty()) {
                                                for (Account b : dts) {
                                                    if (b.getAccID() == editContr.getPartner_id()) {
                                                        died = true;
                                                    }
                                                }
                                                if (died == true) {
                                        %>
                                        <td><input value="<%=editContr.getName_partner()%>" autocomplete="off" size="50" type="text" disabled/></td>
                                
                                            <%
                                            } else {
                                            %>
                                        <td>
                                            <select style="width: 400px" class="select2"  id="partnerID" name="partnerID_new">
                                                <option value="">--- Tất cả ---</option>
                                                <%
                                                    for (Account b : dts) {
                                                %>
                                                <option value="<%= b.getAccID()%>"><%= b.getFullName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <%
                                                    }
                                                }
                                            %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Số Hợp Đồng: </td>
                                        <td><input value="<%=editContr.getContract_no()%>" autocomplete="off" size="50" type="text" name="contract_no"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Thời Gian Bắt Đầu: </td>
                                        <td><input value="<%=editContr.getStart_time()%>" class="dateproc" size="8" type="text" name="start_time"/><span style="margin-left: 10px">Kết Thúc:</span><input style="margin-left: 5px" value="<%=editContr.getExpire_time()%>" class="dateproc" size="8" type="text" name="expire_time"/>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tự Động Thay Đổi: </td>
                                        <td><input type="checkbox" name="auto_renew" value="1" <%=(editContr.getAuto_renew() == 1) ? "checked" : ""%> /></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Thông Tin: </td>
                                        <td><textarea autocomplete="off" cols="40" rows="5" type="text" name="option_info" /><%=editContr.getOption_info()%></textarea></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">File Hợp Đồng: </td>
                                        <td><input value="<%=editContr.getFile_path()%>" autocomplete="off" size="50" type="file" name="file_path"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tên Dịch Vụ: </td>
                                        <td>
                                            <input type="checkbox" name="vte" value="1" <%=(editContr.getVte() == 1) ? "checked" : ""%> />VTE
                                            <input type="checkbox" name="vms" value="1" <%=(editContr.getVms() == 1) ? "checked" : ""%> />VMS
                                            <input type="checkbox" name="vina" value="1" <%=(editContr.getVina() == 1) ? "checked" : ""%> />VINA
                                            <input type="checkbox" name="vnm" value="1" <%=(editContr.getVnm() == 1) ? "checked" : ""%> />VNM
                                            <input type="checkbox" name="bl" value="1" <%=(editContr.getBl() == 1) ? "checked" : ""%>/>BL
                                        </td>
                                    </tr>
<!--                                    <tr>
                                        <td></td>
                                        <td align="left">Email: </td>
                                        <td>
                                            <select name="emaiID">
                                                <%
                                                    EmailConfigManager emailconfimanager = new EmailConfigManager();
                                                    ArrayList<EmailConfigManager> abcxyz = emailconfimanager.listID();
                                                    for (EmailConfigManager one : abcxyz) {
                                                        String selected = "";
                                                        System.out.println(editContr.getEmail_id());
                                                        if (one.getId() == editContr.getEmail_id()) {
                                                            selected = "selected='selected'";

                                                        }
                                                %>
                                                <option value="<%= one.getId()%>" <%=selected%> ><%= one.getEmail()%></option>
                                                <%}%>
                                            </select>
                                        </td>
                                    </tr>-->
                                    <tr>
                                        <td colspan="3" align="center">
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/contract/"%>'" type="reset" name="reset" value="Hủy"/>
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