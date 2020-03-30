<%@page import="java.util.ArrayList"%>
<%@page import="gk.myname.vn.entity.PartnerManager"%>
<%@page import="gk.myname.vn.admin.Account"%>
<%@page import="gk.myname.vn.utils.Tool"%>
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
        response.sendRedirect(request.getContextPath() + "/admin/partner-manager/");
        return;
    }
    int id = Tool.string2Integer(request.getParameter("id"));
    PartnerManager partnerDao = new PartnerManager();
    PartnerManager partner = partnerDao.getByID(id);
    if (partner != null) {
        // Kiem tra xem co dai ly con khong
        if (partner.hasChild()) {
            session.setAttribute("mess", "Bạn không thể xóa khách hàng này vì có đại lý con!");
            response.sendRedirect(request.getContextPath() + "/admin/partner-manager/");
            return;
        } else {
            // Neu khong co con kiem tra xem co tai khoan ko
            ArrayList<Account> subAcc = Account.getSubUserByCPCode(partner.getCode());
            if (subAcc != null && subAcc.size() > 0) {
                session.setAttribute("mess", "Bạn không thể xóa khách hàng này vì khách hàng có tài khoản sử dụng!");
                response.sendRedirect(request.getContextPath() + "/admin/partner-manager/");
                return;
            }
        }
    } else {
        session.setAttribute("mess", "Bạn không thể xóa khách hàng này vì không lấy được thông tin!");
        response.sendRedirect(request.getContextPath() + "/admin/partner-manager/");
        return;
    }
    try {
        //--------------------
        if (partnerDao.del_ever(id)) {
            session.setAttribute("mess", "Xóa dữ liệu thành công");
        } else {
            session.setAttribute("mess", "Xóa dữ liệu thật bại");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("mess", "Xóa dữ liệu thật bại");

    }
    response.sendRedirect(request.getContextPath() + "/admin/partner-manager/");
%>