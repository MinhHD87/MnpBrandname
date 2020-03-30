<%@page import="gk.myname.vn.entity.Complain_title"%><%@page import="gk.myname.vn.utils.SMSUtils"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.entity.Complain_log"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>

        <script>
            $(document).ready(function () {
                $("#_send_to").select2();
                $("#_name").select2({
                    formatResult: function (item) {
                        var valOpt = $(item.element).attr('img-data');
                        if (!valOpt) {
                            return ('<div><b>' + item.text + '</b></div>');
                        } else {
                            return ('<div><span><b style="color: red">' + item.text + '<b> <img src="' + valOpt + '" class="img-flag" /></span></div>');
                        }
                    },

                    formatSelection: function (item) {
                        //  load page or selected
                        var opt = $("#_name option:selected");
                        var valOpt = opt.attr("img-data");
                        var befor_code = opt.attr("cp_code");
                        if (!isBlank(befor_code)) {
                            $("#_befor_code").html(befor_code + "_");
                        } else {
                            $("#_befor_code").html("");
                        }

                        if (!valOpt) {
                            return ('<b>' + item.text + '</b>');
                        } else {
                            return ('<div><span><b style="color: red">' + item.text + '</b> <img src="' + valOpt + '" class="img-flag" /></span></div>');
                        }
                    },
                    dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
                    escapeMarkup: function (m) {
                        return m;
                    }
                });
            });

            function changeBrand() {
                var selectBr = $("#_label option:selected");
                if (selectBr.val() !== "") {
                    var user = selectBr.attr("user_owner");
                    console.log('changeBrand user:'+user)
                    var url = "<%= request.getContextPath()%>/admin/statistic/ajax/list-cp.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_userSender");
                    $("#_userSender").select2('val', user);
                } else {
                    var url = "<%= request.getContextPath()%>/admin/statistic/ajax/list-cp.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_userSender");
                    $("#_userSender").select2('val', "");
                }
            }
            function changeCP() {
                var selectBr = $("#_userSender option:selected");
                var user = selectBr.val();
                console.log('changeCP user:'+user)
                if (user !== "") {
                    var url = "<%= request.getContextPath()%>/admin/statistic/ajax/listBrand.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_label");
                } else {
                    var url = "<%= request.getContextPath()%>/admin/statistic/ajax/listBrand.jsp?user=user";
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_label");
                }
                $("#_label").select2("val", "");
            }
        </script>
    </head>
    <body>
        <%    if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin/complain_log");
                return;
            }
            if (request.getParameter("submit") != null) {
                //---------------------------
                String name = Tool.validStringRequest(request.getParameter("name"));
                String userSender = Tool.validStringRequest(request.getParameter("userSender"));
                int labelId = Tool.string2Integer(request.getParameter("_label"));
                BrandLabel brLabel = BrandLabel.getFromCache(labelId);
                //--
                String label = "";
                if (brLabel != null) {
                    label = brLabel.getBrandLabel();
                }
                String phone = Tool.validStringRequest(request.getParameter("phone"));
                String oper = SMSUtils.buildMobileOperator(phone);
                String send_to = Tool.validStringRequest(request.getParameter("send_to"));
                String complain = Tool.validStringRequest(request.getParameter("complain"));
                String result = Tool.validStringRequest(request.getParameter("result"));
                Complain_log onecl = new Complain_log();
                onecl.setUserSender(userSender);
                onecl.setName(name);
                onecl.setLabel(label);
                onecl.setPhone(phone);
                onecl.setOper(oper);
                onecl.setSend_to(send_to);
                onecl.setCreate_by(userlogin.getUserName());
                onecl.setComplain(complain);
                onecl.setResult(result);
                //------------
                Complain_log daocl = new Complain_log();
                if (daocl.addnew(onecl)) {
                    session.setAttribute("mess", null);
                } else {
                    session.setAttribute("mess", "Thêm mới khiếu nại lỗi!");
                }
                response.sendRedirect(request.getContextPath() + "/admin/complain_log");
                return;
            }
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }%>
                        </div>
                        <form onsubmit="return checkPartnerCode()" action="" method="post">
                            <table  align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th colspan="2" align="center" style="font-weight: bold" scope="col" class="rounded-q4 redBoldUp">
                                            Thêm mới Complian_log</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tên gợi nhớ:</td>
                                        <%
                                            ArrayList<Complain_title> allTitle = Complain_title.getAll();
                                            if (allTitle != null && !allTitle.isEmpty()) {
                                        %>
                                        <td> 
                                            <select id="_name" name="name" style="width: 350px">
                                                <option value="0">--- Tất cả ---</option>
                                                <%
                                                    for (Complain_title oneT : allTitle) {
                                                %>

                                                <option value="<%=oneT.getTitle()%>"><%=oneT.getTitle()%></option>

                                                <%
                                                        }
                                                    }
                                                %>
                                            </select>
                                            &nbsp;&nbsp;    <a style="color: #FAA51A;font-weight: bold" href="/admin/complain_title/add.jsp" >Thêm mới</a> 
                                        </td>   
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left"> Khách Hàng:</td>
                                        <%
                                            ArrayList<Account> allCp = Account.getAllCP();
                                            if (allCp != null && !allCp.isEmpty()) {
                                        %>
                                        <td>
                                            <select style="width: 420px" onchange="changeCP()" id="_userSender" name="userSender">
                                                <option value="0">--- Tất cả ---</option>
                                                <%             for (Account oneAcc : allCp) {
                                                %>
                                                <option 
                                                    value="<%=oneAcc.getUserName()%>"
                                                    img-data="<%=(oneAcc.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=oneAcc.getUserName()%>] <%=oneAcc.getFullName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>   
                                        <%
                                            }
                                            // Nha Cung Cap
                                            ArrayList<Provider> allPrv = Provider.getALL();
                                            if (allPrv != null && !allPrv.isEmpty()) {
                                        %>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Nhãn gửi tin</td>
                                        <td>
                                            <select onchange="changeBrand()" style="width: 280px" id="_label" name="_label">
                                                <option value="">Tất cả</option>
                                                <%
                                                    ArrayList<BrandLabel> allLabel = BrandLabel.getAll();
                                                    for (BrandLabel one : allLabel) {
                                                %>
                                                <option user_owner="<%=one.getUserOwner()%>" 
                                                        value="<%=one.getId()%>" 
                                                        img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" ><%=one.getBrandLabel()%> [<%=one.getUserOwner()%>]</option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td></td>
                                        <td align="left">Số điện thoại:</td>
                                        <td><input id="add_name" autocomplete="off" size="50" type="text" name="phone"/></td>
                                    </tr>

                                    <tr>
                                        <td></td>
                                        <td>Hướng gửi:</td>
                                        <td>
                                            <select id="_send_to" name="send_to" style="width: 350px">
                                                <option value="">--- Tất cả ---</option>
                                                <%
                                                    for (Provider one : allPrv) {
                                                %>
                                                <option value="<%=one.getCode()%>">[<%=one.getCode()%>] <%=one.getName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <%
                                                }
                                            %>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td></td>
                                        <td align="left"> Nội dung Khiếu nại:</td>
                                        <td>
                                            <textarea cols="90" rows="10" name="complain"></textarea>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td></td>
                                        <td align="left">Kết quả gửi: </td>
                                        <td colspan="2">
                                            <textarea cols="90" rows="10" name="result"></textarea>
                                        </td>
                                    </tr> 

                                    <tr>
                                        <td colspan="3" align="center">
                                            <input class="button" type="submit" name="submit" value="Thêm mới"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/complain_log"%>'" type="reset" name="reset" value="Hủy"/>
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