<%@page import="gk.myname.vn.entity.Provider_Telco"%>
<%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#providerCode").select2({
                    formatResult: function (item) {
                        var valOpt = $(item.element).attr('img-data');
                        if (!valOpt) {
                            return ('<div><b>' + item.text + '</b></div>');
                        } else {
                            return ('<div><span><b style="color: red">' + item.text + '<b> <img src="' + valOpt + '" class="img-flag" /></span></div>');
                        }
                    },
                    formatSelection: function (item) {
                        //  load page or selected
                        var opt = $("#providerCode option:selected");
                        var valOpt = opt.attr("img-data");
                        if (!valOpt) {
                            return ('<b>' + item.text + '</b>');
                        } else {
                            return ('<div><span><b style="color: red">' + item.text + '</b> <img src="' + valOpt + '" class="img-flag" /></span></div>');
                        }
                    },
                    dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
                    escapeMarkup: function (m) {
                        return m;
                    }
                });
            });
        </script>
    </head>
    <body>
        <%  //-          
            if (!userlogin.checkView(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin");
                return;
            }
            int max = 50;
            ArrayList<Provider> all = null;
            Provider pDao = new Provider();
            int currentPage = RequestTool.getInt(request, "page", 1);
            String code = RequestTool.getString(request, "code");
            String name = RequestTool.getString(request, "name");
            all = pDao.getProvider(currentPage, max, code, name);
            int totalPage = 0;
            int totalRow = pDao.countProvider(code, name);
            totalPage = (int) totalRow / max;
            if (totalRow % max != 0) {
                totalPage++;
            }
            String urlExport = request.getContextPath() + "/admin/provider/exp/export_provider.jsp?";
            urlExport += "&currentPage=" + currentPage;
            urlExport += "&max=" + max;
            urlExport += "&code=" + code;
            urlExport += "&name=" + name;
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <!-- Tìm kiếm-->
                        <form action="<%=request.getContextPath() + "/admin/provider/index.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Tìm kiếm Nhà Cung Cấp</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Provider </td>
                                        <td>
                                            <select style="width: 300px" name="code" id="providerCode">
                                                <option value="">***** Chọn nhà cung cấp*****</option>
                                                <%
                                                    ArrayList<Provider> allpro = Provider.getCACHE();
                                                    for (Provider one : allpro) {
                                                %>
                                                <option value="<%=one.getCode()%>" 
                                                        img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=one.getCode()%>] <%=one.getName()%> <%= one.getStatus() == 1 ? "" : "[LOCK]"%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
<!--                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            Tên Nhà Cung Cấp:
                                            <input size="20" type="text" name="name"/>-->
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;
                                            <input class="button" onclick="location.href = '<%=request.getContextPath() + "/admin/provider/add.jsp"%>'" type="button" name="Thêm mới" value="Thêm mới"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <input onclick="window.open('<%=urlExport%>')" class="button" type="button" name="button" value="Xuất Excel"/>
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
                                    <!--<th>Provider CODE</th>-->
                                    <th>Provider NAME</th>
                                    <!--<th>POS</th>-->
                                    <!--<th>CLASS</th>-->
                                    <th>Hướng Mua</th>
                                    <th>Trạng thái</th>
                                    <th>Nhập giá</th>
                                    <th>Edit</th>
                                    <th>Delete</th>
                                    <th>Giá</th>
                                    <th>Đè nhãn</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    for (Iterator<Provider> iter = all.iterator(); iter.hasNext();) {
                                        Provider oneProvi = iter.next();
                                        int tmp = (currentPage - 1) * 25 + count++;
                                %>
                                <tr>
                                    <!--<td class="boder_right" align="left">-->
                                        <%--<%= //oneProvi.getCode()%>--%>
                                    <!--</td>-->
                                    <td class="boder_right" align="left">
                                        <%=oneProvi.getName()%>
                                    </td>
                                    <!--<td class="boder_right" align="left">-->
                                        <%--<%=oneProvi.getPos()%>--%>
                                    <!--</td>-->
                                    <!--<td class="boder_right" align="left">-->
                                        <%--<%=oneProvi.getClassSend()%>--%>
                                    <!--</td>-->
                                    <td class="boder_right">
                                        
                                        <% if (oneProvi.getVte() == 1) { %>
                                            <input disabled  checked='checked' type="checkbox" value="1"/> Viettel <br/>
                                        <% } %>
                                        <% if (oneProvi.getMobi() == 1) { %>
                                            <input disabled  checked='checked' type="checkbox" value="1"/> Mobi<br/>
                                        <% } %>
                                        <% if (oneProvi.getVina() == 1) { %>
                                            <input disabled  checked='checked' type="checkbox" value="1"/> Vina<br/>
                                        <% } %>
                                        <% if (oneProvi.getVnm() == 1) { %>
                                            <input disabled  checked='checked' type="checkbox" value="1"/> Vietnam Mobi <br/>
                                        <% } %>
                                        <% if (oneProvi.getBl() == 1) { %>
                                            <input disabled  checked='checked' type="checkbox" value="1"/> Beeline <br/>
                                        <% } %>
                                        <% if (oneProvi.getDdg() == 1) { %>
                                            <input disabled  checked='checked' type="checkbox" value="1"/> Dongduong <br/>
                                        <% } %>
                                        
                                        <% if (oneProvi.getCellcard()== 1) { %>
                                            <input disabled  checked='checked' type="checkbox" value="1"/> CELLCARD <br/>
                                        <% } %>
                                        <% if (oneProvi.getMetfone()== 1) { %>
                                            <input disabled  checked='checked' type="checkbox" value="1"/> METFONE <br/>
                                        <% } %>
                                        <% if (oneProvi.getBeelineCampuchia()== 1) { %>
                                            <input disabled  checked='checked' type="checkbox" value="1"/> BEELINE CAMPUCHIA <br/>
                                        <% } %>
                                        <% if (oneProvi.getSmart()== 1) { %>
                                            <input disabled  checked='checked' type="checkbox" value="1"/> SMART <br/>
                                        <% } %>
                                        <% if (oneProvi.getQbmore()== 1) { %>
                                            <input disabled  checked='checked' type="checkbox" value="1"/> QBMORE <br/>
                                        <% } %>
                                        <% if (oneProvi.getExcell() == 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> EXCELL <br/>
                                        <% } %>
                                        
                                        <% if (oneProvi.getTelemor()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> TELEMOR <br/>
                                        <% } %>
                                        <% if (oneProvi.getTimortelecom()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> TIMOR TELECOM <br/>
                                        <% } %>
                                        
                                        <% if (oneProvi.getMovitel()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> MOVITEL <br/>
                                        <% } %>
                                        <% if (oneProvi.getMcel()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> MCEL <br/>
                                        <% } %>
                                        
                                        <% if (oneProvi.getUnitel()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> UNITEL <br/>
                                        <% } %>
                                        <% if (oneProvi.getEtl()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> ETL <br/>
                                        <% } %>
                                        <% if (oneProvi.getTango()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> TANGO <br/>
                                        <% } %>
                                        <% if (oneProvi.getLaotel()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> LAOTEL <br/>
                                        <% } %>
                                        
                                        <% if (oneProvi.getMytel()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> MYTEL <br/>
                                        <% } %>
                                        <% if (oneProvi.getMpt()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> MPT <br/>
                                        <% } %>
                                        <% if (oneProvi.getOoredo()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> OOREDO <br/>
                                        <% } %>
                                        <% if (oneProvi.getTelenor()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> TELENOR <br/>
                                        <% } %>
                                        
                                        <% if (oneProvi.getNatcom()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> NATCOM <br/>
                                        <% } %>
                                        <% if (oneProvi.getDigicel()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> DIGICEL <br/>
                                        <% } %>
                                        <% if (oneProvi.getComcel()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> COMCEL <br/>
                                        <% } %>
                                        
                                        <% if (oneProvi.getLumitel()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> LUMITEL <br/>
                                        <% } %>
                                        <% if (oneProvi.getAfricell()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> AFRICELL <br/>
                                        <% } %>
                                        <% if (oneProvi.getLacellsu()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> LACELLSU <br/>
                                        <% } %>
                                        
                                        <% if (oneProvi.getNexttel()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> NEXTTEL <br/>
                                        <% } %>
                                        <% if (oneProvi.getMtn()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> MTN <br/>
                                        <% } %>
                                        <% if (oneProvi.getOrange()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> ORANGE <br/>
                                        <% } %>
                                        
                                        <% if (oneProvi.getHalotel()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> HALOTEL <br/>
                                        <% } %>
                                        <% if (oneProvi.getVodacom()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> VODACOM <br/>
                                        <% } %>
                                        <% if (oneProvi.getZantel()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> ZANTEL <br/>
                                        <% } %>
                                        
                                        <% if (oneProvi.getBitel()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> BITEL <br/>
                                        <% } %>
                                        <% if (oneProvi.getClaro()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> CLARO <br/>
                                        <% } %>
                                        <% if (oneProvi.getTelefonica()== 1) { %>
                                        <input disabled  checked='checked' type="checkbox" value="1"/> TELEFONICA <br/>
                                        <% } %>
                                    </td>
                                    <td class="boder_right" align="center">
                                        <%
                                            if (oneProvi.getStatus() == 1) {
                                        %>
                                        <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                        <%
                                        } else if (oneProvi.getStatus() == Tool.STATUS.DEL.val) {
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
                                    <td class="boder_right" align="center">
                                        <a href="<%=request.getContextPath() + "/admin/provider/add_price.jsp?code="+ oneProvi.getCode()%>"><img src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/></a>
                                    </td>
                                    <%=buildControl(request, userlogin, "/admin/provider/edit.jsp?id=" + oneProvi.getId(), "/admin/provider/del.jsp?id=" + oneProvi.getId())%>
                                    <%         
                                        Provider_Telco telco = oneProvi.getBuy_price();
                                    %>
                                    <td class="boder_right" width="400">
                                        <% if (oneProvi.getVte() == 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getMobi() == 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getVina() == 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getVnm() == 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getBl() == 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getDdg() == 1) { %>
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
                                        <% } %>
                                        
                                        <% if (oneProvi.getCellcard()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getMetfone()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getBeelineCampuchia()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getSmart()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getQbmore()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getExcell() == 1) { %>
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
                                        <% } %>
                                        
                                        <% if (oneProvi.getTelemor()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getTimortelecom()== 1) { %>
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
                                        <% } %>
                                        
                                        <% if (oneProvi.getMovitel()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getMcel()== 1) { %>
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
                                        <% } %>
                                        
                                        <% if (oneProvi.getUnitel()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getEtl()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getTango()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getLaotel()== 1) { %>
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
                                        <% } %>
                                        
                                        <% if (oneProvi.getMytel()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getMpt()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getOoredo()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getTelenor()== 1) { %>
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
                                        <% } %>
                                        
                                        <% if (oneProvi.getNatcom()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getDigicel()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getComcel()== 1) { %>
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
                                        <% } %>
                                        
                                        <% if (oneProvi.getLumitel()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getAfricell()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getLacellsu()== 1) { %>
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
                                        <% } %>
                                        
                                        <% if (oneProvi.getNexttel()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getMtn()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getOrange()== 1) { %>
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
                                        <% } %>
                                        
                                        <% if (oneProvi.getHalotel()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getVodacom()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getZantel()== 1) { %>
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
                                        <% } %>
                                        
                                        <% if (oneProvi.getBitel()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getClaro()== 1) { %>
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
                                        <% } %>
                                        <% if (oneProvi.getTelefonica()== 1) { %>
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
                                        <% } %>
                                    </td>   
                                    <td>
                                        <a href="<%=request.getContextPath() + "/admin/provider/listChangeLabel.jsp?id="+ oneProvi.getId()%>"><img src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/></a>
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