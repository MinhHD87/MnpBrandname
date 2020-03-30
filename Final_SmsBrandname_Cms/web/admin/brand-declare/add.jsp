
<%@page import="gk.myname.vn.multipart.request.MultipartFile"%>
<%@page import="gk.myname.vn.multipart.request.HttpServletMultipartRequest"%>
<%@page import="gk.myname.vn.entity.DeclareOption"%>
<%@page import="gk.myname.vn.entity.BrandLabel_Declare"%>
<%@page import="gk.myname.vn.entity.OptionVina"%>
<%@page import="gk.myname.vn.entity.Provider"%>
<%@page import="gk.myname.vn.utils.DateProc"%>
<%@page import="gk.myname.vn.utils.SMSUtils"%>
<%@page import="gk.myname.vn.entity.OperProperties"%>
<%@page import="gk.myname.vn.entity.RouteTable"%>
<%@page import="gk.myname.vn.entity.OptionTelco"%>
<%@page import="gk.myname.vn.entity.BrandLabel"%>
<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.entity.RouteTable"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.io.InputStream"%>
<%@page import="gk.myname.vn.entity.BrandLabel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="gk.myname.vn.entity.PartnerManager"%>
<!DOCTYPE html><%@ page contentType="text/html; charset=utf-8" %>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <%  
            if (userlogin == null) {
                session.setAttribute("error", "Bạn cần đăng nhập để truy cập hệ thống");
                out.print("<script>top.location='" + request.getContextPath() + "/admin/login.jsp';</script>");
                return;
            }
        %>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/resource/css/jquery-ui-1.8.16.custom.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/admin/resource/css/jquery-ui-timepicker-addon.css" type="text/css" media="screen" />
        <link rel='stylesheet' href="<%=request.getContextPath()%>/admin/resource/dateTimeMaster/jquery.datetimepicker.css" type="text/css"/>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.core.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.position.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.widget.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.autocomplete.min.js"></script>
        <script src="<%= request.getContextPath()%>/admin/resource/js/bootstrap.min.js"></script> 
        <script src="<%= request.getContextPath()%>/admin/resource/js/jquery.uniform.js"></script> 
        <script type="text/javascript" src="<%= request.getContextPath()%>/admin/resource/js/jquery.blockUI.js"></script>
    </head>
    <body>
        <%  
            if (!userlogin.checkEdit(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập module này!");
                response.sendRedirect(request.getContextPath() + "/admin/brand/index.jsp");
                return;
            }
            
            String usersender = "";
            HttpServletMultipartRequest req = new HttpServletMultipartRequest(request);
            if (req.getParameter("submit") != null) {
                
//                MultipartFile file = req.getFileParameter("fileUpload");
//
//                    System.out.println(file);
//                    System.out.println(file);
//                    System.out.println(file);

                usersender = RequestTool.getString(req, "usersender");
                
                String label = RequestTool.getString(req, "label");
                
                int status = RequestTool.getInt(req, "status");
                
                boolean vte = RequestTool.getBoolean(req, "vte");
                boolean vms = RequestTool.getBoolean(req, "vms");
                boolean gpc = RequestTool.getBoolean(req, "gpc");
                boolean vnm = RequestTool.getBoolean(req, "vnm");
                boolean gtel = RequestTool.getBoolean(req, "gtel");
                //--
                boolean qc_vte = RequestTool.getBoolean(req, "qc_vte");
                boolean qc_vms = RequestTool.getBoolean(req, "qc_vms");
                boolean qc_gpc = RequestTool.getBoolean(req, "qc_gpc");
                boolean qc_vnm = RequestTool.getBoolean(req, "qc_vnm");
                boolean qc_gtel = RequestTool.getBoolean(req, "qc_gtel");
                RequestTool.debugParam(req);
                DeclareOption declareOp = new DeclareOption(vte, vms, gpc, vnm, gtel, qc_vte, qc_vms, qc_gpc, qc_vnm, qc_gtel);
                Account accSender = Account.getAccount(usersender);
                if (accSender == null) {
                    session.setAttribute("mess", "Không tìm thấy Account cần khai báo Brand trên hệ thống!");
                } else {
                    BrandLabel_Declare declareBr = new BrandLabel_Declare();
                    declareBr.setBrandLabel(label);
                    declareBr.setCp_code(accSender.getCpCode());
                    declareBr.setCreateBy(userlogin.getUserName());
                    declareBr.setStatus(status);
                    declareBr.setUserOwner(usersender);
                    declareBr.setDeclare(declareOp);
//                    if (file != null) {
//                        String ext = file.getExtentsion();
//                        String fileName = file.getName();
//                        String mimeType = getServletContext().getMimeType(fileName);
//                        if (validExtention(ext)) {
                            BrandLabel_Declare brDcl = new BrandLabel_Declare();
                            if (brDcl.addNewNotFile(declareBr)) {
                                session.setAttribute("mess", "Khai báo BRAND Thành công!");
                                response.sendRedirect(request.getContextPath() + "/admin/brand-declare/index.jsp");
                                return;
                            } else {                               
                                session.setAttribute("mess", "Khai báo Brand Thất bại!");
                            }
//                        } else {
//                            session.setAttribute("mess", "Yêu cầu không hợp lệ! Định dang file không cho phép!");
//                        }
//                    } else {
//                        session.setAttribute("mess", "Yêu cầu không hợp lệ. File tải lên không được tìm thấy!");
//                    }
                }
            }
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%  if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <form action="" method="post">
                            <table  align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" colspan="4" class="rounded-q4 redBoldUp">Add Brand Khai Báo</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Brand Name: </td>
                                        <td>
                                            <input value="" name="label" type="text" size="55" id="input_label_declare" class="text-input" autocomplete="off" />
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Cấp cho Account: </td>
                                        <td>
                                            <select class="select2 span5 select2" id="_userSender" name="usersender">
                                                    <option value="0">-- Chọn Tài khoản cần khai báo Brand --</option>
                                                    <% Account accDao = new Account();
                                                        ArrayList<Account> allAccSub = accDao.getKHAccount();
                                                        for (Account oneacc : allAccSub) {
                                                    %>
                                                    <option value="<%=oneacc.getUserName()%>">[<%=oneacc.getUserName()%>] <%=oneacc.getFullName()%></option>
                                                    <%}%>
                                                </select>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>QC</td>
                                        <td>
                                            <span style="width: 100px">VIETTEL</span>&nbsp;&nbsp;<input style="margin: -3px 0 0" onclick="checkBoxClick(this)" type="checkbox" name="qc_vte"/>&nbsp;&nbsp;
                                            <span style="width: 100px">MOBI FONE</span>&nbsp;&nbsp;<input style="margin: -3px 0 0" onclick="checkBoxClick(this)" value="0" type="checkbox" name="qc_vms"/>&nbsp;&nbsp;
                                            <span style="width: 100px">VINA PHONE</span>&nbsp;&nbsp;<input style="margin: -3px 0 0" onclick="checkBoxClick(this)" value="0" type="checkbox" name="qc_gpc"/>&nbsp;&nbsp;
                                            <span style="width: 100px">VIETNAMOBI</span>&nbsp;&nbsp;<input style="margin: -3px 0 0" onclick="checkBoxClick(this)" value="0" type="checkbox" name="qc_vnm"/>&nbsp;&nbsp;
                                            <span style="width: 100px">GTEL</span>&nbsp;&nbsp;<input style="margin: -3px 0 0" onclick="checkBoxClick(this)" value="0" type="checkbox" name="qc_gtel"/>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>CSKH</td>
                                        <td>                                            
                                            <span style="width: 100px">VIETTEL</span>&nbsp;&nbsp;<input style="margin: -3px 0 0" onclick="checkBoxClick(this)" type="checkbox" name="vte"/>&nbsp;&nbsp;
                                            <span style="width: 100px">MOBI FONE</span>&nbsp;&nbsp;<input style="margin: -3px 0 0" onclick="checkBoxClick(this)" value="0" type="checkbox" name="vms"/>&nbsp;&nbsp;
                                            <span style="width: 100px">VINA PHONE</span>&nbsp;&nbsp;<input style="margin: -3px 0 0" onclick="checkBoxClick(this)" value="0" type="checkbox" name="gpc"/>&nbsp;&nbsp;
                                            <span style="width: 100px">VIETNAMOBI</span>&nbsp;&nbsp;<input style="margin: -3px 0 0" onclick="checkBoxClick(this)" value="0" type="checkbox" name="vnm"/>&nbsp;&nbsp;
                                            <span style="width: 100px">GTEL</span>&nbsp;&nbsp;<input style="margin: -3px 0 0" onclick="checkBoxClick(this)" value="0" type="checkbox" name="gtel"/>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
<!--                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>  
                                            <input id="fileUpload" type="file" name="fileUpload" style="display: none" 
                                                   accept="application/pdf,image/jpeg,image/png,application/x-rar-compressed,application/rar,application/octet-stream,application/zip,application/octet-stream"/>
                                            <input class="text-input" size="50" type="text" id="file_full_path" readonly="true"/>
                                            <input class="btn btn-success" type="button" value="Chọn file tải lên" id="fakeBrowse" onclick="HandleBrowseClick();"/>
                                            &nbsp;&nbsp;<span style="color: red">(.rar &nbsp;.zip) Tối đa 10M</span>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>-->
                                    <tr>
                                        <td></td>
                                        <td>
                                            Trạng thái:
                                        </td>
                                        <td colspan="3">
                                            <select name="status">
                                                <option value="<%=BrandLabel.STATUS.WAIT.val %>">Chờ Khai Báo</option>
                                                <option value="<%=BrandLabel.STATUS.PROCESS.val %>">Đang khai báo</option>
                                                <option value="<%=BrandLabel.STATUS.REJECT.val %>">Từ chối</option>
                                                <option value="<%=BrandLabel.STATUS.ACTIVE.val %>">Đã Khai Báo</option>
                                            </select>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" align="center">
                                            <input id="submitData" class="button" name="submit" type="submit" value="Khai Báo" />
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/brand-declare/index.jsp"%>'" type="reset" name="reset" value="Hủy"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div><!-- end of right content-->
                </div>   <!--end of center content -->
                <div class="clear"></div>
            </div> <!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
            <script type="text/javascript" language="javascript">
                function HandleBrowseClick() {
                    var fileinput = document.getElementById("fileUpload");
                    fileinput.click();
                }
                $(document).ready(function () {
                    $('#fileUpload').change(function (event) {
                        var textinput = document.getElementById("file_full_path");
                        textinput.value = $("#fileUpload").val();
                        //this.files[0].size gets the size of your file.
                        var length = parseInt(this.files[0].size / 1024 / 1024);
                        if (length > 10) {
                            $("#file_length").text("~" + Math.round(length) + " Mb");
                            $("#file_length").attr("valid", 0);
                        } else {
                            $("#file_length").text("OK");
                            $("#file_length").attr("valid", 1);
                        }
                    });
                    $('.select2').select2();
                    if (isBlank($(".select2 option:selected").val()))
                        $('.select2').select2('val', '');
                });
                $(document).ready(function () {
                    $('#submitData').click(function () {
                        var opt = $("#_userSender option:selected");
                        if (opt.val() === 0) {
                            jAlert("Bạn chưa chọn tài khoản cần khai báo BRAND này");

                            return false;
                        }
                        var label = $("#input_label_declare").val();
                        if (label.length > 11 || label.length <= 0) {
                            $("#input_label_declare").addClass("valid-error");
                            jAlert("Bạn chưa nhập Nhãn Khai Báo hoặc Nhãn khai báo có chiều dài lớn hơn 11 ký tự.");
                            return false;
                        } else {
                            $("#input_label_declare").removeClass("valid-error");
                        }
                        if ($("#file_length").attr("valid") === 0) {
                            jAlert("File hồ sơ vượt quá dung lượng cho phép.");
                            return false;
                        }

                        var fileName = $("#file_full_path").val();
                        var extension = fileName.substr(fileName.lastIndexOf('.') + 1).toLowerCase();
                        var allowedExtensions = ['rar', 'zip'];
                        if (fileName.length > 0) {
                            if (allowedExtensions.indexOf(extension) === -1) {
                                jAlert('Định dạng file không cho phép. Chỉ đuôi ' + allowedExtensions.join(', ') + ' là được phép.');
                                return false;
                            }
                        } else {
                            jAlert('Chưa có hồ sơ nào được chọn.');
                            return false;
                        }
                    });
                });
            </script>
        </div>
    </body>
</html>
<%! String[] extention = {"rar", "zip"};

    public boolean validExtention(String ext) {
        boolean flag = false;
        try {
            for (String one : extention) {
                if (ext.equals(one.trim())) {
                    flag = true;
                    break;
                }
            }
        } catch (Exception e) {
        }
        return flag;
    }
%>