<%@page import="gk.myname.vn.entity.UserAction"%>
<%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.admin.Account"%><%@page contentType="text/html; charset=utf-8" %>
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
    if (!userlogin.checkDel(request)) {
        session.setAttribute("mess", "Bạn không có quyền xoá module này!");
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
    String ip = request.getRemoteAddr();
    int id = Tool.string2Integer(request.getParameter("id"));
    Account adminDao = new Account();
    try {
        //--------------------
        Account oneAccount = adminDao.getByID(id);
        if (adminDao.delete(id)) {
            session.setAttribute("mess", "Xóa Admin thành công");
            //CongNX: Ghi log action vao db
            UserAction log = new UserAction(userlogin.getUserName(),
                        UserAction.TABLE.accounts.val,
                        UserAction.TYPE.DEL.val,
                        UserAction.RESULT.SUCCESS.val,
                        "user=" + oneAccount.getUserName());
            log.logAction(request);
            //CongNX: ket thuc ghi log db voi action thao tac tu web
            response.sendRedirect(request.getContextPath() + "/admin/account/index.jsp");
        } else {
            session.setAttribute("mess", "Xóa Admin thật bại");
            //CongNX: Ghi log action vao db
            UserAction log = new UserAction(userlogin.getUserName(),
                        UserAction.TABLE.accounts.val,
                        UserAction.TYPE.DEL.val,
                        UserAction.RESULT.FAIL.val,
                        "user=" + oneAccount.getUserName());
            log.logAction(request);
            //CongNX: ket thuc ghi log db voi action thao tac tu web
            response.sendRedirect(request.getContextPath() + "/admin/account/index.jsp");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("mess", "Xóa thật bại");
        //CongNX: Ghi log action vao db
        UserAction log = new UserAction(userlogin.getUserName(),
                    UserAction.TABLE.accounts.val,
                    UserAction.TYPE.DEL.val,
                    UserAction.RESULT.EXCEPTION.val,
                    "System error");
        log.logAction(request);
        //CongNX: ket thuc ghi log db voi action thao tac tu web
        response.sendRedirect(request.getContextPath() + "/admin/account/index.jsp");
    }
%>