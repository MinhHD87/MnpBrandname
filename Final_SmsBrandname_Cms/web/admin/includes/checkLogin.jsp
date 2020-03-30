<%@page import="gk.myname.vn.utils.StringUtil"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.entity.Money_info"%><%@page import="java.util.ArrayList"%><%@page import="gk.myname.vn.admin.Account"%>
<%@page contentType="text/html; charset=utf-8" %>
<%
    //  Account userlogin = Account.getAccount(session);
    try {
        if (userlogin == null) {
            session.setAttribute("error", "Bạn cần đăng nhập để truy cập hệ thống");
            out.print("<script>top.location='" + request.getContextPath() + "/admin/login.jsp';</script>");
            return;
        }
    } catch (Exception ex) {
        System.out.println("Vao Exception CheckLogin:" + ex.getMessage());
        out.print("<script>top.location='" + request.getContextPath() + "/login.jsp';</script>");
        return;
    }
%>
<div class="header">
    <div class="logo"><a href="#"><img src="<%= request.getContextPath()%>/admin/resource/images/logo.png" alt="" title="" border="0" /></a></div>
    
    <div class="right_header">Welcome: <a href="<%=request.getContextPath()%>/admin/changepass.jsp"><b><%=(userlogin.getUserName() != null) ? userlogin.getUserName() : ""%></b></a> | <a href="<%= request.getContextPath()%>/admin/out.jsp" class="logout">Thoát</a></div>
    <div id="clock_a"></div>
</div>
