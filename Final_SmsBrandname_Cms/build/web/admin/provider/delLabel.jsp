<%@page import="gk.myname.vn.entity.ProviderLabelChange"%>
<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.entity.EmailConfigManager"%>
<%@page import="gk.myname.vn.utils.Tool"%>
<%@page import="gk.myname.vn.admin.Account"%>
<%@page contentType="text/html; charset=utf-8" %>
<%    
    Account userlogin = Account.getAccount(session);
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

    int providerid = RequestTool.getInt(request, "providerId");
    int labelError = RequestTool.getInt(request, "labelError");
    ProviderLabelChange plc = new ProviderLabelChange();

    if (!userlogin.checkDel(request)) {
        session.setAttribute("mess", "Bạn không có quyền xóa !");
        response.sendRedirect(request.getContextPath() + "/admin/provider/listChangeLabel.jsp?id=" + providerid);
        return;
    }

    try {
        if (plc.delete(providerid, labelError)) {
            session.setAttribute("mess", "Xóa thành công");
        response.sendRedirect(request.getContextPath() + "/admin/provider/listChangeLabel.jsp?id=" + providerid);
        } else {
            session.setAttribute("mess", "Xóa thất bại");
        response.sendRedirect(request.getContextPath() + "/admin/provider/listChangeLabel.jsp?id=" + providerid);
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        session.setAttribute("mess", "Có lỗi xảy ra trong quá trình xóa , xin vui lòng thử lại sau !");
        response.sendRedirect(request.getContextPath() + "/admin/provider/listChangeLabel.jsp?id=" + providerid);
    }
%>