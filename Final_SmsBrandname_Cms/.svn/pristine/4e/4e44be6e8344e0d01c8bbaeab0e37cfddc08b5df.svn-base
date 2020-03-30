<%@page import="java.io.InputStream"%>
<%@page import="java.io.DataOutputStream"%>
<%@page import="javax.ws.rs.core.MediaType"%>
<%@page import="gk.myname.vn.entity.JSONUtil"%>
<%@page import="com.fasterxml.jackson.core.JsonGenerator"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="java.util.HashMap"%>
<%@page import="gk.myname.vn.entity.RouteTable"%><%@page import="java.io.Reader"%><%@page import="java.io.InputStreamReader"%><%@page import="java.io.BufferedReader"%><%@page import="java.net.HttpURLConnection"%><%@page import="java.net.URL"%><%@page import="java.io.IOException"%><%@page import="java.net.URLEncoder"%><%@page import="java.util.LinkedHashMap"%><%@page import="java.util.Map"%><%@page import="gk.myname.vn.utils.SMSUtils"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="java.util.Collection"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/admin/resource/select2/select2.css" />
        <script type="text/javascript" src="<%= request.getContextPath()%>/admin/resource/select2/select2.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/admin/resource/select2/select2_locale_vi.js"></script>
        <script type="text/javascript" language="javascript">
//            var maxLen = 459;
            var maxLen = 765;
            function checkLength() {
                var contentTmp = document.getElementById("txtContent").value;
                var lines = contentTmp.split(/\r\n|\r|\n/).length - 1;
                var curentLen = countLength(contentTmp) + lines;
                var dislayLen = maxLen - curentLen;
                if (dislayLen > 0) {
                    document.getElementById("currentLength").innerHTML = dislayLen;
                    document.getElementById("useLength").innerHTML = curentLen;
                } else {
                    document.getElementById("currentLength").innerHTML = 0;
                    document.getElementById("txtContent").value = contentTmp.substring(0, maxLen);
                }
            }
            function countLength(mess) {
                var smsLength = 0;
                for (var charPos = 0; charPos < mess.length; charPos++) {
                    switch (mess[charPos]) {
                        case "[":
                        case "]":
                        case "\\":
                        case "^":
                        case "{":
                        case "}":
                        case "|":
                        case "€":
                        case "~":
                            smsLength += 2;
                            break;
                        default:
                            smsLength += 1;
                    }
                }
                return smsLength;
            }
            function timer() {
                setInterval(checkLength, 500);
            }
            // How do you remove unicode characters in javascript?
            // str = str.replace(/[\uE000-\uF8FF]/g, '');
            // str = str.replace(/[^A-Za-z 0-9 \.,\?""!@#\$%\^&\*\(\)-_=\+;:<>\/\\\|\}\{\[\]`~]*/g, '')
            // str.replace(/[^\x00-\x7F]/g, "");
            // buffer.replace(/[\ud800-\udfff]/g, "");
            //------
//            $(document).ready(function () {
//                $("#_userSender").select2({
//                    formatResult: function (item) {
//                        return ('<div>' + item.text + '</div>');
//                    },
//                    formatSelection: function (item) {
//                        return (item.text);
//                    },
//                    dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
//                    escapeMarkup: function (m) {
//                        return m;
//                    }
//                });
//            });
            $(document).ready(function () {
                $("#_userSender").select2({
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
                        var opt = $("#_userSender option:selected");
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
            $(document).ready(function () {
                $("#_label").select2({
                    formatResult: function (item) {
                        return ('<div>' + item.text + '</div>');
                    },
                    formatSelection: function (item) {
                        return (item.text);
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
                    var url = "/admin/statistic/ajax/list-cp.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_userSender");

                    $("#_userSender").select2('val', user);

                    var brId = selectBr.attr("brand_id");
                    var url = "/admin/brand/getRouteTable.jsp?brid=" + brId;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "showRoute");
                } else {
                    var url = "/admin/statistic/ajax/list-cp.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_userSender");
                    $("#_userSender").select2('val', "");
                }
            }
            function changeCP() {
                var selectBr = $("#_userSender option:selected");
                var user = selectBr.val();
                if (user !== "") {
                    var url = "/admin/statistic/ajax/listBrand.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_label");
                } else {
                    var url = "/admin/statistic/ajax/listBrand.jsp?user=0";
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_label");
                }
                $("#_label").select2("val", "");
            }
        </script>
    </head>
    <body onLoad="timer();">
        <%
            String userSender = "";
            if (request.getParameter("submit") != null) {
                userSender = RequestTool.getString(request, "userSender");
                int brandId = RequestTool.getInt(request, "brandId");
                int dataEncode = RequestTool.getInt(request, "endCode", 0);
                String phone = RequestTool.getString(request, "phone");
                String mtSend = RequestTool.getString(request, "mtSend");
                String url_call = RequestTool.getString(request, "url_call");
                String sendTime = "";
                // --
                Account acc = Account.getAccount(userSender);
                BrandLabel brand = new BrandLabel().getById(brandId);
                if (acc != null) {
                    if (brandId == 0) {
                        session.setAttribute("mess", "Bạn chưa chọn một Brand để gửi đi...");
                    } else {
                        String[] arrPhone = phone.split(",");
                        if (arrPhone != null && arrPhone.length <= 3) {
                            ArrayList<String> listImport = SMSUtils.validList(phone);
                            ///--
                            RequestTool.debugParam(request);
                            for (String onePhone : listImport) {
                                doPostJson(acc.getUserName(), acc.getPassSend(), onePhone, brand.getBrandLabel(), mtSend,dataEncode, sendTime, url_call);
                            }
                            session.setAttribute("mess", "Không biết Add thành công hay ko - Xem nhận được chưa?");
                        } else {
                            session.setAttribute("mess", "Chưa nhập số điện thoại hoặc test nhiều hơn 3 số...");
                        }
                    }
                } else {
                    session.setAttribute("mess", "Không lấy được thông tin CP để gửi...");
                }
            }
        %>
        <%-- JSP DATA --%>
        <%!            static final ObjectMapper mapper = new ObjectMapper(); 
            String doPostJson(String username, String password, String msisdn, String brand, String msgbody, int dataEncode, String sendTime,String url_call) {
                String result = "Error";
                try {
                    String seqid = brand + "-" + msisdn + "-" + System.nanoTime();
//            String seqid = "";
                    Map dataMap = new HashMap();
                    dataMap.put("user", username);
                    dataMap.put("pass", password);
                    dataMap.put("tranId", seqid);
                    dataMap.put("brandName", brand);
                    dataMap.put("phone", msisdn);
                    dataMap.put("mess", msgbody);
                    dataMap.put("dataEncode", dataEncode);
                    dataMap.put("sendTime", sendTime);
                    mapper.getFactory().configure(JsonGenerator.Feature.ESCAPE_NON_ASCII, true);
                    String strJson = mapper.writeValueAsString(dataMap);
                    //--
//            System.out.println("doGetJson: " + jobj.toString());
                    String data = strJson;
//            data = JSONUtil.escape(data);
                    System.out.println("escape param:" + data);
                    System.out.println("unescape param:" + JSONUtil.unescape(data));
                    HttpURLConnection conn = null;
                    try {
                        //Create connection
                        URL url = new URL(url_call);
                        conn = (HttpURLConnection) url.openConnection();
                        conn.setRequestMethod("POST");
                        conn.setRequestProperty("accept", MediaType.APPLICATION_JSON);
                        conn.setRequestProperty("Content-Type", MediaType.APPLICATION_JSON);
                        conn.setUseCaches(false);
                        conn.setDoOutput(true);
                        try ( //Send request
                                DataOutputStream wr = new DataOutputStream(conn.getOutputStream())) {
                            wr.writeBytes(data);
                        }
                        //Get Response  
                        InputStream is = conn.getInputStream();
                        StringBuilder response;
                        try (BufferedReader rd = new BufferedReader(new InputStreamReader(is))) {
                            response = new StringBuilder(); // or StringBuffer if not Java 5+
                            String line;
                            while ((line = rd.readLine()) != null) {
                                response.append(line);
                                response.append('\r');
                            }
                        } // or StringBuffer if not Java 5+
                        result = response.toString();
                    } catch (Exception e) {
                        e.printStackTrace();
                        return null;
                    } finally {
                        if (conn != null) {
                            conn.disconnect();
                        }
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                return result;
            }

        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <!-- Tìm kiếm-->
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <form name="frmSend" action="" method="post">
                            <table id="rounded-corner" align="center" >
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded"></th>
                                        <th style="color: red;font-weight: bold;text-transform: uppercase" colspan="2" scope="col" class="rounded-q4">Gửi Tin Nhắn Test</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>Khách Hàng</td>
                                        <td>
                                            <%
                                                ArrayList<Account> allCp = Account.getAllCP();
                                                if (allCp != null && !allCp.isEmpty()) {
                                            %>
                                            <select style="width: 400px" onchange="changeCP()" id="_userSender" name="userSender">
                                                <option value="">--- Tất cả ---</option>
                                                <%
                                                    for (Account oneAcc : allCp) {
                                                        if (!Tool.checkNull(oneAcc.getCpCode()) && oneAcc.getStatus() == Account.STATUS.ACTIVE.val) {
                                                %>
                                                <option <%=(oneAcc.getUserName().equals(userSender)) ? "selected ='selected'" : ""%>
                                                    value="<%=oneAcc.getUserName()%>"
                                                    img-data="<%=(oneAcc.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=oneAcc.getUserName()%>] <%=oneAcc.getFullName()%></option>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </select>
                                            <%
                                                }
                                            %>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td>Label</td>                            
                                        <td>
                                            <select onchange="changeBrand()" style="width: 280px" id="_label" name="brandId">
                                                <option value="">Tất cả</option>
                                                <%ArrayList<BrandLabel> allLabel = BrandLabel.getAll();
                                                    for (BrandLabel one : allLabel) {
                                                %>
                                                <option brand_id="<%=one.getId()%>" user_owner="<%=one.getUserOwner()%>" value="<%=one.getId()%>"><%=one.getBrandLabel()%> &nbsp;&nbsp;[<%=one.getUserOwner()%>] <%=one.getStatus() == 1 ? "" : "[Lock]"%></option>
                                                <%
                                                    }
                                                %>
                                            </select>                                          
                                        </td>                                        
                                    </tr>
                                    <tr>
                                        <td>Hướng Gửi</td>
                                        <td id="showRoute"></td>
                                    </tr>
                                    <tr>
                                        <td>NODE TEST</td>                            
                                        <td>
                                            <select name="url_call">
                                                <option value="http://127.0.0.1:9981/service/sms_api">NODE 1 Campagin - SV1</option>
                                                <option value="http://127.0.0.1:9982/service/sms_api">NODE 2 - SV1</option>
                                                <option value="http://127.0.0.1:9986/service/sms_api">NODE 5 - SV1</option>
                                                <option value="http://10.221.11.11:9983/service/sms_api">NODE 3 - SV2</option>
                                                <option value="http://10.221.11.11:9984/service/sms_api">NODE 4 - SV2</option>
                                                <option value="http://127.0.0.1:9985/service/sms_api">NODE DEV - SV1</option>
                                            </select>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            Data Encode
                                            <select name="endCode">
                                                <option value="0">Không dấu</option>
                                                <option value="1">Có dấu</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Số điện thoại(Max 3 Số - Cách nhau bởi dấu ,)</td>                            
                                        <td>
                                            <input size="80" type="text" name="phone"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Nội dung tin nhắn
                                            <br/>
                                            <span style="font-weight: bold;color: red;font-variant-caps: ">Số ký tự còn lại:</span>
                                            <span style="color: red;font-weight: bold" id="currentLength">459</span>
                                            <br/>
                                            <span style="font-weight: bold;color: blue;font-variant-caps: ">Số ký tự đã dùng:</span>
                                            <span style="color: blue;font-weight: bold" id="useLength">0</span>
                                        </td>                            
                                        <td>
                                            <textarea cols="55" rows="4" type="text" id="txtContent" name="mtSend"></textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2">
                                            <input class="button" type="submit" name="submit" value="Gửi thử"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                        <!--End tim kiếm-->
                    </div><!-- end of right content-->
                </div>   <!--end of center content -->
                <div class="clear"></div>
            </div> <!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html>