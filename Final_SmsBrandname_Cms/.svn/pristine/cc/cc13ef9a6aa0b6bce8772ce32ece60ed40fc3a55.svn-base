<%@page import="gk.myname.vn.entity.Email_tmp_config"%>
<%@page import="gk.myname.vn.utils.RequestTool"%>
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
                response.sendRedirect(request.getContextPath() + "/admin/email_tmp_config/");
                return;
            }
            int id = Tool.string2Integer(request.getParameter("id"));

            Email_tmp_config edao = new Email_tmp_config();
            Email_tmp_config editEmail = null;
            editEmail = edao.getbyid(id);
            if (id == 0 || editEmail == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ...!");
                response.sendRedirect(request.getContextPath() + "/admin/email_tmp_config/");
                return;
            }
            if (request.getParameter("submit") != null) {
                //----------Log--------------
                String name = Tool.validStringRequest(request.getParameter("name"));
                String des = Tool.validStringRequest(request.getParameter("des"));
                String content = Tool.validStringRequest(request.getParameter("content"));
                int status = Tool.string2Integer(request.getParameter("status"));
                //---
                editEmail.setName(name);
                editEmail.setDes(des);
                editEmail.setContent(content);
                editEmail.setStatus(status);
                editEmail.setUpdateBy(userlogin.getUserName());
                if (edao.update(editEmail)) {
                    session.setAttribute("mess", "Sửa dữ liệu thành công");
                    response.sendRedirect(request.getContextPath() + "/admin/email_tmp_config/");
                    return;
                } else {
                    session.setAttribute("mess", "Sửa dữ liệu lỗi");
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
                            <%if (session.getAttribute(
                                        "mess") != null) {
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
                                            Cập nhật Template Mail</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tiêu đề </td>
                                        <td><input value="<%=editEmail.getName()%>" id="add_name" autocomplete="off" size="50" type="text" name="name"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mô tả</td>
                                        <td>
                                            <textarea cols="57" name="des"><%=editEmail.getDes()%></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Nội Dung</td>
                                        <td>
                                            <textarea cols="57" name="content"><%=editEmail.getContent()%></textarea>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td></td>
                                        <td align="left">STATUS:</td>
                                        <td>
                                            <select name="status">
                                                <option <%=editEmail.getStatus() == 1 ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%=editEmail.getStatus() == 0 ? "selected='selected'" : ""%> value="0">Khóa</option>
<!--                                                <option <%=editEmail.getStatus() == 404 ? "selected='selected'" : ""%> value="404">Đã Xóa</option>-->
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center">
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/email_tmp_config/"%>'" type="reset" name="reset" value="Hủy"/>
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