<%@page import="gk.myname.vn.entity.BrandLabel"%>
<%@page import="gk.myname.vn.entity.ProviderLabelChange"%>
<%@page import="gk.myname.vn.entity.Provider"%>
<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.EmailConfigManager"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script type="text/javascript" language="javascript">
            $(document).ready(function () {
                $(".labelInHere").select2({
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
                        var opt = $(".labelInHere option:selected");
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
            $(document).ready(function () {
                $('.ask').jConfirmAction();
            });
        </script>
    </head>
    <body>
        <%  if (!userlogin.checkEdit(request)) {
                session.setAttribute("mess", "Bạn không có quyền sửa module này!");
                response.sendRedirect(request.getContextPath() + "/admin/provider/");
                return;
            }
            int id = RequestTool.getInt(request, "id");
            
            Provider oneProvi = new Provider();
            oneProvi = oneProvi.getbyId(id);
            ProviderLabelChange providerLabelChange = new ProviderLabelChange();
            ArrayList<ProviderLabelChange> plcs = providerLabelChange.findAllByProviderId(id);
            ArrayList<BrandLabel> allLabel = BrandLabel.getAll();
                                        
            if (id == 0 || oneProvi == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/provider/index.jsp");
                return;
            }
            
            if (request.getParameter("submit") != null) {
                int labelError = Tool.string2Integer(RequestTool.getString(request, "labelError"));
                int labelActive = Tool.string2Integer(RequestTool.getString(request, "labelActive"));
                
                if (labelError == 0 || labelActive == 0) {                        
                    session.setAttribute("mess", "Lỗi");
                    response.sendRedirect(request.getContextPath() + "/admin/provider/listChangeLabel.jsp?id=" + id);
                    return;
                }
                
                if (providerLabelChange.add(new ProviderLabelChange(id, labelError, labelActive))) {
                    session.setAttribute("mess", "Thành công");
                    response.sendRedirect(request.getContextPath() + "/admin/provider/listChangeLabel.jsp?id=" + id);
                    return;
                } else {
                    session.setAttribute("mess", "Lỗi");
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
                            <table align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th style="font-weight: bold"  scope="col" class="rounded redBoldUp">
                                            Thêm Label cần thay đổi khi gửi sang nhà cung cấp <i><%=oneProvi.getName()%></i>
                                        </th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td align="left"></td>
                                        <td align="left">Label khách hàng khai báo với công ty:</td>
                                        <td>
                                            <div>
                                                <!--<input size="50" value="" type="text" name="labelError"/>-->                                                
                                            </div>
                                            <div>
                                                <select style="width: 300px" class="labelInHere" id="labelError" name="labelError">
                                                    <option value="">Tất cả</option>
                                                    <%
                                                        for (BrandLabel one : allLabel) {
                                                    %>
                                                    <option value="<%=one.getId()%>" img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >
                                                        <%=one.getBrandLabel()%> [<%=one.getUserOwner()%>]
                                                    </option>
                                                    <%
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td align="left"></td>
                                        <td align="left">Label công ty khai báo với nhà cung cấp:</td>
                                        <td>
                                            <select style="width: 300px" class="labelInHere" id="labelActive" name="labelActive">
                                                <option value="">Tất cả</option>
                                                <%
                                                    for (BrandLabel one : allLabel) {
                                                %>
                                                <option value="<%=one.getId()%>" img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >
                                                    <%=one.getBrandLabel()%> [<%=one.getUserOwner()%>]
                                                </option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/provider/"%>'" type="reset" name="reset" value="Hủy"/>
                                        </td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                            <div align="center" style="height: 100px;margin-bottom: 2px; color: #00ccff;font-weight: bold">
                            </div>            
                            <div align="center" style="height: 20px;margin-bottom: 2px; color: #00ccff;font-weight: bold">
                                Danh sách Label cần thay đổi khi gửi sang nhà cung cấp <i><%=oneProvi.getName()%></i>
                            </div>            
                            <table align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded boder_right">Label Error</th>
                                        <th scope="col" class="rounded boder_right">Label Active</th>
                                        <th scope="col" class="rounded">Delete</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        for (ProviderLabelChange plc : plcs) {
                                    %>
                                    <tr>
                                        <td align="left"></td>
                                        <td align="left" class="boder_right"><%=plc.getBrandLabelError().getBrandLabel()%>[<%=plc.getBrandLabelError().getUserOwner()%>]</td>
                                        <td align="left" class="boder_right"><%=plc.getBrandLabelActive().getBrandLabel()%>[<%=plc.getBrandLabelActive().getUserOwner()%>]</td>
                                        <td align="left">
                                            <a title="Xóa" class="ask" href="<%=request.getContextPath() + "/admin/provider/delLabel.jsp?labelError=" + plc.getLabelError() + "&providerId=" + plc.getProviderId()%> ">
                                                <img width="24" src='<%=request.getContextPath() + "/admin/resource/images/remove.png"%>' title='Xóa' border='0' />
                                            </a>
                                        </td>
                                        <td align="left"></td>
                                    </tr>
                                    <% } %>
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