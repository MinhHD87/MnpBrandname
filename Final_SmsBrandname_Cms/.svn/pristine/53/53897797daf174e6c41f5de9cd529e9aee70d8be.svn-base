<%@page import="gk.myname.vn.entity.UserAction"%>
<%@page import="gk.myname.vn.admin.Permission"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page autoFlush="true" contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
    </head>
    <script>
        function checkall(name) {
            var chk = document.getElementById("check" + name);
            if (chk.checked) {
                var chkmove = $('input[name^=' + name + ']');
                for (var i = 0; i < chkmove.length; i++)
                    chkmove[i].checked = true;
            } else {
                var chkmove = $('input[name^=' + name + ']');
                for (var i = 0; i < chkmove.length; i++)
                    chkmove[i].checked = false;
            }
        }
    </script>
    <body>
        <%      if (!userlogin.checkEdit(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập module này!");
                //CongNX: Ghi log action vao db
                UserAction log = new UserAction(userlogin.getUserName(),
                                UserAction.TABLE.user_permission.val,
                                UserAction.TYPE.EDIT.val,
                                UserAction.RESULT.REJECT.val,
                                "Permit deny!");
                log.logAction(request);
                //CongNX: ket thuc ghi log db voi action thao tac tu web
                response.sendRedirect(request.getContextPath() + "/admin/module/module.jsp");
                return;
            }
            int accId = RequestTool.getInt(request, "id");
            ArrayList all = null;
            Account accDao = new Account();
            accDao = accDao.getByID(accId);
            if (accDao == null) {
                // Error
            }
            Permission dao = new Permission();
            all = dao.getRoleAccModule(accId);
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th colspan="3" scope="col" class="rounded">
                                        <span style="text-align: center;font-weight: bold;color: blueviolet;margin-right: 10px">
                                            QUYỀN CỦA USER: <span class="redBold"> <%=accDao.getUserName()%></span>
                                        </span>
                                    </th>
                                </tr>
                            </thead>
                        </table>
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%
                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <!--Content-->
                        <form action="<%=request.getContextPath() %>/admin/account/role-process.jsp" name="frmARole" id="frmGRole" method="post">
                            <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company boder_right">STT</th>
                                        <th scope="col" class="rounded">Modules</th>
                                        <th scope="col" class="rounded">Resource</th>
                                        <th align="center" scope="col" class="rounded boder_right">Specical<br/><input id="checkspecial" onclick="checkall('special')" value="" name="checkspecial" type="checkbox" /></th>
                                        <th align="center" scope="col" class="rounded boder_right">View Short<br/><input id="checkshortView" onclick="checkall('shortView')" value="" name="checkshortView" type="checkbox" /></th>
                                        <th align="center" scope="col" class="rounded boder_right">View<br/><input id="checkview" onclick="checkall('view')" value="" name="checkView" type="checkbox" /></th>
                                        <th align="center" scope="col" class="rounded boder_right">Add<br/><input id="checkadd" onclick="checkall('add')" value="" name="checkAdd" type="checkbox" /></th>
                                        <th align="center" scope="col" class="rounded boder_right">Edit<br/><input id="checkedit" onclick="checkall('edit')" value="" name="checkEdit" type="checkbox" /></th>
                                        <th align="center" scope="col" class="rounded boder_right">Delete<br/><input id="checkdel" onclick="checkall('del')" value="" name="checkDelete" type="checkbox" /></th>
                                        <th align="center" scope="col" class="rounded-q4 boder_right">Upload<br/><input id="checkupload" onclick="checkall('upload')" value="" name="checkupload" type="checkbox" /></th>
                                    </tr>
                                </thead>
                                <tbody>
                            <%
                                int count = 1; //Bien dung de dem so dong
                                for (Iterator<Permission> iter = all.iterator(); iter.hasNext();) {
                                    Permission onePer = iter.next();
                            %>
                                <tr>
                                    <input type="hidden" value="<%=accId%>" name="uid"/> 
                                    <td class="boder_right"><%=count++%></td>
                                    <td class="boder_right" align="left"><%=onePer.getModuleName()%></td>
                                    <td class="boder_right" align="left"><%=onePer.getResource()%></td>
                                    <td class="boder_right" align="center"><input value="<%=accId + "_" + onePer.getModelId()%>" <%=onePer.isSpecial() ? "checked='true'" : ""%> type="checkbox" name="special"/></td>
                                    <td class="boder_right" align="center"><input value="<%=accId + "_" + onePer.getModelId()%>" <%=onePer.isViewShort()? "checked='true'" : ""%> type="checkbox" name="shortView"/></td>
                                    <td class="boder_right" align="center"><input value="<%=accId + "_" + onePer.getModelId()%>" <%=onePer.isView() ? "checked='true'" : ""%> type="checkbox" name="view"/></td>
                                    <td class="boder_right" align="center"><input value="<%=accId + "_" + onePer.getModelId()%>" <%=onePer.isAdd() ? "checked='true'" : ""%> type="checkbox" name="add"/></td>
                                    <td class="boder_right" align="center"><input value="<%=accId + "_" + onePer.getModelId()%>" <%=onePer.isEdit() ? "checked='true'" : ""%> type="checkbox" name="edit"/></td>
                                    <td class="boder_right" align="center"><input value="<%=accId + "_" + onePer.getModelId()%>" <%=onePer.isDel() ? "checked='true'" : ""%> type="checkbox" name="del"/></td>
                                    <td align="center">                    <input value="<%=accId + "_" + onePer.getModelId()%>" <%=onePer.isUpload()? "checked='true'" : ""%> type="checkbox" name="upload"/></td>
                                </tr>
                            <%}%>
                                <tr align="center">
                                    <td colspan="10">
                                        <input class="button" type="submit" value="Phân quyền"/>
                                        &nbsp;&nbsp;
                                        <input class="button" value="Quay về" type="button" onclick="location.href = '<%=request.getContextPath() + "/admin/account/index.jsp"%>'"/>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </form>
                    </div><!-- end of right content-->
                </div>   <!--end of center content -->
                <div class="clear"></div>
            </div> <!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html>