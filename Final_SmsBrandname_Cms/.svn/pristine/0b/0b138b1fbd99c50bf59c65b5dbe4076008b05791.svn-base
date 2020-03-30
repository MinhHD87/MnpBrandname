<%@page import="gk.myname.vn.admin.Account"%><%@page import="gk.myname.vn.entity.ResendEntity"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="org.apache.log4j.Logger"%><%@page contentType="text/html; charset=utf-8" %>
<%
     Account userlogin = Account.getAccount(session);
    final Logger logger = Logger.getLogger(page.getClass());
    if (!userlogin.checkEdit(request)) {
        session.setAttribute("mess", "Bạn không có quyền truy cập module này!");
        response.sendRedirect(request.getContextPath() + "/admin");
        return;
    }
    try {
        String type = RequestTool.getString(request, "type");
        String tid = RequestTool.getString(request, "tid");
        ResendEntity rDao = new ResendEntity();
        if (type.equals("cf")) {
            rDao.updateProcessList(tid);
        } else if (type.equals("del")) {
            rDao.delProcessList(tid);
        } else {
            // do Nothing
        }
    } catch (Exception ex) {
        logger.error(Tool.getLogMessage(ex));
    }
    out.print("1");
%>