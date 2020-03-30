<%@page import="gk.myname.vn.admin.MoneyAddLog"%>
 <%@page import="java.text.DecimalFormat"%>
<%@page import="gk.myname.vn.admin.BillingAcc"%>
<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        
        <%            if (!userlogin.checkView(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập module này!");
                response.sendRedirect(request.getContextPath() + "/admin");
                return;
            }
            DecimalFormat format = new DecimalFormat("$,000");
            String keyBillingAcc = RequestTool.getString(request, "billingacc");
            String keyString = RequestTool.getString(request, "key");
            String keyUserAdd = RequestTool.getString(request, "useracc");
            int status = RequestTool.getInt(request, "status", 0);
            ArrayList all = null;
            MoneyAddLog dao = new MoneyAddLog();
            int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
            if (currentPage < 1) {
                currentPage = 1;
            }
            maxRow = 20;
            int totalPage = 0;
            int totalRow = dao.countAllLog(keyString);
            totalPage = (int) totalRow / maxRow;
            if (totalRow % maxRow != 0) {
                totalPage++;
            }
            all = dao.getAllLog(currentPage, maxRow, keyString);
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <form action="<%=request.getContextPath() + "/admin/billing/hisMoney.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Lịch sử cộng tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Từ khoá</td>
                                        <td>
                                            <input type="text" name="key" size="55"/>
                                            &nbsp;&nbsp;
                                            Trạng Thái:
                                            <select name="status">
                                                <option <%=status == 0 ? "selected='selected'" : ""%> value="0">Trả sau</option>
                                                <option <%=status == 1 ? "selected='selected'" : ""%> value="1">Trả trước</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            <%--=buildAddControl(request, userlogin, "/admin/customer/agency/add.jsp")--%>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>      
                        <!--End tim kiếm-->
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
                                    <th scope="col" class="rounded">Người cộng</th>
                                    <th scope="col" class="rounded">Tài khoản hưởng</th>
                                    <th scope="col" class="rounded">Số tiền</th>
                                    <th scope="col" class="rounded">Thời gian</th>
                                    <th scope="col" class="rounded">Kết quả</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%                                    int count = 1; //Bien dung de dem so dong
                                    for (Iterator<MoneyAddLog> iter = all.iterator(); iter.hasNext();) {
                                        MoneyAddLog oneAdmin = iter.next();
                                        int index = (currentPage - 1) * maxRow + count++;
                                %>
                                <tr>
                                    <td class="boder_right"><%=index%></td>
                                    <td class="boder_right"><%=oneAdmin.getUsernameadd()%></td>
                                    <td class="boder_right"><%=oneAdmin.getAccountbilling()%></td>
                                    <td class="boder_right"><%=format.format(oneAdmin.getMoneys())%></td>
                                    <td class="boder_right"><%=oneAdmin.getTime_add()%></td>
                                    <td class="boder_right"><%=oneAdmin.getResultadd()%></td>
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