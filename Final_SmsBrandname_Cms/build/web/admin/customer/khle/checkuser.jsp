<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.admin.Account"%><%@page contentType="text/html; charset=utf-8" %><%
    Account userlogin = Account.getAccount(session);
    if (userlogin == null) {
        session.setAttribute("mess", "Bạn không có quyên truy cập trang này");
    }
    String user = RequestTool.getString(request, "user");
    Account userExist = Account.getAccount(user);
    if (userExist != null) {
        out.print("1");
    } else {
        out.print("0");
    }
%>