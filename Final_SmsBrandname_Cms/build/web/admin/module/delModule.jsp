<%@page import="gk.myname.vn.admin.Account"%>
<%@page import="gk.myname.vn.admin.Modules"%>
<%@page import="gk.myname.vn.utils.Tool"%>
<%@page contentType="text/html; charset=utf-8" %>
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
        session.setAttribute("mess", "Bạn không có quyền xóa modul này!");
        response.sendRedirect(request.getContextPath() + "/admin/module/module.jsp");
        return;
    }
    int id = Tool.string2Integer(request.getParameter("id"));
    Modules gDao = new Modules();
    try {
        //--------------------
        if (gDao.del(id)) {
            session.setAttribute("mess", "Xóa Module thành công");
            response.sendRedirect("/admin/module/module.jsp");
        } else {
            session.setAttribute("mess", "Xóa Module thật bại");
            response.sendRedirect("/admin/module/module.jsp");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("mess", "Xóa Module thật bại");
        response.sendRedirect("/admin/module/module.jsp");
    }
%>