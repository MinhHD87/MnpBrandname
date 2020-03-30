<%@page import="gk.myname.vn.entity.KeysBlackList"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="gk.myname.vn.utils.Tool"%>
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
        session.setAttribute("mess", "Bạn không có quyền truy cập trang này!");
        response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
        return;
    }
    int id = Tool.string2Integer(request.getParameter("id"));
    KeysBlackList gDao = new KeysBlackList();
    try {
        //--------------------
        if (gDao.delete(id)) {
            session.setAttribute("mess", "Xóa Từ khóa Black List thành công");
            response.sendRedirect(request.getContextPath() + "/admin/key-blacklist/index.jsp");
        } else {
            session.setAttribute("mess", "Xóa khóa Black List thật bại");
            response.sendRedirect(request.getContextPath() + "/admin/key-blacklist/index.jsp");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("mess", "Xóa khóa Black List thật bại");
        response.sendRedirect(request.getContextPath() + "/admin/key-blacklist/index.jsp");
    }
%>