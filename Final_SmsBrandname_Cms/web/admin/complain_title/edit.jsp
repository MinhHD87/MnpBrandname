<%@page import="gk.myname.vn.entity.Complain_title"%>
<%@page import="gk.myname.vn.utils.DateProc"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        <%    if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin/complain_title/");
                return;
            }

            int id = Integer.parseInt(request.getParameter("id"));

            Complain_title complain_title = new Complain_title();
            Complain_title compl = null;
            compl = complain_title.findID(id);
            if (compl == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ...!");
                response.sendRedirect(request.getContextPath() + "/admin/subsidiary/");
                return;
            }
            if (request.getParameter("submit") != null) {
                //----------Log--------------
                String title = Tool.validStringRequest(request.getParameter("title"));
                
                compl.setTitle(title);

                if (complain_title.update(compl)) {
                    session.setAttribute("mess", "Sửa dữ liệu thành công");
                    response.sendRedirect(request.getContextPath() + "/admin/complain_title/");
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
                            <%
                                if (session.getAttribute("mess") != null) {
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
                                        <th align="center" style="font-weight: bold" scope="col" class="rounded redBoldUp">
                                            Sửa Nội Dung</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Nội Dung </td>
                                        <td><input value="<%= compl.getTitle() %>" size="80" type="text" name="title"/></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" align="center">
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
                                            <input class="button" onclick="window.location.href = '<%= request.getContextPath() + "/admin/complain_title/"%>'" type="reset" name="reset" value="Hủy"/>
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