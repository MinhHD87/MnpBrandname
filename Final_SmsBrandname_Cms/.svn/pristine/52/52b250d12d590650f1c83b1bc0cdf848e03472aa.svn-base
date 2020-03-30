<%@page import="gk.myname.vn.config.MyContext"%><%@page import="java.io.File"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script type="text/javascript" src="<%= request.getContextPath()%>/admin/resource/js/jquery.blockUI.js"></script>
    </head>
    <script type="text/javascript" language="javascript">
        function HandleBrowseClick() {
            var fileinput = document.getElementById("fileUpload");
            fileinput.click();
        }
        $(document).ready(function () {
            $('#fileUpload').change(function (event) {
                var textinput = document.getElementById("file_full_path");
                textinput.value = $("#fileUpload").val();
            });
        });
        // unblock when ajax activity stops 
        $(document).ajaxStop($.unblockUI);
        function doWork() {
            var data = new FormData($("form#uploadForm")[0]);
            jQuery.each(jQuery('#fileUpload')[0].files, function (i, file) {
                data.append('file-' + i, file);
            });
            jQuery.ajax({
                url: '<%=request.getContextPath()%>/admin/partner-manager/addDocument.jsp',
                data: data,
                cache: false,
                contentType: false,
                processData: false,
                type: 'POST',
                timeout: 10 * 60 * 1000,
                success: function (data) {
                    $("#infoProcess").html(data);
                }
            });
        }
        $(document).ready(function () {
            $('#uploadata').click(function () {
                $.blockUI({message: '<h1><img src="<%=request.getContextPath()%>/admin/resource/images/busy.gif" /> We are processing your request.  Please be patient....</h1>'});
                doWork();
            });
        });
    </script>
    <body>
        <%
            int pid = RequestTool.getInt(request, "pid");
            PartnerManager partner = PartnerManager.getCacheById(pid);
            if (partner == null) {
                session.setAttribute("mess", "Yêu câu không hợp lệ");
                response.sendRedirect(webPath + "/admin/partner-manager/");
                return;
            }
            File dirContract = new File(MyContext.ROOT_DIR + "/upload/contract/" + partner.getCode().toLowerCase() + "-" + partner.getId());
            File[] listFile = null;
            if (!dirContract.exists()) {
                dirContract.mkdirs();
            } else {
                listFile = dirContract.listFiles();
            }
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <form id="uploadForm" name="frmSend" enctype="multipart/form-data" action="" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Quản lý hợp đồng của: <span style="color: blue;font-weight: bold">[<%=partner.getName()%>]</span></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td class="redBold">File Hợp đồng:</td>
                                        <td> 
                                            <input type="hidden" name="pid" value="<%=pid%>"/>
                                            <input type="file" id="fileUpload" name="fileUpload" style="display: none" 
                                                   accept="application/pdf,image/jpeg,image/png,application/x-rar-compressed,application/rar,application/octet-stream,application/zip,application/octet-stream"/>
                                            <input size="50" type="text" id="file_full_path" readonly="true"/>
                                            <input type="button" value="Chọn file tải lên" id="fakeBrowse" onclick="HandleBrowseClick();"/>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="button" name="submit" id="uploadata" value="Tải lên"/>
                                            <input class="button" type="button" name="submit" onclick="location.href = '<%=webPath + "/admin/partner-manager/"%>'" value="Quay lại"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>  
                        <div id="infoProcess" align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
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
                                    <th scope="col" class="rounded">Tên Công ty</th>
                                    <th scope="col" class="rounded">File</th>
                                    <th scope="col" class="rounded">Tải về</th>
                                    <th scope="col" class="rounded">Xóa</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  int i = 1;
                                    if (listFile != null && listFile.length > 0) {
                                        for (File oneF : listFile) {
                                %>
                                <tr>
                                    <td class="boder_right"><%=i++%></td>
                                    <td align="left" class="boder_right">
                                        <%=partner.getName()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=oneF.getName()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <a href="<%=webPath + "/upload/contract/"+ partner.getCode().toLowerCase() + "-" + partner.getId()+"/" + oneF.getName()%>" style="text-decoration: none;">
                                            <img src="/resources/images/taive.png" width="36px"/>
                                        </a>
                                    </td>
                                    <%=buildControl(request, userlogin,
                                                null,
                                                "#")%>
                                </tr>
                                <%}
                                } else {
                                %>
                                <tr>
                                    <td colspan="4" class="redBold">Chưa có tài liệu nào được tải lên</td></tr>
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