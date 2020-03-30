<%@page import="gk.myname.vn.entity.Provider_Telco"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="gk.myname.vn.admin.PriceTelco"%>
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
            DecimalFormat format = new DecimalFormat("$,000");
            String key = RequestTool.getString(request, "key");
            int status = RequestTool.getInt(request, "status", 1);
            out.println(key + "" + status);
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
                        <form action="<%=request.getContextPath() + "/admin/billing/index.jsp"%>" method="post">
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
                                    <th scope="col" class="rounded">User</th>
                                    <th scope="col" class="rounded">Họ tên</th>
                                    <th scope="col" class="rounded">Thanh toán</th>
                                    <th scope="col" class="rounded">Số dư</th>
                                    <th scope="col" class="rounded">Đơn giá SMS</th>
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
                                    <td class="boder_right"><%=Tool.dinhDangTienTe(oneAdmin.getBalance()+"")%></td>
                                    <%         
                                        Provider_Telco telco = oneAdmin.getSell_price();
                                    %>
                                    <td class="boder_right" width="400">
                                        <SCRIPT language="javascript">
                                            function show(name) {
                                                document.getElementById('show'+name).style.display = 'none';
                                                document.getElementById('hide'+name).style.display = '';
                                                document.getElementById('price'+name).style.display = '';
                                            }

                                            function hide(name) {
                                                document.getElementById('show'+name).style.display = '';
                                                document.getElementById('hide'+name).style.display = 'none';
                                                document.getElementById('price'+name).style.display = 'none';
                                            }

                                        </SCRIPT>
                                        <% if (!(telco.getVte().getGroup0Price() == 0 && 
                                                    telco.getVte().getGroup1Price() == 0 &&
                                                    telco.getVte().getGroup2Price() == 0 &&
                                                    telco.getVte().getGroup3Price() == 0 &&
                                                    telco.getVte().getGroup4Price() == 0 &&
                                                    telco.getVte().getGroup5Price() == 0 &&
                                                    telco.getVte().getGroup6Price() == 0 &&
                                                    telco.getVte().getGroup7Price() == 0 &&
                                                    telco.getVte().getGroup8Price() == 0 &&
                                                    telco.getVte().getGroup9Price() == 0 &&
                                                    telco.getVte().getGroup10Price() == 0 &&
                                                    telco.getVte().getGroup11Price() == 0 &&
                                                    telco.getVte().getGroup12Price() == 0 &&
                                                    telco.getVte().getGroup13Price() == 0 &&
                                                    telco.getVte().getGroup14Price() == 0 &&
                                                    telco.getVte().getGroup15Price() == 0 &&
                                                    telco.getVte().getGroupLCPrice() == 0 &&
                                                telco.getVina().getGroup0Price() == 0 && 
                                                    telco.getVina().getGroup1Price() == 0 &&
                                                    telco.getVina().getGroup2Price() == 0 &&
                                                    telco.getVina().getGroup3Price() == 0 &&
                                                    telco.getVina().getGroup4Price() == 0 &&
                                                    telco.getVina().getGroup5Price() == 0 &&
                                                    telco.getVina().getGroup6Price() == 0 &&
                                                    telco.getVina().getGroup7Price() == 0 &&
                                                    telco.getVina().getGroup8Price() == 0 &&
                                                    telco.getVina().getGroup9Price() ==0 &&
                                                    telco.getVina().getGroup10Price() == 0 &&
                                                    telco.getVina().getGroup11Price() == 0 &&
                                                    telco.getVina().getGroup12Price() == 0 &&
                                                    telco.getVina().getGroup13Price() == 0 &&
                                                    telco.getVina().getGroup14Price() == 0 &&
                                                    telco.getVina().getGroup15Price() == 0 &&
                                                    telco.getVina().getGroupLCPrice() == 0 &&
                                                telco.getMobi().getGroup0Price() == 0 && 
                                                    telco.getMobi().getGroup1Price() == 0 &&
                                                    telco.getMobi().getGroup2Price() == 0 &&
                                                    telco.getMobi().getGroup3Price() == 0 &&
                                                    telco.getMobi().getGroup4Price() == 0 &&
                                                    telco.getMobi().getGroup5Price() == 0 &&
                                                    telco.getMobi().getGroup6Price() == 0 &&
                                                    telco.getMobi().getGroup7Price() == 0 &&
                                                    telco.getMobi().getGroup8Price() == 0 &&
                                                    telco.getMobi().getGroup9Price() == 0 &&
                                                    telco.getMobi().getGroup10Price() == 0 &&
                                                    telco.getMobi().getGroup11Price() == 0 &&
                                                    telco.getMobi().getGroup12Price() == 0 &&
                                                    telco.getMobi().getGroup13Price() == 0 &&
                                                    telco.getMobi().getGroup14Price() == 0 &&
                                                    telco.getMobi().getGroup15Price() == 0 &&
                                                    telco.getMobi().getGroupLCPrice() == 0 &&
                                                telco.getVnm().getGroup0Price() == 0 && 
                                                    telco.getVnm().getGroup1Price() == 0 &&
                                                    telco.getVnm().getGroup2Price() == 0 &&
                                                    telco.getVnm().getGroup3Price() == 0 &&
                                                    telco.getVnm().getGroup4Price() == 0 &&
                                                    telco.getVnm().getGroup5Price() == 0 &&
                                                    telco.getVnm().getGroup6Price() == 0 &&
                                                    telco.getVnm().getGroup7Price() == 0 &&
                                                    telco.getVnm().getGroup8Price() == 0 &&
                                                    telco.getVnm().getGroup9Price() == 0 &&
                                                    telco.getVnm().getGroup10Price() == 0 &&
                                                    telco.getVnm().getGroup11Price() == 0 &&
                                                    telco.getVnm().getGroup12Price() == 0 &&
                                                    telco.getVnm().getGroup13Price() == 0 &&
                                                    telco.getVnm().getGroup14Price() == 0 &&
                                                    telco.getVnm().getGroup15Price() == 0 &&
                                                    telco.getVnm().getGroupLCPrice() == 0 &&
                                                telco.getBl().getGroup0Price() == 0 && 
                                                    telco.getBl().getGroup1Price() == 0 &&
                                                    telco.getBl().getGroup2Price() == 0 &&
                                                    telco.getBl().getGroup3Price() ==0 &&
                                                    telco.getBl().getGroup4Price() == 0 &&
                                                    telco.getBl().getGroup5Price() ==0 &&
                                                    telco.getBl().getGroup6Price() == 0 &&
                                                    telco.getBl().getGroup7Price() == 0 &&
                                                    telco.getBl().getGroup8Price() == 0 &&
                                                    telco.getBl().getGroup9Price() == 0 &&
                                                    telco.getBl().getGroup10Price() == 0 &&
                                                    telco.getBl().getGroup11Price() == 0 &&
                                                    telco.getBl().getGroup12Price() == 0 &&
                                                    telco.getBl().getGroup13Price() == 0 &&
                                                    telco.getBl().getGroup14Price() == 0 &&
                                                    telco.getBl().getGroup15Price() == 0 &&
                                                    telco.getBl().getGroupLCPrice() == 0 &&
                                                telco.getDdg().getGroup0Price() == 0 && 
                                                    telco.getDdg().getGroup1Price() == 0 &&
                                                    telco.getDdg().getGroup2Price() == 0 &&
                                                    telco.getDdg().getGroup3Price() == 0 &&
                                                    telco.getDdg().getGroup4Price() == 0 &&
                                                    telco.getDdg().getGroup5Price() == 0 &&
                                                    telco.getDdg().getGroup6Price() == 0 &&
                                                    telco.getDdg().getGroup7Price() == 0 &&
                                                    telco.getDdg().getGroup8Price() == 0 &&
                                                    telco.getDdg().getGroup9Price() == 0 &&
                                                    telco.getDdg().getGroup10Price() == 0 &&
                                                    telco.getDdg().getGroup11Price() == 0 &&
                                                    telco.getDdg().getGroup12Price() == 0 &&
                                                    telco.getDdg().getGroup13Price() == 0 &&
                                                    telco.getDdg().getGroup14Price() == 0 &&
                                                    telco.getDdg().getGroup15Price() == 0 &&
                                                    telco.getDdg().getGroupLCPrice() == 0 )) {%>
                                        <div>
                                            <h4>
                                                <b>VIỆT NAM</b>
                                                <div id="showVietnam<%=index%>" style="float: right">
                                                    <img onclick="show('Vietnam'+<%=index%>)" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideVietnam<%=index%>" style="float: right;display: none">
                                                    <img onclick="hide('Vietnam'+<%=index%>)" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                            </h4>
                                        </div>
                                        <div id="priceVietnam<%=index%>" style="display: none">                                            
                                            <b>VTE :</b> 
                                            <%=telco.getVte().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getVte().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getVte().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getVte().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getVte().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getVte().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getVte().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getVte().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getVte().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getVte().getGroup8Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup9Price() != 0 ? "N9: "+Tool.dinhDangTienTe(telco.getVte().getGroup9Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup10Price() != 0 ? "N10: "+Tool.dinhDangTienTe(telco.getVte().getGroup10Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup11Price() != 0 ? "N11: "+Tool.dinhDangTienTe(telco.getVte().getGroup11Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup12Price() != 0 ? "N12: "+Tool.dinhDangTienTe(telco.getVte().getGroup12Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup13Price() != 0 ? "N13: "+Tool.dinhDangTienTe(telco.getVte().getGroup13Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup14Price() != 0 ? "N14: "+Tool.dinhDangTienTe(telco.getVte().getGroup14Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroup15Price() != 0 ? "N15: "+Tool.dinhDangTienTe(telco.getVte().getGroup15Price()+"")+"," : ""%>
                                            <%=telco.getVte().getGroupLCPrice() != 0 ? "NLC: "+Tool.dinhDangTienTe(telco.getVte().getGroupLCPrice()+"")+"," : ""%> 
                                            <br/>
                                            <b>GPC :</b> 
                                            <%=telco.getVina().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getVina().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getVina().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getVina().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getVina().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getVina().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getVina().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getVina().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getVina().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getVina().getGroup8Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup9Price() != 0 ? "N9: "+Tool.dinhDangTienTe(telco.getVina().getGroup9Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup10Price() != 0 ? "N10: "+Tool.dinhDangTienTe(telco.getVina().getGroup10Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup11Price() != 0 ? "N11: "+Tool.dinhDangTienTe(telco.getVina().getGroup11Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup12Price() != 0 ? "N12: "+Tool.dinhDangTienTe(telco.getVina().getGroup12Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup13Price() != 0 ? "N13: "+Tool.dinhDangTienTe(telco.getVina().getGroup13Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup14Price() != 0 ? "N14: "+Tool.dinhDangTienTe(telco.getVina().getGroup14Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroup15Price() != 0 ? "N15: "+Tool.dinhDangTienTe(telco.getVina().getGroup15Price()+"")+"," : ""%>
                                            <%=telco.getVina().getGroupLCPrice() != 0 ? "NLC: "+Tool.dinhDangTienTe(telco.getVina().getGroupLCPrice()+"")+"," : ""%> 
                                            <br/>
                                            <b>VMS :</b>
                                            <%=telco.getMobi().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getMobi().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getMobi().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getMobi().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getMobi().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getMobi().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getMobi().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getMobi().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getMobi().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getMobi().getGroup8Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup9Price() != 0 ? "N9: "+Tool.dinhDangTienTe(telco.getMobi().getGroup9Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup10Price() != 0 ? "N10: "+Tool.dinhDangTienTe(telco.getMobi().getGroup10Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup11Price() != 0 ? "N11: "+Tool.dinhDangTienTe(telco.getMobi().getGroup11Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup12Price() != 0 ? "N12: "+Tool.dinhDangTienTe(telco.getMobi().getGroup12Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup13Price() != 0 ? "N13: "+Tool.dinhDangTienTe(telco.getMobi().getGroup13Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup14Price() != 0 ? "N14: "+Tool.dinhDangTienTe(telco.getMobi().getGroup14Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroup15Price() != 0 ? "N15: "+Tool.dinhDangTienTe(telco.getMobi().getGroup15Price()+"")+"," : ""%>
                                            <%=telco.getMobi().getGroupLCPrice() != 0 ? "NLC: "+Tool.dinhDangTienTe(telco.getMobi().getGroupLCPrice()+"")+"," : ""%> 
                                            <br/>
                                            <b>VNM :</b>
                                            <%=telco.getVnm().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getVnm().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getVnm().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getVnm().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getVnm().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getVnm().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getVnm().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getVnm().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getVnm().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getVnm().getGroup8Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup9Price() != 0 ? "N9: "+Tool.dinhDangTienTe(telco.getVnm().getGroup9Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup10Price() != 0 ? "N10: "+Tool.dinhDangTienTe(telco.getVnm().getGroup10Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup11Price() != 0 ? "N11: "+Tool.dinhDangTienTe(telco.getVnm().getGroup11Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup12Price() != 0 ? "N12: "+Tool.dinhDangTienTe(telco.getVnm().getGroup12Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup13Price() != 0 ? "N13: "+Tool.dinhDangTienTe(telco.getVnm().getGroup13Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup14Price() != 0 ? "N14: "+Tool.dinhDangTienTe(telco.getVnm().getGroup14Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroup15Price() != 0 ? "N15: "+Tool.dinhDangTienTe(telco.getVnm().getGroup15Price()+"")+"," : ""%>
                                            <%=telco.getVnm().getGroupLCPrice() != 0 ? "NLC: "+Tool.dinhDangTienTe(telco.getVnm().getGroupLCPrice()+"")+"," : ""%> 
                                            <br/>
                                            <b>BL :</b>
                                            <%=telco.getBl().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getBl().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getBl().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getBl().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getBl().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getBl().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getBl().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getBl().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getBl().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getBl().getGroup8Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup9Price() != 0 ? "N9: "+Tool.dinhDangTienTe(telco.getBl().getGroup9Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup10Price() != 0 ? "N10: "+Tool.dinhDangTienTe(telco.getBl().getGroup10Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup11Price() != 0 ? "N11: "+Tool.dinhDangTienTe(telco.getBl().getGroup11Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup12Price() != 0 ? "N12: "+Tool.dinhDangTienTe(telco.getBl().getGroup12Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup13Price() != 0 ? "N13: "+Tool.dinhDangTienTe(telco.getBl().getGroup13Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup14Price() != 0 ? "N14: "+Tool.dinhDangTienTe(telco.getBl().getGroup14Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroup15Price() != 0 ? "N15: "+Tool.dinhDangTienTe(telco.getBl().getGroup15Price()+"")+"," : ""%>
                                            <%=telco.getBl().getGroupLCPrice() != 0 ? "NLC: "+Tool.dinhDangTienTe(telco.getBl().getGroupLCPrice()+"")+"," : ""%> 
                                            <br/>
                                            <b>DDG :</b>
                                            <%=telco.getDdg().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getDdg().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getDdg().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getDdg().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getDdg().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getDdg().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getDdg().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getDdg().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getDdg().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getDdg().getGroup8Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup9Price() != 0 ? "N9: "+Tool.dinhDangTienTe(telco.getDdg().getGroup9Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup10Price() != 0 ? "N10: "+Tool.dinhDangTienTe(telco.getDdg().getGroup10Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup11Price() != 0 ? "N11: "+Tool.dinhDangTienTe(telco.getDdg().getGroup11Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup12Price() != 0 ? "N12: "+Tool.dinhDangTienTe(telco.getDdg().getGroup12Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup13Price() != 0 ? "N13: "+Tool.dinhDangTienTe(telco.getDdg().getGroup13Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup14Price() != 0 ? "N14: "+Tool.dinhDangTienTe(telco.getDdg().getGroup14Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroup15Price() != 0 ? "N15: "+Tool.dinhDangTienTe(telco.getDdg().getGroup15Price()+"")+"," : ""%>
                                            <%=telco.getDdg().getGroupLCPrice() != 0 ? "NLC: "+Tool.dinhDangTienTe(telco.getDdg().getGroupLCPrice()+"")+"," : ""%> 
                                            <br/>
                                        </div><% } %>
                                        <% if (!(telco.getCellcard().getGroup0Price() == 0 && 
                                                    telco.getCellcard().getGroup1Price() == 0 &&
                                                    telco.getCellcard().getGroup2Price() == 0 &&
                                                    telco.getCellcard().getGroup3Price() == 0 &&
                                                    telco.getCellcard().getGroup4Price() == 0 &&
                                                    telco.getCellcard().getGroup5Price() == 0 &&
                                                    telco.getCellcard().getGroup6Price() == 0 &&
                                                    telco.getCellcard().getGroup7Price() == 0 &&
                                                    telco.getCellcard().getGroup8Price() == 0 &&
                                                telco.getMetfone().getGroup0Price() == 0 && 
                                                    telco.getMetfone().getGroup1Price() == 0 &&
                                                    telco.getMetfone().getGroup2Price() == 0 &&
                                                    telco.getMetfone().getGroup3Price() == 0 &&
                                                    telco.getMetfone().getGroup4Price() == 0 &&
                                                    telco.getMetfone().getGroup5Price() == 0 &&
                                                    telco.getMetfone().getGroup6Price() == 0 &&
                                                    telco.getMetfone().getGroup7Price() == 0 &&
                                                    telco.getMetfone().getGroup8Price() == 0 &&
                                                telco.getBeelineCampuchia().getGroup0Price() == 0 && 
                                                    telco.getBeelineCampuchia().getGroup1Price() == 0 &&
                                                    telco.getBeelineCampuchia().getGroup2Price() == 0 &&
                                                    telco.getBeelineCampuchia().getGroup3Price() == 0 &&
                                                    telco.getBeelineCampuchia().getGroup4Price() == 0 &&
                                                    telco.getBeelineCampuchia().getGroup5Price() == 0 &&
                                                    telco.getBeelineCampuchia().getGroup6Price() == 0 &&
                                                    telco.getBeelineCampuchia().getGroup7Price() == 0 &&
                                                    telco.getBeelineCampuchia().getGroup8Price() == 0 &&
                                                telco.getSmart().getGroup0Price() == 0 && 
                                                    telco.getSmart().getGroup1Price() == 0 &&
                                                    telco.getSmart().getGroup2Price() == 0 &&
                                                    telco.getSmart().getGroup3Price() == 0 &&
                                                    telco.getSmart().getGroup4Price() == 0 &&
                                                    telco.getSmart().getGroup5Price() == 0 &&
                                                    telco.getSmart().getGroup6Price() == 0 &&
                                                    telco.getSmart().getGroup7Price() == 0 &&
                                                    telco.getSmart().getGroup8Price() == 0 &&
                                                telco.getQbmore().getGroup0Price() == 0 && 
                                                    telco.getQbmore().getGroup1Price() == 0 &&
                                                    telco.getQbmore().getGroup2Price() == 0 &&
                                                    telco.getQbmore().getGroup3Price() ==0 &&
                                                    telco.getQbmore().getGroup4Price() == 0 &&
                                                    telco.getQbmore().getGroup5Price() ==0 &&
                                                    telco.getQbmore().getGroup6Price() == 0 &&
                                                    telco.getQbmore().getGroup7Price() == 0 &&
                                                    telco.getQbmore().getGroup8Price() == 0 &&
                                                telco.getExcell().getGroup0Price() == 0 && 
                                                    telco.getExcell().getGroup1Price() == 0 &&
                                                    telco.getExcell().getGroup2Price() == 0 &&
                                                    telco.getExcell().getGroup3Price() == 0 &&
                                                    telco.getExcell().getGroup4Price() == 0 &&
                                                    telco.getExcell().getGroup5Price() == 0 &&
                                                    telco.getExcell().getGroup6Price() == 0 &&
                                                    telco.getExcell().getGroup7Price() == 0 &&
                                                    telco.getExcell().getGroup8Price() == 0 )) {%>
                                        <div>
                                            <h4>
                                                <b>CAMPUCHIA</b>
                                                <div id="showCampuchia<%=index%>" style="float: right">
                                                    <img onclick="show('Campuchia'+<%=index%>)" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideCampuchia<%=index%>" style="float: right;display: none">
                                                    <img onclick="hide('Campuchia'+<%=index%>)" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                            </h4>
                                        </div>
                                        <div id="priceCampuchia<%=index%>" style="display: none">
                                            <b>Cellcard :</b>
                                            <%=telco.getCellcard().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getCellcard().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getCellcard().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getCellcard().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getCellcard().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getCellcard().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getCellcard().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getCellcard().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getCellcard().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getCellcard().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getCellcard().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getCellcard().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getCellcard().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getCellcard().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getCellcard().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getCellcard().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getCellcard().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getCellcard().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Metfone :</b>
                                            <%=telco.getMetfone().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getMetfone().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getMetfone().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getMetfone().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getMetfone().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getMetfone().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getMetfone().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getMetfone().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getMetfone().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getMetfone().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getMetfone().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getMetfone().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getMetfone().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getMetfone().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getMetfone().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getMetfone().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getMetfone().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getMetfone().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Beeline Campuchia :</b> 
                                            <%=telco.getBeelineCampuchia().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getBeelineCampuchia().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getBeelineCampuchia().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getBeelineCampuchia().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getBeelineCampuchia().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getBeelineCampuchia().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getBeelineCampuchia().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getBeelineCampuchia().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getBeelineCampuchia().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Smart :</b>
                                            <%=telco.getSmart().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getSmart().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getSmart().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getSmart().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getSmart().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getSmart().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getSmart().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getSmart().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getSmart().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getSmart().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getSmart().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getSmart().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getSmart().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getSmart().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getSmart().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getSmart().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getSmart().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getSmart().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Qbmore :</b>
                                            <%=telco.getQbmore().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getQbmore().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getQbmore().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getQbmore().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getQbmore().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getQbmore().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getQbmore().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getQbmore().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getQbmore().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getQbmore().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getQbmore().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getQbmore().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getQbmore().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getQbmore().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getQbmore().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getQbmore().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getQbmore().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getQbmore().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Excell :</b>
                                            <%=telco.getExcell().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getExcell().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getExcell().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getExcell().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getExcell().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getExcell().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getExcell().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getExcell().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getExcell().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getExcell().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getExcell().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getExcell().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getExcell().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getExcell().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getExcell().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getExcell().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getExcell().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getExcell().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                        </div><% } %>
                                        <% if (!(telco.getTelemor().getGroup0Price() == 0 && 
                                                    telco.getTelemor().getGroup1Price() == 0 &&
                                                    telco.getTelemor().getGroup2Price() == 0 &&
                                                    telco.getTelemor().getGroup3Price() == 0 &&
                                                    telco.getTelemor().getGroup4Price() == 0 &&
                                                    telco.getTelemor().getGroup5Price() == 0 &&
                                                    telco.getTelemor().getGroup6Price() == 0 &&
                                                    telco.getTelemor().getGroup7Price() == 0 &&
                                                    telco.getTelemor().getGroup8Price() == 0 &&
                                                telco.getTimortelecom().getGroup0Price() == 0 && 
                                                    telco.getTimortelecom().getGroup1Price() == 0 &&
                                                    telco.getTimortelecom().getGroup2Price() == 0 &&
                                                    telco.getTimortelecom().getGroup3Price() == 0 &&
                                                    telco.getTimortelecom().getGroup4Price() == 0 &&
                                                    telco.getTimortelecom().getGroup5Price() == 0 &&
                                                    telco.getTimortelecom().getGroup6Price() == 0 &&
                                                    telco.getTimortelecom().getGroup7Price() == 0 &&
                                                    telco.getTimortelecom().getGroup8Price() == 0 )) {%>
                                        <div>
                                            <h4>
                                                <b>ĐÔNG TIMOR</b>
                                                <div id="showDongtimor<%=index%>" style="float: right">
                                                    <img onclick="show('Dongtimor'+<%=index%>)" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideDongtimor<%=index%>" style="float: right;display: none">
                                                    <img onclick="hide('Dongtimor'+<%=index%>)" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                            </h4>
                                        </div>
                                        <div id="priceDongtimor<%=index%>" style="display: none">
                                            <b>Telemor :</b>
                                            <%=telco.getTelemor().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getTelemor().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getTelemor().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getTelemor().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getTelemor().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getTelemor().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getTelemor().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getTelemor().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getTelemor().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getTelemor().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getTelemor().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getTelemor().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getTelemor().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getTelemor().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getTelemor().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getTelemor().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getTelemor().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getTelemor().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Timor Telecom :</b>
                                            <%=telco.getTimortelecom().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getTimortelecom().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getTimortelecom().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getTimortelecom().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getTimortelecom().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getTimortelecom().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getTimortelecom().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getTimortelecom().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getTimortelecom().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getTimortelecom().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getTimortelecom().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getTimortelecom().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getTimortelecom().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getTimortelecom().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getTimortelecom().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getTimortelecom().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getTimortelecom().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getTimortelecom().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                        </div><% } %>
                                        <% if (!(telco.getMovitel().getGroup0Price() == 0 && 
                                                    telco.getMovitel().getGroup1Price() == 0 &&
                                                    telco.getMovitel().getGroup2Price() == 0 &&
                                                    telco.getMovitel().getGroup3Price() == 0 &&
                                                    telco.getMovitel().getGroup4Price() == 0 &&
                                                    telco.getMovitel().getGroup5Price() == 0 &&
                                                    telco.getMovitel().getGroup6Price() == 0 &&
                                                    telco.getMovitel().getGroup7Price() == 0 &&
                                                    telco.getMovitel().getGroup8Price() == 0 &&
                                                telco.getMcel().getGroup0Price() == 0 && 
                                                    telco.getMcel().getGroup1Price() == 0 &&
                                                    telco.getMcel().getGroup2Price() == 0 &&
                                                    telco.getMcel().getGroup3Price() == 0 &&
                                                    telco.getMcel().getGroup4Price() == 0 &&
                                                    telco.getMcel().getGroup5Price() == 0 &&
                                                    telco.getMcel().getGroup6Price() == 0 &&
                                                    telco.getMcel().getGroup7Price() == 0 &&
                                                    telco.getMcel().getGroup8Price() == 0 )) {%>
                                        <div>
                                            <h4>
                                                <b>MOZAMBIQUE</b>
                                                <div id="showMozambique<%=index%>" style="float: right">
                                                    <img onclick="show('Mozambique'+<%=index%>)" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideMozambique<%=index%>" style="float: right;display: none">
                                                    <img onclick="hide('Mozambique'+<%=index%>)" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                            </h4>
                                        </div>
                                        <div id="priceMozambique<%=index%>" style="display: none">
                                            <b>Movitel :</b>
                                            <%=telco.getMovitel().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getMovitel().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getMovitel().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getMovitel().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getMovitel().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getMovitel().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getMovitel().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getMovitel().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getMovitel().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getMovitel().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getMovitel().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getMovitel().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getMovitel().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getMovitel().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getMovitel().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getMovitel().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getMovitel().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getMovitel().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Mcel :</b>
                                            <%=telco.getMcel().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getMcel().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getMcel().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getMcel().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getMcel().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getMcel().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getMcel().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getMcel().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getMcel().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getMcel().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getMcel().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getMcel().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getMcel().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getMcel().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getMcel().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getMcel().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getMcel().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getMcel().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                        </div><% } %>
                                        <% if (!(telco.getUnitel().getGroup0Price() == 0 && 
                                                    telco.getUnitel().getGroup1Price() == 0 &&
                                                    telco.getUnitel().getGroup2Price() == 0 &&
                                                    telco.getUnitel().getGroup3Price() == 0 &&
                                                    telco.getUnitel().getGroup4Price() == 0 &&
                                                    telco.getUnitel().getGroup5Price() == 0 &&
                                                    telco.getUnitel().getGroup6Price() == 0 &&
                                                    telco.getUnitel().getGroup7Price() == 0 &&
                                                    telco.getUnitel().getGroup8Price() == 0 &&
                                                telco.getEtl().getGroup0Price() == 0 && 
                                                    telco.getEtl().getGroup1Price() == 0 &&
                                                    telco.getEtl().getGroup2Price() == 0 &&
                                                    telco.getEtl().getGroup3Price() == 0 &&
                                                    telco.getEtl().getGroup4Price() == 0 &&
                                                    telco.getEtl().getGroup5Price() == 0 &&
                                                    telco.getEtl().getGroup6Price() == 0 &&
                                                    telco.getEtl().getGroup7Price() == 0 &&
                                                    telco.getEtl().getGroup8Price() == 0 &&
                                                telco.getTango().getGroup0Price() == 0 && 
                                                    telco.getTango().getGroup1Price() == 0 &&
                                                    telco.getTango().getGroup2Price() == 0 &&
                                                    telco.getTango().getGroup3Price() == 0 &&
                                                    telco.getTango().getGroup4Price() == 0 &&
                                                    telco.getTango().getGroup5Price() == 0 &&
                                                    telco.getTango().getGroup6Price() == 0 &&
                                                    telco.getTango().getGroup7Price() == 0 &&
                                                    telco.getTango().getGroup8Price() == 0 &&
                                                telco.getLaotel().getGroup0Price() == 0 && 
                                                    telco.getLaotel().getGroup1Price() == 0 &&
                                                    telco.getLaotel().getGroup2Price() == 0 &&
                                                    telco.getLaotel().getGroup3Price() == 0 &&
                                                    telco.getLaotel().getGroup4Price() == 0 &&
                                                    telco.getLaotel().getGroup5Price() == 0 &&
                                                    telco.getLaotel().getGroup6Price() == 0 &&
                                                    telco.getLaotel().getGroup7Price() == 0 &&
                                                    telco.getLaotel().getGroup8Price() == 0 )) {%>
                                        <div>
                                            <h4>
                                                <b>Lao</b>
                                                <div id="showLao<%=index%>" style="float: right">
                                                    <img onclick="show('Lao'+<%=index%>)" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideLao<%=index%>" style="float: right;display: none">
                                                    <img onclick="hide('Lao'+<%=index%>)" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                            </h4>
                                        </div>
                                        <div id="priceLao<%=index%>" style="display: none">
                                            <b>Unitel :</b>
                                            <%=telco.getUnitel().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getUnitel().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getUnitel().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getUnitel().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getUnitel().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getUnitel().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getUnitel().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getUnitel().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getUnitel().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getUnitel().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getUnitel().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getUnitel().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getUnitel().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getUnitel().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getUnitel().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getUnitel().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getUnitel().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getUnitel().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>ETL :</b>
                                            <%=telco.getEtl().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getEtl().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getEtl().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getEtl().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getEtl().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getEtl().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getEtl().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getEtl().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getEtl().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getEtl().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getEtl().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getEtl().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getEtl().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getEtl().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getEtl().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getEtl().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getEtl().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getEtl().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Tango :</b>
                                            <%=telco.getTango().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getTango().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getTango().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getTango().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getTango().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getTango().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getTango().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getTango().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getTango().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getTango().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getTango().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getTango().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getTango().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getTango().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getTango().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getTango().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getTango().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getTango().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Lao Tel :</b>
                                            <%=telco.getLaotel().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getLaotel().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getLaotel().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getLaotel().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getLaotel().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getLaotel().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getLaotel().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getLaotel().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getLaotel().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getLaotel().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getLaotel().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getLaotel().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getLaotel().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getLaotel().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getLaotel().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getLaotel().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getLaotel().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getLaotel().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                        </div><% } %>
                                        <% if (!(telco.getMytel().getGroup0Price() == 0 && 
                                                    telco.getMytel().getGroup1Price() == 0 &&
                                                    telco.getMytel().getGroup2Price() == 0 &&
                                                    telco.getMytel().getGroup3Price() == 0 &&
                                                    telco.getMytel().getGroup4Price() == 0 &&
                                                    telco.getMytel().getGroup5Price() == 0 &&
                                                    telco.getMytel().getGroup6Price() == 0 &&
                                                    telco.getMytel().getGroup7Price() == 0 &&
                                                    telco.getMytel().getGroup8Price() == 0 &&
                                                telco.getMpt().getGroup0Price() == 0 && 
                                                    telco.getMpt().getGroup1Price() == 0 &&
                                                    telco.getMpt().getGroup2Price() == 0 &&
                                                    telco.getMpt().getGroup3Price() == 0 &&
                                                    telco.getMpt().getGroup4Price() == 0 &&
                                                    telco.getMpt().getGroup5Price() == 0 &&
                                                    telco.getMpt().getGroup6Price() == 0 &&
                                                    telco.getMpt().getGroup7Price() == 0 &&
                                                    telco.getMpt().getGroup8Price() == 0 &&
                                                telco.getOoredo().getGroup0Price() == 0 && 
                                                    telco.getOoredo().getGroup1Price() == 0 &&
                                                    telco.getOoredo().getGroup2Price() == 0 &&
                                                    telco.getOoredo().getGroup3Price() == 0 &&
                                                    telco.getOoredo().getGroup4Price() == 0 &&
                                                    telco.getOoredo().getGroup5Price() == 0 &&
                                                    telco.getOoredo().getGroup6Price() == 0 &&
                                                    telco.getOoredo().getGroup7Price() == 0 &&
                                                    telco.getOoredo().getGroup8Price() == 0 &&
                                                telco.getTelenor().getGroup0Price() == 0 && 
                                                    telco.getTelenor().getGroup1Price() == 0 &&
                                                    telco.getTelenor().getGroup2Price() == 0 &&
                                                    telco.getTelenor().getGroup3Price() == 0 &&
                                                    telco.getTelenor().getGroup4Price() == 0 &&
                                                    telco.getTelenor().getGroup5Price() == 0 &&
                                                    telco.getTelenor().getGroup6Price() == 0 &&
                                                    telco.getTelenor().getGroup7Price() == 0 &&
                                                    telco.getTelenor().getGroup8Price() == 0 )) {%>
                                        <div>
                                            <h4>
                                                <b>MIANMAR</b>
                                                <div id="showMianmar<%=index%>" style="float: right">
                                                    <img onclick="show('Mianmar'+<%=index%>)" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideMianmar<%=index%>" style="float: right;display: none">
                                                    <img onclick="hide('Mianmar'+<%=index%>)" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                            </h4>
                                        </div>
                                        <div id="priceMianmar<%=index%>" style="display: none">
                                            <b>Mytel :</b>
                                            <%=telco.getMytel().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getMytel().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getMytel().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getMytel().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getMytel().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getMytel().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getMytel().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getMytel().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getMytel().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getMytel().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getMytel().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getMytel().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getMytel().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getMytel().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getMytel().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getMytel().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getMytel().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getMytel().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>MPT :</b>
                                            <%=telco.getMpt().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getMpt().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getMpt().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getMpt().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getMpt().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getMpt().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getMpt().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getMpt().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getMpt().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getMpt().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getMpt().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getMpt().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getMpt().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getMpt().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getMpt().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getMpt().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getMpt().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getMpt().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Ooredo :</b>
                                            <%=telco.getOoredo().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getOoredo().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getOoredo().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getOoredo().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getOoredo().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getOoredo().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getOoredo().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getOoredo().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getOoredo().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getOoredo().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getOoredo().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getOoredo().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getOoredo().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getOoredo().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getOoredo().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getOoredo().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getOoredo().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getOoredo().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Telenor :</b>
                                            <%=telco.getTelenor().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getTelenor().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getTelenor().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getTelenor().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getTelenor().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getTelenor().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getTelenor().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getTelenor().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getTelenor().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getTelenor().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getTelenor().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getTelenor().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getTelenor().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getTelenor().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getTelenor().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getTelenor().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getTelenor().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getTelenor().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                        </div><% } %>
                                        <% if (!(telco.getNatcom().getGroup0Price() == 0 && 
                                                    telco.getNatcom().getGroup1Price() == 0 &&
                                                    telco.getNatcom().getGroup2Price() == 0 &&
                                                    telco.getNatcom().getGroup3Price() == 0 &&
                                                    telco.getNatcom().getGroup4Price() == 0 &&
                                                    telco.getNatcom().getGroup5Price() == 0 &&
                                                    telco.getNatcom().getGroup6Price() == 0 &&
                                                    telco.getNatcom().getGroup7Price() == 0 &&
                                                    telco.getNatcom().getGroup8Price() == 0 &&
                                                telco.getDigicel().getGroup0Price() == 0 && 
                                                    telco.getDigicel().getGroup1Price() == 0 &&
                                                    telco.getDigicel().getGroup2Price() == 0 &&
                                                    telco.getDigicel().getGroup3Price() == 0 &&
                                                    telco.getDigicel().getGroup4Price() == 0 &&
                                                    telco.getDigicel().getGroup5Price() == 0 &&
                                                    telco.getDigicel().getGroup6Price() == 0 &&
                                                    telco.getDigicel().getGroup7Price() == 0 &&
                                                    telco.getDigicel().getGroup8Price() == 0 &&
                                                telco.getComcel().getGroup0Price() == 0 && 
                                                    telco.getComcel().getGroup1Price() == 0 &&
                                                    telco.getComcel().getGroup2Price() == 0 &&
                                                    telco.getComcel().getGroup3Price() == 0 &&
                                                    telco.getComcel().getGroup4Price() == 0 &&
                                                    telco.getComcel().getGroup5Price() == 0 &&
                                                    telco.getComcel().getGroup6Price() == 0 &&
                                                    telco.getComcel().getGroup7Price() == 0 &&
                                                    telco.getComcel().getGroup8Price() == 0 )) {%>
                                        <div>
                                            <h4>
                                                <b>HAITI</b>
                                                <div id="showHaiti<%=index%>" style="float: right">
                                                    <img onclick="show('Haiti'+<%=index%>)" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideHaiti<%=index%>" style="float: right;display: none">
                                                    <img onclick="hide('Haiti'+<%=index%>)" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                            </h4>
                                        </div>
                                        <div id="priceHaiti<%=index%>" style="display: none">
                                            <b>Natcom :</b>
                                            <%=telco.getNatcom().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getNatcom().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getNatcom().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getNatcom().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getNatcom().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getNatcom().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getNatcom().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getNatcom().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getNatcom().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getNatcom().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getNatcom().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getNatcom().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getNatcom().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getNatcom().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getNatcom().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getNatcom().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getNatcom().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getNatcom().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Digicel :</b>
                                            <%=telco.getDigicel().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getDigicel().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getDigicel().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getDigicel().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getDigicel().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getDigicel().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getDigicel().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getDigicel().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getDigicel().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getDigicel().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getDigicel().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getDigicel().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getDigicel().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getDigicel().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getDigicel().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getDigicel().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getDigicel().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getDigicel().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Comcel :</b>
                                            <%=telco.getComcel().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getComcel().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getComcel().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getComcel().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getComcel().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getComcel().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getComcel().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getComcel().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getComcel().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getComcel().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getComcel().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getComcel().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getComcel().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getComcel().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getComcel().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getComcel().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getComcel().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getComcel().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                        </div><%}%>
                                        <% if (!(telco.getLumitel().getGroup0Price() == 0 && 
                                                    telco.getLumitel().getGroup1Price() == 0 &&
                                                    telco.getLumitel().getGroup2Price() == 0 &&
                                                    telco.getLumitel().getGroup3Price() == 0 &&
                                                    telco.getLumitel().getGroup4Price() == 0 &&
                                                    telco.getLumitel().getGroup5Price() == 0 &&
                                                    telco.getLumitel().getGroup6Price() == 0 &&
                                                    telco.getLumitel().getGroup7Price() == 0 &&
                                                    telco.getLumitel().getGroup8Price() == 0 &&
                                                telco.getAfricell().getGroup0Price() == 0 && 
                                                    telco.getAfricell().getGroup1Price() == 0 &&
                                                    telco.getAfricell().getGroup2Price() == 0 &&
                                                    telco.getAfricell().getGroup3Price() == 0 &&
                                                    telco.getAfricell().getGroup4Price() == 0 &&
                                                    telco.getAfricell().getGroup5Price() == 0 &&
                                                    telco.getAfricell().getGroup6Price() == 0 &&
                                                    telco.getAfricell().getGroup7Price() == 0 &&
                                                    telco.getAfricell().getGroup8Price() == 0 &&
                                                telco.getLacellsu().getGroup0Price() == 0 && 
                                                    telco.getLacellsu().getGroup1Price() == 0 &&
                                                    telco.getLacellsu().getGroup2Price() == 0 &&
                                                    telco.getLacellsu().getGroup3Price() == 0 &&
                                                    telco.getLacellsu().getGroup4Price() == 0 &&
                                                    telco.getLacellsu().getGroup5Price() == 0 &&
                                                    telco.getLacellsu().getGroup6Price() == 0 &&
                                                    telco.getLacellsu().getGroup7Price() == 0 &&
                                                    telco.getLacellsu().getGroup8Price() == 0 )) {%>
                                        <div>
                                            <h4>
                                                <b>BURUNDI</b>
                                                <div id="showBurundi<%=index%>" style="float: right">
                                                    <img onclick="show('Burundi'+<%=index%>)" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideBurundi<%=index%>" style="float: right;display: none">
                                                    <img onclick="hide('Burundi'+<%=index%>)" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                            </h4>
                                        </div>
                                        <div id="priceBurundi<%=index%>" style="display: none">
                                            <b>Lumitel :</b>
                                            <%=telco.getLumitel().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getLumitel().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getLumitel().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getLumitel().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getLumitel().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getLumitel().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getLumitel().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getLumitel().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getLumitel().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getLumitel().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getLumitel().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getLumitel().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getLumitel().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getLumitel().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getLumitel().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getLumitel().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getLumitel().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getLumitel().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Africell :</b>
                                            <%=telco.getAfricell().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getAfricell().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getAfricell().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getAfricell().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getAfricell().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getAfricell().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getAfricell().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getAfricell().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getAfricell().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getAfricell().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getAfricell().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getAfricell().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getAfricell().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getAfricell().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getAfricell().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getAfricell().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getAfricell().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getAfricell().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Lacellsu :</b> 
                                            <%=telco.getLacellsu().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getLacellsu().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getLacellsu().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getLacellsu().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getLacellsu().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getLacellsu().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getLacellsu().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getLacellsu().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getLacellsu().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getLacellsu().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getLacellsu().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getLacellsu().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getLacellsu().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getLacellsu().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getLacellsu().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getLacellsu().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getLacellsu().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getLacellsu().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                        </div><%}%>
                                        <% if (!(telco.getNexttel().getGroup0Price() == 0 && 
                                                    telco.getNexttel().getGroup1Price() == 0 &&
                                                    telco.getNexttel().getGroup2Price() == 0 &&
                                                    telco.getNexttel().getGroup3Price() == 0 &&
                                                    telco.getNexttel().getGroup4Price() == 0 &&
                                                    telco.getNexttel().getGroup5Price() == 0 &&
                                                    telco.getNexttel().getGroup6Price() == 0 &&
                                                    telco.getNexttel().getGroup7Price() == 0 &&
                                                    telco.getNexttel().getGroup8Price() == 0 &&
                                                telco.getMtn().getGroup0Price() == 0 && 
                                                    telco.getMtn().getGroup1Price() == 0 &&
                                                    telco.getMtn().getGroup2Price() == 0 &&
                                                    telco.getMtn().getGroup3Price() == 0 &&
                                                    telco.getMtn().getGroup4Price() == 0 &&
                                                    telco.getMtn().getGroup5Price() == 0 &&
                                                    telco.getMtn().getGroup6Price() == 0 &&
                                                    telco.getMtn().getGroup7Price() == 0 &&
                                                    telco.getMtn().getGroup8Price() == 0 &&
                                                telco.getOrange().getGroup0Price() == 0 && 
                                                    telco.getOrange().getGroup1Price() == 0 &&
                                                    telco.getOrange().getGroup2Price() == 0 &&
                                                    telco.getOrange().getGroup3Price() == 0 &&
                                                    telco.getOrange().getGroup4Price() == 0 &&
                                                    telco.getOrange().getGroup5Price() == 0 &&
                                                    telco.getOrange().getGroup6Price() == 0 &&
                                                    telco.getOrange().getGroup7Price() == 0 &&
                                                    telco.getOrange().getGroup8Price() == 0 )) {%>
                                        <div>
                                            <h4>
                                                <b>CAMERON</b>
                                                <div id="showCameron<%=index%>" style="float: right">
                                                    <img onclick="show('Cameron'+<%=index%>)" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideCameron<%=index%>" style="float: right;display: none">
                                                    <img onclick="hide('Cameron'+<%=index%>)" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                            </h4>
                                        </div>
                                        <div id="priceCameron<%=index%>" style="display: none">
                                            <b>Nexttel :</b>
                                            <%=telco.getNexttel().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getNexttel().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getNexttel().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getNexttel().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getNexttel().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getNexttel().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getNexttel().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getNexttel().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getNexttel().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getNexttel().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getNexttel().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getNexttel().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getNexttel().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getNexttel().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getNexttel().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getNexttel().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getNexttel().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getNexttel().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>MTN :</b>
                                            <%=telco.getMtn().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getMtn().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getMtn().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getMtn().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getMtn().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getMtn().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getMtn().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getMtn().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getMtn().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getMtn().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getMtn().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getMtn().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getMtn().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getMtn().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getMtn().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getMtn().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getMtn().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getMtn().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Orange :</b>
                                            <%=telco.getOrange().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getOrange().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getOrange().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getOrange().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getOrange().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getOrange().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getOrange().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getOrange().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getOrange().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getOrange().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getOrange().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getOrange().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getOrange().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getOrange().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getOrange().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getOrange().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getOrange().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getOrange().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                        </div><%}%>
                                        <% if (!(telco.getHalotel().getGroup0Price() == 0 && 
                                                    telco.getHalotel().getGroup1Price() == 0 &&
                                                    telco.getHalotel().getGroup2Price() == 0 &&
                                                    telco.getHalotel().getGroup3Price() == 0 &&
                                                    telco.getHalotel().getGroup4Price() == 0 &&
                                                    telco.getHalotel().getGroup5Price() == 0 &&
                                                    telco.getHalotel().getGroup6Price() == 0 &&
                                                    telco.getHalotel().getGroup7Price() == 0 &&
                                                    telco.getHalotel().getGroup8Price() == 0 &&
                                                telco.getVodacom().getGroup0Price() == 0 && 
                                                    telco.getVodacom().getGroup1Price() == 0 &&
                                                    telco.getVodacom().getGroup2Price() == 0 &&
                                                    telco.getVodacom().getGroup3Price() == 0 &&
                                                    telco.getVodacom().getGroup4Price() == 0 &&
                                                    telco.getVodacom().getGroup5Price() == 0 &&
                                                    telco.getVodacom().getGroup6Price() == 0 &&
                                                    telco.getVodacom().getGroup7Price() == 0 &&
                                                    telco.getVodacom().getGroup8Price() == 0 &&
                                                telco.getZantel().getGroup0Price() == 0 && 
                                                    telco.getZantel().getGroup1Price() == 0 &&
                                                    telco.getZantel().getGroup2Price() == 0 &&
                                                    telco.getZantel().getGroup3Price() == 0 &&
                                                    telco.getZantel().getGroup4Price() == 0 &&
                                                    telco.getZantel().getGroup5Price() == 0 &&
                                                    telco.getZantel().getGroup6Price() == 0 &&
                                                    telco.getZantel().getGroup7Price() == 0 &&
                                                    telco.getZantel().getGroup8Price() == 0 )) {%>
                                        <div>
                                            <h4>
                                                <b>TANZANIA</b>
                                                <div id="showTanzania<%=index%>" style="float: right">
                                                    <img onclick="show('Tanzania'+<%=index%>)" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideTanzania<%=index%>" style="float: right;display: none">
                                                    <img onclick="hide('Tanzania'+<%=index%>)" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                            </h4>
                                        </div>
                                        <div id="priceTanzania<%=index%>" style="display: none">
                                            <b>Halotel :</b> 
                                            <%=telco.getHalotel().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getHalotel().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getHalotel().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getHalotel().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getHalotel().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getHalotel().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getHalotel().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getHalotel().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getHalotel().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getHalotel().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getHalotel().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getHalotel().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getHalotel().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getHalotel().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getHalotel().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getHalotel().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getHalotel().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getHalotel().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Vodacom :</b>
                                            <%=telco.getVodacom().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getVodacom().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getVodacom().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getVodacom().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getVodacom().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getVodacom().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getVodacom().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getVodacom().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getVodacom().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getVodacom().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getVodacom().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getVodacom().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getVodacom().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getVodacom().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getVodacom().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getVodacom().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getVodacom().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getVodacom().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Zantel :</b>
                                            <%=telco.getZantel().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getZantel().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getZantel().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getZantel().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getZantel().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getZantel().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getZantel().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getZantel().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getZantel().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getZantel().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getZantel().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getZantel().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getZantel().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getZantel().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getZantel().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getZantel().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getZantel().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getZantel().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                        </div><%}%>
                                        <% if (!(telco.getBitel().getGroup0Price() == 0 && 
                                                    telco.getBitel().getGroup1Price() == 0 &&
                                                    telco.getBitel().getGroup2Price() == 0 &&
                                                    telco.getBitel().getGroup3Price() == 0 &&
                                                    telco.getBitel().getGroup4Price() == 0 &&
                                                    telco.getBitel().getGroup5Price() == 0 &&
                                                    telco.getBitel().getGroup6Price() == 0 &&
                                                    telco.getBitel().getGroup7Price() == 0 &&
                                                    telco.getBitel().getGroup8Price() == 0 &&
                                                telco.getClaro().getGroup0Price() == 0 && 
                                                    telco.getClaro().getGroup1Price() == 0 &&
                                                    telco.getClaro().getGroup2Price() == 0 &&
                                                    telco.getClaro().getGroup3Price() == 0 &&
                                                    telco.getClaro().getGroup4Price() == 0 &&
                                                    telco.getClaro().getGroup5Price() == 0 &&
                                                    telco.getClaro().getGroup6Price() == 0 &&
                                                    telco.getClaro().getGroup7Price() == 0 &&
                                                    telco.getClaro().getGroup8Price() == 0 &&
                                                telco.getTelefonica().getGroup0Price() == 0 && 
                                                    telco.getTelefonica().getGroup1Price() == 0 &&
                                                    telco.getTelefonica().getGroup2Price() == 0 &&
                                                    telco.getTelefonica().getGroup3Price() == 0 &&
                                                    telco.getTelefonica().getGroup4Price() == 0 &&
                                                    telco.getTelefonica().getGroup5Price() == 0 &&
                                                    telco.getTelefonica().getGroup6Price() == 0 &&
                                                    telco.getTelefonica().getGroup7Price() == 0 &&
                                                    telco.getTelefonica().getGroup8Price() == 0 )) {%>
                                        <div>
                                            <h4>
                                                <b>PERU</b>
                                                <div id="showPeru<%=index%>" style="float: right">
                                                    <img onclick="show('Peru'+<%=index%>)" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hidePeru<%=index%>" style="float: right;display: none">
                                                    <img onclick="hide('Peru'+<%=index%>)" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                            </h4>
                                        </div>
                                        <div id="pricePeru<%=index%>" style="display: none">
                                            <b>Bitel :</b>
                                            <%=telco.getBitel().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getBitel().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getBitel().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getBitel().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getBitel().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getBitel().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getBitel().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getBitel().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getBitel().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getBitel().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getBitel().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getBitel().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getBitel().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getBitel().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getBitel().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getBitel().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getBitel().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getBitel().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Claro :</b>
                                            <%=telco.getClaro().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getClaro().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getClaro().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getClaro().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getClaro().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getClaro().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getClaro().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getClaro().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getClaro().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getClaro().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getClaro().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getClaro().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getClaro().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getClaro().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getClaro().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getClaro().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getClaro().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getClaro().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                            <b>Telefonica :</b>
                                            <%=telco.getTelefonica().getGroup0Price() != 0 ? "N0: "+Tool.dinhDangTienTe(telco.getTelefonica().getGroup0Price()+"")+"," : ""%>
                                            <%=telco.getTelefonica().getGroup1Price() != 0 ? "N1: "+Tool.dinhDangTienTe(telco.getTelefonica().getGroup1Price()+"")+"," : ""%>
                                            <%=telco.getTelefonica().getGroup2Price() != 0 ? "N2: "+Tool.dinhDangTienTe(telco.getTelefonica().getGroup2Price()+"")+"," : ""%>
                                            <%=telco.getTelefonica().getGroup3Price() != 0 ? "N3: "+Tool.dinhDangTienTe(telco.getTelefonica().getGroup3Price()+"")+"," : ""%>
                                            <%=telco.getTelefonica().getGroup4Price() != 0 ? "N4: "+Tool.dinhDangTienTe(telco.getTelefonica().getGroup4Price()+"")+"," : ""%>
                                            <%=telco.getTelefonica().getGroup5Price() != 0 ? "N5: "+Tool.dinhDangTienTe(telco.getTelefonica().getGroup5Price()+"")+"," : ""%>
                                            <%=telco.getTelefonica().getGroup6Price() != 0 ? "N6: "+Tool.dinhDangTienTe(telco.getTelefonica().getGroup6Price()+"")+"," : ""%>
                                            <%=telco.getTelefonica().getGroup7Price() != 0 ? "N7: "+Tool.dinhDangTienTe(telco.getTelefonica().getGroup7Price()+"")+"," : ""%>
                                            <%=telco.getTelefonica().getGroup8Price() != 0 ? "N8: "+Tool.dinhDangTienTe(telco.getTelefonica().getGroup8Price()+"")+"," : ""%>
                                            <br/>
                                        </div><%}%>
                                    </td>

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
                                            "/admin/billing/edit.jsp?account=" + oneAdmin.getUsername(),
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