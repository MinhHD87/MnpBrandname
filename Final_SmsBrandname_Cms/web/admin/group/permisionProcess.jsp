<%@page import="gk.myname.vn.admin.Account"%><%@page import="gk.myname.vn.admin.Permission"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page contentType="text/html; charset=utf-8" %>
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
        session.setAttribute("mess", "Bạn không có quyền thực hiện thao tác này này!");
        response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
        return;
    }
    int gid = RequestTool.getInt(request, "gid");
    String[] arrSpecial = request.getParameterValues("special");
    String[] arrView = request.getParameterValues("view");
    String[] shortView = request.getParameterValues("shortView");
    String[] arrAdd = request.getParameterValues("add");
    String[] arrEdit = request.getParameterValues("edit");
    String[] arrDel = request.getParameterValues("del");
    String[] upload = request.getParameterValues("upload");
    Permission perDao = new Permission();
    // Special
    perDao.cleanRoleGroup(gid, Permission.PER.SPECIAL.val);
    perDao.mapRoleGroup(arrSpecial, Permission.PER.SPECIAL.val);
    // Xem
    perDao.cleanRoleGroup(gid, Permission.PER.VIEW.val);
    perDao.mapRoleGroup(arrView, Permission.PER.VIEW.val);
    // Xem
    perDao.cleanRoleGroup(gid, Permission.PER.VIEW_SHORT.val);
    perDao.mapRoleGroup(shortView, Permission.PER.VIEW_SHORT.val);
    // Them
    perDao.cleanRoleGroup(gid, Permission.PER.ADD.val);
    perDao.mapRoleGroup(arrAdd, Permission.PER.ADD.val);
    // Sua
    perDao.cleanRoleGroup(gid, Permission.PER.EDIT.val);
    perDao.mapRoleGroup(arrEdit, Permission.PER.EDIT.val);
    // Xoa
    perDao.cleanRoleGroup(gid, Permission.PER.DEL.val);
    perDao.mapRoleGroup(arrDel, Permission.PER.DEL.val);
    // Xoa
    perDao.cleanRoleGroup(gid, Permission.PER.UPLOAD.val);
    perDao.mapRoleGroup(upload, Permission.PER.UPLOAD.val);
    // Update User Role Of Group
    Permission.updateRoleUserOfGroup(gid);
    session.setAttribute("mess", "Phâm quyền cho nhóm thành công");
    response.sendRedirect(request.getContextPath() + "/admin/group/permission.jsp?id=" + gid);
%>