<%@page import="gk.myname.vn.entity.PartnerManager"%><%@page import="gk.myname.vn.entity.KpiSubmit"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="java.sql.Timestamp"%><%@page import="gk.myname.vn.entity.Contract"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head><% session.setAttribute("title", "Thống kê KPI Submit: SMS BRAND cms.brand1.xyz"); %>
        <%@include file="/admin/includes/header.jsp" %>
        <script>
            $(document).ready(function () {
                $('.dateproc').datetimepicker({
                    lang: 'vi',
                    timepicker: false,
                    format: 'd/m/Y',
                    formatDate: 'Y/m/d'
                });
                $('.select2').select2();
            });
        </script>
    </head>
    <body>
        <%            ArrayList<KpiSubmit> all = null;
            KpiSubmit kpisubmit = new KpiSubmit();
            int currentPage = Tool.string2Integer(request.getParameter("page"), 1);
            if (currentPage < 1) {
                currentPage = 1;
            }
       
            String date1 = RequestTool.getString(request, "log_date1");
            if (Tool.checkNull(date1)) {
                date1 = DateProc.Timestamp2DDMMYYYY(DateProc.getNextDateN(DateProc.createTimestamp(),-1));
            }
            String date2 = RequestTool.getString(request, "log_date2");
            if (Tool.checkNull(date2)) {
                date2 = DateProc.Timestamp2DDMMYYYY(DateProc.getNextDateN(DateProc.createTimestamp(),-1));
            }
            String user_sender = RequestTool.getString(request, "user_sender");
            String oper = RequestTool.getString(request, "oper");
            String cp_code = RequestTool.getString(request, "cp_code");

            all = kpisubmit.findList(maxRow, currentPage, date1,date2, user_sender, oper, cp_code);

            int totalPage = 0;
            int totalRow = kpisubmit.count(date1,date2, user_sender, oper, cp_code);
            totalPage = (int) totalRow / maxRow;
            if (totalRow % maxRow != 0) {
                totalPage++;
            }

            String urlExport = request.getContextPath() + "/admin/statistic/exp/export_kpi_submit.jsp?";
            urlExport += "log_date1=" + date1;
            urlExport += "&log_date2=" + date2;
            urlExport += "&oper=" + oper;
            urlExport += "&user_sender=" + user_sender;
            urlExport += "&oper=" + oper;
            urlExport += "&cp_code=" + cp_code;
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <form action="<%=request.getContextPath() + "/admin/statistic/kpi_submit.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-q4 redBoldUp">KPI_SUBMIT</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><span class="redBold">Từ Ngày: </span>
                                            <input class="dateproc" size="8" type="text" name="log_date1"/>
                                            &nbsp;&nbsp;&nbsp;<span class="redBold">Đến Ngày: </span>
                                            <input class="dateproc" size="8" type="text" name="log_date2"/>
                                            &nbsp;&nbsp;&nbsp;<span class="redBold">Telco</span>
                                            <select name="oper">
                                                <option value=""> Tất cả </option>
                                                <option value="VMS">MOBI</option>
                                                <option value="GPC">VINA PHONE</option>
                                                <option value="VTE">VIETTEL</option>
                                                <option value="VNM">VIETNAM MOBI</option>
                                                <option value="BL">GTEL</option>
                                                <option value="DDG">ITELECOM</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="redBold">Mã Giao Dịch</span>
                                            <%
                                                ArrayList<PartnerManager> allpartner = PartnerManager.getAll();
                                                if (allpartner != null && !allpartner.isEmpty()) {
                                            %>
                                            <select style="width: 420px" onchange="changeCP()" class="select2" name="cp_code">
                                                <option value="">--- Tất cả ---</option>
                                                <%
                                                    for (PartnerManager oneAcc : allpartner) {
                                                %>
                                                <option value="<%=oneAcc.getCode()%>">[<%=oneAcc.getCode()%>] <%=oneAcc.getName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <%
                                                }
                                            %>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><span class="redBold">Tài Khoản Người Gửi</span>
                                            <%
                                                ArrayList<Account> allCp = Account.getAllCP();
                                                if (allCp != null && !allCp.isEmpty()) {
                                            %>
                                            <select style="width: 420px" onchange="changeCP()" class="select2" name="user_sender">
                                                <option value="">--- Tất cả ---</option>
                                                <%
                                                    for (Account oneAcc : allCp) {
                                                %>
                                                <option value="<%=oneAcc.getUserName()%>">[<%=oneAcc.getUserName()%>] <%=oneAcc.getFullName()%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <%
                                                }
                                            %>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Báo Cáo"/>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <input onclick="window.open('<%=urlExport%>')" class="button" type="button" name="button" value="Xuất Excel"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>  
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%
                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <!--Content-->
                        <%@include file="/admin/includes/page.jsp" %>
                        <table align="center" id="rounded-corner" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company">STT</th>
                                    <th scope="col" class="rounded">ID</th>
                                    <th scope="col" class="rounded">Ngày Giao Dịch</th>
                                    <th scope="col" class="rounded">Tài Khoản Người Gửi</th>
                                    <th scope="col" class="rounded">Số Lần</th>
                                    <th scope="col" class="rounded">Kết Quả</th>                              
                                    <th scope="col" class="rounded">Nhà Mạng</th>
                                    <th scope="col" class="rounded">Mã Khách Hàng</th>
                                    <th scope="col" class="rounded">Gửi Đến</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%                                    int count = 1; //Bien dung de dem so dong
                                    for (KpiSubmit kpiS : all) {
                                %>
                                <tr>
                                    <td class="boder_right"><%=count++%></td>
                                    <td align="left" class="boder_right">
                                        <%=kpiS.getId()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=DateProc.Timestamp2DDMMYYYY(kpiS.getLog_date())%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=kpiS.getUser_sender()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=kpiS.getTotal()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=kpiS.getResult()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=kpiS.getOper()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=kpiS.getCp_code()%>
                                    </td>
                                    <td align="left" class="boder_right">
                                        <%=kpiS.getSend_to()%>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div><!-- end of right content-->
                </div>   <!--end of center content -->
                <div class="clear"></div>
            </div> <!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html>