<%@page import="gk.myname.vn.entity.MsgBrandAds"%>
<%@page import="gk.myname.vn.entity.UserAction"%>
<%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.admin.Account"%><%@page contentType="text/html; charset=utf-8" %>
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
        //CongNX: Ghi log action vao db
        UserAction log = new UserAction(userlogin.getUserName(),
                            "MsgBrandAds",
                        UserAction.TYPE.DEL.val,
                        UserAction.RESULT.REJECT.val,
                        "Permit deny!");
        log.logAction(request);
        //CongNX: ket thuc ghi log db voi action thao tac tu web
        session.setAttribute("mess", "Bạn không có quyền truy cập module này!");
        response.sendRedirect(request.getContextPath() + "/admin/campaign/detail.jsp");
        return;
    }
    int id = Tool.string2Integer(request.getParameter("id"));
    MsgBrandAds msgBrandAds = new MsgBrandAds();
    try {
        MsgBrandAds mba = msgBrandAds.findById(id);
        if (mba.delForEver(id)) {
            //CongNX: Ghi log action vao db
            UserAction log = new UserAction(userlogin.getUserName(),
                            "MsgBrandAds",
                            UserAction.TYPE.DEL.val,
                            UserAction.RESULT.SUCCESS.val,
                            "MsgBrandAds= " + mba.toString());
            log.logAction(request);
            //CongNX: ket thuc ghi log db voi action thao tac tu web
            session.setAttribute("mess", "Xóa MsgBrandAds thành công");
            response.sendRedirect(request.getContextPath() + "/admin/campaign/detail.jsp");
        } else {
            //CongNX: Ghi log action vao db
            UserAction log = new UserAction(userlogin.getUserName(),
                            "MsgBrandAds",
                            UserAction.TYPE.DEL.val,
                            UserAction.RESULT.FAIL.val,
                            "MsgBrandAds= " + mba.toString());
            log.logAction(request);
            //CongNX: ket thuc ghi log db voi action thao tac tu web
            session.setAttribute("mess", "Xóa MsgBrandAds thật bại");
            response.sendRedirect(request.getContextPath() + "/admin/campaign/detail.jsps");
        }
    } catch (Exception ex) {
        //CongNX: Ghi log action vao db
        UserAction log = new UserAction(userlogin.getUserName(),
                            "MsgBrandAds",
                        UserAction.TYPE.DEL.val,
                        UserAction.RESULT.EXCEPTION.val,
                        "System error ");
        log.logAction(request);
        //CongNX: ket thuc ghi log db voi action thao tac tu web
        ex.printStackTrace();
        session.setAttribute("mess", "Xóa MsgBrandAds thật bại");
        response.sendRedirect(request.getContextPath() + "/admin/campaign/detail.jsp");
    }
%>