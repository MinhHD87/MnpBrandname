<%@page import="gk.myname.vn.entity.Template_sms"%>
<%@page import="gk.myname.vn.entity.Provider_Telco"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="gk.myname.vn.admin.BillingAcc"%>
<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <style>
        </style>
    </head>
    <body>
        <%  if (!userlogin.checkView(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập module này!");
                response.sendRedirect(request.getContextPath() + "/admin");
                return;
            }
            String key = RequestTool.getString(request, "key");
            int status = RequestTool.getInt(request, "status", 1);
            ArrayList all = null;
            BillingAcc dao = new BillingAcc();
            int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
            if (currentPage < 1) {
                currentPage = 1;
            }
            maxRow = 20;
            int totalPage = 0;
            int totalRow = dao.countAllAgentcy(key, status);
            totalPage = (int) totalRow / maxRow;
            if (totalRow % maxRow != 0) {
                totalPage++;
            }
            all = dao.getAllAgentcy(currentPage, maxRow, key, status);
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <form action="<%=request.getContextPath() + "/admin/template_sms/list_acc_temp.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Tìm kiếm tài khoản KH</th>
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
                                                <option <%=status == 1 ? "selected='selected'" : ""%> value="1">Trả trước</option>
                                                <option <%=status == 0 ? "selected='selected'" : ""%> value="0">Trả sau</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
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
                                    <th scope="col" class="rounded">Tên đăng nhập</th>
                                    <th scope="col" class="rounded">Tên đầy đủ</th>
                                    <th scope="col" class="rounded">Thanh toán</th>
                                    <th scope="col" class="rounded">Cấp nhãn theo hướng</th>
                                    <th scope="col" class="rounded">Trạng thái</th>
                                    <th scope="col" class="rounded-q4">Edit</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%                                    int count = 1; //Bien dung de dem so dong
                                    for (Iterator<BillingAcc> iter = all.iterator(); iter.hasNext();) {
                                        BillingAcc oneAdmin = iter.next();
                                        int index = (currentPage - 1) * maxRow + count++;
                                %>
                                <tr>
                                    <td class="boder_right"><%=index%></td>
                                    <td align="left" class="boder_right"><%=oneAdmin.getUsername()%></td>
                                    <td align="left" class="boder_right"><%= oneAdmin.getFullname()%></td>
                                    <td class="boder_right"><% if (oneAdmin.getPrepaid() == 0) {
                                            out.println("Trả sau");
                                        } else {
                                            out.println("<font color='blue'>Trả trước</font>");
                                        }%></td>
                                    <td class="boder_right">
                                        <%
                                            ArrayList<Template_sms> allpro = Template_sms.getCACHE();
                                            for (Template_sms one : allpro) {
                                                if( one.getId_template_send()== oneAdmin.getId_template()){
                                        %>
                                       
                                        [<%=one.getId_template_send()%>] <%=one.getDescription()%> 
                                        
                                        <%
                                            }
                                            }
                                
                                        %>
                                    <td align="center" class="boder_right">
                                        <%if (oneAdmin.getStatus() == 1) {%>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%} else if (oneAdmin.getStatus() == 404) {%>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/remove.png"/>
                                        <%} else {%>
                                        <img width="24" src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                        <%}%>
                                    </td>
                                    <%=buildControl(request, userlogin,
                                            "/admin/template_sms/add_temp.jsp?account=" + oneAdmin.getUsername(),
                                            ""
                                    )%>
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