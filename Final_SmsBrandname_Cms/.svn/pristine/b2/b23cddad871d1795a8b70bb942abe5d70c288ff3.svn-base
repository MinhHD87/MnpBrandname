<%@page import="gk.myname.vn.entity.Provider"%>
<%@page import="java.util.Iterator"%>
<%@page import="gk.myname.vn.utils.SMSUtils"%>
<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.entity.Template_sms"%>
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
            ArrayList<Template_sms> all = null;
            Template_sms pDao = new Template_sms();
            int currentPage = RequestTool.getInt(request, "page", 1);
            String content = RequestTool.getString(request, "content");
            String description = RequestTool.getString(request, "description");
            int status = RequestTool.getInt(request, "status", 1);
            all = pDao.getList(currentPage, maxRow, content, description, status);
            int totalPage = 0;
            int totalRow = pDao.countTemp(content, description, status);
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
                        <form action="<%=request.getContextPath() + "/admin/template_sms/index.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded redBoldUp">Quản lý tin nhắn mẫu</th>
                                        <th scope="col" class="rounded"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>

                                        <td>
                                            Nội dung: <input size="20" type="text" name="content"/>
                                        </td>
                                        <td>
                                            Mô tả: <input size="20" type="text" name="description"/>
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;
                                            <span class="redBold">Trạng thái</span>
                                            <select name="telco">
                                                <option value="">---Tất cả---</option>
                                                <option value="1">Kích hoạt</option>
                                                <option value="0">Khóa</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="12">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;
                                            <input class="button" onclick="location.href = '<%=request.getContextPath() + "/admin/template_sms/add.jsp"%>'" type="button" name="Thêm mới" value="Thêm mới"/>
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
                                    <th scope="col" class="rounded">Mã tin nhắn mẫu gửi</th>
                                    <th scope="col" class="rounded">Mã nhà cung cấp</th>
                                    <th scope="col" class="rounded">Nội dung</th>
                                    <th scope="col" class="rounded">Mô tả</th>
                                    <th scope="col" class="rounded">Từ khóa 1</th>
                                    <th scope="col" class="rounded">Từ khóa 2</th>
                                    <th scope="col" class="rounded">Từ khóa 3</th>
                                    <th scope="col" class="rounded">Từ khóa 4</th>
                                    <th scope="col" class="rounded">Từ khóa 5</th>
                                    <th scope="col" class="rounded">Từ khóa 6</th>
                                    <th scope="col" class="rounded">Từ khóa 7</th>
                                    <th scope="col" class="rounded">Từ khóa 8</th>
                                    <th scope="col" class="rounded">Từ khóa 9</th>
                                    <th scope="col" class="rounded">Từ khóa 10  </th>
                                    <th scope="col" class="rounded">Trạng thái  </th>
                                        <%= buildHeader(request, userlogin, true, false)%>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    for (Iterator<Template_sms> iter = all.iterator(); iter.hasNext();) {
                                        Template_sms oneTem = iter.next();
                                        int tmp = (currentPage - 1) * 25 + count++;
                                %>
                                <tr>
                                    <td class="boder_right"><%=tmp%></td>
                                    <td class="boder_right" align="left">
                                        <%=oneTem.getId_template_send()%>
                                    </td>  
                                    <td class="boder_right">
                                        <%
                                            ArrayList<Provider> allpro = Provider.getCACHE();
                                            for (Provider one : allpro) {
                                                if( one.getId() == oneTem.getId_provider()){
                                        %>
                                       
                                        [<%=one.getId()%>][<%=one.getCode()%>] <%=one.getName()%> 
                                        
                                        <%
                                            }
                                            }
                                
                                        %>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneTem.getContent()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneTem.getDescription()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneTem.getKey1()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneTem.getKey2()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneTem.getKey3()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneTem.getKey4()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneTem.getKey5()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneTem.getKey6()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneTem.getKey7()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneTem.getKey8()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneTem.getKey9()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneTem.getKey10()%>
                                    </td>
                                    <td class="boder_right">
                                        <%=oneTem.getStatus() == 0 ? "Khóa" : "Kích hoạt"%>
                                    </td>
                                    <%=buildControl(request, userlogin,
                                                    "/admin/template_sms/edit.jsp?id=" + oneTem.getId(),
                                                    null
                                            )%>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>   
                <div class="clear"></div>
            </div>
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html>