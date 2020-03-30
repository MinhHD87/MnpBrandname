<%-- 
    Document   : delete
    Created on : Oct 31, 2017, 10:24:22 PM
    Author     : MinhKudo
--%>

<%@page import="gk.myname.vn.entity.Contract"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int subID = Integer.parseInt(request.getParameter("subid"));
    int partnerID = Integer.parseInt(request.getParameter("partnerid"));
    String contractNo = request.getParameter("contractno");
    Contract contr = new Contract();
    if(contr.delete(subID, partnerID, contractNo)==true)
    {
        response.sendRedirect(request.getContextPath() + "/admin/contract/index.jsp");
    } else {
        response.sendRedirect(request.getContextPath() + "/admin/contract/index.jsp");
    }
%>
