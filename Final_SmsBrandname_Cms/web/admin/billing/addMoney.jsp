<%@page import="gk.myname.vn.admin.MoneyAddLog"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.DataOutputStream"%>
<%@page import="javax.ws.rs.core.MediaType"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="gk.myname.vn.entity.JSONUtil"%>
<%@page import="com.fasterxml.jackson.core.JsonGenerator"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@page import="gk.myname.vn.admin.BillingAcc"%>
<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.admin.AccountRole"%><%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/admin/resource/css/jquery-ui-1.8.16.custom.css">
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.core.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.position.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.widget.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/admin/resource/js/suggest/jquery.ui.autocomplete.min.js"></script>
        <script type ='text/javascript'>
            $(document).ready(function () {
                $("#_cp_code").select2({
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
                        var opt = $("#_cp_code option:selected");
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
    </head>
    <body>
        <%
            if (!userlogin.checkEdit(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin/billing/index.jsp");
                return;
            }
            
            
            //String account = Tool.validStringRequest(request.getParameter("account"));
            BillingAcc admDao = new BillingAcc();
            BillingAcc oneAccount = null;
            /*
            oneAccount = admDao.getByUsername(account);

            if (oneAccount == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ. Không lấy được thông tin tài khoản");
                response.sendRedirect(request.getContextPath() + "/admin/billing/index.jsp");
                return;
            }
            */
            

            if (request.getParameter("submit") != null) {
                //----------Log--------------
                String accountname = Tool.validStringRequest(request.getParameter("accountname"));
                int moneyAdd = Tool.string2Integer(request.getParameter("moneyadd"), 0);
                int quotaAdd = Tool.string2Integer(request.getParameter("quotaadd"), 0);
                String notecomment = request.getParameter("notecomment");
                oneAccount = admDao.getByUsername(accountname);
                int total = oneAccount.getBalance() + moneyAdd;
                int totalsms = oneAccount.getSms_quota() + quotaAdd;
                oneAccount.setBalance(total);
                oneAccount.setSms_quota(totalsms);
                //Call API cong tien
                String urlCallApi = "http://127.0.0.1:9937/service/billing_api";
                String addMoneyAPI = doPostJson(oneAccount.getUsername(),0,"","TOPUP",moneyAdd,"",0,0,0,0,0,urlCallApi,"","","","","",notecomment,0,userlogin.getUserName());
                int resultAdd = Tool.string2Integer(addMoneyAPI, 0);
                if (admDao.updateBilling(oneAccount)) {
                    MoneyAddLog dao = new MoneyAddLog();
                    dao.setId(0);
                    dao.setAccountbilling(accountname);
                    dao.setUsernameadd(userlogin.getUserName());
                    dao.setMoneys(moneyAdd);
                    //dao.setTime_add(0);
                    dao.setResultadd(resultAdd);
                    dao.addLogs(dao);
                    session.setAttribute("mess", "Thêm tiền thành công cho tài khoản " + accountname);
                    response.sendRedirect(request.getContextPath() + "/admin/billing/index.jsp");
                    return;
                } else {
                    session.setAttribute("mess", "Sửa tài khoản lỗi");
                }
            }
        %>
        
        <%-- JSP DATA --%>
        <%!            static final ObjectMapper mapper = new ObjectMapper(); 
            String doPostJson(String account, int smsNumber, String telcoCode, String action, int money, String security, int vtePrice,int gpcPrice, int vmsPrice, int vnmPrice, int blPrice, String url_call, String gpc_pe, String vte_pe, String vms_pe, String vnm_pe, String bl_pe, String notecomment, int monthly_price_active,String accAction) {
                String result = "Error";
                try {
                    Map dataMap = new HashMap();
                    dataMap.put("account", account);
                    dataMap.put("smsNumber", smsNumber);
                    dataMap.put("telcoCode", telcoCode);
                    dataMap.put("action", action);
                    dataMap.put("money", money);
                    dataMap.put("security", security);
                    dataMap.put("vtePrice", vtePrice);
                    dataMap.put("gpcPrice", gpcPrice);
                    dataMap.put("vmsPrice", vmsPrice);
                    dataMap.put("vnmPrice", vnmPrice);
                    dataMap.put("blPrice", blPrice);
                    dataMap.put("gpc_pe", gpc_pe);
                    dataMap.put("vte_pe", vte_pe);
                    dataMap.put("vms_pe", vms_pe);
                    dataMap.put("vnm_pe", vnm_pe);
                    dataMap.put("bl_pe", bl_pe);
                    dataMap.put("notecomment", notecomment);
                    dataMap.put("monthly_price_active", monthly_price_active);
                    dataMap.put("accAction", accAction);
                    
                    

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
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }%>
                        </div>
                        <form action="" method="post">
                            <table align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th colspan="4" style="font-weight: bold"  scope="col" class="rounded redBoldUp">Thêm tiền cho tài khoản </th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    
                                    <tr>
                                        <td></td>
                                        <td align="left">Chọn tài khoản:</td>
                                        <td colspan="5">
                                            <select style="width: 400px" name="accountname" id="_cp_code">
                                                <option value="0">-- Chọn tài khoản Sở hữu --</option>
                                                <%
                                                    ArrayList<BillingAcc> allCp = BillingAcc.getAllPrepaid();
                                                    for (BillingAcc one : allCp) {
                                                        if (one.getStatus() != Account.STATUS.ACTIVE.val) {
                                                            continue;
                                                        };
                                                %>
                                                <option value="<%=one.getUsername()%>" 
                                                    img-data="<%=(one.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" > [<%=one.getUsername()%>] <%=one.getFullname()%> </option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Số tiền:</td>
                                        <td colspan="5">
                                            <input type="text" name="moneyadd" value=""/>
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td></td>
                                        <td align="left">Số sms:</td>
                                        <td colspan="5">
                                            <!--<input type="text" name="quotaadd" value=""/>-->
                                            <textarea name="notecomment"></textarea>
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td colspan="7" align="center">
                                            <input class="button" type="submit" name="submit" value="Cộng thêm"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/billing/index.jsp"%>'" type="reset" name="reset" value="Hủy"/>
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