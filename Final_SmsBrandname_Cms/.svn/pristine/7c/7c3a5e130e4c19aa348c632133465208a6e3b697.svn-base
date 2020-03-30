<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.entity.BrandLabel"%>
<%@page import="gk.myname.vn.entity.Email_tmp_config"%>
<%@page import="gk.myname.vn.entity.Provider"%>
<%@page import="gk.myname.vn.entity.Complain_log"%>
<%@page import="gk.myname.vn.utils.Tool"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script>
            $(document).ready(function () {
                $("#_send_to").select2();
                $("#_name").select2({
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
                        var opt = $("#_name option:selected");
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
        <%  if (!userlogin.checkEdit(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin/complain_log/");
                return;
            }
            int id = Tool.string2Integer(request.getParameter("id"));

            Complain_log daocl = new Complain_log();
            Complain_log editcl = null;
            editcl = daocl.getbyid(id);
            if (id == 0 || editcl == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ...!");
                response.sendRedirect(request.getContextPath() + "/admin/complain_log/");
                return;
            }
            //---------------------------
            if (request.getParameter("submit") != null) {
                String result = Tool.validStringRequest(request.getParameter("result"));
                int status = RequestTool.getInt(request, "status",0);
                editcl.setUpdate_by(userlogin.getUserName());
                editcl.setResult(result);
                editcl.setStatus(status);
                //------------
                if (daocl.edit(editcl)) {
                    session.setAttribute("mess", " Sửa khiếu nại thành công!");
                    response.sendRedirect(request.getContextPath() + "/admin/complain_log/");
                    return;
                } else {
                    session.setAttribute("mess", "Sửa khiếu nại lỗi!");
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
                                }%>
                        </div>
                        <form onsubmit="return checkPartnerCode()" action="" method="post">
                            <table  align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th align="center" style="font-weight: bold" scope="col" class="rounded redBoldUp">
                                            Sửa Complian_log</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Kết quả gửi: </td>
                                        <td colspan="2">
                                            <textarea cols="90" rows="10" name="result"><%=editcl.getResult()%></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Kết quả gửi: </td>
                                        <td colspan="2">
                                            <select name="status">
                                                <option <%=editcl.getStatus() == 0 ? "selected='selected'" : ""%> value="0">Chờ xử lý</option>
                                                <option <%=editcl.getStatus() == 1 ? "selected='selected'" : ""%> value="1">Đang xử lý</option>
                                                <option <%=editcl.getStatus() == 2 ? "selected='selected'" : ""%> value="2">Đã xử lý xong</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center">
                                            <input class="button" type="submit" name="submit" value="Sửa"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/complain_log"%>'" type="reset" name="reset" value="Hủy"/>
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