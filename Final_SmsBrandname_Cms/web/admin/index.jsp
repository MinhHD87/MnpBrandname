<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head><% session.setAttribute("title", "Hệ thống quản trị SMS BRAND cms.brand1.xyz"); %>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <body>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="clear"></div>
                <div align="center" style="height: 20px;margin-top: 50px;color: red;font-weight: bold">
                    <%
                        if (session.getAttribute("mess") != null) {
                            out.print(session.getAttribute("mess"));
                            out.print("</br>"+request.getHeader("referer"));
                            session.removeAttribute("mess");
                        }%>
                </div>
            </div><!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html>