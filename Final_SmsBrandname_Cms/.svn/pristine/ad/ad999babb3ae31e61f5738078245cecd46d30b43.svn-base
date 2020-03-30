<%@page import="gk.myname.vn.entity.Contract"%><%@page contentType="text/html; charset=utf-8" %><%@include file="/admin/includes/header.jsp" %><%@include file="/admin/includes/checkLogin.jsp" %>
<%    if (!userlogin.checkEdit(request)) {
        session.setAttribute("mess", "Bạn không có quyền sửa module này!");
        response.sendRedirect(request.getContextPath() + "/admin/contract/");
        return;
    } else {
        int subID = Integer.parseInt(request.getParameter("subid"));
        int partnerID = Integer.parseInt(request.getParameter("partnerid"));
        String contractNo = request.getParameter("contractno");
        Contract contract = new Contract();
        Contract contr = contract.getFile(subID, partnerID, contractNo);
%>
<object  data="<%=request.getContextPath()%>/upload/contract/<%=contr.getFile_path()%>" hspace="120" style="background-color: white;width: 80%;height:100% " ></object>
<%
    }
%>

