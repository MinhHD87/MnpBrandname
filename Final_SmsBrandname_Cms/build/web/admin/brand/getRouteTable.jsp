<%@page import="gk.myname.vn.entity.OptionTelco"%>
<%@page import="gk.myname.vn.entity.OptionCheckDuplicate"%>
<%@page import="gk.myname.vn.entity.RouteTable"%><%@page import="gk.myname.vn.entity.BrandLabel"%><%@page import="gk.myname.vn.utils.RequestTool"%><%@page contentType="text/html; charset=utf-8" %>
<%
    int brId = RequestTool.getInt(request, "brid");
    BrandLabel label = BrandLabel.getFromCache(brId);
    if (label != null) {
        RouteTable route = label.getRoute();
        OptionTelco optTelco = label.buildOption();
        OptionCheckDuplicate opt_CheckDuplicateTelco = new OptionCheckDuplicate();
        if (optTelco == null) {
            opt_CheckDuplicateTelco = new OptionCheckDuplicate();
        }
        int checkDuplicateVte = opt_CheckDuplicateTelco.getVte();
        int checkDuplicateVms = opt_CheckDuplicateTelco.getMobi();
        int checkDuplicateGpc = opt_CheckDuplicateTelco.getVina();
%>
<div style="float: left;border-right: 1px solid #cd0a0a;width: 180px">
    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VIETTEL:</div>
    <div style="float: left">
        QC => <%=route.getVte().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getVte().getRoute_QC() + "</span>"%>
        <br/>
        CSKH => <%=route.getVte().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getVte().getRoute_CSKH() + "</span>"%>
        <br/>
        Chặn tin trùng => <%= checkDuplicateVte == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
    </div>
</div>
<div style="float: left;border-right: 1px solid #cd0a0a;width: 180px">
    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">MOBI:</div>
    <div style="float: left">
        QC => <%=route.getMobi().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getMobi().getRoute_QC() + "</span>"%>
        <br/>
        CSKH => <%=route.getMobi().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getMobi().getRoute_CSKH() + "</span>"%>
        <br/>
        Chặn tin trùng => <%= checkDuplicateVms == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
    </div>
</div>
<div style="float: left">
    <div style="float: left;color: #F78D1D;font-weight: bold;width: 53px">VINA:</div>
    <div style="float: left">
        QC => <%=route.getVina().getRoute_QC().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getVina().getRoute_QC() + "</span>"%>
        <br/>
        CSKH => <%=route.getVina().getRoute_CSKH().equals("0") ? "<span style='color: red;font-weight: bold'>Không Cấp</span>" : "<span style='color: blue;font-weight: bold'>" + route.getVina().getRoute_CSKH() + "</span>"%>
        <br/>
        Chặn tin trùng => <%= checkDuplicateGpc == 1 ? "<span style='color: red;font-weight: bold'>No</span>" : "<span style='color: blue;font-weight: bold'>Yes</span>"%>
    </div>
</div>
<%
    }
%>
