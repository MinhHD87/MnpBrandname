<%@page import="gk.myname.vn.entity.IPManager"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="gk.myname.vn.utils.Tool"%>
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
        session.setAttribute("mess", "Bạn không có quyền truy cập trang này!");
        response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
        return;
    }
    int id = Tool.string2Integer(request.getParameter("id"));
    IPManager gDao = new IPManager();
    IPManager obj = gDao.getById(id);
    try {
        //--------------------
        if (obj == null) {
            session.setAttribute("mess", "Yêu cầu không hợp lệ");
        } else {
            if (gDao.delete(id)) {
                String result = gDao.executeRemoveIPCmd(obj.getIpRequest(), obj.getPortRequest());
                if ("success".equals(result.trim())) {
                    session.setAttribute("mess", "Xóa IP Firewall thành công");
                } else {
                    session.setAttribute("mess", "Xóa IP Firewall thật bại");
                }
            } else {
                session.setAttribute("mess", "Xóa IP DB thật bại");

            }
        }

    } catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("mess", "Xóa IP DB thật bại");
    } finally {
        response.sendRedirect(request.getContextPath() + "/admin/firewall-manager/index.jsp");
    }
%>