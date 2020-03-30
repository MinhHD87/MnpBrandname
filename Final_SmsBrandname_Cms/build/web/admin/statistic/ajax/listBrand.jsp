<%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="java.util.ArrayList"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page contentType="text/html; charset=utf-8" %>
<%    String user = RequestTool.getString(request, "user");
    if (!Tool.checkNull(user) && !user.equals("0")) {
%><option brand_id="" user_owner="" value="" img-data="">******** Tất cả ********</option><%ArrayList<BrandLabel> allLabel = BrandLabel.getBrandBy(user);
    for (BrandLabel one : allLabel) {%><option brand_id="<%=one.getId()%>" user_owner="<%=one.getUserOwner()%>" value="<%=one.getId()%>" img-data="<%=(one.getStatus() == 1?"":"/admin/resource/images/lock1.png")%>">
        <%=one.getBrandLabel()%> [<%=one.getUserOwner()%>]</option>
<%}
} else {
%><option brand_id="" user_owner="" value="" img-data="">******** Tất cả ********</option><%
    ArrayList<BrandLabel> allLabel = BrandLabel.getAll();
    for (BrandLabel one : allLabel) {%>
<option brand_id="<%=one.getId()%>" user_owner="<%=one.getUserOwner()%>" value="<%=one.getId()%>" img-data="<%=(one.getStatus() == 1?"":"/admin/resource/images/lock1.png")%>">
    <%=one.getBrandLabel()%>  [<%=one.getUserOwner()%>]</option>
<%}
    }%>
