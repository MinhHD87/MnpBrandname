
<%@page import="gk.myname.vn.utils.SendMail"%>
<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.entity.Email_tmp_config"%>
<%@page import="gk.myname.vn.entity.EmailConfigManager"%>
<%@page import="gk.myname.vn.entity.Subsidiary"%>
<%@page import="gk.myname.vn.utils.DateProc"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="gk.myname.vn.entity.Contract"%><%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <!--        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
                <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />
                <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/js/select2.min.js"></script>-->
        <script>
            $(document).ready(function () {
                $('.select2').select2();
                $('#title_mail').select2({
                    tag: true
                });
            });
        </script>
    </head>
    <body>
        <%  if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin/send_mail/");
                return;
            }

            String sendMail= "";
            String abcxyz = "";
            EmailConfigManager email_send = new EmailConfigManager();
            EmailConfigManager emailconfig = null;
            boolean success = false;

            if (request.getParameter("submit") != null) {
                int subid = RequestTool.getInt(request, "subID");
                String a[] = request.getParameterValues("partnerID");
                String subject = request.getParameter("title_mail");
                String content = request.getParameter("content");
                String checkTemp = RequestTool.getString(request, "checkMail");
                String checTokTemp = RequestTool.getString(request, "checkToMail");
                String ccc = RequestTool.getString(request, "toMail");
                String c[] = ccc.split("\\,");
                if (checTokTemp.equals("No")) {
                    a = c;
                }
                int tempId = RequestTool.getInt(request, "title_mail_temp");
                Email_tmp_config tempMail = new Email_tmp_config();
                Email_tmp_config mail = tempMail.getbyid(tempId);
                if (a != null) {
                    emailconfig = email_send.getConfigById(subid);
                        for (String b : a) {
                              abcxyz += b + ",";
                        }
                        if (checkTemp.equals("No")) {
                            success = SendMail.sendMailOneToOne(emailconfig.getFromname(), emailconfig.getEmail(), emailconfig.getPassmail(), emailconfig.getHostemail(), emailconfig.getPortmail(), subject, content, abcxyz);
                        } else {
                            success = SendMail.sendMailOneToOne(emailconfig.getFromname(), emailconfig.getEmail(), emailconfig.getPassmail(), emailconfig.getHostemail(), emailconfig.getPortmail(), mail.getName(), mail.getContent(), abcxyz);
                        }

                        if (success == true) {
                            sendMail += "<br/> Send to " + abcxyz + " success !";
                        } else {
                            sendMail += "<br/> Send to " + abcxyz + " lỗi !";
                        }
                    session.setAttribute("mess", sendMail);
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
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>
                        <br/>

                        <form action="" method="post">
                            <table  align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th align="center" style="font-weight: bold" scope="col" class="rounded redBoldUp">
                                            Send Email</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Người Gửi: </td>
                                        <td>
                                            <%
                                                EmailConfigManager sub = new EmailConfigManager();
                                                ArrayList<EmailConfigManager> arr = sub.listID();
                                                if (arr != null && !arr.isEmpty()) {
                                            %>
                                            <select style="width: 400px" id="subID" name="subID">
                                                <option value="">--- Tất cả ---</option>
                                                <%
                                                    for (EmailConfigManager oneAcc : arr) {
                                                %>
                                                <option value="<%=oneAcc.getId()%>"><%=oneAcc.getEmail()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <%
                                                }
                                            %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Gửi Tới: </td>
                                        <td class="newToMail" style="display: none;">
                                            <input style="width: 400px" type="text" id="toMail" name="toMail"/>
                                        </td>
                                        <td class="templateToMail">
                                            <%
                                                Account partner = new Account();
                                                ArrayList<Account> dts = partner.getKHAccount();
                                                if (dts != null && !dts.isEmpty()) {
                                            %>
                                            <select style="width: 400px" class="select2" id="partnerID" name="partnerID" multiple>
                                                <option value="">--- Tất cả ---</option>
                                                <%
                                                    for (Account b : dts) {
                                                %>
                                                <option value="<%= b.getEmail()%>"><%= b.getFullName()+" -- "+b.getEmail()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <%
                                                }
                                            %>
                                        </td>
                                        <td colspan="1" class="newToMail" style="display: none;" align="right">
                                            <INPUT type="button"  value=" Old Mail KH" onclick="changeOldToMail()" />
                                        </td>
                                        <td colspan="1" class="templateToMail" align="right">
                                            <INPUT type="button" value="New Mail KH" onclick="changeNewToMail()" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tiêu Đề Tin Nhắn: </td>
                                        <td class="newMail" style="display: none;">
                                            <input type="text" id="title_mail" name="title_mail"/>
                                        </td>
                                        <td class="templateMail">
                                            <%
                                                Email_tmp_config email = new Email_tmp_config();
                                                ArrayList<Email_tmp_config> etc = email.view();

                                                if (etc != null && !etc.isEmpty()) {
                                            %>
                                            <select style="width: 400px" id="title_mail" name="title_mail_temp">
                                                <option value="">--- Tất cả ---</option>
                                                <%
                                                    for (Email_tmp_config c : etc) {
                                                %>
                                                <option value="<%= c.getId()%>"><%= c.getName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <%
                                                }
                                            %>
                                        </td>
                                        <td colspan="1" class="newMail" style="display: none;" align="right">
                                            <INPUT type="button"  value="Template Mail" onclick="changeTemplateMail()" />
                                        </td>
                                        <td colspan="1" class="templateMail" align="right">
                                            <INPUT type="button" value="New Mail" onclick="changeNewMail()" />
                                        </td>
                                    </tr>
                                    <tr class="newMail" style="display: none;">
                                        <td></td>
                                        <td align="left" >Nội Dung: </td>
                                        <td><textarea cols="40" rows="5" type="text" id="content" name="content"></textarea></td>
                                    </tr>
                                    <tr>
                                <input style="display: none;" type="text" value="Yes" id="checkMail" name="checkMail"/>
                                <input style="display: none;" type="text" value="Yes" id="checkToMail" name="checkToMail"/>
                                        <td colspan="3" align="center">
                                            <input class="button" type="submit" name="submit" value="Gửi Tin Nhắn"/>
                                            <input class="button" onclick="window.location.href = '<%= request.getContextPath() + "/admin/contract/"%>'" type="reset" name="reset" value="Hủy"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <SCRIPT language="javascript">
                                            function changeTemplateMail() {
                                                for (let el of document.querySelectorAll('.newMail')) el.style.display = 'none';
                                                for (let el of document.querySelectorAll('.templateMail')) el.style.display = '';
                                                document.getElementById('checkMail').value = 'Yes';
                                            }

                                            function changeNewMail() {
                                                for (let el of document.querySelectorAll('.templateMail')) el.style.display = 'none';
                                                for (let el of document.querySelectorAll('.newMail')) el.style.display = '';
                                                document.getElementById('checkMail').value = 'No';
                                            }
                                            
                                            function changeOldToMail() {
                                                for (let el of document.querySelectorAll('.newToMail')) el.style.display = 'none';
                                                for (let el of document.querySelectorAll('.templateToMail')) el.style.display = '';
                                                document.getElementById('checkToMail').value = 'Yes';
                                            }

                                            function changeNewToMail() {
                                                for (let el of document.querySelectorAll('.templateToMail')) el.style.display = 'none';
                                                for (let el of document.querySelectorAll('.newToMail')) el.style.display = '';
                                                document.getElementById('checkToMail').value = 'No';
                                            }

                                        </SCRIPT>
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