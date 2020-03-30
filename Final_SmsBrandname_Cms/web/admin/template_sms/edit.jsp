<%@page import="gk.myname.vn.entity.Provider"%>
<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.entity.Template_sms"%>
<%@page import="gk.myname.vn.utils.Tool"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><%@page contentType="text/html; charset=utf-8" %>
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %></head>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#providerCode").select2({
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
                    var opt = $("#providerCode option:selected");
                    var valOpt = opt.attr("img-data");
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
    </script>
    <body>
        <%            if (!userlogin.checkEdit(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập trang này!");
                response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
                return;
            }
            Template_sms oneTem = new Template_sms();
            int id = RequestTool.getInt(request, "id");
            oneTem = oneTem.getById(id);
            if (oneTem == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ. Bạn vui lòng kiểm tra lại!");
                response.sendRedirect(request.getContextPath() + "/admin/template_sms/index.jsp");
                return;
            }
            if (request.getParameter("submit") != null) {
                //---------------------------
                int id_template_send = Tool.string2Integer(request.getParameter("id_template_send"));
                int id_provider = Tool.string2Integer(request.getParameter("id_provider"));
                String content = Tool.validStringRequest(request.getParameter("content"));
                String key1 = Tool.validStringRequest(request.getParameter("key1"));
                String key2 = Tool.validStringRequest(request.getParameter("key2"));
                String key3 = Tool.validStringRequest(request.getParameter("key3"));
                String key4 = Tool.validStringRequest(request.getParameter("key4"));
                String key5 = Tool.validStringRequest(request.getParameter("key5"));
                String key6 = Tool.validStringRequest(request.getParameter("key6"));
                String key7 = Tool.validStringRequest(request.getParameter("key7"));
                String key8 = Tool.validStringRequest(request.getParameter("key8"));
                String key9 = Tool.validStringRequest(request.getParameter("key9"));
                String key10 = Tool.validStringRequest(request.getParameter("key10"));
                int status = Tool.string2Integer(request.getParameter("status"));
                String description = Tool.validStringRequest(request.getParameter("description"));
                //---
                oneTem.setId_template_send(id_template_send);
                oneTem.setId_provider(id_provider);
                oneTem.setContent(content);
                oneTem.setKey1(key1);
                oneTem.setKey2(key2);
                oneTem.setKey3(key3);
                oneTem.setKey4(key4);
                oneTem.setKey5(key5);
                oneTem.setKey6(key6);
                oneTem.setKey7(key7);
                oneTem.setKey8(key8);
                oneTem.setKey9(key9);
                oneTem.setKey10(key10);
                oneTem.setUpdatedby(userlogin.getUserName());
                oneTem.setStatus(status);
                oneTem.setDescription(description);

                //------------
                if (oneTem.update(oneTem)) {
                    session.setAttribute("mess", "Cập nhật dữ liệu thành công!");
                    response.sendRedirect(request.getContextPath() + "/admin/template_sms/index.jsp");
                    return;
                } else {
                    session.setAttribute("mess", "Cập nhật dữ liệu lỗi!");
                }
            }
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%
                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <form action="" method="post">
                            <input type="hidden" value="<%=id%>" name="id"/>
                            <table  align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th style="font-weight: bold" scope="col" class="rounded redBoldUp">Cập nhật tin nhắn mẫu</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>                            
                                    <tr>
                                        <td></td>
                                        <td align="left">Mã tin nhắn mẫu gửi:</td>
                                        <td><input autocomplete="off" size="50" type="text" value="<%=oneTem.getId_template_send()%>" name="id_template_send"/></td>
                                    </tr>
                                     <tr>
                                        <td></td>
                                        <td align="left">Mã nhà cung cấp </td>
                                         <td>
                                            <select style="width: 420px" name="id_provider" id="providerCode">
                                                <option value="">***** Chọn nhà cung cấp*****</option>
                                                <%
                                                    ArrayList<Provider> allpro = Provider.getCACHE();
                                                    for (Provider one : allpro) {
                                                %>
                                                <option value="<%=one.getId()%>" 
                                                        img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=one.getId()%>][<%=one.getCode()%>] <%=one.getName()%> <%= one.getStatus() == 1 ? "" : "[LOCK]"%></option>
                                                <%
                                                    }
                                                %>
                                            </select>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Từ khóa 1</td>
                                        <td><input type="text" value="<%=oneTem.getKey1()%>" name="key1"/>
                                            &nbsp;&nbsp;
                                            Từ khóa 2
                                            <input type="text" value="<%=oneTem.getKey2()%>" name="key2"/>
                                        </td>
                                    </tr>                               
                                    <tr>
                                        <td></td>
                                        <td>Từ khóa 3</td>
                                        <td><input type="text" value="<%=oneTem.getKey3()%>" name="key3"/>
                                            &nbsp;&nbsp;
                                            Từ khóa 4
                                            <input type="text" value="<%=oneTem.getKey4()%>" name="key4"/>
                                        </td>
                                    </tr>                               
                                    <tr>
                                        <td></td>
                                        <td>Từ khóa 5</td>
                                        <td><input type="text" value="<%=oneTem.getKey5()%>" name="key5"/>
                                            &nbsp;&nbsp;
                                            Từ khóa 6
                                            <input type="text" value="<%=oneTem.getKey6()%>" name="key6"/>
                                        </td>
                                    </tr>                               
                                    <tr>
                                        <td></td>
                                        <td>Từ khóa 7</td>
                                        <td><input type="text" value="<%=oneTem.getKey7()%>" name="key7"/>
                                            &nbsp;&nbsp;
                                            Từ khóa 8
                                            <input type="text" value="<%=oneTem.getKey8()%>" name="key8"/>
                                        </td>
                                    </tr>                               
                                    <tr>
                                        <td></td>
                                        <td>Từ khóa 9</td>
                                        <td><input type="text" value="<%=oneTem.getKey9()%>" name="key9"/>
                                            &nbsp;&nbsp;
                                            Từ khóa 10
                                            <input type="text" value="<%=oneTem.getKey10()%>" name="key10"/>
                                        </td>
                                    </tr>                              
                                    <tr>
                                        <td></td>
                                        <td align="left">Nội dung tin nhắn</td>
                                        <td>
                                            <textarea cols="57" name="content"><%=oneTem.getContent()%></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mô tả</td>
                                        <td>
                                            <textarea cols="57" name="description"><%=oneTem.getDescription()%></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Trạng thái: </td>
                                        <td colspan="2">
                                            <select name="status">
                                                <option value="1">Kích hoạt</option>
                                                <option value="0">Khóa</option>
                                            </select>
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td colspan="4" align="center">
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/template_sms/"%>'" type="reset" name="reset" value="Hủy"/>
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