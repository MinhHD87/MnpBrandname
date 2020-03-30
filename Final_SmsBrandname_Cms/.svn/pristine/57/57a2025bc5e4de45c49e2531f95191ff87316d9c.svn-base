<%@page import="gk.myname.vn.utils.SMSUtils"%>
<%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.entity.AlertNotify"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><%@page contentType="text/html; charset=utf-8" %>
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
        <%  //--          
            if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập trang này!");
                response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
                return;
            }
            int id = RequestTool.getInt(request, "id");
            AlertNotify oneAlert = new AlertNotify();
//            Tool.debug("ID Request=" + id);
            oneAlert = oneAlert.getbyId(id);
//            Tool.debug("ID GetEntity=" + oneAlert.getNotifyId());
            if (id == 0 || oneAlert == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/monitorapp/index.jsp");
                return;
            }
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
                if (!Tool.checkNull(phone)) {
                    phone = SMSUtils.phoneTo84(phone);
                }
                //---
                oneAlert.setPhone(phone);
                oneAlert.setMessage(message);
                oneAlert.setLabelId(_labelId);
                oneAlert.setKind(kind);
                oneAlert.setType(type);
                oneAlert.setContentEmail(contentEmail);
                oneAlert.setStartTime(startTime);
                oneAlert.setEndTime(endTime);
                oneAlert.setDelay(delay);
                oneAlert.setEmail(email);
//                Tool.debug(DateProc.createTimestamp() + "ID=" + id + "|" + oneAlert.getNotifyId());
                //------------
                if (oneAlert.update(oneAlert)) {
                    session.setAttribute("mess", "Cập nhật dữ liệu thành công!");
                    response.sendRedirect(request.getContextPath() + "/admin/monitorapp/index.jsp");
                    return;
                } else {
                    session.setAttribute("mess", "Cập nhật dữ liệu lỗi!");
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
                                <input type="hidden" name="id" value="<%=id%>"/>
                                <tr>
                                    <td></td>
                                    <td align="left">Phone: </td>
                                    <td colspan="2">
                                        <input size="25" type="text" value="<%=oneAlert.getPhone()%>" name="phone"/>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        Nhãn Monitor
                                        <select style="width: 180px" id="_label" name="_labelId">
                                            <option value="">Tất cả</option>
                                            <%ArrayList<BrandLabel> allLabel = BrandLabel.getAll();
                                                for (BrandLabel one : allLabel) {
                                            %>
                                            <option <%=oneAlert.getLabelId() == one.getId() ? "selected='selected'" : ""%> 
                                                value="<%=one.getId()%>"><%=one.getBrandLabel()%> [<%=one.getUserOwner()%>] <%=one.getStatus() == 1 ? "" : "[Lock]"%></option>
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
                                        <textarea cols="55" name="message"><%=oneAlert.getMessage()%></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td align="left">KIND: </td>
                                    <td colspan="2">
                                        <select name="kind">
                                            <option <%=oneAlert.getKind() == AlertNotify.KIND.MONITOR.val ? "selected='selected'" : ""%> value="<%=AlertNotify.KIND.MONITOR.val%>"><%=AlertNotify.KIND.MONITOR.desc%></option>
                                            <option <%=oneAlert.getKind() == AlertNotify.KIND.ALER.val ? "selected='selected'" : ""%> value="<%=AlertNotify.KIND.ALER.val%>"><%=AlertNotify.KIND.ALER.desc%></option>
                                            <option <%=oneAlert.getKind() == AlertNotify.KIND.ALL.val ? "selected='selected'" : ""%> value="<%=AlertNotify.KIND.ALL.val%>"><%=AlertNotify.KIND.ALL.desc%></option>
                                        </select>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        TYPE 
                                        <select name="type">
                                            <option <%=oneAlert.getType() == AlertNotify.TYPE.SMS.val ? "selected='selected'" : ""%> value="<%=AlertNotify.TYPE.SMS.val%>"><%=AlertNotify.TYPE.SMS.desc%></option>
                                            <option <%=oneAlert.getType() == AlertNotify.TYPE.SMS_NOMAL.val ? "selected='selected'" : ""%> value="<%=AlertNotify.TYPE.SMS_NOMAL.val%>"><%=AlertNotify.TYPE.SMS_NOMAL.desc%></option>
                                            <option <%=oneAlert.getType() == AlertNotify.TYPE.EMAIL.val ? "selected='selected'" : ""%> value="<%=AlertNotify.TYPE.EMAIL.val%>"><%=AlertNotify.TYPE.EMAIL.desc%></option>
                                            <option <%=oneAlert.getType() == AlertNotify.TYPE.ALL.val ? "selected='selected'" : ""%> value="<%=AlertNotify.TYPE.ALL.val%>"><%=AlertNotify.TYPE.ALL.desc%></option>
                                        </select>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        Delay Time
                                        <input type="text" name="delay" value="<%=oneAlert.getDelay()%>"> Phút/lần
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td align="left">Nội Dung Email</td>
                                    <td colspan="2">
                                        <textarea cols="55" name="contentEmail"><%=oneAlert.getEmail()%></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td align="left">StartTime: </td>
                                    <td colspan="2">
                                        <input size="25" type="text" value="<%=oneAlert.getStartTime()%>" name="startTime"/>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        End Time
                                        <input size="25" type="text" value="<%=oneAlert.getEndTime()%>" name="endTime"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td align="left">Email: </td>
                                    <td colspan="2"><input size="75" type="text" value="<%=oneAlert.getEmail()%>" name="email"/></td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="center">
                                        <input class="button" type="submit" name="submit" value="Cập nhật"/>
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