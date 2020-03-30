<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.entity.EmailConfigManager"%>
<%@page import="gk.myname.vn.utils.Tool"%>
<%@page import="gk.myname.vn.admin.Account"%>
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
        session.setAttribute("mess", "Bạn không có quyền xóa !");
        response.sendRedirect(request.getContextPath() + "/admin/email_manager");
        return;
    }

    int id = RequestTool.getInt(request, "id");
    EmailConfigManager appConfigDao = new EmailConfigManager();
    EmailConfigManager appConfig = appConfigDao.getConfigById(id);
    try {
        //--------------------
        if (appConfigDao.deleteConfigById(id)) {
            session.setAttribute("mess", "Xóa Email : " + appConfig.getEmail() + " thành công");
            response.sendRedirect(request.getContextPath() + "/admin/email_manager");
        } else {
            session.setAttribute("mess", "Xóa Email : " + appConfig.getEmail() + " thất bại");
            response.sendRedirect(request.getContextPath() + "/admin/email_manager");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("mess", "Có lỗi xảy ra trong quá trình xóa Email :  " + appConfig.getEmail() + ", xin vui lòng thử lại sau !");
        response.sendRedirect(request.getContextPath() + "/admin/email_manager");
    }
%>