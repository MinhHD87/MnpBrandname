<%@page import="gk.myname.vn.entity.Complain_title"%><%@page import="gk.myname.vn.entity.Complain_log"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script type="text/javascript" language="javascript">
//            $.noConflict();
            $(document).ready(function () {
                $('#example').DataTable({
                    order: [[3, "desc"]],
                    bPaginate: false,
                    bLengthChange: false,
                    bFilter: true,
                    bInfo: false,
                    bAutoWidth: false
                });
                $("#_name_title").select2();
            });
            $(document).ready(function () {
                $('.dateproc').datetimepicker({
                    lang: 'vi',
                    timepicker: false,
                    format: 'd/m/Y',
                    formatDate: 'Y/m/d',
                    minDate: '2017/01/01', // yesterday is minimum date
                    maxDate: '+1970/01/02' // and tommorow is maximum date calendar
                });
            });
            //------
            function validMonth() {
                var stRequest = $("#stRequest").val();
                var endRequest = $("#endRequest").val();
                var arrstRequest = stRequest.split("/");
                var arrendRequest = endRequest.split("/");
                if (stRequest !== "" && stRequest !== null) {
                    if (endRequest === "" || endRequest === null) {
                        jAlert("Bạn cần chọn ngày kết thúc...");
                        return false;
                    }
                    if (arrstRequest[1] !== arrendRequest[1]) {
                        jAlert("Bạn chỉ thống kê được dữ liệu từng tháng...");
                        return false;
                    }
                    if (arrstRequest[2] !== arrendRequest[2]) {
                        jAlert("Năm bạn chọn không hợp lệ...");
                        return false;
                    }
                }
            }
            function changeBrand() {
                var selectBr = $("#_label option:selected");
                if (selectBr.val() !== "") {
                    var user = selectBr.attr("user_sender");
                    var url = "<%= request.getContextPath()%>/admin/statistic/ajax/list-cp.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_userSender");
                    $("#_userSender").select2('val', user);
                } else {
                    var url = "<%= request.getContextPath()%>/admin/statistic/ajax/list-cp.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_userSender");
                    $("#_userSender").select2('val', "");
                }
            }
            function changeCP() {
                var selectBr = $("#_userSender option:selected");
                var user = selectBr.val();
                if (user !== "") {
                    var url = "<%= request.getContextPath()%>/admin/statistic/ajax/listBrand.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_label");
                } else {
                    var url = "<%= request.getContextPath()%>/admin/statistic/ajax/listBrand.jsp?user=user";
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_label");
                }
                $("#_label").select2("val", "");
            }
        </script>
    </head>
    <body>
        <%            //-
            Complain_log dao = new Complain_log();
            String stRequest = RequestTool.getString(request, "stRequest");
//            if (Tool.checkNull(stRequest)) {
//                stRequest = DateProc.createDDMMYYYY();
//            }
            String endRequest = RequestTool.getString(request, "endRequest");
            if (Tool.checkNull(endRequest)) {
                endRequest = DateProc.createDDMMYYYY();
            }
            String name = RequestTool.getString(request, "name");

            String oper = RequestTool.getString(request, "oper");
            int labelId = RequestTool.getInt(request, "_label");
            BrandLabel brLabel = BrandLabel.getFromCache(labelId);
            //--
            String label = "";
            if (brLabel != null) {
                label = brLabel.getBrandLabel();
            }
            String userSender = RequestTool.getString(request, "usersender");
            String provider = RequestTool.getString(request, "provider");
            int currentPage = RequestTool.getInt(request, "page", 1);
            ArrayList<Complain_log> allLog = dao.staticComplain_log(currentPage, maxRow, stRequest, endRequest, name, oper, label, userSender, provider);
            int totalPage = 0;
            int totalRow = dao.count(stRequest, endRequest, name, oper, label, userSender, provider);
            totalPage = (int) totalRow / maxRow;
            if (totalRow % maxRow != 0) {
                totalPage++;
            }
            RequestTool.debugParam(request);

        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <!-- Tìm kiếm-->
                        <form onsubmit="return  validMonth();" action="<%=request.getContextPath() + "/admin/complain_log/index.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Complain_log</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Từ ngày:</td>
                                        <td> 
                                            &nbsp;<span class="redBold"> </span>
                                            <input value="<%=stRequest%>" id="stRequest" class="dateproc" size="8" type="text" name="stRequest"/>
                                            &nbsp;<span class="redBold">Đến ngày </span>
                                            <input value="<%=endRequest%>" id="endRequest" class="dateproc" size="8" type="text" name="endRequest"/>
                                            &nbsp;
                                            Telco
                                            <select name="oper">
                                                <option value="">+Tất cả+</option>
                                                <option <%= oper.equalsIgnoreCase("VMS") ? "selected='selected'" : ""%> value="VMS">MOBI</option>
                                                <option <%= oper.equalsIgnoreCase("GPC") ? "selected='selected'" : ""%> value="GPC">VINA PHONE</option>
                                                <option <%= oper.equalsIgnoreCase("VTE") ? "selected='selected'" : ""%> value="VTE">VIETTEL</option>
                                                <option <%= oper.equalsIgnoreCase("VNM") ? "selected='selected'" : ""%> value="VNM">VN MOBI</option>
                                                <option <%= oper.equalsIgnoreCase("BL") ? "selected='selected'" : ""%> value="BL">GTEL</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Khách Hàng:</td>
                                        <td>
                                            <%
                                                ArrayList<Account> allCp = Account.getAllCP();
                                                if (allCp != null && !allCp.isEmpty()) {
                                            %>
                                            <select style="width: 420px" onchange="changeCP()" id="_userSender" name="usersender">
                                                <option value="">--- Tất cả ---</option>
                                                <%             for (Account oneAcc : allCp) {
                                                        if (oneAcc.getStatus() != Account.STATUS.ACTIVE.val) {
                                                            continue;
                                                        }
                                                %>
                                                <option <%=(oneAcc.getUserName().equals(userSender)) ? "selected ='selected'" : ""%>
                                                    value="<%=oneAcc.getUserName()%>"
                                                    img-data="<%=(oneAcc.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=oneAcc.getUserName()%>] <%=oneAcc.getFullName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <%
                                                }
                                            %>
                                            &nbsp;&nbsp;&nbsp;
                                            Nhãn gửi tin:
                                            <select onchange="changeBrand()" style="width: 180px" id="_label" name="_label">
                                                <option value="">Tất cả</option>
                                                <%
                                                    ArrayList<BrandLabel> allLabel = BrandLabel.getAll();
                                                    for (BrandLabel one : allLabel) {
                                                %>
                                                <option user_sender="<%=one.getUserOwner()%>" 
                                                        <%=(label.equals(one.getBrandLabel()) && one.getUserOwner().equals(userSender)) ? "selected='selected'" : ""%> 
                                                        value="<%=one.getId()%>" 
                                                        img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" ><%=one.getBrandLabel()%> [<%=one.getUserOwner()%>]</option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Tên gợi nhớ:</td>
                                        <td>
                                            <%
                                                ArrayList<Complain_title> allTitle = Complain_title.getAll();
                                                if (allTitle != null && !allTitle.isEmpty()) {
                                            %>
                                            <select id="_name_title" name="name" style="width: 350px">
                                                <option value="">--- Tất cả ---</option>
                                                <%
                                                    for (Complain_title oneT : allTitle) {
                                                %>
                                                <option value="<%=oneT.getTitle()%>"><%=oneT.getTitle()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <%
                                                }
                                                // Nha Cung Cap
                                                ArrayList<Provider> allPrv = Provider.getALL();
                                                if (allPrv != null && !allPrv.isEmpty()) {
                                            %>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            Hướng gửi:
                                            <select name="provider">
                                                <option value="">--- Tất cả ---</option>
                                                <%              for (Provider one : allPrv) {
                                                %>
                                                <option <%=(provider.equals(one.getCode())) ? "selected ='selected'" : ""%> value="<%=one.getCode()%>"><%=one.getName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <%
                                                }
                                            %>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Thống kê"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <input onclick="location.href = 'addNew.jsp'" class="button" type="button" name="button" value="Thêm mới"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <input onclick="location.href = '<%=request.getContextPath() + "/admin/complain_title/add.jsp"%>'" class="button" type="button" name="button" value="Thêm tên gợi nhớ"/>
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
                        <!--<table align="center" id="example" class="display" summary="Msc Joint Stock Company" >-->
                        <%@include file="/admin/includes/page.jsp" %>
                        <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company Bold"><b>STT</b></th>
                                    <th scope="col" class="rounded Bold"><b>Brand Name</b></th>
                                    <th scope="col" class="rounded Bold"><b>Điện thoại </b></th>
                                    <th scope="col" class="rounded Bold"><b>mạng</b></th>
                                    <th scope="col" class="rounded Bold"><b>Hướng gửi</b></th> 
                                    <th scope="col" class="rounded Bold"><b>Người khởi tạo</b></th>
                                    <th scope="col" class="rounded Bold"><b>Ngày</b></th>
                                    <th scope="col" class="rounded Bold"><b>Khiếu nại</b></th>
                                    <th scope="col" class="rounded Bold"><b>Kết quả gửi</b></th> 
                                    <th scope="col" class="rounded Bold">Trạng thái</th> 

                                    <%=buildHeader(request, userlogin, true, true)%>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    int total = 0;
                                    for (Iterator<Complain_log> iter = allLog.iterator(); iter.hasNext();) {
                                        Complain_log oneComplain = iter.next();
                                        int tmp = (currentPage - 1) * maxRow + count++;
                                %>
                                <tr>
                                    <td class="boder_right"><%=tmp%></td>
                                    <td class="boder_right" align="center">
                                        <%=oneComplain.getLabel()%>
                                    </td>
                                    <td class="boder_right" align="center" style="width: 100px">
                                        <%=oneComplain.getPhone()%>
                                    </td>
                                    <td class="boder_right" align="left"><%=oneComplain.getOper()%></td>
                                    <td class="boder_right" align="center"><%=oneComplain.getSend_to()%></td>
                                    <td class="boder_right" align="center"><%=oneComplain.getCreate_by()%></td>
                                    <td class="boder_right" align="center"><%=oneComplain.getCreate_date()%></td>
                                    <td class="boder_right" align="center"><%=oneComplain.getComplain()%></td>
                                    <td class="boder_right" align="left"><span  style="width: 250px" class="redBold"><%=oneComplain.getResult()%></span></td>
                                    <td class="boder_right" style="<%=buildStype(oneComplain.getStatus()) %>">
                                        <%=Complain_log.STATUS.getDesc(oneComplain.getStatus())%>
                                    </td>
                                    <%=buildControl(request, userlogin,
                                            "/admin/complain_log/edit.jsp?id=" + oneComplain.getId(),
                                            oneComplain.getStatus()!=2?"/admin/complain_log/del.jsp?id=" + oneComplain.getId():"#")%>
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
<%!    String buildStype(int status) {
        String str = "";
        if(status==0)
            str="font-weight: bold;color: red";
        if(status==1)
            str="font-weight: bold;color: #F78D1D";
        if(status==2)
            str="font-weight: bold;color: blue";
        return str;
    }
%>