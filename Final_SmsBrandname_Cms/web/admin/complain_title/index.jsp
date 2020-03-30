<%@page import="gk.myname.vn.entity.Complain_title"%>
<%@page import="gk.myname.vn.utils.DateProc"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script>
            $(document).ready(function () {
                $('.dateproc').datetimepicker({
                    lang: 'vi',
                    timepicker: false,
                    format: 'd/m/Y',
                    formatDate: 'Y/m/d'
                });
            });
        </script>
    </head>
    <body>
        <%            ArrayList<Complain_title> all = null;
            Complain_title title = new Complain_title();
            int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
            if (currentPage < 1) {
                currentPage = 1;
            }

            all = title.findList(maxRow, currentPage);

            int totalPage = 0;
            int totalRow = title.count();
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
                        <form action="<%=request.getContextPath() + "/admin/contract/"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Complain Title</th>
                                        <th scope="col" class="rounded"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr align="center">
                                        <td colspan="3">
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <%=buildAddControl(request, userlogin, "/admin/complain_title/add.jsp")%>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>  
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%
                                if (session.getAttribute("mess") != null) {
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
                                    <th scope="col" class="rounded">Mã Title</th>
                                    <th scope="col" class="rounded">Nội Dung Title</th>
                                        <%=buildHeader(request, userlogin, true, true)%>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    for (Complain_title compl : all) {
                                %>
                                <tr>
                                    <td class="boder_right"><%=count++%></td>
                                    <td align="left" class="boder_right">
                                        <%=compl.getId()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=compl.getTitle()%>
                                    </td>
                                    <%=buildControl(request, userlogin,
                                            "/admin/complain_title/edit.jsp?id=" + compl.getId(), "/admin/complain_title/delete.jsp?id=" + compl.getId())%>
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