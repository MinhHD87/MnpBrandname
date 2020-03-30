<%@page import="org.apache.commons.lang.StringEscapeUtils"%>
<%@page import="gk.myname.vn.entity.MsgBrandRequest"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.utils.RequestTool"%>
<%@include file="/admin/includes/header.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%    int id = RequestTool.getInt(request, "id");
    String date = RequestTool.getString(request, "date");
    if (userlogin != null) {
        MsgBrandRequest branLogdao = new MsgBrandRequest();
        branLogdao = branLogdao.getById(id, date);
        if (branLogdao != null) {
%>
<table id="rounded-corner">
    <thead>
        <tr>
            <td colspan="4">Lịch sử MT</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="boder_right">Phone</td>
            <td class="boder_right"><%=branLogdao.getPhone()%></td>
            <td class="boder_right">Request Time:</td>
            <td><%=DateProc.Timestamp2DDMMYYYYHH24MiSS(branLogdao.getRequestTime())%></td>
        </tr>
        <tr>
            <td class="boder_right">Kết quả: </td>
            <td class="boder_right"><%=branLogdao.getResult()%>-(<%=branLogdao.getErrInfo()%>)</td>
            <td class="boder_right">Tổng SMS: </td>
            <td><%=branLogdao.getTotalSms()%></td>
        </tr>
        <tr>
            <td class="boder_right">TranId: </td>
            <td class="boder_right"><%=branLogdao.getTranId()%></td>
            <td class="boder_right">Sys ID: </td>
            <td><%=branLogdao.getSysId()%></td>
        </tr>
        <tr>
            <td class="boder_right">MT: </td>
            <td colspan="3"><%=StringEscapeUtils.escapeHtml(branLogdao.getMessage())%></td>
        </tr>
        <tr>
            <td class="boder_right">MT: </td>
            <td colspan="3"><textarea cols="55" rows="5"><%=StringEscapeUtils.escapeHtml(branLogdao.getMessage())%></textarea></td>
        </tr>
    </tbody>
</table>
<%
        } else {
            out.print("<h1>Message Not found!</h1>");
        }
    } else {
        out.print("<h1>User not Login...</h1>");
    }
%>
