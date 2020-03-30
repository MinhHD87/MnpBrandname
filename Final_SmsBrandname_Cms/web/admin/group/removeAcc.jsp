<%@page import="gk.myname.vn.admin.Account"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.admin.Permission"%><%@page import="gk.myname.vn.admin.GroupAccDetail"%><%@page contentType="text/html; charset=utf-8" %>
<%    Account userlogin = Account.getAccount(session);
    if (userlogin == null) {
        session.setAttribute("mess", "Bạn không có quyên truy cập trang này");
%>
<script type="text/javascript" language="javascript">
    alert('Bạn không có quyên truy cập trang này');
    parent.history.back();
</script>
<%
        return;
    }
    if (!userlogin.checkEdit(request)) {
        session.setAttribute("mess", "Bạn không có quyền truy cập trang này!");
        response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
        return;
    }
    int uid = RequestTool.getInt(request, "uid");
    int gid = RequestTool.getInt(request, "gid");
    GroupAccDetail gDetail = new GroupAccDetail();
    if (gDetail.removeAcc(gid, uid)) {
        Permission.removeUserRole(gid, uid);
        session.setAttribute("mess", "Xóa Tài khoản khỏi nhóm thành Công!");
        response.sendRedirect(request.getContextPath() + "/admin/group/showAcc.jsp?id=" + gid);
        return;
    } else {
        session.setAttribute("mess", "Xóa Tài khoản khỏi nhóm thất bại!");
        response.sendRedirect(request.getContextPath() + "/admin/group/showAcc.jsp?id=" + gid);
    }
%>
