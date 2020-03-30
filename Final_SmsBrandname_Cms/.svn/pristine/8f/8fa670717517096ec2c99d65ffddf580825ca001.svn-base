<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.admin.Modules"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><%@page contentType="text/html; charset=utf-8" %>
<html>
    <head><%@include file="/admin/includes/header.jsp" %></head>
    <body>
        <%
            if (!userlogin.checkEdit(request)) {
                session.setAttribute("mess", "Bạn không có quyền cập nhật module!");
                response.sendRedirect(request.getContextPath() + "/admin/module/module.jsp");
                return;
            }
            Modules oneModule = new Modules();
            int gid = RequestTool.getInt(request, "id");
            oneModule = oneModule.getModuleByID(gid);
            if (oneModule == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ. Bạn vui lòng kiểm tra lại!");
                response.sendRedirect(request.getContextPath() + "/admin/module/module.jsp");
                return;
            }
            if (request.getParameter("submit") != null) {
                //---------------------------
                String name = Tool.validStringRequest(request.getParameter("name"));
                String desc = Tool.validStringRequest(request.getParameter("desc"));
                String resource = Tool.validStringRequest(request.getParameter("resource"));
                int status = Tool.string2Integer(request.getParameter("status"));
                //---
                oneModule.setName(name);
                oneModule.setResource(resource);
                oneModule.setDesc(desc);
                oneModule.setStatus(status);
                //------------
                if (oneModule.updateModule(oneModule)) {
                    session.setAttribute("mess", "Cập nhật dữ liệu thành công!");
                    response.sendRedirect(request.getContextPath() + "/admin/module/module.jsp");
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
                            <%
                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <form action="" method="post">
                            <input type="hidden" value="<%=gid%>" name="gid"/>
                            <table  align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th style="font-weight: bold" scope="col" class="rounded redBoldUp">Cập nhật Module</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tên nhóm: </td>
                                        <td colspan="2"><input value="<%=oneModule.getName()%>" size="75" type="text" name="name"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tài nguyên sử dụng: </td>
                                        <td colspan="2"><input value="<%=oneModule.getResource()%>" size="75" type="text" name="resource"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mô tả: </td>
                                        <td colspan="2"><textarea cols="55" name="desc"><%=oneModule.getDesc()%></textarea></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Trạng thái: </td>
                                        <td colspan="2">
                                            <select name="status">
                                                <option <%=(oneModule.getStatus() == 1) ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%=(oneModule.getStatus() == 0) ? "selected='selected'" : ""%> value="0">Khóa</option>
                                            </select>
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td colspan="4" align="center">
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/module/module.jsp"%>'" type="reset" name="reset" value="Hủy"/>
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