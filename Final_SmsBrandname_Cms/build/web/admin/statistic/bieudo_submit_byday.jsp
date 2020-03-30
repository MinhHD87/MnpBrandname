<%@page import="gk.myname.vn.entity.CDRSubmit"%>
<%@page import="java.sql.Timestamp"%><%@page import="java.util.HashMap"%><%@page import="gk.myname.vn.utils.SMSUtils"%><%@page import="gk.myname.vn.entity.MsgBrandSubmit"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.DateProc"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="gk.myname.vn.config.MyContext"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8" %><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
    <head>
        <%@include file="/admin/includes/header.jsp" %>
        <script type="text/javascript" src="<%= request.getContextPath()%>/admin/resource/js/angular-chart/angular.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/admin/resource/js/angular-chart/Chart.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/admin/resource/js/angular-chart/angular-chart.min.js"></script>
        <script type="text/javascript" language="javascript">
            $(document).ready(function () {
                $('#dataTable').DataTable({
                    "order": [[0, "asc"]],
                    "bPaginate": false,
                    "bLengthChange": false,
                    "bFilter": true,
                    "bInfo": false,
                    "bAutoWidth": false
                });
            });
            $(document).ready(function () {
                $('.dateproc').datetimepicker({
                    lang: 'vi',
                    timepicker: false,
                    format: 'd/m/Y',
                    formatDate: 'Y/m/d',
                    minDate: '2014/01/01', // yesterday is minimum date
                    maxDate: '+1970/01/02' // and tommorow is maximum date calendar
                });
            });
            //------
            function validMonth() {
                var stRequest = $("#stRequest").val();
                var endRequest = $("#endRequest").val();
                var arrstRequest = stRequest.split("/");
                var arrendRequest = endRequest.split("/");
                if (stRequest !== "" && stRequest !== null) {
                    if (endRequest === "" || endRequest === null) {
                        jAlert("Bạn cần chọn ngày kết thúc...");
                        return false;
                    }
                    if (arrstRequest[1] !== arrendRequest[1]) {
                        jAlert("Bạn chỉ thống kê được dữ liệu từng tháng...");
                        return false;
                    }
                    if (arrstRequest[2] !== arrendRequest[2]) {
                        jAlert("Năm bạn chọn không hợp lệ...");
                        return false;
                    }
                }
            }
            function changeBrand() {
                var selectBr = $("#_label option:selected");
                if (selectBr.val() !== "") {
                    var user = selectBr.attr("user_owner");
                    var url = "/admin/statistic/ajax/list-cp.jsp?user=" + user;
                    url += "&_=" + Math.floor(Math.random() * 10000);
                    AjaxAction(url, "_userSender");
                    $("#_userSender").select2('val', user);
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
            function addCommas(nStr) {
                nStr += '';
                x = nStr.split('.');
                x1 = x[0];
                x2 = x.length > 1 ? '.' + x[1] : '';
                var rgx = /(\d+)(\d{3})/;
                while (rgx.test(x1)) {
                    x1 = x1.replace(rgx, '$1' + ',' + '$2');
                }
                return x1 + x2;
            }
        </script>
    </head>
    <body>
        <%            //-
            ArrayList<CDRSubmit> allLog = null;
            CDRSubmit smDao = new CDRSubmit();
            int type = RequestTool.getInt(request, "type", 0);
            String stRequest = RequestTool.getString(request, "stRequest");
            if (Tool.checkNull(stRequest)) {
//                stRequest = DateProc.Timestamp2DDMMYYYY(DateProc.getNextDateN(DateProc.createTimestamp(), -7));
                  stRequest = DateProc.createDDMMYYYY_Start01();  
            }
            String endRequest = RequestTool.getString(request, "endRequest");
            if (Tool.checkNull(endRequest)) {
                endRequest = DateProc.createDDMMYYYY();
            }
            String userSender = RequestTool.getString(request, "userSender", "0");
            allLog = smDao.statisticSubmByDay(userSender, stRequest, endRequest, type);
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <!-- Tìm kiếm-->
                        <form onsubmit="return  validMonth();" action="<%=request.getContextPath() + "/admin/statistic/bieudo_submit_byday.jsp"%>" method="post">
                            <table id="rounded-corner" align="center">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th scope="col" class="rounded-q4 redBoldUp">Thống kê Log Submit</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Kết Quả:</td>
                                        <td> 
                                            &nbsp;&nbsp;&nbsp;<span class="redBold"> </span>
                                            <input value="<%=stRequest%>" id="stRequest" class="dateproc" size="10" type="text" name="stRequest"/>
                                            &nbsp;&nbsp;&nbsp;<span class="redBold">Đến ngày </span>
                                            <input value="<%=endRequest%>" id="endRequest" class="dateproc" size="10" type="text" name="endRequest"/>
                                            &nbsp;&nbsp;&nbsp;
                                            Kết Quả:
                                            <select name="result">
                                                <option value="">== Tất Cả ==</option>
                                                <option value="1">Thành Công</option>
                                                <option value="-1">Thất bại</option>
                                            </select>
                                            &nbsp;
                                            Loại tin
                                            <select id="type" name="type">
                                                <option <%=type == -1 ? "selected='selected'" : ""%> value="-1">Tất cả</option>
                                                <option <%=type == 0 ? "selected='selected'" : ""%> value="0">Tin CSKH</option>
                                                <option <%=type == 1 ? "selected='selected'" : ""%> value="1">Tin QC</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Khách Hàng</td>
                                        <td>
                                            <%
                                                ArrayList<Account> allCp = Account.getAllCP();
                                                if (allCp != null && !allCp.isEmpty()) {
                                            %>
                                            <select style="width: 400px" id="_userSender" name="userSender">
                                                <option value="">--- Tất cả ---</option>
                                                <%
                                                    for (Account oneAcc : allCp) {
                                                %>
                                                <option <%=(oneAcc.getUserName().equals(userSender)) ? "selected ='selected'" : ""%> 
                                                    value="<%=oneAcc.getUserName()%>"
                                                    img-data="<%=(oneAcc.getStatus() == 1 ? "" : "/admin/resource/images/lock1.png")%>" >[<%=oneAcc.getUserName()%>]<%=oneAcc.getFullName()%> [<%= oneAcc.getUserType() == 0 ? "-- Khách hang lẻ --" : "-- Đại lý --"%>]</option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                            <%
                                                }
                                            %>
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td colspan="3">
                                            <input class="button" type="submit" name="submit" value="Thống kê"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                        <div>
                            <%!                                
                                String buidLable(ArrayList<CDRSubmit> allLog) {
                                    String result = "";
                                    for (CDRSubmit one : allLog) {
                                        result += "'" + one.getLogDate()+ "',";
                                    }
                                    if (!Tool.checkNull(result) && result.endsWith(",")) {
                                        result = result.substring(0, result.length() - 1);
                                    }
                                    return result;
                                }

                                String buidData(ArrayList<CDRSubmit> allLog) {
                                    String result = "";
                                    for (CDRSubmit one : allLog) {
                                        result += "" + one.getTotalMsg()+ ",";
                                    }
                                    if (result.endsWith(",")) {
                                        result = result.substring(0, result.length() - 1);
                                    }
                                    return result;
                                }
                            %>
                            <div ng-app="appChart" ng-controller="LineCtrl" style="max-width:1024px;">
                                <canvas id="line" class="chart chart-line" chart-data="data"
                                        chart-labels="labels" chart-series="series" chart-options="options"
                                        chart-dataset-override="datasetOverride" chart-click="onClick">
                                </canvas>
                            </div>

                        </div>
                        <!--End tim kiếm-->
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <!--Content-->
                        <table align="center" id="dataTable" summary="Msc Joint Stock Company" >
                            <thead>
                                <tr>
                                    <th scope="col" class="rounded-company">STT</th>
                                    <th scope="col" class="rounded">Ngày Gửi</th>
                                    <th scope="col" class="rounded">Tổng tin nhắn</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    int count = 1; //Bien dung de dem so dong
                                    int total = 0;
                                    for (Iterator<CDRSubmit> iter = allLog.iterator(); iter.hasNext();) {
                                        CDRSubmit oneBrand = iter.next();
                                        total += oneBrand.getTotalMsg();
                                %>
                                <tr>
                                    <td class="boder_right boder_left"><%=count++%></td>
                                    <td class="boder_right" align="left">
                                        <%=oneBrand.getLogDate()%>
                                    </td>
                                    <td class="boder_right" align="left">
                                        <%=oneBrand.getTotalMsg()%>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>                                
                            </tbody>
                        </table>
                        <table id="rounded-corner">
                            <tr>
                                <td class="boder_right" colspan="3" style="font-weight: bold;color: blue;width: 352px">Tổng MT thành công</td>
                                <td colspan="5" style="font-weight: bold;color: blue" align="left"><%=total%></td>
                            </tr>
                        </table>
                    </div><!-- end of right content-->
                </div>   <!--end of center content -->
                <div class="clear"></div>
            </div> <!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html>
<script type="text/javascript">
    angular.module("appChart", ["chart.js"]).controller("LineCtrl", function ($scope) {
        Chart.defaults.global.multiTooltipTemplate = function (label) {
            return label.datasetLabel + ': ' + label.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        };
        $scope.labels = [<%=buidLable(allLog)%>];
        $scope.series = ['<%=(userSender.equals("0") ? "ALL" : userSender)%>'];
        $scope.data = [
            [<%=buidData(allLog)%>]
        ];
        $scope.onClick = function (points, evt) {
            console.log(points, evt);
        };
        $scope.options = {
            animation: false,
            legend: {display: false},
            maintainAspectRatio: false,
            responsive: true,
            responsiveAnimationDuration: 0,
            tooltips: {
                callbacks: {
                    label: function (tooltipItem, data) {
                        var value = tooltipItem.yLabel;
                        if (parseInt(value) >= 1000) {
                            return data.datasets[tooltipItem.datasetIndex].label + ': ' + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
//                                                        return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        } else {
                            return data.series + " " + value;
                        }
                    }
                }
            },
            scales: {
                yAxes: [{
                        ticks: {
                            beginAtZero: true,
                            callback: function (value, index, values) {
                                if (parseInt(value) >= 1000) {
                                    return  value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                } else {
                                    return  value;
                                }
                            }
                        }
                    }]
            }
        };
    });
</script>
<%!
    private String getType(int type) {
        if (type == BrandLabel.TYPE.CSKH.val) {
            return "CSKH";
        } else if (type == BrandLabel.TYPE.QC.val) {
            return "Tin QC";
        } else {
            return type + "";
        }
    }
%>