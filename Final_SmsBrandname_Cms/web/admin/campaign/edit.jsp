<%@page import="gk.myname.vn.entity.MsgBrandAds"%>
<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><%@page contentType="text/html; charset=utf-8" %>
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script type="text/javascript" src="<%= request.getContextPath()%>/admin/resource/js/jquery.blockUI.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('.dateproc').datetimepicker({
                    lang: 'vi',
                    timepicker: false,
                    format: 'd/m/Y',
                    formatDate: 'Y/m/d',
                    minDate: '2017/01/01', // yesterday is minimum date
                    maxDate: '+1970/01/02' // and tommorow is maximum date calendar
                });
            });
            $(document).ready(function () {
                $('.ItemPopup').showPopup({
                    top: 100,
                    closeButton: ".close_popup", //khai báo nút close cho popup
                    scroll: 0, //cho phép scroll khi mở popup, mặc định là không cho phép
                    width: 500,
                    height: 'auto',
                    closeOnEscape: true
                });
            });
            function changeBrand() {
                var selectBr = $("#_label option:selected");
                if (selectBr.val() !== "") {
                    var user = selectBr.attr("user_owner");
                    var url = "/admin/statistic/ajax/list-cp.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_userSender");
                    $("#_userSender").select2('val', user);
                } else {
                    var url = "/admin/statistic/ajax/list-cp.jsp?user=" + 0;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_userSender");
                    $("#_userSender").select2('val', "");
                }
            }
            function changeCP() {
                var selectBr = $("#_userSender option:selected");
                var user = selectBr.val();
                if (user !== "") {
                    var url = "/admin/statistic/ajax/listBrand.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_label");
                } else {
                    var url = "/admin/statistic/ajax/listBrand.jsp?user=0";
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_label");
                }
                $("#_label").select2("val", "");
            }
        </script>
    </head>
    <body>
        <%  //--          
            if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập trang này!");
                response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
                return;
            }
            int id = RequestTool.getInt(request, "id");
            MsgBrandAds msgBrandAds = new MsgBrandAds();
            MsgBrandAds mba = msgBrandAds.findById(id);
            if (id == 0 || mba == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/campaign/detail.jsp");
                return;
            }
            String phone = RequestTool.getString(request, "phone");
            String oper = RequestTool.getString(request, "oper");
            String message = RequestTool.getString(request, "message");
            int total_sms = RequestTool.getInt(request, "total_sms");
            String label = RequestTool.getString(request, "label");
            String user_sender = RequestTool.getString(request, "user_sender");
            String tran_id = RequestTool.getString(request, "tran_id");
            String result = RequestTool.getString(request, "result");
            String time_send = RequestTool.getString(request, "time_send");
            String send_to = RequestTool.getString(request, "send_to");
            String br_group = RequestTool.getString(request, "br_group");
            String cp_code = RequestTool.getString(request, "cp_code");
            int status = RequestTool.getInt(request, "status");           
            if (request.getParameter("submit") != null) {
                mba.setPhone(phone);
                mba.setOper(oper);
                mba.setMessage(message);
                mba.setTotalMsg(total_sms);
                mba.setLabel(label);
                mba.setUserSender(user_sender);
                mba.setTranId(tran_id);
                mba.setResult(result);
                mba.setTimeSend(time_send);
                mba.setSendTo(send_to);
                mba.setBrGroup(br_group);
                mba.setCpCode(cp_code);
                mba.setStatus(status);
                if (mba.update(mba)) {
                    session.setAttribute("mess", "Cập nhật dữ liệu thành công!");
                    response.sendRedirect(request.getContextPath() + "/admin/campaign/detail.jsp");
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
                                        <th style="font-weight: bold" scope="col" class="rounded redBoldUp">Chỉnh sửa thông tin kết quả chiến dịch</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Phone: </td>
                                        <td colspan="2"><input value="<%=mba.getPhone()%>" size="75" type="text" name="phone"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Oper: </td>
                                        <td colspan="2"><input value="<%=mba.getOper()%>" size="75" type="text" name="oper"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Message: </td>
                                        <td colspan="2">
                                            <textarea  cols="77" rows="5" name="message"><%=mba.getMessage()%></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Total SMS: </td>
                                        <td colspan="2"><input value="<%=mba.getTotalMsg()%>" size="75" type="number" name="total_sms"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Label: </td>
                                        <td colspan="2"><input value="<%=mba.getLabel()%>" size="75" type="text" name="label"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">User sender: </td>
                                        <td colspan="2"><input value="<%=mba.getUserSender()%>" size="75" type="text" name="user_sender"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Trans ID: </td>
                                        <td colspan="2"><input value="<%=mba.getTranId()%>" size="75" type="text" name="tran_id"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Result: </td>
                                        <td colspan="2"><input value="<%=mba.getResult()%>" size="75" type="text" name="result"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Time send: </td>
                                        <td colspan="2">
                                            <input value="<%=mba.getTimeSend()%>" size="75" type="text" name="time_send"/>
                                        </td>   
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Send to: </td>
                                        <td colspan="2"><input value="<%=mba.getSendTo()%>" size="75" type="text" name="send_to"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">BR Group: </td>
                                        <td colspan="2"><input value="<%=mba.getBrGroup()%>" size="75" type="text" name="br_group"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">CP Code: </td>
                                        <td colspan="2"><input value="<%=mba.getCpCode()%>" size="75" type="text" name="cp_code"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Trạng thái</td>
                                        <td>
                                            <select name="status">
                                                <option <%=mba.getStatus() == 1 ? "selected='selected'" : ""%> value="1">Thành công</option>
                                                <option <%=mba.getStatus() == 0 ? "selected='selected'" : ""%> value="0">Error</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
                                            <input class="button" onclick="window.location.href = '/admin/campaign/detai.jsp'" type="reset" name="reset" value="Hủy"/>
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