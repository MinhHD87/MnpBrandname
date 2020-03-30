<%@page import="gk.myname.vn.entity.DeclareOption"%><%@page import="gk.myname.vn.entity.BrandLabel_Declare"%><%@page import="gk.myname.vn.utils.SMSUtils"%><%@page import="gk.myname.vn.entity.RouteTable"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
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
                $('.ItemPopup').showPopup({
                    top: 100,
                    closeButton: ".close_popup", //khai báo nút close cho popup
                    scroll: 0, //cho phép scroll khi mở popup, mặc định là không cho phép
                    width: 500,
                    height: 'auto',
                    closeOnEscape: true
                });
                $('.ask').jConfirmAction();
            });
        </script>
    </head>
    <body>
        <%            BrandLabel_Declare brDclDao = new BrandLabel_Declare();
            int currentPage = RequestTool.getInt(request, "page", 1);
            int status = RequestTool.getInt(request, "status", -2);
            String label = RequestTool.getString(request, "_label");
            String cpuser = RequestTool.getString(request, "cpuser", "0");
//            String cp_code = userlogin.getCpCode();
            ArrayList<BrandLabel_Declare> allBrandDcl = brDclDao.getBrDeclare(currentPage, maxRow, label, cpuser, "", status);
            int totalPage = 0;
            int totalRow = brDclDao.countBrDeclare(label, cpuser, "", status);
            totalPage = (int) totalRow / maxRow;
            if (totalRow % maxRow != 0) {
                totalPage++;
            }
        %>
        <div id="popup_content_add" class="popup"></div>
        <div id="popup_content_edit" class="popup"></div>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <!-- Tìm kiếm-->
                        <form action="<%=request.getContextPath() + "/admin/brand-declare/index.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">QUẢN LÝ BRAND NAME KHÁCH HÀNG KHAI BÁO</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Brand Label:</td>
                                        <td>
                                            <select style="width: 180px" id="_label" name="_label">
                                                <option value="">Tất cả</option>
                                                <%ArrayList<BrandLabel> allLabel = BrandLabel.getAll();
                                                    for (BrandLabel one : allLabel) {
                                                %>
                                                <option id="_<%=one.getId()%>" status="_<%=one.getStatus()%>" <%=label.equals(one.getBrandLabel()) ? "selected='selected'" : ""%> value="<%=one.getBrandLabel()%>"><%=one.getBrandLabel()%> - [<%=one.getUserOwner()%>] <%=one.getStatus() == 1 ? "" : "[Lock]"%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Trạng thái:</td>
                                        <td>
                                            <select name="status">
                                                <option value="-2">Tất cả</option>
                                                <option value="1">Đã duyệt</option>
                                                <option value="0">Khóa</option>
                                                <option value="404">Xóa</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Khách hàng :</td>
                                        <td>

                                            <select style="width: 400px" name="cpuser" id="_userSender">
                                                <option value="0">***** Tất cả *****</option>
                                                <%
                                                    ArrayList<Account> allCp = Account.getAllCP();
                                                    for (Account one : allCp) {
                                                %>
                                                <option value="<%=one.getUserName()%>"> [<%=one.getUserName()%>] <%=one.getFullName()%> </option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="btnsearch" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <%=buildAddControl(request, userlogin, "/admin/brand-declare/add.jsp")%>
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
                                        <th scope="col" class="rounded">Khai Báo</th>
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
                                        for (BrandLabel_Declare oneBrand : allBrandDcl) {
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
                                                DeclareOption route = oneBrand.getDeclare();
                                            %>
                                            <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 130px">
                                                <div style="float: left;color: #F78D1D;font-weight: bold;width: 130px">VTE:
                                                    <%=route.isVte() ? "<span style='color: red;font-weight: bold'>Khai báo</span>" : "<span style='color: blue;font-weight: bold'>Không</span>"%>
                                                </div>
                                            </div>
                                            <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 130px">
                                                <div style="float: left;color: #F78D1D;font-weight: bold;width: 130px">MOBI:
                                                    <%=route.isVms() ? "<span style='color: red;font-weight: bold'>Khai báo</span>" : "<span style='color: blue;font-weight: bold'>Không</span>"%>
                                                </div>
                                            </div>
                                            <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 130px">
                                                <div style="float: left;color: #F78D1D;font-weight: bold;width: 130px">VINA:
                                                    <%=route.isGpc() ? "<span style='color: red;font-weight: bold'>Khai báo</span>" : "<span style='color: blue;font-weight: bold'>Không</span>"%>
                                                </div>
                                            </div>
                                            <div style="float: left;border-bottom: 1px solid #cd0a0a;width: 130px">
                                                <div style="float: left;color: #F78D1D;font-weight: bold;width: 130px">VNM:
                                                    <%=route.isVnm() ? "<span style='color: red;font-weight: bold'>Khai báo</span>" : "<span style='color: blue;font-weight: bold'>Không</span>"%>
                                                </div>
                                            </div>
                                            <div style="float: left">
                                                <div style="float: left;color: #F78D1D;font-weight: bold;width: 130px">GTEL:
                                                    <%=route.isGtel() ? "<span style='color: red;font-weight: bold'>Khai báo</span>" : "<span style='color: blue;font-weight: bold'>Không</span>"%>
                                                </div>
                                            </div>
                                        </td>  
                                        <td class="boder_right" align="center">
                                            <%=oneBrand.getCreateDate()%>
                                        </td>
                                        <td class="boder_right"><%=oneBrand.getCreateBy()%></td>
                                        <td class="boder_right" align="center">
                                            <a target="_blank" href="DownloadDocument.jsp?bid=<%=oneBrand.getId()%>">
                                                <img src="<%=webPath%>/resources/images/preview.png" title="Xem File Hồ sơ" alt="Xem"/>
                                            </a>
                                            <%=oneBrand.checkHasFile() ? "<b style='color:blue'>Có</b>" : "<b style='color:red'>Không</b>"%>
                                        </td>
                                        <td class="boder_right" align="center">
                                            <%
                                                if (oneBrand.getStatus() == 1) {
                                            %>
                                            <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/>
                                            <%
                                            } else if (oneBrand.getStatus() == Tool.STATUS.DEL.val) {
                                            %> <img width="16" src="<%= request.getContextPath()%>/admin/resource/images/shutdown.png"/><% } else {
                                            %>
                                            <img width="32" src="<%= request.getContextPath()%>/admin/resource/images/key_lock.png"/>
                                            <%}%>
                                        </td>
                                        <%=buildControl(request, userlogin,
                                                "/admin/brand-declare/editBrand.jsp?id=" + oneBrand.getId(),
                                                (oneBrand.getStatus() == 404) ? "/admin/brand-declare/del_ever.jsp?id=" + oneBrand.getId() : "/admin/brand-declare/delBrand.jsp?id=" + oneBrand.getId())%>
                                    </tr>
                                    <%
                                        }
                                    %>
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