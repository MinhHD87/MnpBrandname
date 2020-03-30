<%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="java.util.ArrayList"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page contentType="text/html; charset=utf-8" %>
<%    String user = RequestTool.getString(request, "user");   %>
<option img-data="" value="">******** Tất cả ********</option>
<%ArrayList<Account> allCp = Account.getAllCP(); for (Account oneAcc : allCp) {
        if (!Tool.checkNull(oneAcc.getUserName())) {%>
        <option img-data="<%=(oneAcc.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" <%=(user.equals(oneAcc.getUserName())) ? "selected ='selected'" : ""%> value="<%=oneAcc.getUserName()%>">[<%=oneAcc.getUserName()%>] <%=oneAcc.getFullName()%></option>
<%}
    }%>