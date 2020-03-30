<%@page import="gk.myname.vn.utils.SMSUtils"%><%@page import="gk.myname.vn.entity.RouteTable"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script type="text/javascript" language="javascript">
            $(document).ready(function () {
                $('#_dataTable').DataTable({
                    "order": [[0, "asc"]],
                    "bPaginate": false,
                    "bLengthChange": false,
                    "bFilter": true,
                    "bInfo": false,
                    "bAutoWidth": false
                });
            });
            $(document).ready(function () {
                $('.ask').jConfirmAction();
            });
            function checkallMove() {
                var chk = document.getElementById("checkall");
                if (chk.checked) {
                    var chkmove = document.getElementsByName("chkmove");
                    for (var i = 0; i < chkmove.length; i++)
                        chkmove[i].checked = true;
                } else {
                    var chkmove = document.getElementsByName("chkmove");
                    for (var i = 0; i < chkmove.length; i++)
                        chkmove[i].checked = false;
                }
            }
            function CheckMove() {
                var chkmove = document.getElementsByName("chkmove");
                for (var i = 0; i < chkmove.length; i++) {
                    if (chkmove[i].checked) {
                        return true;
                    }
                }
                alert("Bạn cần chọn ít nhất một nội dung để chuyển chuyên mục");
                return false;
            }
            function  delChoice() {
                var supertarget = '<%=request.getContextPath() + "/admin/brand/delallBrand.jsp"%>'
                var theForm = document.getElementById("mainForm");
                theForm.action = supertarget;
                theForm.submit();
                // $("#mainForm").submit();
            }
        </script>
    </head>
    <body>
        <%
            ArrayList<BrandLabel> allBrand = null;
            BrandLabel dao = new BrandLabel();
            int currentPage = RequestTool.getInt(request, "page", 1);
            int status = RequestTool.getInt(request, "status", -2);
            String _label = RequestTool.getString(request, "_label");
            String telco = RequestTool.getString(request, "telco");
            String providerCode = RequestTool.getString(request, "providerCode");
            String cpuser = RequestTool.getString(request, "cpuser", "0");
            //--
            allBrand = dao.getAll(currentPage, maxRow, _label, cpuser, status, providerCode, telco);
            int totalPage = 0;
            int totalRow = dao.countAll(_label, cpuser, status, providerCode, telco);
            totalPage = (int) totalRow / maxRow;
            if (totalRow % maxRow != 0) {
                totalPage++;
            }
            String urlExport = request.getContextPath() + "/admin/brand/exportBrand.jsp?";
            String dataGet = "";
            dataGet += "page=" + currentPage;
            dataGet += "&status=" + status;
            dataGet += "&_label=" + _label;
            dataGet += "&telco=" + telco;
            dataGet += "&providerCode=" + providerCode;
            dataGet += "&cpuser=" + cpuser;
            urlExport += dataGet;
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <!-- Tìm kiếm-->
                        <form action="<%=request.getContextPath() + "/admin/brand/index.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">HỆ THỐNG QUẢN LÝ BRAND NAME</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Brand Label</td>
                                        <td>
                                            <select style="width: 180px" id="_label" name="_label">
                                                <option value="">Tất cả</option>
                                                <%ArrayList<BrandLabel> allLabel = BrandLabel.getAll();
                                                    for (BrandLabel one : allLabel) {
                                                %>
                                                <option id="_<%=one.getId()%>" status="_<%=one.getStatus()%>" <%=_label.equals(one.getBrandLabel()) ? "selected='selected'" : ""%> value="<%=one.getBrandLabel()%>"><%=one.getBrandLabel()%> - [<%=one.getUserOwner()%>] <%=one.getStatus() == 1 ? "" : "[Lock]"%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            Trạng thái:
                                            <select name="status">
                                                <option <%=(status == -2 ? "selected='selected'" : "")%> value="-2">Tất cả</option>
                                                <option <%=(status == 1 ? "selected='selected'" : "")%> value="1">Đã duyệt</option>
                                                <option <%=(status == 0 ? "selected='selected'" : "")%> value="0">Khóa</option>
                                                <option <%=(status == 404 ? "selected='selected'" : "")%> value="404">Xóa</option>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;
                                            <span class="redBold">Telco</span>
                                            <select name="telco">
                                                <option value="">---Tất cả---</option>
                                                <option <%=telco.equals(SMSUtils.OPER.VIETTEL.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.VIETTEL.val%>">VIETTEL</option>
                                                <option <%=telco.equals(SMSUtils.OPER.VINA.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.VINA.val%>">VINA PHONE</option>
                                                <option <%=telco.equals(SMSUtils.OPER.MOBI.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.MOBI.val%>">MOBI PHONE</option>
                                                <option <%=telco.equals(SMSUtils.OPER.BEELINE.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.BEELINE.val%>">BEELINE</option>
                                                <option <%=telco.equals(SMSUtils.OPER.VNM.val) ? "selected='selected'" : ""%> value="<%=SMSUtils.OPER.VNM.val%>">VIETNAMMOBIE</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Nhà Cung Cấp:</td>
                                        <td>
                                            <select style="width: 300px" name="providerCode" id="_agentcy_id">
                                                <option value="">***** Chọn nhà cung cấp*****</option>
                                                <%
                                                    ArrayList<Provider> allpro = Provider.getCACHE();
                                                    for (Provider one : allpro) {
                                                %>
                                                <option value="<%=one.getCode()%>" <%=(one.getCode().equals(providerCode)) ? "selected ='selected'" : ""%> 
                                                        img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" ><%=one.getName()%> <%= one.getStatus() == 1 ? "" : "[LOCK]"%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            Khách hàng 
                                            <select style="width: 400px" name="cpuser" id="_userSender">
                                                <option value="0">***** Tất cả *****</option>
                                                <%
                                                    ArrayList<Account> allCp = Account.getAllCP();
                                                    for (Account one : allCp) {
                                                %>
                                                <option <%=(one.getUserName().equals(cpuser) ? "selected='selected'" : "")%> 
                                                    value="<%=one.getUserName()%>" 
                                                    img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" > [<%=one.getUserName()%>] <%=one.getFullName()%> </option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="btnsearch" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;
                                            <%=buildAddControl(request, userlogin, "/admin/brand/addBrand.jsp")%>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <input onclick="window.open('<%=urlExport%>')" class="button" type="button" name="btnExport" value="Xuất Excel"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>      
                        <!--End tim kiếm-->
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%
                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <!--                        <div style="margin-left: 30px;margin-bottom: 10px">
                                                    <input onclick="delChoice()" class="button" type="button" name="delchoice" value="Xoá chọn"/>
                                                </div>-->
                        <%@include file="/admin/includes/page.jsp" %>
                        <!--Content-->
                        <form action="" name="mainForm" id="mainForm">
                            <!--<table align="center" class="display" id="_dataTable" summary="Msc Joint Stock Company" >-->
                            <table style="font-size: 11px" id="_dataTable" class="display" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded">STT</th>
                                        <th scope="col" class="rounded">Brand Name</th>
                                        <th scope="col" class="rounded">Tài khoản</th>
                                        <th scope="col" class="rounded">Định Tuyến</th>
                                        <th scope="col" class="rounded">Nhóm</th>
                                        <th scope="col" class="rounded">Create Date</th>
                                        <th scope="col" class="rounded">Create By</th>
                                        <th scope="col" class="rounded">Hồ sơ</th>
                                        <!--<th scope="col" class="rounded">Update By</th>-->
                                        <!--<th scope="col" class="rounded">Max SMS</th>--> 
                                        <th scope="col" class="rounded">Trạng thái</th>
                                            <%=buildHeader(request, userlogin, true, true)%>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%      //Bien dung de dem so dong
                                        int count = 1;
                                        for (Iterator<BrandLabel> iter = allBrand.iterator(); iter.hasNext();) {
                                            BrandLabel oneBrand = iter.next();
                                            int tmp = (currentPage - 1) * maxRow + count++;
                                    %>
                                    <tr>
                                        <td class="boder_right"><%=tmp%></td>
                                        <td class="boder_right" align="left">
                                            <b><%=oneBrand.getBrandLabel()%></b>
                                        </td>
                                        <td class="boder_right" align="left">
                                            <%=oneBrand.getUserOwner()%>
                                        </td>
                                        <td class="boder_right" style="width: 180px" align="left">
                                            <%
                                                RouteTable route = oneBrand.getRoute();
                                            %>
                                            <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 180px">
                                                <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VIETTEL:</div>
                                                <div style="float: left">
                                                    QC => <%=route.getVte().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getVte().getRoute_QC() + "</span>"%>
                                                    <br/>
                                                    CSKH => <%=route.getVte().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getVte().getRoute_CSKH() + "</span>"%>
                                                </div>
                                            </div>
                                            <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 180px">
                                                <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">MOBI:</div>
                                                <div style="float: left">
                                                    QC => <%=route.getMobi().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getMobi().getRoute_QC() + "</span>"%>
                                                    <br/>
                                                    CSKH => <%=route.getMobi().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getMobi().getRoute_CSKH() + "</span>"%>
                                                </div>
                                            </div>
                                            <div style="float: left">
                                                <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VINA:</div>
                                                <div style="float: left">
                                                    QC => <%=route.getVina().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getVina().getRoute_QC() + "</span>"%>
                                                    <br/>
                                                    CSKH => <%=route.getVina().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getVina().getRoute_CSKH() + "</span>"%>
                                                </div>
                                            </div>
                                        </td>  
                                        <td class="boder_right">
                                            <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VIETTEL:</div>
                                                <div style="float: left">
                                                    <%=route.getVte().getGroup()%>
                                                </div>
                                            </div>
                                            <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">MOBI:</div>
                                                <div style="float: left">
                                                    <%=route.getMobi().getGroup()%>
                                                </div>
                                            </div>
                                            <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VINA:</div>
                                                <div style="float: left">
                                                    <%=route.getVina().getGroup()%>
                                                </div>
                                            </div>
                                            <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VN MOBI:</div>
                                                <div style="float: left">
                                                    <%=route.getVnm().getGroup()%>
                                                </div>
                                            </div>
                                            <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 80px">
                                                <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">BEELINE:</div>
                                                <div style="float: left">
                                                    <%=route.getBl().getGroup()%>
                                                </div>
                                            </div>
                                            <div style="float: left">
                                                <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">ITELECOM:</div>
                                                <div style="float: left">
                                                    <%=route.getDdg().getGroup()%>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="boder_right" align="center">
                                            <%=oneBrand.getCreateDate()%>
                                        </td>
                                        <td class="boder_right"><%=Account.getNameById(oneBrand.getCreateBy())%></td>
                                        <td class="boder_right" align="center">
                                            <a href="addDocument.jsp?bid=<%=oneBrand.getId()%>">
                                                <img src="<%=webPath%>/resources/images/preview.png" title="Xem File Hồ sơ" alt="Xem"/>
                                            </a>
                                            <%=oneBrand.checkHasFile() ? "<b style='color:blue'>Có</b>" : "<b style='color:red'>Không</b>"%>
                                        </td>
                                        <td class="boder_right" align="center">
                                            <%if (oneBrand.getStatus() == 1) {%>
                                            <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                            <%} else if (oneBrand.getStatus() == Tool.STATUS.DEL.val) {
                                            %> <img width="16" src="<%= request.getContextPath()%>/admin/resource/images/shutdown.png"/><%
                                            } else {%>
                                            <img width="32" src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                            <%}%>
                                        </td>
                                        <%=buildControl(request, userlogin,
                                                "/admin/brand/editBrand.jsp?id=" + oneBrand.getId(),
                                                (oneBrand.getStatus() == 404) ? "/admin/brand/del_ever.jsp?id=" + oneBrand.getId() : "/admin/brand/delBrand.jsp?id=" + oneBrand.getId())%>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </form>
                    </div><!-- end of right content-->
                </div>   <!--end of center content -->
                <div class="clear"></div>
            </div> <!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html>