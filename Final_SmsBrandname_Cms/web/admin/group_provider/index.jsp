<%@page import="gk.myname.vn.entity.Groups_Providers"%>
<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.entity.GroupProvider"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        <%       
            if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền vào module này!");
                response.sendRedirect(request.getContextPath() + "/admin");
                return;
            }
            
            int max = 20;
            ArrayList<GroupProvider> all = null;
            GroupProvider dao = new GroupProvider();
            
            int currentPage = RequestTool.getInt(request, "page", 1);
            
            String name = RequestTool.getString(request, "name");
            int status = Tool.string2Integer(RequestTool.getString(request, "status", "1"));
            
            all = dao.findAll(max, currentPage, name, status);
            
            int totalPage = 0;
            int totalRow = dao.count(name, status);
            
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
                        <form action="<%=request.getContextPath() + "/admin/group_provider/index.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded redBoldUp">Quản lý nhóm nhà cung cấp</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>                                        
                                        <td>Tên nhóm nhà cung cấp: <input type="text" name="name"/></td>
                                        <td>
                                        <span class="redBold">Trạng thái: </span>
                                        <select name="status">
                                            <option value="1">Active</option>
                                            <option value="0">Khóa</option>
                                        </select>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;
                                            <input class="button" onclick="location.href = '<%=request.getContextPath() + "/admin/group_provider/add.jsp"%>'" type="button" name="Thêm mới" value="Thêm mới"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>      
                        <!--End tim kiếm-->
                        <%@include file="/admin/includes/page.jsp" %>
                        <div align="center" style="margin-bottom: 2px; color: red;font-weight: bold">
                            <%  
                                if (session.getAttribute("mess") != null) {
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
                                    <th scope="col" class="rounded">Tên nhóm</th>
                                    <th scope="col" class="rounded">Mô tả</th>
                                    <th scope="col" class="rounded">Danh sách nhà mạng trong nhóm</th>
                                    <th scope="col" class="rounded">Status</th>
                                    <th scope="col" class="rounded-q4">Edit</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; 
                                    
                                    for (Iterator<GroupProvider> iter = all.iterator(); iter.hasNext();) {
                                        GroupProvider one = iter.next();
                                        int tmp = (currentPage - 1) * 25 + count++;
                                %>
                                    <tr>
                                        <td class="boder_right"><%=tmp%></td>
                                        <td class="boder_right" align="left">
                                            <%=one.getName()%>
                                        </td>
                                        <td class="boder_right">
                                            <%=one.getDescription()%>
                                        </td>
                                        <td class="boder_right">
                                            <% 
                                                Groups_Providers groups_Providers = new Groups_Providers();
                                                ArrayList<Groups_Providers> arrayList = groups_Providers.findAllByGroupId(one.getId());
                                                for (Groups_Providers gp : arrayList ) {
                                            %>
                                            [<%=gp.getProvider().getCode()%>] <%=gp.getProvider().getName()%> --> <%=gp.getNumber()%>
                                            <br/>
                                            <%
                                                }
                                            %>
                                        </td>
                                        <td class="boder_right">
                                            <%if (one.getStatus() == 1) {%>
                                            <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                            <%} else {%>
                                            <img width="32" src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                            <%}%>
                                        </td>
                                        <td>
                                            <a title="Sửa"  href="<%=request.getContextPath()%>/admin/group_provider/edit.jsp?id=<%=one.getId()%>">
                                                <img width="24" src="<%= request.getContextPath()%>/admin/resource/images/user_edit.png" title="Sửa" border="0" />
                                            </a>
                                        </td>
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