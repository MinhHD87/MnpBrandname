<%@page import="gk.myname.vn.entity.Provider"%><%@page import="java.util.ArrayList"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.admin.Account"%><%@page contentType="text/html; charset=utf-8" %>
<%
    request.setCharacterEncoding("utf-8");
    Account userlogin = Account.getAccount(session);
    if (userlogin == null) {
        session.setAttribute("error", "Bạn cần đăng nhập để truy cập hệ thống");
        out.print("<script>top.location='" + request.getContextPath() + "/admin/login.jsp';</script>");
        return;
    }
    int cpid = RequestTool.getInt(request, "cpid");
%>
<div style="margin-left: 30px;">
    <form id="uploadForm" name="uploadForm" action="<%=request.getContextPath() + "/admin/campaign/processReport.jsp"%>" method="post"  enctype="multipart/form-data">
        <table id="rounded-corner">
            <input type="hidden" name="cpid" value="<%=cpid%>" />
            <tr>
                <td style="text-align: center" colspan="2" class="redBoldUp">Upload File Kết quả</td>
            </tr>
            <tr>
                <td>Gửi đi </td>
                <td>
                    <select style="width: 300px" name="sento" id="providerCode">
                        <option value="">***** Chọn nhà cung cấp*****</option>
                        <%
                            ArrayList<Provider> allpro = Provider.getCACHE();
                            for (Provider one : allpro) {
                        %>
                        <option value="<%=one.getCode()%>" 
                                img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" ><%=one.getName()%> <%= one.getStatus() == 1 ? "" : "[LOCK]"%></option>
                        <%
                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Nhóm </td>
                <td>
                    <select id="group_brand" name="group">
                        <option value="0">Nhóm BRAND</option>
                        <option value="N1">Nhóm N1</option>
                        <option value="N2">Nhóm N2</option>
                        <option value="N3">Nhóm N3</option>
                        <option value="N4">Nhóm N4</option>
                        <option value="N5">Nhóm N5</option>
                        <option value="N6">Nhóm N6</option>
                        <option value="N7">Nhóm N7</option>
                        <option value="N8">Nhóm N8</option>
                    </select>
                    &nbsp;&nbsp;
                    Ngày Gửi:
                    <input readonly="" type="text" onfocus="dateForClick();" id="timeSearch" name="timeSearch"/>
                </td>
            </tr>
            <tr>
                <td>File Dữ Liệu</td>
                <td colspan="3">
                    <input type="file" onchange="fileUploadChoice(this)" class="fileUpload" id="fileUpload_<%=cpid%>" cpid="<%=cpid%>" name="fileUpload_<%=cpid%>" style="display: none" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel"/>
                    <input size="40" type="text" id="file_path_fake" readonly="true"/>
                    <input type="button" value="Chọn File" class="button" name="choiceFile" onclick="HandleBrowseClick('<%=cpid%>');"/>
                </td>
            </tr>
            <tr>
                <td colspan="4"  align="center"><input name="submit" onclick="uploadFile('<%=cpid%>')" class="button" type="button" value="Upload" /></td>
            </tr>
        </table>
    </form>
</div>