<%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="java.io.File"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.entity.Campaign"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script type="text/javascript" src="<%= request.getContextPath()%>/admin/resource/js/jquery.blockUI.js"></script>
    </head>
    <body>
        <%  //---         
            String campaignId = RequestTool.getString(request, "campaignId");
            String startTime = RequestTool.getString(request, "startTime");
            String startCal = RequestTool.getString(request, "startCal");
            //if (Tool.checkNull(startTime)) {
            //    startTime = DateProc.createDDMMYYYY_Start01();
            //}
            //if (Tool.checkNull(startCal)) {
            //    startCal = DateProc.createDDMMYYYY_Start01();
            //}
            String endTime = RequestTool.getString(request, "endTime");
            String endCal = RequestTool.getString(request, "endCal");
            int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
            if (currentPage < 1) {
                currentPage = 1;
            }
            String userSender = RequestTool.getString(request, "userSender");
            int status = RequestTool.getInt(request, "status", -2);
            Campaign gDao = new Campaign();
            ArrayList<Campaign> allCampaign = gDao.findByAll(currentPage, maxRow, campaignId, Campaign.TYPE.QC.val, "", startTime, endTime, startCal, endCal, status, userSender);
            int max = 20;
            int totalPage = 0;
            int totalRow = gDao.countByAll(campaignId, Campaign.TYPE.QC.val, "", startTime, endTime, startCal, endCal, status, userSender);
            totalPage = (int) totalRow / max;
            if (totalRow % max != 0) {
                totalPage++;
            }
        %>
        <div id="popup_content_edit" class="popup"></div>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <form action="<%=request.getContextPath() + "/admin/campaign/"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Tìm kiếm đơn hàng Quảng cáo</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td class="redBold">Mã Chiến dịch:</td>
                                        <td> 
                                            <input size="20" type="text" name="campaignId"/>
                                            &nbsp;<span class="redBold">Tạo từ ngày: </span>
                                            <input readonly  class="dateproc" value="<%=!Tool.checkNull(startTime) ? startTime : ""%>" size="10" id="stRequest" type="text" name="startTime"/>
                                            &nbsp;<span class="redBold">Đến </span>
                                            <input readonly class="dateproc" value="" size="10" id="endRequest" type="text" name="endTime"/>
                                            &nbsp;&nbsp;&nbsp;
                                            Trạng thái
                                            <select name="status">
                                                <option <%=status == -2 ? "selected='selected'" : ""%> value="-2">-Tất cả-</option>
                                                <option <%=status == 0 ? "selected='selected'" : ""%> value="0">Chờ duyệt</option>
                                                <option <%=status == 1 ? "selected='selected'" : ""%> value="1">Duyệt chờ gửi</option>
                                                <option <%=status == 2 ? "selected='selected'" : ""%> value="2">Đang gửi</option>
                                                <option <%=status == 3 ? "selected='selected'" : ""%> value="3">Đã gửi</option>
                                                <option <%=status == 4 ? "selected='selected'" : ""%> value="4">Từ chối</option>
                                            </select>
                                        </td>
                                    </tr>
<!--                                    <tr>
                                        <td></td>
                                        <td class="redBold">Tên chiến dịch:</td>
                                        <td> 
                                            <input size="20" type="text" name="name"/>
                                            &nbsp;<span class="redBold">Lịch gửi từ: </span>
                                            <input readonly  class="dateproc" value="<%=!Tool.checkNull(startCal) ? startCal : ""%>" size="10" id="stRequest" type="text" name="startCal"/>
                                            &nbsp;<span class="redBold">Đến </span>
                                            <input readonly class="dateproc" value="" size="10" id="endRequest" type="text" name="endCal"/>
                                            &nbsp;&nbsp;&nbsp;
                                            Trạng thái
                                            <select name="status">
                                                <option <%=status == -2 ? "selected='selected'" : ""%> value="-2">-Tất cả-</option>
                                                <option <%=status == 0 ? "selected='selected'" : ""%> value="0">Chờ duyệt</option>
                                                <option <%=status == 1 ? "selected='selected'" : ""%> value="1">Duyệt chờ gửi</option>
                                                <option <%=status == 2 ? "selected='selected'" : ""%> value="2">Đang gửi</option>
                                                <option <%=status == 3 ? "selected='selected'" : ""%> value="3">Đã gửi</option>
                                                <option <%=status == 4 ? "selected='selected'" : ""%> value="4">Từ chối</option>
                                            </select>
                                        </td>
                                    </tr>-->
                                    <tr>
                                        <td></td>
                                        <td>Tài khoản: </td>
                                        <td>
                                            <%
                                                // Lay ra Tai Khoản Dai Ly Hoac Quản Lý Cấp 1
                                                ArrayList<Account> allUser = Account.getAllCP();
                                            %>
                                            <select style="width: 350px" onchange="changeCP()" id="_userSender" name="userSender">
                                                <option value="">******** Tất cả ********</option>
                                                <%
                                                    for (Account oneUser : allUser) {
                                                %>
                                                <option user_sender="<%=oneUser.getAccID()%>" <%=(userSender.equals(oneUser.getUserName())) ? "selected ='selected'" : ""%> 
                                                        value="<%=oneUser.getUserName()%>" 
                                                        img-data="<%=(oneUser.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=oneUser.getUserName()%>] <%=oneUser.getFullName()%></option>
                                                <%}%>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Tìm kiếm"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <%--<%=buildAddControl(request, userlogin, "/admin/partner-manager/add.jsp")%>--%>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <b><a  style="color: red;" href="<%=request.getContextPath()%>/admin/campaign/example.xlsx">File Mẫu</a></b>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>  
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%   if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <!--Content-->
                        <%@include file="/admin/includes/page.jsp" %>
                        <form id="uploadForm" name="uploadForm">
                            <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded">User Gửi</th>
                                        <th scope="col" class="rounded">Mã Chiến Dịch</th>
                                        <th scope="col" class="rounded">Label</th>
                                        <th scope="col" class="rounded">Message</th>
                                        <th style="width: 150px" scope="col" class="rounded">Total SMS</th>
                                        <th scope="col" class="rounded">Ngày Tạo</th>
                                        <th scope="col" class="rounded">Ngày gửi</th>
                                        <th scope="col" class="rounded">Trạng thái</th>
                                        <th scope="col" class="rounded">Dữ liệu KH</th>
                                        <th scope="col" class="rounded">Fie Kết Quả</th>
                                        <th scope="col" class="rounded">Chi Tiết</th>
                                        <th scope="col" class="rounded">Edit</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%  //
                                        for (Iterator<Campaign> iter = allCampaign.iterator(); iter.hasNext();) {
                                            Campaign oneCP = iter.next();
                                    %>
                                    <tr>
                                        <td align="left" class="boder_right">
                                            <%=oneCP.getUserSender()%>
                                        </td>
                                        <td align="left" class="boder_right">
                                            <%=oneCP.getCampaignId()%>
                                        </td>
                                        <td align="left" class="boder_right">
                                            <%=oneCP.getLabel()%>
                                        </td>
                                        <td align="left" class="boder_right">
                                            <%= oneCP.getMessage()%>
                                        </td>
                                        <td align="left" class="boder_right redBold">
                                            <span style="color: red;font-weight: bold;float: left;width: 70px">Viettel: </span>
                                            <span style="color: blue;font-weight: bold;float: left;"><%=oneCP.getVteTTsms()%></span><br/>
                                            <span style="color: red;font-weight: bold;float: left;width: 70px">Mobi: </span>
                                            <span style="color: blue;font-weight: bold;float: left;"><%=oneCP.getMobiTTsms()%></span><br/>
                                            <span style="color: red;font-weight: bold;float: left;width: 70px">Vina: </span>
                                            <span style="color: blue;font-weight: bold;float: left;"><%=oneCP.getVinaTTsms()%></span><br/>
                                            <span style="color: red;font-weight: bold;float: left;width: 70px">VN Mobi: </span>
                                            <span style="color: blue;font-weight: bold;float: left;"><%=oneCP.getVnmTTsms()%></span><br/>
                                            <span style="color: red;font-weight: bold;float: left;width: 70px">Gtel </span>
                                            <span style="color: blue;font-weight: bold;float: left;"><%=oneCP.getBlTTsms()%></span>
                                        </td>
                                        <td class="boder_right"><%=DateProc.Timestamp2DDMMYYYYHH24Mi(oneCP.getCreateDate())%></td>
                                        <td class="boder_right"><%=DateProc.Timestamp2DDMMYYYYHH24Mi(oneCP.getEndTime())%></td>                                        
                                        <td align="center" class="boder_right">
                                            <%
                                                if (oneCP.notapproved()) {
                                            %>
                                            <img width="64px" src="<%= request.getContextPath()%>/admin/resource/images/notapproved.png"/><br/>Khách chưa duyệt
                                            <%
                                            } else if (oneCP.getStatus() == 1) {
                                            %>
                                            <img src="<%= request.getContextPath()%>/admin/resource/images/active.png"/><br/>(Đã đuyệt)
                                            <%
                                            } else if (oneCP.getStatus() == 2) {
                                            %>
                                            <img width="32px" src="<%= request.getContextPath()%>/admin/resource/images/sending.png"/><br/>(Đang gửi)
                                            <%} else if (oneCP.getStatus() == 3) {
                                            %>
                                            <img width="32px" src="<%= request.getContextPath()%>/admin/resource/images/sended.png"/><br/>(Đã gửi)
                                            <%} else if (oneCP.getStatus() == 4) {
                                            %><img width="32px" title="từ chối" src="<%= request.getContextPath()%>/admin/resource/images/cancel.png"/>
                                            <%
                                                }%>
                                        </td>
                                        <td class="boder_right">
                                            <%  File f = new File("/data/webroot/upload/campaign/advertisement/" + oneCP.getId() + "-" + oneCP.getCampaignId() + ".xlsx");
                                                if (!oneCP.notapproved() && f.exists()) {
                                            %>
                                            <a target="_blank" href="<%=request.getContextPath() + "/DownloadCamPaign?cpid=" + oneCP.getId()%>">
                                                <img width="32px" src="/admin/resource/images/Downloads.png" alt="" title="Tải về" border="0">
                                            </a>
                                            <%}%>
                                        </td>
                                        <td class="boder_right">
                                            <% if (!oneCP.notapproved()) {                                                    
                                                    String pathFileResult = MyContext.ROOT_DIR + "/upload/campaign/result/";
                                                    File f1 = new File(pathFileResult + oneCP.getId() + ".xls");
                                                    File f2 = new File(pathFileResult + oneCP.getId() + ".xlsx");
                                                    if (f1.exists() || f2.exists()) {%>
                                            <img width="32px" src="<%=webPath%>/admin/resource/images/uploaded.png" alt="Đã tải lên" title="Đã tải lên" border="0">Đã tải lên
                                            <%} else {%>
                                            <a class="ItemPopup" 
                                               url-data="<%=request.getContextPath() + "/admin/campaign/uploadResult.jsp?cpid=" + oneCP.getId()%>" href="#popup_content_edit" id="open_popup_edit" name="open_popup">
                                                <img width="32px" src="<%=webPath%>/admin/resource/images/wp_upload.png" alt="Chọn file tải lên" title="Chọn file tải lên" border="0"><br/>Tải lên
                                            </a>
                                            <%}
                                                }%>
                                        </td>
                                        <td class="boder_right">
                                            <% if(oneCP.isSended()){%>
                                            <a href="detail.jsp?campaignId=<%=oneCP.getCampaignId()%>"><img width="32px" src="<%=webPath%>/admin/resource/images/view.png" alt="" title="Chi Tiết" border="0"></a>
                                            <%}%>
                                        </td>
                                        <td>
                                            <%if (oneCP.getStatus() != 3 && oneCP.getStatus() != 0) {%>
                                            <a class="ItemPopup" 
                                               url-data="<%=request.getContextPath() + "/admin/campaign/editForm.jsp?cid=" + oneCP.getId()%>" href="#popup_content_edit" id="open_popup_edit" name="open_popup">
                                                <img width="32px" src="<%=webPath%>/admin/resource/images/user_edit.png" alt="" title="Sửa" border="0">
                                            </a>
                                            <%}%>
                                        </td>
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
        <script type="text/javascript">
            function HandleBrowseClick(elmId) {
                var fileinput = document.getElementById("fileUpload_" + elmId);
                fileinput.click();
            }
            function fileUploadChoice(elm) {
                var cpid = $(elm).attr('cpid');
                var textinput = document.getElementById("file_path_fake");
                textinput.value = $("#fileUpload_" + cpid).val();
            }
            function uploadFile(cpid) {
                var sendto = $("#providerCode option:selected").val();
                if (isBlank(sendto)) {
                    jAlert('Bạn chưa chọn nhà cung cấp gửi tin');
                    return;
                }
                var group = $("#group_brand option:selected").val();
                if (group == 0) {
                    jAlert('Bạn chưa chọn nhóm Brand');
                    return;
                }
                if (isBlank($("#timeSearch").val())) {
                    jAlert('Bạn chưa chọn ngày bạn gửi đơn hàng');
                    return;
                }
                var file = $("#fileUpload_" + cpid).val();
                if (file == null || file == "" || file == 'undefine') {
                    jAlert("Bạn cần chọn một file trước khi upload dữ liệu");
                    return;
                }
                jConfirm('Bạn chắc chắn đây là file kết quả của chiến dịch này\n\n<span style="color:red;font-weight: bold">Upload kết quả lên?<span>', 'Confirm', function (r) {
                    if (r) {
                        $.blockUI({message: '<h1><img src="<%=request.getContextPath()%>/admin/resource/images/busy.gif" />Chúng tôi đang xử lý yêu cầu của bạn<br/> \n\
                                    <span style="color:red;font-weight: bold">Xin hãy kiên nhẫn ...<span></h1>'});
                        doWork(cpid, sendto, group);
                    } else {
                        jAlert('Bạn cần chắc chắn trước khi trả kết quả đơn hàng');
                    }
                });
            }
            // unblock when ajax activity stops 
            $(document).ajaxStop($.unblockUI);
            function doWork(cpid, sendto, group) {
                var data = new FormData($("form#uploadForm")[0]);
                jQuery.each(jQuery('.fileUpload')[0].files, function (i, file) {
                    data.append('file-' + i, file);
                });
                jQuery.ajax({
                    url: '<%=request.getContextPath()%>/admin/campaign/processReport.jsp?cpid=' + cpid + '&sento=' + sendto + '&group=' + group,
                    data: data,
                    cache: false,
                    contentType: false,
                    processData: false,
                    type: 'POST',
                    timeout: 10 * 60 * 1000,
                    success: function (data) {
                        if (data == 1) {
                            
                        } else {
                            jAlert('Upload result OK ?' + data);
                            <% session.setAttribute("mess", "Up dữ liệu thành công"); %>
                            window.location = '<%=request.getContextPath()%>/admin/campaign/index.jsp';
                        }
                    }
                });
            }
            $(document).ready(function () {
                $('.dateproc').datetimepicker({
                    lang: 'vi',
                    timepicker: false,
                    format: 'd/m/Y',
                    formatDate: 'Y/m/d',
                    minDate: '2017/01/01', // yesterday is minimum date
//                    maxDate: '+1970/01/02' // and tommorow is maximum date calendar
                });
            });
            $(document).ready(function () {
                $('.ItemPopup').showPopup({
                    top: 100,
                    closeButton: ".close_popup", //khai báo nút close cho popup
                    scroll: 0, //cho phép scroll khi mở popup, mặc định là không cho phép
                    width: 600,
                    height: 'auto',
                    closeOnEscape: true
                });
            });
            function dateForClick() {
                $('#timeSearch').datetimepicker({
                    lang: 'vi',
                    timepicker: false,
                    format: 'd/m/Y',
                    formatDate: 'Y/m/d',
                    minDate: '2017/01/01', // yesterday is minimum date
                    maxDate: '<%=DateProc.Timestamp2YYYYMMDD(DateProc.createTimestamp())%>' // and tommorow is maximum date calendar
                });
            }
        </script>
    </body>
</html>