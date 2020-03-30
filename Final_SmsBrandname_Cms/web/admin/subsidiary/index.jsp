<%@page import="gk.myname.vn.entity.Subsidiary"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        <%            ArrayList<Subsidiary> all = null;
            Subsidiary pdao = new Subsidiary();
            int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
            if (currentPage < 1) {
                currentPage = 1;
            }
            String name = RequestTool.getString(request, "name");
            String fax = RequestTool.getString(request, "fax");
            String bank_acc = RequestTool.getString(request, "bank_acc");
            String business_code = RequestTool.getString(request, "business_code");
            String phone = RequestTool.getString(request, "phone");
            int status = RequestTool.getInt(request, "status", -1);
            all = pdao.findList(maxRow, currentPage, name, bank_acc, business_code, phone, fax, status);

            int totalPage = 0;
            int totalRow = pdao.count(name, bank_acc, business_code, phone, fax, status);
            totalPage = (int) totalRow / maxRow;
            if (totalRow % maxRow != 0) {
                totalPage++;
            }
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <form action="<%=request.getContextPath() + "/admin/subsidiary/"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Tìm kiếm công ty</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td class="redBold">Tên Công Ty:</td>
                                        <td> 
                                            <input size="30" type="text" name="name"/>
                                            &nbsp;&nbsp;&nbsp;<span class="redBold">Phone: </span>
                                            <input size="30" type="text" name="phone"/>
                                            &nbsp;&nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td class="redBold">TK Ngân Hàng:</td>
                                        <td>
                                            <input value="" id="stRequest" class="dateproc" size="30" type="text" name="bank_acc"/>
                                            &nbsp;&nbsp;&nbsp;<span class="redBold">Fax: </span>
                                            <input value="" id="stRequest" class="dateproc" size="30" type="text" name="fax" style="margin-left:15px "/>
                                            &nbsp;&nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td class="redBold">Mã Số Thuế:</td>
                                        <td>
                                            <input value="" id="stRequest" class="dateproc" size="30" type="text" name="business_code"/>
                                            &nbsp;&nbsp;&nbsp;
                                            <span class="redBold">Trạng Thái: </span>
                                            <select name="status" style="margin-left: 10px">
                                                <option <%=status == -1 ? "selected='selected'" : ""%> value="-1">-Tất cả-</option>
                                                <option <%=status == 1 ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%=status == 0 ? "selected='selected'" : ""%> value="0">Khóa</option>
                                                <option <%=status == 404 ? "selected='selected'" : ""%> value="404">Đã xóa</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <%=buildAddControl(request, userlogin, "/admin/subsidiary/add.jsp")%>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>  
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <!--Content-->
                        <%@include file="/admin/includes/page.jsp" %>
                        <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company">STT</th>
                                    <th scope="col" class="rounded">ID</th>
                                    <th scope="col" class="rounded">Tên Công ty</th>
                                    <th scope="col" class="rounded">Địa Chỉ</th>
                                    <th scope="col" class="rounded">TK Ngân Hàng</th>
                                    <th scope="col" class="rounded">Địa Chỉ Ngân Hàng</th>                              
                                    <th scope="col" class="rounded">MST</th>
                                    <th scope="col" class="rounded">Số Điện Thoại</th>
                                    <th scope="col" class="rounded">Fax</th>
                                    <th scope="col" class="rounded">Người Quản Lý</th>
                                    <th scope="col" class="rounded">Trạng thái</th>
                                        <%=buildHeader(request, userlogin, true, true)%>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    for (Subsidiary subs : all) {
                                %>
                                <tr>
                                    <td class="boder_right"><%=count++%></td>
                                    <td align="left" class="boder_right">
                                        <%=subs.getId()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=subs.getName()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%= subs.getAddress()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%= subs.getBank_acc()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%= subs.getBank_add()%>
                                    </td>
                                    <td align="left" class="boder_right redBold">
                                        <%=subs.getBusiness_code()%>
                                    </td>
                                    <td align="left" class="boder_right redBold">
                                        <%=subs.getPhone()%>
                                    </td>
                                    <td align="left" class="boder_right redBold">
                                        <%=subs.getFax()%>
                                    </td>
                                    <td align="left" class="boder_right redBold">
                                        <%=subs.getManager()%>
                                    </td>
                                    <td align="center" class="boder_right">
                                        <%
                                            if (subs.getStatus() == 1) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%
                                        } else if (subs.getStatus() == 404) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/Full_Recycle_Bin.png"/>
                                        <%
                                        } else {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <%=buildControl(request, userlogin,
                                            "/admin/subsidiary/edit.jsp?id=" + subs.getId(), "/admin/subsidiary/delete.jsp?id=" + subs.getId())%>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div><!-- end of right content-->
                </div>   <!--end of center content -->
                <div class="clear"></div>
            </div> <!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html>