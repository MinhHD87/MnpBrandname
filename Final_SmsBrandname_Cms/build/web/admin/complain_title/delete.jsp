<%@page import="gk.myname.vn.entity.Complain_title"%>
    Author     : MinhKudo
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Complain_title title = new Complain_title();
    if(title.delete(id)==true)
    {
        response.sendRedirect(request.getContextPath() + "/admin/complain_title/index.jsp");
    } else {
        response.sendRedirect(request.getContextPath() + "/admin/complain_title/index.jsp");
    }
%>