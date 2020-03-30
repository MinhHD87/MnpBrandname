<%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.entity.BrandLabel_Declare"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.admin.Account"%><%@page contentType="text/html; charset=utf-8" %>
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
        session.setAttribute("mess", "Bạn không có quyền truy cập module này!");
        response.sendRedirect(request.getContextPath() + "/admin/brand-declare/index.jsp");
        return;
    }
    String ip = request.getRemoteAddr();
    int id = Tool.string2Integer(request.getParameter("id"));
    BrandLabel_Declare brDao = new BrandLabel_Declare();
    try {
        //--------------------
        if (brDao.delForEver(id)) {
            session.setAttribute("mess", "Xóa Brand Name thành công");
        } else {
            session.setAttribute("mess", "Xóa Brand Name thật bại");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("mess", "Xóa Brand Name thật bại");
    }
    response.sendRedirect(request.getContextPath() + "/admin/brand-declare/index.jsp");
%>