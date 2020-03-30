<%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.entity.AlertNotify"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        <%  //-          
            if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin");
                return;
            }
            int max = 50;
            ArrayList<AlertNotify> all = null;
            AlertNotify pDao = new AlertNotify();
            int currentPage = RequestTool.getInt(request, "page", 1);
            String code = RequestTool.getString(request, "code");
            all = pDao.getbyAll(currentPage, max, code);
            int totalPage = 0;
            int totalRow = pDao.countAll(code);
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
                        <!-- Tìm kiếm-->
                        <form action="<%=request.getContextPath() + "/admin/monitorapp/index.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Tài Khoản MONITOR</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Phone Hoặc Email </td>
                                        <td>
                                            <input size="20" type="text" name="code"/>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;
                                            <input class="button" onclick="location.href = '<%=request.getContextPath() + "/admin/monitorapp/add.jsp"%>'" type="button" name="Thêm mới" value="Thêm mới"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>      
                        <!--End tim kiếm-->
                        <%@include file="/admin/includes/page.jsp" %>
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <!--Content-->
                        <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company">STT</th>
                                    <th scope="col" class="rounded">PHONE</th>
                                    <th scope="col" class="rounded">LABEL</th>
                                    <th scope="col" class="rounded">KIND </th>
                                    <th scope="col" class="rounded">TYPE</th>
                                    <th scope="col" class="rounded">Start Time</th>
                                    <th scope="col" class="rounded">End Time</th>
                                    <th scope="col" class="rounded">Delay Time</th>
                                    <th scope="col" class="rounded">EMAIL</th>
                                    <th scope="col" class="rounded">Edit</th>
                                    <th scope="col" class="rounded-q4">Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    for (Iterator<AlertNotify> iter = all.iterator(); iter.hasNext();) {
                                        AlertNotify oneAlert = iter.next();
                                        int tmp = (currentPage - 1) * 25 + count++;
                                        BrandLabel brand = BrandLabel.getFromCache(oneAlert.getLabelId());
                                        
                                %>
                                <tr>
                                    <td class="boder_right"><%=tmp%></td>
                                    <td class="boder_right" align="left">
                                        <%=oneAlert.getPhone()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%if(brand!=null){ %>
                                        <%=brand.getBrandLabel() + " - [" + brand.getUserOwner() + "]"%>
                                        <%}else {out.print("Không Tìm thấy Brand??");}%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=AlertNotify.KIND.getname(oneAlert.getKind())%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=AlertNotify.TYPE.getname(oneAlert.getType())%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneAlert.getStartTime()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneAlert.getEndTime()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneAlert.getDelay() %>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneAlert.getEmail()%>
                                    </td>
                                    <%if (userlogin.checkEdit(request)) {%><td class="boder_right"><a href="/admin/monitorapp/edit.jsp?id=<%=oneAlert.getNotifyId()%>"><img width="24px" src="<%= request.getContextPath()%>/admin/resource/images/user_edit.png" alt="" title="" border="0" /></a></td><%}%>
                                    <%if (userlogin.checkDel(request)) {%><td><a href="/admin/monitorapp/del.jsp?id=<%=oneAlert.getNotifyId()%>" class="ask"><img src="<%= request.getContextPath()%>/admin/resource/images/remove.png" alt="" title="" border="0" /></a></td><%}%>
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