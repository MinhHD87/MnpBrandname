<%@page import="gk.myname.vn.utils.DateProc"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="gk.myname.vn.entity.Contract"%>
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
        <%            ArrayList<Contract> all = null;
            Contract pdao = new Contract();
            int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
            if (currentPage < 1) {
                currentPage = 1;
            }

            String contract_no = Tool.validStringRequest(request.getParameter("contract_no"));
            String stRequest = RequestTool.getString(request, "start_time");
            String expire_time = RequestTool.getString(request, "expire_time");

            all = pdao.findList(maxRow, currentPage, contract_no, stRequest, expire_time);

            int totalPage = 0;
            int totalRow = pdao.count(contract_no, stRequest, expire_time);
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
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Tìm kiếm</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td class="redBold">Hợp Đồng:</td>
                                        <td> 
                                            <input size="30" type="text" name="contract_no"/>
                                            &nbsp;&nbsp;&nbsp;<span class="redBold">Bắt Đầu: </span>
                                            <input class="dateproc" size="8" type="text" name="start_time"/>
                                            &nbsp;&nbsp;&nbsp;<span class="redBold">Kết Thúc: </span>
                                            <input class="dateproc" size="8" type="text" name="expire_time"/>
                                            &nbsp;&nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <%=buildAddControl(request, userlogin, "/admin/contract/add.jsp")%>
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
                                    <th scope="col" class="rounded">Chi Nhánh</th>
                                    <th scope="col" class="rounded">Cộng Sự</th>
                                    <th scope="col" class="rounded">Hợp Đồng</th>
                                    <th scope="col" class="rounded">Bắt Đầu</th>
                                    <th scope="col" class="rounded">Kết Thúc</th>                              
                                    <th scope="col" class="rounded">Thay Mới</th>
                                    <th scope="col" class="rounded">Đường Dẫn Tệp</th>
                                    <th scope="col" class="rounded">VTE</th>
                                    <th scope="col" class="rounded">VMS</th>
                                    <th scope="col" class="rounded">VINA</th>
                                    <th scope="col" class="rounded">VNM</th>
                                    <th scope="col" class="rounded">BL</th>
                                    <!--<th scope="col" class="rounded">EMAIL_ID</th>-->
                                        <%=buildHeader(request, userlogin, true, true)%>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    for (Contract contr : all) {
                                %>
                                <tr>
                                    <td class="boder_right"><%=count++%></td>
                                    <td align="left" class="boder_right">
                                        <%=contr.getName_sub()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=contr.getName_partner()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=contr.getContract_no()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=contr.getStart_time()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=contr.getExpire_time()%>
                                    </td>
                                    <td align="center" class="boder_right">
                                        <%
                                            if (contr.getAuto_renew() == 1) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%
                                        } else {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <td align="left" class="boder_right redBold">
                                        <%
                                            if (Tool.checkNull(contr.getFile_path())) {
                                        %>
                                        <span>Unknow</span>
                                        <%
                                        } else {
                                        %>
                                        <a href="<%=request.getContextPath()%>/admin/contract/view.jsp?subid=<%=contr.getSub_id()%>&partnerid=<%=contr.getPartner_id()%>&contractno=<%=contr.getContract_no()%>" title="<%=contr.getFile_path()%>" target="_blank">View</a>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <td align="center" class="boder_right">
                                        <%
                                            if (contr.getVte() == 1) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%
                                        } else {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <td align="center" class="boder_right">
                                        <%
                                            if (contr.getVms() == 1) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%
                                        } else {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <td align="center" class="boder_right">
                                        <%
                                            if (contr.getVina() == 1) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%
                                        } else {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <td align="center" class="boder_right">
                                        <%
                                            if (contr.getVnm() == 1) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%
                                        } else {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                        <%
                                            }
                                        %>
                                    </td>
                                    <td align="center" class="boder_right">
                                        <%
                                            if (contr.getBl() == 1) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%
                                        } else {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                        <%
                                            }
                                        %>
                                    </td>
<!--                                    <td align="left" class="boder_right">
                                        <%=contr.getName_email()%>
                                    </td>-->
                                    <%=buildControl(request, userlogin,
                                            "/admin/contract/edit.jsp?subid=" + contr.getSub_id() + "&partnerid=" + contr.getPartner_id() + "&contractno=" + contr.getContract_no(), "/admin/contract/delete.jsp?subid=" + contr.getSub_id() + "&partnerid=" + contr.getPartner_id() + "&contractno=" + contr.getContract_no())%>
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