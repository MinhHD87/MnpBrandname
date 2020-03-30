<%@page import="java.util.ArrayList"%>
<%@page import="gk.myname.vn.entity.PartnerManager"%>
<%@page import="gk.myname.vn.admin.Account"%>
<%@page import="gk.myname.vn.utils.Tool"%>
<%@page import="gk.myname.vn.entity.Complain_log"%>
<%@page contentType="text/html; charset=utf-8" %>   
<%    Account userlogin = Account.getAccount(session);
    if (userlogin == null) {
        session.setAttribute("mess", "Bạn không có quyên truy cập trang này");
    }
%>
<script type="text/javascript" language="javascript">
    alert('Bạn không có quyên truy cập trang này');
    parent.history.back();
</script>
<%
    if (!userlogin.checkDel(request)) {
        session.setAttribute("mess", "Bạn không có quyền sửa module này!");
        response.sendRedirect(request.getContextPath() + "/admin/complain_log/");
        return;
    }
    int id = Tool.string2Integer(request.getParameter("id"));
    Complain_log cldao = new Complain_log();
    Complain_log cl = cldao.getbyid(id);
//    if (userlogin.getUserName() != cl.getCreate_by()) {
//        session.setAttribute("mess", "Bạn không có quyền xóa dữ liệu");
//    }
    try {
        //--------------------
        if (cl.del(id)) {
            session.setAttribute("mess", "Xóa dữ liệu thành công");
        } else {
            session.setAttribute("mess", "Xóa dữ liệu thất bại");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("mess", "Xóa dữ liệu thất bại");

    }
    response.sendRedirect(request.getContextPath() + "/admin/complain_log/");
%>