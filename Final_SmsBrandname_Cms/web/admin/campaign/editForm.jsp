<%@page import="gk.myname.vn.admin.Account"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="java.io.File"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.entity.Campaign"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page contentType="text/html; charset=utf-8" %>
<%  request.setCharacterEncoding("utf-8");
    Account userlogin = Account.getAccount(session);
    if (userlogin == null) {
        session.setAttribute("error", "Bạn cần đăng nhập để truy cập hệ thống");
        out.print("<script>top.location='" + request.getContextPath() + "/admin/login.jsp';</script>");
        return;
    }
    int cid = RequestTool.getInt(request, "cid");
    RequestTool.debugParam(request);
    Campaign cpDao = new Campaign();
    cpDao = cpDao.findById(cid);
    if (request.getParameter("submit") != null) {
        int status = RequestTool.getInt(request, "status");
        String reason = RequestTool.getString(request, "reason");
        if (cpDao.confirm(cid, status, reason)) {
            session.setAttribute("mess", "Cập nhật chiến dịch thành công");
        } else {
            session.setAttribute("mess", "Cập nhật chiến dịch thất bại");
        }
        response.sendRedirect(request.getContextPath() + "/admin/campaign/index.jsp");
        return;
    }
%>
<div style="margin-left: 20px; margin-right: 20px">
    <form action="<%=request.getContextPath() + "/admin/campaign/editForm.jsp"%>" method="post">
        <table id="rounded-corner">
            <input type="hidden" name="cid" value="<%=cid%>" />
            <tr>
                <td>CAMPAIGN ID: </td>
                <td><input size="20" type="text" readonly="" value="<%=cpDao.getCampaignId()%>"/></td>
                <td>LABEL: </td>
                <td><input size="20" type="text" readonly="" value="<%=cpDao.getLabel()%>"/></td>
            </tr>
            <tr>
                <td>TIME SEND: </td>
                <td><input size="20" type="text" readonly="" value="<%=DateProc.Timestamp2DDMMYYYYHH24Mi(cpDao.getEndTime())%>"/></td>
                <td>Trạng Thái:</td>
                <td>
                    <select name="status">
                        <option <%=cpDao.getStatus() == 1 ? "selected='selected'" : ""%> value="1">Đã duyệt Chờ gửi</option>
                        <option <%=cpDao.getStatus() == 2 ? "selected='selected'" : ""%> value="2">Đang gửi ==> </option>
                        <option <%=cpDao.getStatus() == 3 ? "selected='selected'" : ""%> value="3">==> Đã gửi</option>
                        <option <%=cpDao.getStatus() == 4 ? "selected='selected'" : ""%> value="4">Từ Chối</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Lý do từ chối</td>
                <td colspan="3"><textarea name="reason" style="width: 90%"><%=cpDao.getReason()%></textarea></td>
            </tr>
            <tr>
                <td>File Kết quả:</td>
                <td colspan="3">
                    <%  File f1 = new File("/data/webroot/upload/campaign/result/" + cpDao.getId() + ".xls");
                        File f2 = new File("/data/webroot/upload/campaign/result/" + cpDao.getId() + ".xlsx");
                        if (f1.exists() || f2.exists()) {%>
                    <img width="32px" src="<%=request.getContextPath()%>/admin/resource/images/uploaded.png" alt="Đã tải lên" title="Đã tải lên" border="0"> (Đã tải lên)
                    <%} else {%>
                    <span class="redBold">Chưa tải lên</span>
                    <%}%>
                </td>
            </tr>
            <tr>
                <td colspan="4"  align="center"><input name="submit" class="button" type="submit" value="Cập nhật" /></td>
            </tr>
        </table>
    </form>
</div>