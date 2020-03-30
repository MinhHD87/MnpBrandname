<%@page import="gk.myname.vn.entity.UserAction"%><%@page import="gk.myname.vn.admin.Account"%><%@page import="gk.myname.vn.utils.Tool"%><%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head><% session.setAttribute("title", "Hệ thống quản trị SMS BRAND cms.brand1.xyz"); %>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Đăng nhập quản trị hệ thống SMS BRAND</title>
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/admin/resource/css/style.css" />
        <script type="text/javascript" src="<%= request.getContextPath()%>/admin/resource/js/jquery-1.7.1.min.js"></script>
        <link rel="stylesheet" type="text/css" media="all" href="<%= request.getContextPath()%>/admin/resource/css/niceforms-default.css" />
        <script type = "text/javascript" >
            $(document).keypress(function (event) {
                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13') {
                    $("#submit").click();
                }
            });
        </script>
    </head>
    <%
        if (request.getParameter("submit") != null) {
            String username = Tool.validStringRequest(request.getParameter("user"));
            String pass = Tool.validStringRequest(request.getParameter("pass"));
            Account admin = new Account();
            admin = admin.checkLogin(username, pass);
            if (admin != null) {
                if (admin.getUserType() == Account.TYPE.ADMIN.val) {
                    session.setAttribute("userlogin", admin);
                    UserAction log = new UserAction(username,
                            UserAction.TABLE.accounts.val,
                            UserAction.TYPE.LOGIN.val,
                            UserAction.RESULT.SUCCESS.val,
                            "Đăng nhập thành công user:" + username);
                    log.logAction(request);
                    response.sendRedirect(request.getContextPath() + "/admin");
                    return;
                } else {
                    session.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng");
                }
            } else {
                session.setAttribute("error", "Tài khoản hoặc mật khẩu không đúng");
            }
        }
    %>
    <body>
        <div id="main_container">
            <div class="header_login">
                <div class="logo" style="margin-left: 200px"><a href="#"><img src="<%= request.getContextPath()%>/admin/resource/images/logo.png" alt="" title="" border="0" /></a></div>
            </div>
            <div class="login_form">
                <form action="" method="post" class="niceform">
                    <table style="margin-left: 0px;width: 100%" align="center">
                        <tr>
                            <td colspan="2" style="text-align: center;font-weight: bold;font-size: large" >Đăng nhập hệ thống</td>
                        </tr>
                        <tr>
                            <td style="color: red;text-align: center" colspan="2">
                                <%=(session.getAttribute("error") != null) ? "" + session.getAttribute("error") : ""%><%session.removeAttribute("error");%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                            <th style="text-align: center;width: 170px;margin-left: 15px">Tên đăng nhập:</th>
                            <td><input style="padding: 4px;border-radius: 3px 3px  3px  3px" type="text" value="" name="user" id="" size="40" /></td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                            <th style="text-align: center;width: 170px; ">Mật khẩu:</th>
                            <td><input style="padding: 4px;border-radius: 3px 3px  3px  3px" type="password" value="" name="pass" id="" size="40" /></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <input class="button" type="submit" name="submit" id="submit" value="Đăng nhập" />
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </body>
</html>