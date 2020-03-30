<%-- 
    Document   : delete
    Created on : Oct 25, 2017, 4:02:03 PM
    Author     : MinhKudo
--%>

<%@page import="gk.myname.vn.entity.Subsidiary"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Subsidiary sub = new Subsidiary();
    if (sub.delete(id) == true) {
        response.sendRedirect(request.getContextPath() + "/admin/subsidiary/index.jsp");
    } else {
        response.sendRedirect(request.getContextPath() + "/admin/subsidiary/index.jsp");
    }
%>