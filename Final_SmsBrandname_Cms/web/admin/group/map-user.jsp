<%@page import="gk.myname.vn.admin.Permission"%><%@page import="gk.myname.vn.admin.GroupAccDetail"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="java.util.ArrayList"%><%@page contentType="text/html; charset=utf-8" %>
<%
    Account userlogin = Account.getAccount(session);
    if (userlogin == null) {
        session.setAttribute("error", "Bạn cần đăng nhập để truy cập hệ thống");
        out.print("<script>top.location='" + request.getContextPath() + "/admin/login.jsp';</script>");
        return;
    } else {
        System.out.println("Admin [Adv Link.vn] user: " + userlogin.getUserName() + "---" + DateProc.createTimestamp());
    }
    if (!userlogin.checkEdit(request)) {
        session.setAttribute("mess", "Bạn không có quyền truy cập trang này!");
        response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
        return;
    }
    int gid = RequestTool.getInt(request, "gid");
    int uid = RequestTool.getInt(request, "uid");
    GroupAccDetail gAdminDao = new GroupAccDetail();
    int[] tem = new int[1];
    tem[0] = gid;
    if (gAdminDao.create(uid, tem, userlogin.getAccID())) {
        Permission.updateUserRole(gid, uid);
        session.setAttribute("mess", "Thêm user vào nhóm thành công");
        response.sendRedirect(request.getContextPath() + "/admin/group/showAcc.jsp?id=" + gid);
        return;
    } else {
        session.setAttribute("mess", "Thêm user vào nhóm thất bại");
        response.sendRedirect(request.getContextPath() + "/admin/group/showAcc.jsp?id=" + gid);
    }
%>