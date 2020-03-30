<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.entity.AppConfig"%>
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
        response.sendRedirect(request.getContextPath() + "/admin/configApp");
        return;
    }

    int id = RequestTool.getInt(request, "id");
    AppConfig appConfigDao = new AppConfig();
    AppConfig appConfig = appConfigDao.getConfigById(id);
    try {
        //--------------------
        if (appConfigDao.deleteConfigById(id)) {
            session.setAttribute("mess", "Xóa CONFIG_KEY : " + appConfig.getConfig_key() + " thành công");
            response.sendRedirect(request.getContextPath() + "/admin/configApp");
        } else {
            session.setAttribute("mess", "Xóa CONFIG_KEY : " + appConfig.getConfig_key() + " thất bại");
            response.sendRedirect(request.getContextPath() + "/admin/configApp");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("mess", "Có lỗi xảy ra trong quá trình xóa CONFIG_KEY :  " + appConfig.getConfig_key() + ", xin vui lòng thử lại sau !");
        response.sendRedirect(request.getContextPath() + "/admin/configApp");
        System.out.println("Error when deleting configApp ! " + appConfig.getID());
    }
%>