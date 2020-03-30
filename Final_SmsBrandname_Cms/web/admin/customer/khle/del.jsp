<%@page import="gk.myname.vn.admin.Account"%>
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
        session.setAttribute("mess", "Bạn không có truy cập module này!");
        response.sendRedirect(request.getContextPath() + "/admin/customer/khle/index.jsp");
        return;
    }
    int id = Tool.string2Integer(request.getParameter("id"));
    Account adminDao = new Account();
    try {
        //--------------------
        if (adminDao.deleteBlock(id)) {
            session.setAttribute("mess", "Xóa tài khoản thành công");
            response.sendRedirect(request.getContextPath() + "/admin/customer/khle/index.jsp");
        } else {
            session.setAttribute("mess", "Xóa tài khoản thật bại");
            response.sendRedirect(request.getContextPath() + "/admin/customer/khle/index.jsp");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("mess", "Xóa tài khoản thật bại");
        response.sendRedirect(request.getContextPath() + "/admin/customer/khle/index.jsp");
    }
%>