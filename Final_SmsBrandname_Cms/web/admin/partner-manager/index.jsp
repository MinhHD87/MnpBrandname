<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        <%            ArrayList<PartnerManager> all = null;
            PartnerManager pdao = new PartnerManager();
            int max = 20;
            int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
            if (currentPage < 1) {
                currentPage = 1;
            }
            String name = RequestTool.getString(request, "name");
            String code = RequestTool.getString(request, "code");
            int status = RequestTool.getInt(request, "status", -1);
            all = pdao.getAll(currentPage, max, name, code, status);

            int totalPage = 0;
            int totalRow = pdao.countAll(name, code, status);
            totalPage = (int) totalRow / max;
            if (totalRow % max != 0) {
                totalPage++;
            }
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <form action="<%=request.getContextPath() + "/admin/partner-manager/"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Tìm kiếm đại lý</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td class="redBold">Partner Code:</td>
                                        <td> 
                                            <input value="" id="endRequest" class="dateproc" size="20" type="text" name="code"/>
                                            &nbsp;&nbsp;&nbsp;<span class="redBold">Tên Công ty </span>
                                            <input value="" id="stRequest" class="dateproc" size="30" type="text" name="name"/>
                                            &nbsp;&nbsp;&nbsp;
                                            Trạng thái
                                            <select name="status">
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
                                            <%=buildAddControl(request, userlogin, "/admin/partner-manager/add.jsp")%>
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
                                    <th scope="col" class="rounded">ID TK</th>
                                    <th scope="col" class="rounded">Tên Công ty</th>
                                    <th scope="col" class="rounded">Mô tả</th>
                                    <th scope="col" class="rounded">PARTNER CODE</th>
                                    <th scope="col" class="rounded">Hợp Đồng</th>
                                    <th scope="col" class="rounded">QL Tài khoản</th>
                                    <th scope="col" class="rounded">Thêm Tài khoản</th>
                                    <th scope="col" class="rounded">Trạng thái</th>
                                        <%=buildHeader(request, userlogin,true,true)%>
                                </tr>
                            </thead>
                            <tbody>
                                <%                                    int count = 1; //Bien dung de dem so dong
                                    for (Iterator<PartnerManager> iter = all.iterator(); iter.hasNext();) {
                                        PartnerManager onePartner = iter.next();
                                %>
                                <tr>
                                    <td class="boder_right"><%=count++%></td>
                                    <td align="left" class="boder_right">
                                        <%=onePartner.getId()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=onePartner.getName()%>
                                        <%
                                            if (onePartner.hasChild()) {
                                                out.print("<sub><a class='redBoldUp' href='" + request.getContextPath() + "/admin/partner-manager/agentcy.jsp?code=" + onePartner.getCode() + "'>[Có ĐL con]</a><sub>");
                                            }
                                            if (onePartner.hasParent()) {
                                                PartnerManager parent = onePartner.getParentCache();
                                                out.print("<sup  style='color: blue;font-weight: bold'>[TK QL: " + parent.getCode() + "]<sup>");
                                            }
                                        %>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%= onePartner.getDesc()%>
                                    </td>
                                    <td align="left" class="boder_right redBold">
                                        <%=onePartner.getCode()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <a href="hopdong.jsp?pid=<%=onePartner.getId() %>">
                                            Xem HĐ
                                        </a>
                                    </td>
                                    <td align="center" class="boder_right">
                                        <a href="<%=request.getContextPath()%>/admin/customer/agency/index.jsp?key=<%=onePartner.getCode()%>">
                                            <img width="24px" src="<%=request.getContextPath()%>/admin/resource/images/users.png" alt="User"/>
                                        </a>
                                    </td>
                                    <td align="center" class="boder_right">
                                        <a title="Thêm mới tài khoản" href="<%=webPath + "/admin/customer/agency/add.jsp?cpCode=" + onePartner.getCode()%>">
                                            <img alt="Thêm mới tài khoản" src="<%=request.getContextPath() + "/admin/resource/images/add-user.png"%>"/>
                                        </a>
                                    </td>
                                    <td align="center" class="boder_right">
                                        <%
                                            if (onePartner.getStatus() == 1) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%
                                        } else if (onePartner.getStatus() == 404) {
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
                                            "/admin/partner-manager/edit.jsp?id=" + onePartner.getId(),
                                            (onePartner.getStatus() == 404) ? "/admin/partner-manager/del_ever.jsp?id=" + onePartner.getId() : "/admin/partner-manager/del.jsp?id=" + onePartner.getId())%>
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