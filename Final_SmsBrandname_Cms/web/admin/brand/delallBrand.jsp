<%@page import="gk.myname.vn.entity.UserAction"%>
<%@page import="gk.myname.vn.admin.Permission"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.admin.Account"%><%@page contentType="text/html; charset=utf-8" %>
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
    if (!userlogin.checkRight("/admin/brand/", Permission.PER.DEL.val)) {
        //CongNX: Ghi log action vao db
        UserAction log = new UserAction(userlogin.getUserName(),
                        UserAction.TABLE.brand_label.val,
                        UserAction.TYPE.DEL.val,
                        UserAction.RESULT.REJECT.val,
                        "Permit deny!");
        log.logAction(request);
        //CongNX: ket thuc ghi log db voi action thao tac tu web
        session.setAttribute("mess", "Bạn không có quyền truy cập module này!");
        response.sendRedirect(request.getContextPath() + "/admin/brand/index.jsp");
        return;
    }
    BrandLabel brDao = new BrandLabel();
//---
    String[] param = request.getParameterValues("chkmove");
    if (param != null && param.length > 0) {
        for (String one : param) {
            if (!Tool.checkNull(one)) {
                String[] arr = one.split("-");
                int id = Tool.string2Integer(arr[0]);
                BrandLabel oneBrand = brDao.getById(id);
                if (arr[1].equals("404")) {
                    if (brDao.delForEver(id)) {
                        //CongNX: Ghi log action vao db
                        UserAction log = new UserAction(userlogin.getUserName(),
                                        UserAction.TABLE.brand_label.val,
                                        UserAction.TYPE.DEL.val,
                                        UserAction.RESULT.SUCCESS.val,
                                        "Brandname= " + oneBrand.getBrandLabel());
                        log.logAction(request);
                        //CongNX: ket thuc ghi log db voi action thao tac tu web
                        session.setAttribute("mess", "Xóa Brand Name thành công");
                    } else {
                        //CongNX: Ghi log action vao db
                        UserAction log = new UserAction(userlogin.getUserName(),
                                        UserAction.TABLE.brand_label.val,
                                        UserAction.TYPE.DEL.val,
                                        UserAction.RESULT.FAIL.val,
                                        "Brandname= " + oneBrand.getBrandLabel());
                        log.logAction(request);
                        //CongNX: ket thuc ghi log db voi action thao tac tu web
                        session.setAttribute("mess", "Xóa Brand Name thật bại");
                    }
                } else {
                    if (brDao.delete(id)) {
                        //CongNX: Ghi log action vao db
                        UserAction log = new UserAction(userlogin.getUserName(),
                                        UserAction.TABLE.brand_label.val,
                                        UserAction.TYPE.DEL.val,
                                        UserAction.RESULT.SUCCESS.val,
                                        "Brandname= " + oneBrand.getBrandLabel());
                        log.logAction(request);
                        //CongNX: ket thuc ghi log db voi action thao tac tu web
                        session.setAttribute("mess", "Xóa Brand Name thành công");
                    } else {
                        //CongNX: Ghi log action vao db
                        UserAction log = new UserAction(userlogin.getUserName(),
                                        UserAction.TABLE.brand_label.val,
                                        UserAction.TYPE.DEL.val,
                                        UserAction.RESULT.FAIL.val,
                                        "Brandname= " + oneBrand.getBrandLabel());
                        log.logAction(request);
                        //CongNX: ket thuc ghi log db voi action thao tac tu web
                        session.setAttribute("mess", "Xóa Brand Name thật bại");
                    }
                }
            }
        }
    }
    response.sendRedirect(request.getContextPath() + "/admin/brand/index.jsp");
%>