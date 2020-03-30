<%@page import="gk.myname.vn.admin.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Account userlogin = Account.getAccount(session);
    if (userlogin == null) {
        out.print("<script>top.location='" + request.getContextPath() + "/admin/index.jsp';</script>");
        return;
    }
    session.removeAttribute("userlogin");
    session.invalidate();
    out.print("<script>top.location='" + request.getContextPath() + "/admin/index.jsp';</script>");
%>