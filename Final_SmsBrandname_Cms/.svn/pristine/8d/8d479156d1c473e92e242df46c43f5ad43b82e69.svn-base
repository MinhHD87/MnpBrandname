<%@page import="java.util.ArrayList"%>
<%@page import="gk.myname.vn.entity.PartnerManager"%>
<%@page import="gk.myname.vn.admin.Account"%>
<%@page import="gk.myname.vn.utils.Tool"%>
<%@page import="gk.myname.vn.entity.Email_tmp_config"%>
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
        session.setAttribute("mess", "Bạn không có quyền xoá module này!");
        response.sendRedirect(request.getContextPath() + "/admin//");
        return;
    }
    int id = Tool.string2Integer(request.getParameter("id"));
    Email_tmp_config Edao = new Email_tmp_config();
    Email_tmp_config e = Edao.getbyid(id);
    try {
        //--------------------
        if (e.del(id)) {
            session.setAttribute("mess", "Xóa dữ liệu thành công");
        } else {
            session.setAttribute("mess", "Xóa dữ liệu thật bại");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("mess", "Xóa dữ liệu thật bại");

    }
    response.sendRedirect(request.getContextPath() + "/admin/email_tmp_config/");
%>