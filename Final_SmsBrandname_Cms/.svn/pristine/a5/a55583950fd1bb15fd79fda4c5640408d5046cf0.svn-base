<%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="java.io.File"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%>
<%
    int id = RequestTool.getInt(request, "bid");
    String fileName = RequestTool.getString(request, "f");
    File f = new File(MyContext.ROOT_DIR + BrandLabel.BRAND_FILE_UPLOAD + "/" + id + "/" + fileName);
    if (f.exists()) {
        f.delete();
        session.setAttribute("mess", "Xóa File thành công");
    }
    response.sendRedirect("/admin/brand/addDocument.jsp?bid=" + id);
%>