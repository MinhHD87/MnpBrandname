<%@page import="gk.myname.vn.entity.UserAction"%>
<%@page import="gk.myname.vn.admin.Account"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.admin.Permission"%><%@page contentType="text/html; charset=utf-8" %>
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
    if (!userlogin.checkRight("/admin/account/", Permission.PER.EDIT.val)) {
        session.setAttribute("mess", "Bạn không có quyền truy cập module này!");
        //CongNX: Ghi log action vao db
        UserAction log = new UserAction(userlogin.getUserName(),
                        UserAction.TABLE.accounts.val,
                        UserAction.TYPE.ADD.val,
                        UserAction.RESULT.REJECT.val,
                        "Permit deny!");
        log.logAction(request);
        //CongNX: ket thuc ghi log db voi action thao tac tu web
        response.sendRedirect(request.getContextPath() + "/admin/module/module.jsp");
        return;
    }
    int accId = RequestTool.getInt(request, "uid");
    String[] arrSpecial = request.getParameterValues("special");
    String[] arrView = request.getParameterValues("view");
    String[] shortView = request.getParameterValues("shortView");
    String[] arrAdd = request.getParameterValues("add");
    String[] arrEdit = request.getParameterValues("edit");
    String[] arrDel = request.getParameterValues("del");
    String[] upload = request.getParameterValues("upload");
    Permission perDao = new Permission();
    // Special
    if (arrSpecial != null && arrSpecial.length >= 0) {
        perDao.cleanUserRole(accId, Permission.PER.SPECIAL.val);
        perDao.mapUsertRole(arrSpecial, Permission.PER.SPECIAL.val);
    } else {
        perDao.cleanUserRole(accId, Permission.PER.SPECIAL.val);
    }
    // Xem
    if (arrView != null && arrView.length >= 0) {
        perDao.cleanUserRole(accId, Permission.PER.VIEW.val);
        perDao.mapUsertRole(arrView, Permission.PER.VIEW.val);
    } else {
        perDao.cleanUserRole(accId, Permission.PER.VIEW.val);
    }
    // Xem Ngan
    if (shortView != null && shortView.length >= 0) {
        perDao.cleanUserRole(accId, Permission.PER.VIEW_SHORT.val);
        perDao.mapUsertRole(shortView, Permission.PER.VIEW_SHORT.val);
    } else {
        perDao.cleanUserRole(accId, Permission.PER.VIEW_SHORT.val);
    }
    // Them
    if (arrAdd != null && arrAdd.length >= 0) {
        perDao.cleanUserRole(accId, Permission.PER.ADD.val);
        perDao.mapUsertRole(arrAdd, Permission.PER.ADD.val);
    } else {
        perDao.cleanUserRole(accId, Permission.PER.ADD.val);
    }
    // Sua
    if (arrEdit != null && arrEdit.length >= 0) {
        perDao.cleanUserRole(accId, Permission.PER.EDIT.val);
        perDao.mapUsertRole(arrEdit, Permission.PER.EDIT.val);
    } else {
        perDao.cleanUserRole(accId, Permission.PER.EDIT.val);
    }
    // Xoa
    if (arrDel != null && arrDel.length >= 0) {
        perDao.cleanUserRole(accId, Permission.PER.DEL.val);
        perDao.mapUsertRole(arrDel, Permission.PER.DEL.val);
    } else {
        perDao.cleanUserRole(accId, Permission.PER.DEL.val);
    }
    // Xoa
    if (upload != null && upload.length >= 0) {
        perDao.cleanUserRole(accId, Permission.PER.UPLOAD.val);
        perDao.mapUsertRole(upload, Permission.PER.UPLOAD.val);
    } else {
        perDao.cleanUserRole(accId, Permission.PER.UPLOAD.val);
    }
    //CongNX: Ghi log action vao db
    Account accDao = new Account();
    accDao = accDao.getByID(accId);
    UserAction log = new UserAction(userlogin.getUserName(),
                    UserAction.TABLE.user_permission.val,
                    UserAction.TYPE.EDIT.val,
                    UserAction.RESULT.SUCCESS.val,
                    "User= "+accDao.getUserName());
    log.logAction(request);
    //CongNX: ket thuc ghi log db voi action thao tac tu web
    session.setAttribute("mess", "Cấp quyền cho user thành công!");
    response.sendRedirect(request.getContextPath() + "/admin/account/role.jsp?id=" + accId);
%>