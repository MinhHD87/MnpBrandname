<%-- 
    Document   : newjsp
    Created on : Aug 25, 2016, 10:00:14 AM
    Author     : TUANPLA
--%>

<%@page import="gk.myname.vn.utils.DateProc"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <script language="JavaScript" type="text/javascript">
            function HandleBrowseClick()
            {
                var fileinput = document.getElementById("browse");
                fileinput.click();
            }
            function Handlechange()
            {
                var fileinput = document.getElementById("browse");
                var textinput = document.getElementById("filename");
                textinput.value = fileinput.value;
            }
        </script>
        <%
        String now = DateProc.createDDMMYYYY();
        %>
        <input type="file" id="browse" name="fileupload" style="display: none" onChange="Handlechange();"/>
        <input type="text" id="filename" readonly="true"/>
        <input type="button" value="Chọn file tải lên" id="fakeBrowse" onclick="HandleBrowseClick();"/>
    </body>
</html>
