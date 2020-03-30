<%@page import="gk.myname.vn.utils.SMSUtils"%>
<%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.entity.AlertNotify"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
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
            AlertNotify oneProvi = null;
            if (request.getParameter("submit") != null) {
                //---------------------------
                String phone = RequestTool.getString(request, "phone");
                String message = RequestTool.getString(request, "message");
                int _labelId = RequestTool.getInt(request, "_labelId");
                int kind = RequestTool.getInt(request, "kind");
                int type = RequestTool.getInt(request, "type");
                String contentEmail = RequestTool.getString(request, "contentEmail");
                int startTime = RequestTool.getInt(request, "startTime");
                int endTime = RequestTool.getInt(request, "endTime");
                int delay = RequestTool.getInt(request, "delay");
                String email = RequestTool.getString(request, "email");
                //---
                if (!Tool.checkNull(phone)) {
                    phone = SMSUtils.phoneTo84(phone);
                }
                oneProvi = new AlertNotify();
                oneProvi.setPhone(phone);
                oneProvi.setMessage(message);
                oneProvi.setLabelId(_labelId);
                oneProvi.setKind(kind);
                oneProvi.setType(type);
                oneProvi.setContentEmail(contentEmail);
                oneProvi.setStartTime(startTime);
                oneProvi.setEndTime(endTime);
                oneProvi.setDelay(delay);
                oneProvi.setEmail(email);
                //------------
                if (oneProvi.add(oneProvi)) {
                    session.setAttribute("mess", "Thêm mới dữ liệu thành công!");
                    response.sendRedirect(request.getContextPath() + "/admin/monitorapp/index.jsp");
                    return;
                } else {
                    session.setAttribute("mess", "Thêm mới dữ liệu lỗi!");
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
                                        <th scope="col" class="rounded"></th>
                                        <th style="font-weight: bold" scope="col" class="rounded redBoldUp">Thêm mới MONITOR</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Phone: </td>
                                        <td colspan="2">
                                            <input size="25" type="text" name="phone"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            Nhãn Monitor
                                            <select style="width: 180px" id="_label" name="_labelId">
                                                <option value="">Tất cả</option>
                                                <%ArrayList<BrandLabel> allLabel = BrandLabel.getAll();
                                                    for (BrandLabel one : allLabel) {
                                                %>
                                                <option value="<%=one.getId()%>"><%=one.getBrandLabel()%>  [<%=one.getUserOwner()%>] <%=one.getStatus() == 1 ? "" : "[Lock]"%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tin nhắn SMS </td>
                                        <td colspan="2">
                                            <textarea cols="55" name="message"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">KIND: </td>
                                        <td colspan="2">
                                            <select name="kind">
                                                <option value="<%=AlertNotify.KIND.MONITOR.val%>"><%=AlertNotify.KIND.MONITOR.desc%></option>
                                                <option value="<%=AlertNotify.KIND.ALER.val%>"><%=AlertNotify.KIND.ALER.desc%></option>
                                                <option value="<%=AlertNotify.KIND.ALL.val%>"><%=AlertNotify.KIND.ALL.desc%></option>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            TYPE 
                                            <select name="type">
                                                <option value="<%=AlertNotify.TYPE.SMS.val%>"><%=AlertNotify.TYPE.SMS.desc%></option>
                                                <option value="<%=AlertNotify.TYPE.SMS.val%>"><%=AlertNotify.TYPE.SMS_NOMAL.desc%></option>
                                                <option value="<%=AlertNotify.TYPE.EMAIL.val%>"><%=AlertNotify.TYPE.EMAIL.desc%></option>
                                                <option value="<%=AlertNotify.TYPE.ALL.val%>"><%=AlertNotify.TYPE.ALL.desc%></option>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            Delay Time
                                            <input type="text" name="delay" value="60"> Phút/lần
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Nội Dung Email</td>
                                        <td colspan="2">
                                            <textarea cols="55" name="contentEmail"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">StartTime: </td>
                                        <td colspan="2">
                                            <input size="25" type="text" name="startTime" value="7"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            End Time
                                            <input size="25" type="text" name="endTime" value="23"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Email: </td>
                                        <td colspan="2"><input size="75" type="text" name="email"/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <input class="button" type="submit" name="submit" value="Thêm mới"/>
                                            <input class="button" onclick="window.location.href = '/admin/monitorapp/index.jsp'" type="reset" name="reset" value="Hủy"/>
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