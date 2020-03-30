<%@page import="gk.myname.vn.utils.Tool"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%String host = request.getHeader("host");
            if (!Tool.checkNull(host) && host.contains("tpcoms.net")) {
                response.sendRedirect("http://myname.vn/dang-nhap.htm");
            }
        %>
        <h1 style="text-align: center">Domain is Block</h1>
        <h1 style="text-align: center">Come Back to <a href="http://myname.vn/dang-nhap.htm">Myname.vn</a></h1>
    </body>
</html>
