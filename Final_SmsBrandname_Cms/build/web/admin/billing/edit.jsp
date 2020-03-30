<%@page import="gk.myname.vn.entity.Provider_Telco"%>
<%@page import="gk.myname.vn.admin.PriceTelco"%>
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
<%@page import="gk.myname.vn.utils.RequestTool"%>
<%@page import="gk.myname.vn.admin.AccountRole"%>
<%@page import="gk.myname.vn.entity.PartnerManager"%>
<%@page import="gk.myname.vn.utils.Tool"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
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

            function addDTGT(name) {
                for (let el of document.querySelectorAll('.dtgt' + name))
                    el.style.display = '';
                document.getElementById('add' + name).style.display = 'none';
                document.getElementById('del' + name).style.display = '';
            }

            function deleteDTGT(name) {
                for (let el of document.querySelectorAll('.dtgt' + name))
                    el.style.display = 'none';
                document.getElementById('add' + name).style.display = '';
                document.getElementById('del' + name).style.display = 'none';
            }
        </script>
    </head>
    <body>
        <%
            if (!userlogin.checkEdit(request)) {
                session.setAttribute("mess", "Bạn không có quyền thêm module này!");
                response.sendRedirect(request.getContextPath() + "/admin/billing/index.jsp");
                return;
            }
            String account = Tool.validStringRequest(request.getParameter("account"));
            BillingAcc admDao = new BillingAcc();
            BillingAcc oneAccount = null;
            oneAccount = admDao.getByUsername(account);

            if (oneAccount == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ. Không lấy được thông tin tài khoản");
                response.sendRedirect(request.getContextPath() + "/admin/billing/index.jsp");
                return;
            }

            if (request.getParameter("submit") != null) {
                //----------Log--------------
                String accountname = Tool.validStringRequest(request.getParameter("accountname"));
                int prepaid = Tool.string2Integer(request.getParameter("prepaid"), 0);

                int vteprice = Tool.string2Integer(request.getParameter("vteprice"), 0);
                int vte_n1_price = Tool.string2Integer(request.getParameter("vte_n1_price"), 0);
                int vte_n2_price = Tool.string2Integer(request.getParameter("vte_n2_price"), 0);
                int vte_n3_price = Tool.string2Integer(request.getParameter("vte_n3_price"), 0);
                int vte_n4_price = Tool.string2Integer(request.getParameter("vte_n4_price"), 0);
                int vte_n5_price = Tool.string2Integer(request.getParameter("vte_n5_price"), 0);
                int vte_n6_price = Tool.string2Integer(request.getParameter("vte_n6_price"), 0);
                int vte_n7_price = Tool.string2Integer(request.getParameter("vte_n7_price"), 0);
                int vte_n8_price = Tool.string2Integer(request.getParameter("vte_n8_price"), 0);
                int vte_n9_price = Tool.string2Integer(request.getParameter("vte_n9_price"), 0);
                int vte_n10_price = Tool.string2Integer(request.getParameter("vte_n10_price"), 0);
                int vte_n11_price = Tool.string2Integer(request.getParameter("vte_n11_price"), 0);
                int vte_n12_price = Tool.string2Integer(request.getParameter("vte_n12_price"), 0);
                int vte_n13_price = Tool.string2Integer(request.getParameter("vte_n13_price"), 0);
                int vte_n14_price = Tool.string2Integer(request.getParameter("vte_n14_price"), 0);
                int vte_n15_price = Tool.string2Integer(request.getParameter("vte_n15_price"), 0);
                int vte_nlc_price = Tool.string2Integer(request.getParameter("vte_nlc_price"), 0);

                int gpcprice = Tool.string2Integer(request.getParameter("gpcprice"), 0);
                int gpc_n1_price = Tool.string2Integer(request.getParameter("gpc_n1_price"), 0);
                int gpc_n2_price = Tool.string2Integer(request.getParameter("gpc_n2_price"), 0);
                int gpc_n3_price = Tool.string2Integer(request.getParameter("gpc_n3_price"), 0);
                int gpc_n4_price = Tool.string2Integer(request.getParameter("gpc_n4_price"), 0);
                int gpc_n5_price = Tool.string2Integer(request.getParameter("gpc_n5_price"), 0);
                int gpc_n6_price = Tool.string2Integer(request.getParameter("gpc_n6_price"), 0);
                int gpc_n7_price = Tool.string2Integer(request.getParameter("gpc_n7_price"), 0);
                int gpc_n8_price = Tool.string2Integer(request.getParameter("gpc_n8_price"), 0);
                int gpc_n9_price = Tool.string2Integer(request.getParameter("gpc_n9_price"), 0);
                int gpc_n10_price = Tool.string2Integer(request.getParameter("gpc_n10_price"), 0);
                int gpc_n11_price = Tool.string2Integer(request.getParameter("gpc_n11_price"), 0);
                int gpc_n12_price = Tool.string2Integer(request.getParameter("gpc_n12_price"), 0);
                int gpc_n13_price = Tool.string2Integer(request.getParameter("gpc_n13_price"), 0);
                int gpc_n14_price = Tool.string2Integer(request.getParameter("gpc_n14_price"), 0);
                int gpc_n15_price = Tool.string2Integer(request.getParameter("gpc_n15_price"), 0);
                int gpc_nlc_price = Tool.string2Integer(request.getParameter("gpc_nlc_price"), 0);

                int vmsprice = Tool.string2Integer(request.getParameter("vmsprice"), 0);
                int vms_n1_price = Tool.string2Integer(request.getParameter("vms_n1_price"), 0);
                int vms_n2_price = Tool.string2Integer(request.getParameter("vms_n2_price"), 0);
                int vms_n3_price = Tool.string2Integer(request.getParameter("vms_n3_price"), 0);
                int vms_n4_price = Tool.string2Integer(request.getParameter("vms_n4_price"), 0);
                int vms_n5_price = Tool.string2Integer(request.getParameter("vms_n5_price"), 0);
                int vms_n6_price = Tool.string2Integer(request.getParameter("vms_n6_price"), 0);
                int vms_n7_price = Tool.string2Integer(request.getParameter("vms_n7_price"), 0);
                int vms_n8_price = Tool.string2Integer(request.getParameter("vms_n8_price"), 0);
                int vms_n9_price = Tool.string2Integer(request.getParameter("vms_n9_price"), 0);
                int vms_n10_price = Tool.string2Integer(request.getParameter("vms_n10_price"), 0);
                int vms_n11_price = Tool.string2Integer(request.getParameter("vms_n11_price"), 0);
                int vms_n12_price = Tool.string2Integer(request.getParameter("vms_n12_price"), 0);
                int vms_n13_price = Tool.string2Integer(request.getParameter("vms_n13_price"), 0);
                int vms_n14_price = Tool.string2Integer(request.getParameter("vms_n14_price"), 0);
                int vms_n15_price = Tool.string2Integer(request.getParameter("vms_n15_price"), 0);
                int vms_nlc_price = Tool.string2Integer(request.getParameter("vms_nlc_price"), 0);

                int vnmprice = Tool.string2Integer(request.getParameter("vnmprice"), 0);
                int vnm_n1_price = Tool.string2Integer(request.getParameter("vnm_n1_price"), 0);
                int vnm_n2_price = Tool.string2Integer(request.getParameter("vnm_n2_price"), 0);
                int vnm_n3_price = Tool.string2Integer(request.getParameter("vnm_n3_price"), 0);
                int vnm_n4_price = Tool.string2Integer(request.getParameter("vnm_n4_price"), 0);
                int vnm_n5_price = Tool.string2Integer(request.getParameter("vnm_n5_price"), 0);
                int vnm_n6_price = Tool.string2Integer(request.getParameter("vnm_n6_price"), 0);
                int vnm_n7_price = Tool.string2Integer(request.getParameter("vnm_n7_price"), 0);
                int vnm_n8_price = Tool.string2Integer(request.getParameter("vnm_n8_price"), 0);
                int vnm_n9_price = Tool.string2Integer(request.getParameter("vnm_n9_price"), 0);
                int vnm_n10_price = Tool.string2Integer(request.getParameter("vnm_n10_price"), 0);
                int vnm_n11_price = Tool.string2Integer(request.getParameter("vnm_n11_price"), 0);
                int vnm_n12_price = Tool.string2Integer(request.getParameter("vnm_n12_price"), 0);
                int vnm_n13_price = Tool.string2Integer(request.getParameter("vnm_n13_price"), 0);
                int vnm_n14_price = Tool.string2Integer(request.getParameter("vnm_n14_price"), 0);
                int vnm_n15_price = Tool.string2Integer(request.getParameter("vnm_n15_price"), 0);
                int vnm_nlc_price = Tool.string2Integer(request.getParameter("vnm_nlc_price"), 0);

                int blprice = Tool.string2Integer(request.getParameter("blprice"), 0);
                int bl_n1_price = Tool.string2Integer(request.getParameter("bl_n1_price"), 0);
                int bl_n2_price = Tool.string2Integer(request.getParameter("bl_n2_price"), 0);
                int bl_n3_price = Tool.string2Integer(request.getParameter("bl_n3_price"), 0);
                int bl_n4_price = Tool.string2Integer(request.getParameter("bl_n4_price"), 0);
                int bl_n5_price = Tool.string2Integer(request.getParameter("bl_n5_price"), 0);
                int bl_n6_price = Tool.string2Integer(request.getParameter("bl_n6_price"), 0);
                int bl_n7_price = Tool.string2Integer(request.getParameter("bl_n7_price"), 0);
                int bl_n8_price = Tool.string2Integer(request.getParameter("bl_n8_price"), 0);
                int bl_n9_price = Tool.string2Integer(request.getParameter("bl_n9_price"), 0);
                int bl_n10_price = Tool.string2Integer(request.getParameter("bl_n10_price"), 0);
                int bl_n11_price = Tool.string2Integer(request.getParameter("bl_n11_price"), 0);
                int bl_n12_price = Tool.string2Integer(request.getParameter("bl_n12_price"), 0);
                int bl_n13_price = Tool.string2Integer(request.getParameter("bl_n13_price"), 0);
                int bl_n14_price = Tool.string2Integer(request.getParameter("bl_n14_price"), 0);
                int bl_n15_price = Tool.string2Integer(request.getParameter("bl_n15_price"), 0);
                int bl_nlc_price = Tool.string2Integer(request.getParameter("bl_nlc_price"), 0);

                int ddgprice = Tool.string2Integer(request.getParameter("ddgprice"), 0);
                int ddg_n1_price = Tool.string2Integer(request.getParameter("ddg_n1_price"), 0);
                int ddg_n2_price = Tool.string2Integer(request.getParameter("ddg_n2_price"), 0);
                int ddg_n3_price = Tool.string2Integer(request.getParameter("ddg_n3_price"), 0);
                int ddg_n4_price = Tool.string2Integer(request.getParameter("ddg_n4_price"), 0);
                int ddg_n5_price = Tool.string2Integer(request.getParameter("ddg_n5_price"), 0);
                int ddg_n6_price = Tool.string2Integer(request.getParameter("ddg_n6_price"), 0);
                int ddg_n7_price = Tool.string2Integer(request.getParameter("ddg_n7_price"), 0);
                int ddg_n8_price = Tool.string2Integer(request.getParameter("ddg_n8_price"), 0);
                int ddg_n9_price = Tool.string2Integer(request.getParameter("ddg_n9_price"), 0);
                int ddg_n10_price = Tool.string2Integer(request.getParameter("ddg_n10_price"), 0);
                int ddg_n11_price = Tool.string2Integer(request.getParameter("ddg_n11_price"), 0);
                int ddg_n12_price = Tool.string2Integer(request.getParameter("ddg_n12_price"), 0);
                int ddg_n13_price = Tool.string2Integer(request.getParameter("ddg_n13_price"), 0);
                int ddg_n14_price = Tool.string2Integer(request.getParameter("ddg_n14_price"), 0);
                int ddg_n15_price = Tool.string2Integer(request.getParameter("ddg_n15_price"), 0);
                int ddg_nlc_price = Tool.string2Integer(request.getParameter("ddg_nlc_price"), 0);

                int cellcardprice = Tool.string2Integer(request.getParameter("cellcardprice"), 0);
                int cellcard_n1_price = Tool.string2Integer(request.getParameter("cellcard_n1_price"), 0);
                int cellcard_n2_price = Tool.string2Integer(request.getParameter("cellcard_n2_price"), 0);
                int cellcard_n3_price = Tool.string2Integer(request.getParameter("cellcard_n3_price"), 0);
                int cellcard_n4_price = Tool.string2Integer(request.getParameter("cellcard_n4_price"), 0);
                int cellcard_n5_price = Tool.string2Integer(request.getParameter("cellcard_n5_price"), 0);
                int cellcard_n6_price = Tool.string2Integer(request.getParameter("cellcard_n6_price"), 0);
                int cellcard_n7_price = Tool.string2Integer(request.getParameter("cellcard_n7_price"), 0);
                int cellcard_n8_price = Tool.string2Integer(request.getParameter("cellcard_n8_price"), 0);

                int metfoneprice = Tool.string2Integer(request.getParameter("metfoneprice"), 0);
                int metfone_n1_price = Tool.string2Integer(request.getParameter("metfone_n1_price"), 0);
                int metfone_n2_price = Tool.string2Integer(request.getParameter("metfone_n2_price"), 0);
                int metfone_n3_price = Tool.string2Integer(request.getParameter("metfone_n3_price"), 0);
                int metfone_n4_price = Tool.string2Integer(request.getParameter("metfone_n4_price"), 0);
                int metfone_n5_price = Tool.string2Integer(request.getParameter("metfone_n5_price"), 0);
                int metfone_n6_price = Tool.string2Integer(request.getParameter("metfone_n6_price"), 0);
                int metfone_n7_price = Tool.string2Integer(request.getParameter("metfone_n7_price"), 0);
                int metfone_n8_price = Tool.string2Integer(request.getParameter("metfone_n8_price"), 0);

                int beelineCampuchiaprice = Tool.string2Integer(request.getParameter("beelineCampuchiaprice"), 0);
                int beelineCampuchia_n1_price = Tool.string2Integer(request.getParameter("beelineCampuchia_n1_price"), 0);
                int beelineCampuchia_n2_price = Tool.string2Integer(request.getParameter("beelineCampuchia_n2_price"), 0);
                int beelineCampuchia_n3_price = Tool.string2Integer(request.getParameter("beelineCampuchia_n3_price"), 0);
                int beelineCampuchia_n4_price = Tool.string2Integer(request.getParameter("beelineCampuchia_n4_price"), 0);
                int beelineCampuchia_n5_price = Tool.string2Integer(request.getParameter("beelineCampuchia_n5_price"), 0);
                int beelineCampuchia_n6_price = Tool.string2Integer(request.getParameter("beelineCampuchia_n6_price"), 0);
                int beelineCampuchia_n7_price = Tool.string2Integer(request.getParameter("beelineCampuchia_n7_price"), 0);
                int beelineCampuchia_n8_price = Tool.string2Integer(request.getParameter("beelineCampuchia_n8_price"), 0);

                int smartprice = Tool.string2Integer(request.getParameter("smartprice"), 0);
                int smart_n1_price = Tool.string2Integer(request.getParameter("smart_n1_price"), 0);
                int smart_n2_price = Tool.string2Integer(request.getParameter("smart_n2_price"), 0);
                int smart_n3_price = Tool.string2Integer(request.getParameter("smart_n3_price"), 0);
                int smart_n4_price = Tool.string2Integer(request.getParameter("smart_n4_price"), 0);
                int smart_n5_price = Tool.string2Integer(request.getParameter("smart_n5_price"), 0);
                int smart_n6_price = Tool.string2Integer(request.getParameter("smart_n6_price"), 0);
                int smart_n7_price = Tool.string2Integer(request.getParameter("smart_n7_price"), 0);
                int smart_n8_price = Tool.string2Integer(request.getParameter("smart_n8_price"), 0);

                int qbmoreprice = Tool.string2Integer(request.getParameter("qbmoreprice"), 0);
                int qbmore_n1_price = Tool.string2Integer(request.getParameter("qbmore_n1_price"), 0);
                int qbmore_n2_price = Tool.string2Integer(request.getParameter("qbmore_n2_price"), 0);
                int qbmore_n3_price = Tool.string2Integer(request.getParameter("qbmore_n3_price"), 0);
                int qbmore_n4_price = Tool.string2Integer(request.getParameter("qbmore_n4_price"), 0);
                int qbmore_n5_price = Tool.string2Integer(request.getParameter("qbmore_n5_price"), 0);
                int qbmore_n6_price = Tool.string2Integer(request.getParameter("qbmore_n6_price"), 0);
                int qbmore_n7_price = Tool.string2Integer(request.getParameter("qbmore_n7_price"), 0);
                int qbmore_n8_price = Tool.string2Integer(request.getParameter("qbmore_n8_price"), 0);

                int excellprice = Tool.string2Integer(request.getParameter("excellprice"), 0);
                int excell_n1_price = Tool.string2Integer(request.getParameter("excell_n1_price"), 0);
                int excell_n2_price = Tool.string2Integer(request.getParameter("excell_n2_price"), 0);
                int excell_n3_price = Tool.string2Integer(request.getParameter("excell_n3_price"), 0);
                int excell_n4_price = Tool.string2Integer(request.getParameter("excell_n4_price"), 0);
                int excell_n5_price = Tool.string2Integer(request.getParameter("excell_n5_price"), 0);
                int excell_n6_price = Tool.string2Integer(request.getParameter("excell_n6_price"), 0);
                int excell_n7_price = Tool.string2Integer(request.getParameter("excell_n7_price"), 0);
                int excell_n8_price = Tool.string2Integer(request.getParameter("excell_n8_price"), 0);

                int telemorprice = Tool.string2Integer(request.getParameter("telemorprice"), 0);
                int telemor_n1_price = Tool.string2Integer(request.getParameter("telemor_n1_price"), 0);
                int telemor_n2_price = Tool.string2Integer(request.getParameter("telemor_n2_price"), 0);
                int telemor_n3_price = Tool.string2Integer(request.getParameter("telemor_n3_price"), 0);
                int telemor_n4_price = Tool.string2Integer(request.getParameter("telemor_n4_price"), 0);
                int telemor_n5_price = Tool.string2Integer(request.getParameter("telemor_n5_price"), 0);
                int telemor_n6_price = Tool.string2Integer(request.getParameter("telemor_n6_price"), 0);
                int telemor_n7_price = Tool.string2Integer(request.getParameter("telemor_n7_price"), 0);
                int telemor_n8_price = Tool.string2Integer(request.getParameter("telemor_n8_price"), 0);

                int timortelecomprice = Tool.string2Integer(request.getParameter("timortelecomprice"), 0);
                int timortelecom_n1_price = Tool.string2Integer(request.getParameter("timortelecom_n1_price"), 0);
                int timortelecom_n2_price = Tool.string2Integer(request.getParameter("timortelecom_n2_price"), 0);
                int timortelecom_n3_price = Tool.string2Integer(request.getParameter("timortelecom_n3_price"), 0);
                int timortelecom_n4_price = Tool.string2Integer(request.getParameter("timortelecom_n4_price"), 0);
                int timortelecom_n5_price = Tool.string2Integer(request.getParameter("timortelecom_n5_price"), 0);
                int timortelecom_n6_price = Tool.string2Integer(request.getParameter("timortelecom_n6_price"), 0);
                int timortelecom_n7_price = Tool.string2Integer(request.getParameter("timortelecom_n7_price"), 0);
                int timortelecom_n8_price = Tool.string2Integer(request.getParameter("timortelecom_n8_price"), 0);

                int movitelprice = Tool.string2Integer(request.getParameter("movitelprice"), 0);
                int movitel_n1_price = Tool.string2Integer(request.getParameter("movitel_n1_price"), 0);
                int movitel_n2_price = Tool.string2Integer(request.getParameter("movitel_n2_price"), 0);
                int movitel_n3_price = Tool.string2Integer(request.getParameter("movitel_n3_price"), 0);
                int movitel_n4_price = Tool.string2Integer(request.getParameter("movitel_n4_price"), 0);
                int movitel_n5_price = Tool.string2Integer(request.getParameter("movitel_n5_price"), 0);
                int movitel_n6_price = Tool.string2Integer(request.getParameter("movitel_n6_price"), 0);
                int movitel_n7_price = Tool.string2Integer(request.getParameter("movitel_n7_price"), 0);
                int movitel_n8_price = Tool.string2Integer(request.getParameter("movitel_n8_price"), 0);

                int mcelprice = Tool.string2Integer(request.getParameter("mcelprice"), 0);
                int mcel_n1_price = Tool.string2Integer(request.getParameter("mcel_n1_price"), 0);
                int mcel_n2_price = Tool.string2Integer(request.getParameter("mcel_n2_price"), 0);
                int mcel_n3_price = Tool.string2Integer(request.getParameter("mcel_n3_price"), 0);
                int mcel_n4_price = Tool.string2Integer(request.getParameter("mcel_n4_price"), 0);
                int mcel_n5_price = Tool.string2Integer(request.getParameter("mcel_n5_price"), 0);
                int mcel_n6_price = Tool.string2Integer(request.getParameter("mcel_n6_price"), 0);
                int mcel_n7_price = Tool.string2Integer(request.getParameter("mcel_n7_price"), 0);
                int mcel_n8_price = Tool.string2Integer(request.getParameter("mcel_n8_price"), 0);

                int unitelprice = Tool.string2Integer(request.getParameter("unitelprice"), 0);
                int unitel_n1_price = Tool.string2Integer(request.getParameter("unitel_n1_price"), 0);
                int unitel_n2_price = Tool.string2Integer(request.getParameter("unitel_n2_price"), 0);
                int unitel_n3_price = Tool.string2Integer(request.getParameter("unitel_n3_price"), 0);
                int unitel_n4_price = Tool.string2Integer(request.getParameter("unitel_n4_price"), 0);
                int unitel_n5_price = Tool.string2Integer(request.getParameter("unitel_n5_price"), 0);
                int unitel_n6_price = Tool.string2Integer(request.getParameter("unitel_n6_price"), 0);
                int unitel_n7_price = Tool.string2Integer(request.getParameter("unitel_n7_price"), 0);
                int unitel_n8_price = Tool.string2Integer(request.getParameter("unitel_n8_price"), 0);

                int etlprice = Tool.string2Integer(request.getParameter("etlprice"), 0);
                int etl_n1_price = Tool.string2Integer(request.getParameter("etl_n1_price"), 0);
                int etl_n2_price = Tool.string2Integer(request.getParameter("etl_n2_price"), 0);
                int etl_n3_price = Tool.string2Integer(request.getParameter("etl_n3_price"), 0);
                int etl_n4_price = Tool.string2Integer(request.getParameter("etl_n4_price"), 0);
                int etl_n5_price = Tool.string2Integer(request.getParameter("etl_n5_price"), 0);
                int etl_n6_price = Tool.string2Integer(request.getParameter("etl_n6_price"), 0);
                int etl_n7_price = Tool.string2Integer(request.getParameter("etl_n7_price"), 0);
                int etl_n8_price = Tool.string2Integer(request.getParameter("etl_n8_price"), 0);

                int tangoprice = Tool.string2Integer(request.getParameter("tangoprice"), 0);
                int tango_n1_price = Tool.string2Integer(request.getParameter("tango_n1_price"), 0);
                int tango_n2_price = Tool.string2Integer(request.getParameter("tango_n2_price"), 0);
                int tango_n3_price = Tool.string2Integer(request.getParameter("tango_n3_price"), 0);
                int tango_n4_price = Tool.string2Integer(request.getParameter("tango_n4_price"), 0);
                int tango_n5_price = Tool.string2Integer(request.getParameter("tango_n5_price"), 0);
                int tango_n6_price = Tool.string2Integer(request.getParameter("tango_n6_price"), 0);
                int tango_n7_price = Tool.string2Integer(request.getParameter("tango_n7_price"), 0);
                int tango_n8_price = Tool.string2Integer(request.getParameter("tango_n8_price"), 0);

                int laotelprice = Tool.string2Integer(request.getParameter("laotelprice"), 0);
                int laotel_n1_price = Tool.string2Integer(request.getParameter("laotel_n1_price"), 0);
                int laotel_n2_price = Tool.string2Integer(request.getParameter("laotel_n2_price"), 0);
                int laotel_n3_price = Tool.string2Integer(request.getParameter("laotel_n3_price"), 0);
                int laotel_n4_price = Tool.string2Integer(request.getParameter("laotel_n4_price"), 0);
                int laotel_n5_price = Tool.string2Integer(request.getParameter("laotel_n5_price"), 0);
                int laotel_n6_price = Tool.string2Integer(request.getParameter("laotel_n6_price"), 0);
                int laotel_n7_price = Tool.string2Integer(request.getParameter("laotel_n7_price"), 0);
                int laotel_n8_price = Tool.string2Integer(request.getParameter("laotel_n8_price"), 0);

                int mytelprice = Tool.string2Integer(request.getParameter("mytelprice"), 0);
                int mytel_n1_price = Tool.string2Integer(request.getParameter("mytel_n1_price"), 0);
                int mytel_n2_price = Tool.string2Integer(request.getParameter("mytel_n2_price"), 0);
                int mytel_n3_price = Tool.string2Integer(request.getParameter("mytel_n3_price"), 0);
                int mytel_n4_price = Tool.string2Integer(request.getParameter("mytel_n4_price"), 0);
                int mytel_n5_price = Tool.string2Integer(request.getParameter("mytel_n5_price"), 0);
                int mytel_n6_price = Tool.string2Integer(request.getParameter("mytel_n6_price"), 0);
                int mytel_n7_price = Tool.string2Integer(request.getParameter("mytel_n7_price"), 0);
                int mytel_n8_price = Tool.string2Integer(request.getParameter("mytel_n8_price"), 0);

                int mptprice = Tool.string2Integer(request.getParameter("mptprice"), 0);
                int mpt_n1_price = Tool.string2Integer(request.getParameter("mpt_n1_price"), 0);
                int mpt_n2_price = Tool.string2Integer(request.getParameter("mpt_n2_price"), 0);
                int mpt_n3_price = Tool.string2Integer(request.getParameter("mpt_n3_price"), 0);
                int mpt_n4_price = Tool.string2Integer(request.getParameter("mpt_n4_price"), 0);
                int mpt_n5_price = Tool.string2Integer(request.getParameter("mpt_n5_price"), 0);
                int mpt_n6_price = Tool.string2Integer(request.getParameter("mpt_n6_price"), 0);
                int mpt_n7_price = Tool.string2Integer(request.getParameter("mpt_n7_price"), 0);
                int mpt_n8_price = Tool.string2Integer(request.getParameter("mpt_n8_price"), 0);

                int ooredoprice = Tool.string2Integer(request.getParameter("ooredoprice"), 0);
                int ooredo_n1_price = Tool.string2Integer(request.getParameter("ooredo_n1_price"), 0);
                int ooredo_n2_price = Tool.string2Integer(request.getParameter("ooredo_n2_price"), 0);
                int ooredo_n3_price = Tool.string2Integer(request.getParameter("ooredo_n3_price"), 0);
                int ooredo_n4_price = Tool.string2Integer(request.getParameter("ooredo_n4_price"), 0);
                int ooredo_n5_price = Tool.string2Integer(request.getParameter("ooredo_n5_price"), 0);
                int ooredo_n6_price = Tool.string2Integer(request.getParameter("ooredo_n6_price"), 0);
                int ooredo_n7_price = Tool.string2Integer(request.getParameter("ooredo_n7_price"), 0);
                int ooredo_n8_price = Tool.string2Integer(request.getParameter("ooredo_n8_price"), 0);

                int telenorprice = Tool.string2Integer(request.getParameter("telenorprice"), 0);
                int telenor_n1_price = Tool.string2Integer(request.getParameter("telenor_n1_price"), 0);
                int telenor_n2_price = Tool.string2Integer(request.getParameter("telenor_n2_price"), 0);
                int telenor_n3_price = Tool.string2Integer(request.getParameter("telenor_n3_price"), 0);
                int telenor_n4_price = Tool.string2Integer(request.getParameter("telenor_n4_price"), 0);
                int telenor_n5_price = Tool.string2Integer(request.getParameter("telenor_n5_price"), 0);
                int telenor_n6_price = Tool.string2Integer(request.getParameter("telenor_n6_price"), 0);
                int telenor_n7_price = Tool.string2Integer(request.getParameter("telenor_n7_price"), 0);
                int telenor_n8_price = Tool.string2Integer(request.getParameter("telenor_n8_price"), 0);

                int natcomprice = Tool.string2Integer(request.getParameter("natcomprice"), 0);
                int natcom_n1_price = Tool.string2Integer(request.getParameter("natcom_n1_price"), 0);
                int natcom_n2_price = Tool.string2Integer(request.getParameter("natcom_n2_price"), 0);
                int natcom_n3_price = Tool.string2Integer(request.getParameter("natcom_n3_price"), 0);
                int natcom_n4_price = Tool.string2Integer(request.getParameter("natcom_n4_price"), 0);
                int natcom_n5_price = Tool.string2Integer(request.getParameter("natcom_n5_price"), 0);
                int natcom_n6_price = Tool.string2Integer(request.getParameter("natcom_n6_price"), 0);
                int natcom_n7_price = Tool.string2Integer(request.getParameter("natcom_n7_price"), 0);
                int natcom_n8_price = Tool.string2Integer(request.getParameter("natcom_n8_price"), 0);

                int digicelprice = Tool.string2Integer(request.getParameter("digicelprice"), 0);
                int digicel_n1_price = Tool.string2Integer(request.getParameter("digicel_n1_price"), 0);
                int digicel_n2_price = Tool.string2Integer(request.getParameter("digicel_n2_price"), 0);
                int digicel_n3_price = Tool.string2Integer(request.getParameter("digicel_n3_price"), 0);
                int digicel_n4_price = Tool.string2Integer(request.getParameter("digicel_n4_price"), 0);
                int digicel_n5_price = Tool.string2Integer(request.getParameter("digicel_n5_price"), 0);
                int digicel_n6_price = Tool.string2Integer(request.getParameter("digicel_n6_price"), 0);
                int digicel_n7_price = Tool.string2Integer(request.getParameter("digicel_n7_price"), 0);
                int digicel_n8_price = Tool.string2Integer(request.getParameter("digicel_n8_price"), 0);

                int comcelprice = Tool.string2Integer(request.getParameter("comcelprice"), 0);
                int comcel_n1_price = Tool.string2Integer(request.getParameter("comcel_n1_price"), 0);
                int comcel_n2_price = Tool.string2Integer(request.getParameter("comcel_n2_price"), 0);
                int comcel_n3_price = Tool.string2Integer(request.getParameter("comcel_n3_price"), 0);
                int comcel_n4_price = Tool.string2Integer(request.getParameter("comcel_n4_price"), 0);
                int comcel_n5_price = Tool.string2Integer(request.getParameter("comcel_n5_price"), 0);
                int comcel_n6_price = Tool.string2Integer(request.getParameter("comcel_n6_price"), 0);
                int comcel_n7_price = Tool.string2Integer(request.getParameter("comcel_n7_price"), 0);
                int comcel_n8_price = Tool.string2Integer(request.getParameter("comcel_n8_price"), 0);

                int lumitelprice = Tool.string2Integer(request.getParameter("lumitelprice"), 0);
                int lumitel_n1_price = Tool.string2Integer(request.getParameter("lumitel_n1_price"), 0);
                int lumitel_n2_price = Tool.string2Integer(request.getParameter("lumitel_n2_price"), 0);
                int lumitel_n3_price = Tool.string2Integer(request.getParameter("lumitel_n3_price"), 0);
                int lumitel_n4_price = Tool.string2Integer(request.getParameter("lumitel_n4_price"), 0);
                int lumitel_n5_price = Tool.string2Integer(request.getParameter("lumitel_n5_price"), 0);
                int lumitel_n6_price = Tool.string2Integer(request.getParameter("lumitel_n6_price"), 0);
                int lumitel_n7_price = Tool.string2Integer(request.getParameter("lumitel_n7_price"), 0);
                int lumitel_n8_price = Tool.string2Integer(request.getParameter("lumitel_n8_price"), 0);

                int africellprice = Tool.string2Integer(request.getParameter("africellprice"), 0);
                int africell_n1_price = Tool.string2Integer(request.getParameter("africell_n1_price"), 0);
                int africell_n2_price = Tool.string2Integer(request.getParameter("africell_n2_price"), 0);
                int africell_n3_price = Tool.string2Integer(request.getParameter("africell_n3_price"), 0);
                int africell_n4_price = Tool.string2Integer(request.getParameter("africell_n4_price"), 0);
                int africell_n5_price = Tool.string2Integer(request.getParameter("africell_n5_price"), 0);
                int africell_n6_price = Tool.string2Integer(request.getParameter("africell_n6_price"), 0);
                int africell_n7_price = Tool.string2Integer(request.getParameter("africell_n7_price"), 0);
                int africell_n8_price = Tool.string2Integer(request.getParameter("africell_n8_price"), 0);

                int lacellsuprice = Tool.string2Integer(request.getParameter("lacellsuprice"), 0);
                int lacellsu_n1_price = Tool.string2Integer(request.getParameter("lacellsu_n1_price"), 0);
                int lacellsu_n2_price = Tool.string2Integer(request.getParameter("lacellsu_n2_price"), 0);
                int lacellsu_n3_price = Tool.string2Integer(request.getParameter("lacellsu_n3_price"), 0);
                int lacellsu_n4_price = Tool.string2Integer(request.getParameter("lacellsu_n4_price"), 0);
                int lacellsu_n5_price = Tool.string2Integer(request.getParameter("lacellsu_n5_price"), 0);
                int lacellsu_n6_price = Tool.string2Integer(request.getParameter("lacellsu_n6_price"), 0);
                int lacellsu_n7_price = Tool.string2Integer(request.getParameter("lacellsu_n7_price"), 0);
                int lacellsu_n8_price = Tool.string2Integer(request.getParameter("lacellsu_n8_price"), 0);

                int nexttelprice = Tool.string2Integer(request.getParameter("nexttelprice"), 0);
                int nexttel_n1_price = Tool.string2Integer(request.getParameter("nexttel_n1_price"), 0);
                int nexttel_n2_price = Tool.string2Integer(request.getParameter("nexttel_n2_price"), 0);
                int nexttel_n3_price = Tool.string2Integer(request.getParameter("nexttel_n3_price"), 0);
                int nexttel_n4_price = Tool.string2Integer(request.getParameter("nexttel_n4_price"), 0);
                int nexttel_n5_price = Tool.string2Integer(request.getParameter("nexttel_n5_price"), 0);
                int nexttel_n6_price = Tool.string2Integer(request.getParameter("nexttel_n6_price"), 0);
                int nexttel_n7_price = Tool.string2Integer(request.getParameter("nexttel_n7_price"), 0);
                int nexttel_n8_price = Tool.string2Integer(request.getParameter("nexttel_n8_price"), 0);

                int mtnprice = Tool.string2Integer(request.getParameter("mtnprice"), 0);
                int mtn_n1_price = Tool.string2Integer(request.getParameter("mtn_n1_price"), 0);
                int mtn_n2_price = Tool.string2Integer(request.getParameter("mtn_n2_price"), 0);
                int mtn_n3_price = Tool.string2Integer(request.getParameter("mtn_n3_price"), 0);
                int mtn_n4_price = Tool.string2Integer(request.getParameter("mtn_n4_price"), 0);
                int mtn_n5_price = Tool.string2Integer(request.getParameter("mtn_n5_price"), 0);
                int mtn_n6_price = Tool.string2Integer(request.getParameter("mtn_n6_price"), 0);
                int mtn_n7_price = Tool.string2Integer(request.getParameter("mtn_n7_price"), 0);
                int mtn_n8_price = Tool.string2Integer(request.getParameter("mtn_n8_price"), 0);

                int orangeprice = Tool.string2Integer(request.getParameter("orangeprice"), 0);
                int orange_n1_price = Tool.string2Integer(request.getParameter("orange_n1_price"), 0);
                int orange_n2_price = Tool.string2Integer(request.getParameter("orange_n2_price"), 0);
                int orange_n3_price = Tool.string2Integer(request.getParameter("orange_n3_price"), 0);
                int orange_n4_price = Tool.string2Integer(request.getParameter("orange_n4_price"), 0);
                int orange_n5_price = Tool.string2Integer(request.getParameter("orange_n5_price"), 0);
                int orange_n6_price = Tool.string2Integer(request.getParameter("orange_n6_price"), 0);
                int orange_n7_price = Tool.string2Integer(request.getParameter("orange_n7_price"), 0);
                int orange_n8_price = Tool.string2Integer(request.getParameter("orange_n8_price"), 0);

                int halotelprice = Tool.string2Integer(request.getParameter("halotelprice"), 0);
                int halotel_n1_price = Tool.string2Integer(request.getParameter("halotel_n1_price"), 0);
                int halotel_n2_price = Tool.string2Integer(request.getParameter("halotel_n2_price"), 0);
                int halotel_n3_price = Tool.string2Integer(request.getParameter("halotel_n3_price"), 0);
                int halotel_n4_price = Tool.string2Integer(request.getParameter("halotel_n4_price"), 0);
                int halotel_n5_price = Tool.string2Integer(request.getParameter("halotel_n5_price"), 0);
                int halotel_n6_price = Tool.string2Integer(request.getParameter("halotel_n6_price"), 0);
                int halotel_n7_price = Tool.string2Integer(request.getParameter("halotel_n7_price"), 0);
                int halotel_n8_price = Tool.string2Integer(request.getParameter("halotel_n8_price"), 0);

                int vodacomprice = Tool.string2Integer(request.getParameter("vodacomprice"), 0);
                int vodacom_n1_price = Tool.string2Integer(request.getParameter("vodacom_n1_price"), 0);
                int vodacom_n2_price = Tool.string2Integer(request.getParameter("vodacom_n2_price"), 0);
                int vodacom_n3_price = Tool.string2Integer(request.getParameter("vodacom_n3_price"), 0);
                int vodacom_n4_price = Tool.string2Integer(request.getParameter("vodacom_n4_price"), 0);
                int vodacom_n5_price = Tool.string2Integer(request.getParameter("vodacom_n5_price"), 0);
                int vodacom_n6_price = Tool.string2Integer(request.getParameter("vodacom_n6_price"), 0);
                int vodacom_n7_price = Tool.string2Integer(request.getParameter("vodacom_n7_price"), 0);
                int vodacom_n8_price = Tool.string2Integer(request.getParameter("vodacom_n8_price"), 0);

                int zantelprice = Tool.string2Integer(request.getParameter("zantelprice"), 0);
                int zantel_n1_price = Tool.string2Integer(request.getParameter("zantel_n1_price"), 0);
                int zantel_n2_price = Tool.string2Integer(request.getParameter("zantel_n2_price"), 0);
                int zantel_n3_price = Tool.string2Integer(request.getParameter("zantel_n3_price"), 0);
                int zantel_n4_price = Tool.string2Integer(request.getParameter("zantel_n4_price"), 0);
                int zantel_n5_price = Tool.string2Integer(request.getParameter("zantel_n5_price"), 0);
                int zantel_n6_price = Tool.string2Integer(request.getParameter("zantel_n6_price"), 0);
                int zantel_n7_price = Tool.string2Integer(request.getParameter("zantel_n7_price"), 0);
                int zantel_n8_price = Tool.string2Integer(request.getParameter("zantel_n8_price"), 0);

                int bitelprice = Tool.string2Integer(request.getParameter("bitelprice"), 0);
                int bitel_n1_price = Tool.string2Integer(request.getParameter("bitel_n1_price"), 0);
                int bitel_n2_price = Tool.string2Integer(request.getParameter("bitel_n2_price"), 0);
                int bitel_n3_price = Tool.string2Integer(request.getParameter("bitel_n3_price"), 0);
                int bitel_n4_price = Tool.string2Integer(request.getParameter("bitel_n4_price"), 0);
                int bitel_n5_price = Tool.string2Integer(request.getParameter("bitel_n5_price"), 0);
                int bitel_n6_price = Tool.string2Integer(request.getParameter("bitel_n6_price"), 0);
                int bitel_n7_price = Tool.string2Integer(request.getParameter("bitel_n7_price"), 0);
                int bitel_n8_price = Tool.string2Integer(request.getParameter("bitel_n8_price"), 0);

                int claroprice = Tool.string2Integer(request.getParameter("claroprice"), 0);
                int claro_n1_price = Tool.string2Integer(request.getParameter("claro_n1_price"), 0);
                int claro_n2_price = Tool.string2Integer(request.getParameter("claro_n2_price"), 0);
                int claro_n3_price = Tool.string2Integer(request.getParameter("claro_n3_price"), 0);
                int claro_n4_price = Tool.string2Integer(request.getParameter("claro_n4_price"), 0);
                int claro_n5_price = Tool.string2Integer(request.getParameter("claro_n5_price"), 0);
                int claro_n6_price = Tool.string2Integer(request.getParameter("claro_n6_price"), 0);
                int claro_n7_price = Tool.string2Integer(request.getParameter("claro_n7_price"), 0);
                int claro_n8_price = Tool.string2Integer(request.getParameter("claro_n8_price"), 0);

                int telefonicaprice = Tool.string2Integer(request.getParameter("telefonicaprice"), 0);
                int telefonica_n1_price = Tool.string2Integer(request.getParameter("telefonica_n1_price"), 0);
                int telefonica_n2_price = Tool.string2Integer(request.getParameter("telefonica_n2_price"), 0);
                int telefonica_n3_price = Tool.string2Integer(request.getParameter("telefonica_n3_price"), 0);
                int telefonica_n4_price = Tool.string2Integer(request.getParameter("telefonica_n4_price"), 0);
                int telefonica_n5_price = Tool.string2Integer(request.getParameter("telefonica_n5_price"), 0);
                int telefonica_n6_price = Tool.string2Integer(request.getParameter("telefonica_n6_price"), 0);
                int telefonica_n7_price = Tool.string2Integer(request.getParameter("telefonica_n7_price"), 0);
                int telefonica_n8_price = Tool.string2Integer(request.getParameter("telefonica_n8_price"), 0);

                int monthlyActivePrice = Tool.string2Integer(request.getParameter("monthlyprice"), 0);
                int alarmmoney = Tool.string2Integer(request.getParameter("alarmmoney"), 0);

                Provider_Telco telco = new Provider_Telco();

                PriceTelco vte = new PriceTelco();
                vte.setGroup0Price(vteprice);
                vte.setGroup1Price(vte_n1_price);
                vte.setGroup2Price(vte_n2_price);
                vte.setGroup3Price(vte_n3_price);
                vte.setGroup4Price(vte_n4_price);
                vte.setGroup5Price(vte_n5_price);
                vte.setGroup6Price(vte_n6_price);
                vte.setGroup7Price(vte_n7_price);
                vte.setGroup8Price(vte_n8_price);
                vte.setGroup9Price(vte_n9_price);
                vte.setGroup10Price(vte_n10_price);
                vte.setGroup11Price(vte_n11_price);
                vte.setGroup12Price(vte_n12_price);
                vte.setGroup13Price(vte_n13_price);
                vte.setGroup14Price(vte_n14_price);
                vte.setGroup15Price(vte_n15_price);
                vte.setGroupLCPrice(vte_nlc_price);

                PriceTelco gpc = new PriceTelco();
                gpc.setGroup0Price(gpcprice);
                gpc.setGroup1Price(gpc_n1_price);
                gpc.setGroup2Price(gpc_n2_price);
                gpc.setGroup3Price(gpc_n3_price);
                gpc.setGroup4Price(gpc_n4_price);
                gpc.setGroup5Price(gpc_n5_price);
                gpc.setGroup6Price(gpc_n6_price);
                gpc.setGroup7Price(gpc_n7_price);
                gpc.setGroup8Price(gpc_n8_price);
                gpc.setGroup9Price(gpc_n9_price);
                gpc.setGroup10Price(gpc_n10_price);
                gpc.setGroup11Price(gpc_n11_price);
                gpc.setGroup12Price(gpc_n12_price);
                gpc.setGroup13Price(gpc_n13_price);
                gpc.setGroup14Price(gpc_n14_price);
                gpc.setGroup15Price(gpc_n15_price);
                gpc.setGroupLCPrice(gpc_nlc_price);

                PriceTelco vms = new PriceTelco();
                vms.setGroup0Price(vmsprice);
                vms.setGroup1Price(vms_n1_price);
                vms.setGroup2Price(vms_n2_price);
                vms.setGroup3Price(vms_n3_price);
                vms.setGroup4Price(vms_n4_price);
                vms.setGroup5Price(vms_n5_price);
                vms.setGroup6Price(vms_n6_price);
                vms.setGroup7Price(vms_n7_price);
                vms.setGroup8Price(vms_n8_price);
                vms.setGroup9Price(vms_n9_price);
                vms.setGroup10Price(vms_n10_price);
                vms.setGroup11Price(vms_n11_price);
                vms.setGroup12Price(vms_n12_price);
                vms.setGroup13Price(vms_n13_price);
                vms.setGroup14Price(vms_n14_price);
                vms.setGroup15Price(vms_n15_price);
                vms.setGroupLCPrice(vms_nlc_price);

                PriceTelco vnm = new PriceTelco();
                vnm.setGroup0Price(vnmprice);
                vnm.setGroup1Price(vnm_n1_price);
                vnm.setGroup2Price(vnm_n2_price);
                vnm.setGroup3Price(vnm_n3_price);
                vnm.setGroup4Price(vnm_n4_price);
                vnm.setGroup5Price(vnm_n5_price);
                vnm.setGroup6Price(vnm_n6_price);
                vnm.setGroup7Price(vnm_n7_price);
                vnm.setGroup8Price(vnm_n8_price);
                vnm.setGroup9Price(vnm_n9_price);
                vnm.setGroup10Price(vnm_n10_price);
                vnm.setGroup11Price(vnm_n11_price);
                vnm.setGroup12Price(vnm_n12_price);
                vnm.setGroup13Price(vnm_n13_price);
                vnm.setGroup14Price(vnm_n14_price);
                vnm.setGroup15Price(vnm_n15_price);
                vnm.setGroupLCPrice(vnm_nlc_price);

                PriceTelco bl = new PriceTelco();
                bl.setGroup0Price(blprice);
                bl.setGroup1Price(bl_n1_price);
                bl.setGroup2Price(bl_n2_price);
                bl.setGroup3Price(bl_n3_price);
                bl.setGroup4Price(bl_n4_price);
                bl.setGroup5Price(bl_n5_price);
                bl.setGroup6Price(bl_n6_price);
                bl.setGroup7Price(bl_n7_price);
                bl.setGroup8Price(bl_n8_price);
                bl.setGroup9Price(bl_n9_price);
                bl.setGroup10Price(bl_n10_price);
                bl.setGroup11Price(bl_n11_price);
                bl.setGroup12Price(bl_n12_price);
                bl.setGroup13Price(bl_n13_price);
                bl.setGroup14Price(bl_n14_price);
                bl.setGroup15Price(bl_n15_price);
                bl.setGroupLCPrice(bl_nlc_price);

                PriceTelco ddg = new PriceTelco();
                ddg.setGroup0Price(ddgprice);
                ddg.setGroup1Price(ddg_n1_price);
                ddg.setGroup2Price(ddg_n2_price);
                ddg.setGroup3Price(ddg_n3_price);
                ddg.setGroup4Price(ddg_n4_price);
                ddg.setGroup5Price(ddg_n5_price);
                ddg.setGroup6Price(ddg_n6_price);
                ddg.setGroup7Price(ddg_n7_price);
                ddg.setGroup8Price(ddg_n8_price);
                ddg.setGroup9Price(ddg_n9_price);
                ddg.setGroup10Price(ddg_n10_price);
                ddg.setGroup11Price(ddg_n11_price);
                ddg.setGroup12Price(ddg_n12_price);
                ddg.setGroup13Price(ddg_n13_price);
                ddg.setGroup14Price(ddg_n14_price);
                ddg.setGroup15Price(ddg_n15_price);
                ddg.setGroupLCPrice(ddg_nlc_price);

                PriceTelco cellcard = new PriceTelco();
                cellcard.setGroup0Price(cellcardprice);
                cellcard.setGroup1Price(cellcard_n1_price);
                cellcard.setGroup2Price(cellcard_n2_price);
                cellcard.setGroup3Price(cellcard_n3_price);
                cellcard.setGroup4Price(cellcard_n4_price);
                cellcard.setGroup5Price(cellcard_n5_price);
                cellcard.setGroup6Price(cellcard_n6_price);
                cellcard.setGroup7Price(cellcard_n7_price);
                cellcard.setGroup8Price(cellcard_n8_price);

                PriceTelco metfone = new PriceTelco();
                metfone.setGroup0Price(metfoneprice);
                metfone.setGroup1Price(metfone_n1_price);
                metfone.setGroup2Price(metfone_n2_price);
                metfone.setGroup3Price(metfone_n3_price);
                metfone.setGroup4Price(metfone_n4_price);
                metfone.setGroup5Price(metfone_n5_price);
                metfone.setGroup6Price(metfone_n6_price);
                metfone.setGroup7Price(metfone_n7_price);
                metfone.setGroup8Price(metfone_n8_price);

                PriceTelco beelineCampuchia = new PriceTelco();
                beelineCampuchia.setGroup0Price(beelineCampuchiaprice);
                beelineCampuchia.setGroup1Price(beelineCampuchia_n1_price);
                beelineCampuchia.setGroup2Price(beelineCampuchia_n2_price);
                beelineCampuchia.setGroup3Price(beelineCampuchia_n3_price);
                beelineCampuchia.setGroup4Price(beelineCampuchia_n4_price);
                beelineCampuchia.setGroup5Price(beelineCampuchia_n5_price);
                beelineCampuchia.setGroup6Price(beelineCampuchia_n6_price);
                beelineCampuchia.setGroup7Price(beelineCampuchia_n7_price);
                beelineCampuchia.setGroup8Price(beelineCampuchia_n8_price);

                PriceTelco smart = new PriceTelco();
                smart.setGroup0Price(smartprice);
                smart.setGroup1Price(smart_n1_price);
                smart.setGroup2Price(smart_n2_price);
                smart.setGroup3Price(smart_n3_price);
                smart.setGroup4Price(smart_n4_price);
                smart.setGroup5Price(smart_n5_price);
                smart.setGroup6Price(smart_n6_price);
                smart.setGroup7Price(smart_n7_price);
                smart.setGroup8Price(smart_n8_price);

                PriceTelco qbmore = new PriceTelco();
                qbmore.setGroup0Price(qbmoreprice);
                qbmore.setGroup1Price(qbmore_n1_price);
                qbmore.setGroup2Price(qbmore_n2_price);
                qbmore.setGroup3Price(qbmore_n3_price);
                qbmore.setGroup4Price(qbmore_n4_price);
                qbmore.setGroup5Price(qbmore_n5_price);
                qbmore.setGroup6Price(qbmore_n6_price);
                qbmore.setGroup7Price(qbmore_n7_price);
                qbmore.setGroup8Price(qbmore_n8_price);

                PriceTelco excell = new PriceTelco();
                excell.setGroup0Price(excellprice);
                excell.setGroup1Price(excell_n1_price);
                excell.setGroup2Price(excell_n2_price);
                excell.setGroup3Price(excell_n3_price);
                excell.setGroup4Price(excell_n4_price);
                excell.setGroup5Price(excell_n5_price);
                excell.setGroup6Price(excell_n6_price);
                excell.setGroup7Price(excell_n7_price);
                excell.setGroup8Price(excell_n8_price);

                PriceTelco telemor = new PriceTelco();
                telemor.setGroup0Price(telemorprice);
                telemor.setGroup1Price(telemor_n1_price);
                telemor.setGroup2Price(telemor_n2_price);
                telemor.setGroup3Price(telemor_n3_price);
                telemor.setGroup4Price(telemor_n4_price);
                telemor.setGroup5Price(telemor_n5_price);
                telemor.setGroup6Price(telemor_n6_price);
                telemor.setGroup7Price(telemor_n7_price);
                telemor.setGroup8Price(telemor_n8_price);

                PriceTelco timortelecom = new PriceTelco();
                timortelecom.setGroup0Price(timortelecomprice);
                timortelecom.setGroup1Price(timortelecom_n1_price);
                timortelecom.setGroup2Price(timortelecom_n2_price);
                timortelecom.setGroup3Price(timortelecom_n3_price);
                timortelecom.setGroup4Price(timortelecom_n4_price);
                timortelecom.setGroup5Price(timortelecom_n5_price);
                timortelecom.setGroup6Price(timortelecom_n6_price);
                timortelecom.setGroup7Price(timortelecom_n7_price);
                timortelecom.setGroup8Price(timortelecom_n8_price);

                PriceTelco movitel = new PriceTelco();
                movitel.setGroup0Price(movitelprice);
                movitel.setGroup1Price(movitel_n1_price);
                movitel.setGroup2Price(movitel_n2_price);
                movitel.setGroup3Price(movitel_n3_price);
                movitel.setGroup4Price(movitel_n4_price);
                movitel.setGroup5Price(movitel_n5_price);
                movitel.setGroup6Price(movitel_n6_price);
                movitel.setGroup7Price(movitel_n7_price);
                movitel.setGroup8Price(movitel_n8_price);

                PriceTelco mcel = new PriceTelco();
                mcel.setGroup0Price(mcelprice);
                mcel.setGroup1Price(mcel_n1_price);
                mcel.setGroup2Price(mcel_n2_price);
                mcel.setGroup3Price(mcel_n3_price);
                mcel.setGroup4Price(mcel_n4_price);
                mcel.setGroup5Price(mcel_n5_price);
                mcel.setGroup6Price(mcel_n6_price);
                mcel.setGroup7Price(mcel_n7_price);
                mcel.setGroup8Price(mcel_n8_price);

                PriceTelco unitel = new PriceTelco();
                unitel.setGroup0Price(unitelprice);
                unitel.setGroup1Price(unitel_n1_price);
                unitel.setGroup2Price(unitel_n2_price);
                unitel.setGroup3Price(unitel_n3_price);
                unitel.setGroup4Price(unitel_n4_price);
                unitel.setGroup5Price(unitel_n5_price);
                unitel.setGroup6Price(unitel_n6_price);
                unitel.setGroup7Price(unitel_n7_price);
                unitel.setGroup8Price(unitel_n8_price);

                PriceTelco etl = new PriceTelco();
                etl.setGroup0Price(etlprice);
                etl.setGroup1Price(etl_n1_price);
                etl.setGroup2Price(etl_n2_price);
                etl.setGroup3Price(etl_n3_price);
                etl.setGroup4Price(etl_n4_price);
                etl.setGroup5Price(etl_n5_price);
                etl.setGroup6Price(etl_n6_price);
                etl.setGroup7Price(etl_n7_price);
                etl.setGroup8Price(etl_n8_price);

                PriceTelco tango = new PriceTelco();
                tango.setGroup0Price(tangoprice);
                tango.setGroup1Price(tango_n1_price);
                tango.setGroup2Price(tango_n2_price);
                tango.setGroup3Price(tango_n3_price);
                tango.setGroup4Price(tango_n4_price);
                tango.setGroup5Price(tango_n5_price);
                tango.setGroup6Price(tango_n6_price);
                tango.setGroup7Price(tango_n7_price);
                tango.setGroup8Price(tango_n8_price);

                PriceTelco laotel = new PriceTelco();
                laotel.setGroup0Price(laotelprice);
                laotel.setGroup1Price(laotel_n1_price);
                laotel.setGroup2Price(laotel_n2_price);
                laotel.setGroup3Price(laotel_n3_price);
                laotel.setGroup4Price(laotel_n4_price);
                laotel.setGroup5Price(laotel_n5_price);
                laotel.setGroup6Price(laotel_n6_price);
                laotel.setGroup7Price(laotel_n7_price);
                laotel.setGroup8Price(laotel_n8_price);

                PriceTelco mytel = new PriceTelco();
                mytel.setGroup0Price(mytelprice);
                mytel.setGroup1Price(mytel_n1_price);
                mytel.setGroup2Price(mytel_n2_price);
                mytel.setGroup3Price(mytel_n3_price);
                mytel.setGroup4Price(mytel_n4_price);
                mytel.setGroup5Price(mytel_n5_price);
                mytel.setGroup6Price(mytel_n6_price);
                mytel.setGroup7Price(mytel_n7_price);
                mytel.setGroup8Price(mytel_n8_price);

                PriceTelco mpt = new PriceTelco();
                mpt.setGroup0Price(mptprice);
                mpt.setGroup1Price(mpt_n1_price);
                mpt.setGroup2Price(mpt_n2_price);
                mpt.setGroup3Price(mpt_n3_price);
                mpt.setGroup4Price(mpt_n4_price);
                mpt.setGroup5Price(mpt_n5_price);
                mpt.setGroup6Price(mpt_n6_price);
                mpt.setGroup7Price(mpt_n7_price);
                mpt.setGroup8Price(mpt_n8_price);

                PriceTelco ooredo = new PriceTelco();
                ooredo.setGroup0Price(ooredoprice);
                ooredo.setGroup1Price(ooredo_n1_price);
                ooredo.setGroup2Price(ooredo_n2_price);
                ooredo.setGroup3Price(ooredo_n3_price);
                ooredo.setGroup4Price(ooredo_n4_price);
                ooredo.setGroup5Price(ooredo_n5_price);
                ooredo.setGroup6Price(ooredo_n6_price);
                ooredo.setGroup7Price(ooredo_n7_price);
                ooredo.setGroup8Price(ooredo_n8_price);

                PriceTelco telenor = new PriceTelco();
                telenor.setGroup0Price(telenorprice);
                telenor.setGroup1Price(telenor_n1_price);
                telenor.setGroup2Price(telenor_n2_price);
                telenor.setGroup3Price(telenor_n3_price);
                telenor.setGroup4Price(telenor_n4_price);
                telenor.setGroup5Price(telenor_n5_price);
                telenor.setGroup6Price(telenor_n6_price);
                telenor.setGroup7Price(telenor_n7_price);
                telenor.setGroup8Price(telenor_n8_price);

                PriceTelco natcom = new PriceTelco();
                natcom.setGroup0Price(natcomprice);
                natcom.setGroup1Price(natcom_n1_price);
                natcom.setGroup2Price(natcom_n2_price);
                natcom.setGroup3Price(natcom_n3_price);
                natcom.setGroup4Price(natcom_n4_price);
                natcom.setGroup5Price(natcom_n5_price);
                natcom.setGroup6Price(natcom_n6_price);
                natcom.setGroup7Price(natcom_n7_price);
                natcom.setGroup8Price(natcom_n8_price);

                PriceTelco digicel = new PriceTelco();
                digicel.setGroup0Price(digicelprice);
                digicel.setGroup1Price(digicel_n1_price);
                digicel.setGroup2Price(digicel_n2_price);
                digicel.setGroup3Price(digicel_n3_price);
                digicel.setGroup4Price(digicel_n4_price);
                digicel.setGroup5Price(digicel_n5_price);
                digicel.setGroup6Price(digicel_n6_price);
                digicel.setGroup7Price(digicel_n7_price);
                digicel.setGroup8Price(digicel_n8_price);

                PriceTelco comcel = new PriceTelco();
                comcel.setGroup0Price(comcelprice);
                comcel.setGroup1Price(comcel_n1_price);
                comcel.setGroup2Price(comcel_n2_price);
                comcel.setGroup3Price(comcel_n3_price);
                comcel.setGroup4Price(comcel_n4_price);
                comcel.setGroup5Price(comcel_n5_price);
                comcel.setGroup6Price(comcel_n6_price);
                comcel.setGroup7Price(comcel_n7_price);
                comcel.setGroup8Price(comcel_n8_price);

                PriceTelco lumitel = new PriceTelco();
                lumitel.setGroup0Price(lumitelprice);
                lumitel.setGroup1Price(lumitel_n1_price);
                lumitel.setGroup2Price(lumitel_n2_price);
                lumitel.setGroup3Price(lumitel_n3_price);
                lumitel.setGroup4Price(lumitel_n4_price);
                lumitel.setGroup5Price(lumitel_n5_price);
                lumitel.setGroup6Price(lumitel_n6_price);
                lumitel.setGroup7Price(lumitel_n7_price);
                lumitel.setGroup8Price(lumitel_n8_price);

                PriceTelco africell = new PriceTelco();
                africell.setGroup0Price(africellprice);
                africell.setGroup1Price(africell_n1_price);
                africell.setGroup2Price(africell_n2_price);
                africell.setGroup3Price(africell_n3_price);
                africell.setGroup4Price(africell_n4_price);
                africell.setGroup5Price(africell_n5_price);
                africell.setGroup6Price(africell_n6_price);
                africell.setGroup7Price(africell_n7_price);
                africell.setGroup8Price(africell_n8_price);

                PriceTelco lacellsu = new PriceTelco();
                lacellsu.setGroup0Price(lacellsuprice);
                lacellsu.setGroup1Price(lacellsu_n1_price);
                lacellsu.setGroup2Price(lacellsu_n2_price);
                lacellsu.setGroup3Price(lacellsu_n3_price);
                lacellsu.setGroup4Price(lacellsu_n4_price);
                lacellsu.setGroup5Price(lacellsu_n5_price);
                lacellsu.setGroup6Price(lacellsu_n6_price);
                lacellsu.setGroup7Price(lacellsu_n7_price);
                lacellsu.setGroup8Price(lacellsu_n8_price);

                PriceTelco nexttel = new PriceTelco();
                nexttel.setGroup0Price(nexttelprice);
                nexttel.setGroup1Price(nexttel_n1_price);
                nexttel.setGroup2Price(nexttel_n2_price);
                nexttel.setGroup3Price(nexttel_n3_price);
                nexttel.setGroup4Price(nexttel_n4_price);
                nexttel.setGroup5Price(nexttel_n5_price);
                nexttel.setGroup6Price(nexttel_n6_price);
                nexttel.setGroup7Price(nexttel_n7_price);
                nexttel.setGroup8Price(nexttel_n8_price);

                PriceTelco mtn = new PriceTelco();
                mtn.setGroup0Price(mtnprice);
                mtn.setGroup1Price(mtn_n1_price);
                mtn.setGroup2Price(mtn_n2_price);
                mtn.setGroup3Price(mtn_n3_price);
                mtn.setGroup4Price(mtn_n4_price);
                mtn.setGroup5Price(mtn_n5_price);
                mtn.setGroup6Price(mtn_n6_price);
                mtn.setGroup7Price(mtn_n7_price);
                mtn.setGroup8Price(mtn_n8_price);

                PriceTelco orange = new PriceTelco();
                orange.setGroup0Price(orangeprice);
                orange.setGroup1Price(orange_n1_price);
                orange.setGroup2Price(orange_n2_price);
                orange.setGroup3Price(orange_n3_price);
                orange.setGroup4Price(orange_n4_price);
                orange.setGroup5Price(orange_n5_price);
                orange.setGroup6Price(orange_n6_price);
                orange.setGroup7Price(orange_n7_price);
                orange.setGroup8Price(orange_n8_price);

                PriceTelco halotel = new PriceTelco();
                halotel.setGroup0Price(halotelprice);
                halotel.setGroup1Price(halotel_n1_price);
                halotel.setGroup2Price(halotel_n2_price);
                halotel.setGroup3Price(halotel_n3_price);
                halotel.setGroup4Price(halotel_n4_price);
                halotel.setGroup5Price(halotel_n5_price);
                halotel.setGroup6Price(halotel_n6_price);
                halotel.setGroup7Price(halotel_n7_price);
                halotel.setGroup8Price(halotel_n8_price);

                PriceTelco vodacom = new PriceTelco();
                vodacom.setGroup0Price(vodacomprice);
                vodacom.setGroup1Price(vodacom_n1_price);
                vodacom.setGroup2Price(vodacom_n2_price);
                vodacom.setGroup3Price(vodacom_n3_price);
                vodacom.setGroup4Price(vodacom_n4_price);
                vodacom.setGroup5Price(vodacom_n5_price);
                vodacom.setGroup6Price(vodacom_n6_price);
                vodacom.setGroup7Price(vodacom_n7_price);
                vodacom.setGroup8Price(vodacom_n8_price);

                PriceTelco zantel = new PriceTelco();
                zantel.setGroup0Price(zantelprice);
                zantel.setGroup1Price(zantel_n1_price);
                zantel.setGroup2Price(zantel_n2_price);
                zantel.setGroup3Price(zantel_n3_price);
                zantel.setGroup4Price(zantel_n4_price);
                zantel.setGroup5Price(zantel_n5_price);
                zantel.setGroup6Price(zantel_n6_price);
                zantel.setGroup7Price(zantel_n7_price);
                zantel.setGroup8Price(zantel_n8_price);

                PriceTelco bitel = new PriceTelco();
                bitel.setGroup0Price(bitelprice);
                bitel.setGroup1Price(bitel_n1_price);
                bitel.setGroup2Price(bitel_n2_price);
                bitel.setGroup3Price(bitel_n3_price);
                bitel.setGroup4Price(bitel_n4_price);
                bitel.setGroup5Price(bitel_n5_price);
                bitel.setGroup6Price(bitel_n6_price);
                bitel.setGroup7Price(bitel_n7_price);
                bitel.setGroup8Price(bitel_n8_price);

                PriceTelco claro = new PriceTelco();
                claro.setGroup0Price(claroprice);
                claro.setGroup1Price(claro_n1_price);
                claro.setGroup2Price(claro_n2_price);
                claro.setGroup3Price(claro_n3_price);
                claro.setGroup4Price(claro_n4_price);
                claro.setGroup5Price(claro_n5_price);
                claro.setGroup6Price(claro_n6_price);
                claro.setGroup7Price(claro_n7_price);
                claro.setGroup8Price(claro_n8_price);

                PriceTelco telefonica = new PriceTelco();
                telefonica.setGroup0Price(telefonicaprice);
                telefonica.setGroup1Price(telefonica_n1_price);
                telefonica.setGroup2Price(telefonica_n2_price);
                telefonica.setGroup3Price(telefonica_n3_price);
                telefonica.setGroup4Price(telefonica_n4_price);
                telefonica.setGroup5Price(telefonica_n5_price);
                telefonica.setGroup6Price(telefonica_n6_price);
                telefonica.setGroup7Price(telefonica_n7_price);
                telefonica.setGroup8Price(telefonica_n8_price);

                oneAccount.setPrepaid(prepaid);
                telco.setVte(vte);
                telco.setVina(gpc);
                telco.setMobi(vms);
                telco.setVnm(vnm);
                telco.setBl(bl);
                telco.setDdg(ddg);
                telco.setCellcard(cellcard);
                telco.setMetfone(metfone);
                telco.setBeelineCampuchia(beelineCampuchia);
                telco.setSmart(smart);
                telco.setQbmore(qbmore);
                telco.setExcell(excell);

                telco.setTelemor(telemor);
                telco.setTimortelecom(timortelecom);

                telco.setMovitel(movitel);
                telco.setMcel(mcel);

                telco.setUnitel(unitel);
                telco.setEtl(etl);
                telco.setTango(tango);
                telco.setLaotel(laotel);

                telco.setMytel(mytel);
                telco.setMpt(mpt);
                telco.setOoredo(ooredo);
                telco.setTelenor(telenor);

                telco.setNatcom(natcom);
                telco.setDigicel(digicel);
                telco.setComcel(comcel);

                telco.setLumitel(lumitel);
                telco.setAfricell(africell);
                telco.setLacellsu(lacellsu);

                telco.setNexttel(nexttel);
                telco.setMtn(mtn);
                telco.setOrange(orange);

                telco.setHalotel(halotel);
                telco.setVodacom(vodacom);
                telco.setZantel(zantel);

                telco.setBitel(bitel);
                telco.setClaro(claro);
                telco.setTelefonica(telefonica);

                oneAccount.setMonthly_price_active(monthlyActivePrice);
                oneAccount.setAlarmmoney(alarmmoney);
                oneAccount.setSell_price(telco);

                if (admDao.addPrice(oneAccount)) {
                    //Call API thong bao billing cap nhat thong tin acc de billing khi trang thai la tra truoc
                    if (prepaid == 1) {
                        String urlCallApi = "http://127.0.0.1:9937/service/billing_api";
                        String addMoneyAPI = doPostJson(oneAccount.getUsername(), 0, "", "RELOAD", 0, "", urlCallApi, gpc.toJson(), vte.toJson(), vms.toJson(), vnm.toJson(), bl.toJson(), ddg.toJson(), 0, monthlyActivePrice);
                        int resultAdd = Tool.string2Integer(addMoneyAPI, 0);
                    }

                    session.setAttribute("mess", "Sửa tài khoản thành công");
                    response.sendRedirect(request.getContextPath() + "/admin/billing/index.jsp");
                    return;
                } else {
                    session.setAttribute("mess", "Sửa tài khoản lỗi");
                }
            }
        %>

        <%-- JSP DATA --%>
        <%!            static final ObjectMapper mapper = new ObjectMapper();

            String doPostJson(String account, int smsNumber, String telcoCode, String action, int money, String security, String url_call, String gpc, String vte, String vms, String vnm, String bl, String ddg, int sms_quota, int monthly_price_active) {
                String result = "Error";
                try {
                    Map dataMap = new HashMap();
                    dataMap.put("account", account);
                    dataMap.put("smsNumber", smsNumber);
                    dataMap.put("telcoCode", telcoCode);
                    dataMap.put("action", action);
                    dataMap.put("money", money);
                    dataMap.put("security", security);

                    dataMap.put("gpc", gpc);
                    dataMap.put("vte", vte);
                    dataMap.put("vms", vms);
                    dataMap.put("vnm", vnm);
                    dataMap.put("bl", bl);
                    dataMap.put("ddg", ddg);
                    dataMap.put("sms_quota", sms_quota);
                    dataMap.put("monthly_price_active", monthly_price_active);

                    mapper.getFactory().configure(JsonGenerator.Feature.ESCAPE_NON_ASCII, true);
                    String strJson = mapper.writeValueAsString(dataMap);
                    String data = strJson;
//                    System.out.println("escape param:" + data);
//                    System.out.println("unescape param:" + JSONUtil.unescape(data));
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
                        <script>
                                         var inputnumber = 'Giá trị nhập vào không phải là số';
	function FormatNumber(str) {
		var strTemp = GetNumber(str);
		if (strTemp.length <= 3)
			return strTemp;
		strResult = "";
		for (var i = 0; i < strTemp.length; i++)
			strTemp = strTemp.replace(",", "");
		var m = strTemp.lastIndexOf(".");
		if (m == -1) {
			for (var i = strTemp.length; i >= 0; i--) {
				if (strResult.length > 0 && (strTemp.length - i - 1) % 3 == 0)
					strResult = "," + strResult;
				strResult = strTemp.substring(i, i + 1) + strResult;
			}
		} else {
			var strphannguyen = strTemp.substring(0, strTemp.lastIndexOf("."));
			var strphanthapphan = strTemp.substring(strTemp.lastIndexOf("."),
					strTemp.length);
			var tam = 0;
			for (var i = strphannguyen.length; i >= 0; i--) {

				if (strResult.length > 0 && tam == 4) {
					strResult = "," + strResult;
					tam = 1;
				}

				strResult = strphannguyen.substring(i, i + 1) + strResult;
				tam = tam + 1;
			}
			strResult = strResult + strphanthapphan;
		}
		return strResult;
	}

	function GetNumber(str) {
		var count = 0;
		for (var i = 0; i < str.length; i++) {
			var temp = str.substring(i, i + 1);
			if (!(temp == "," || temp == "." || (temp >= 0 && temp <= 9))) {
				alert(inputnumber);
				return str.substring(0, i);
			}
			if (temp == " ")
				return str.substring(0, i);
			if (temp == ".") {
				if (count > 0)
					return str.substring(0, ipubl_date);
				count++;
			}
		}
		return str;
	}

	function IsNumberInt(str) {
		for (var i = 0; i < str.length; i++) {
			var temp = str.substring(i, i + 1);
			if (!(temp == "." || (temp >= 0 && temp <= 9))) {
				alert(inputnumber);
				return str.substring(0, i);
			}
			if (temp == ",") {
				return str.substring(0, i);
			}
		}
		return str;
	}
                                </script>
                        <form action="" method="post">
                            <table align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th colspan="4" style="font-weight: bold"  scope="col" class="rounded redBoldUp">Cập nhật thông tin Đại lý </th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <tr>
                                        <td></td>
                                        <td align="left">Tài khoản:</td>
                                        <td colspan="5">
                                            <input readonly type="text" name="accountname" value="<%=oneAccount.getUsername()%>"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Kiểu thanh toán:</td>
                                        <td colspan="5">
                                            <select name="prepaid" >
                                                <option <%=oneAccount.getPrepaid() == 0 ? "selected='selected'" : ""%> value="0">Trả sau</option>
                                                <option <%=oneAccount.getPrepaid() == 1 ? "selected='selected'" : ""%> value="1">Trả trước</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Phí duy trì Brandname:</td>
                                        <td colspan="5">
                                            <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="monthlyprice" size="15" value="<%=Tool.dinhDangTienTe(oneAccount.getMonthly_price_active()+"")%>">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mức cảnh báo tiền:</td>
                                        <td colspan="5">
                                            <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="alarmmoney" size="15" value="<%=Tool.dinhDangTienTe(oneAccount.getAlarmmoney()+"")%>">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="7" align="center" ><b>BẢNG GIÁ CÁC NHÓM CỦA MỖI NHÀ MẠNG(nhóm 0 là mặc định)</b></td>
                                    </tr>
                                        <%
                                            Provider_Telco telco = oneAccount.getSell_price();

                                        %>                                    
                                        <SCRIPT language="javascript">
                                            function show(name) {
                                                for (let el of document.querySelectorAll('.spp'+name)) el.style.display = '';
                                                document.getElementById('showPrice'+name).style.display = 'none';
                                                document.getElementById('hidePrice'+name).style.display = '';
                                            }

                                            function hide(name) {
                                                for (let el of document.querySelectorAll('.spp'+name)) el.style.display = 'none';
                                                document.getElementById('showPrice'+name).style.display = '';
                                                document.getElementById('hidePrice'+name).style.display = 'none';
                                            }
                                            function showP(name) {
                                                document.getElementById('show'+name).style.display = 'none';
                                                document.getElementById('hide'+name).style.display = '';
                                                for (let el of document.querySelectorAll('.price'+name)) el.style.display = '';
                                            }

                                            function hideP(name) {
                                                document.getElementById('show'+name).style.display = '';
                                                document.getElementById('hide'+name).style.display = 'none';
                                                for (let el of document.querySelectorAll('.price'+name)) el.style.display = 'none';
                                            }

                                        </SCRIPT>
                                    <tr>
                                        <td></td>
                                        <td><h3>Việt Nam</h3></td>
                                        <td colspan="5">
                                                <div id="showVietnam" style="float: right">
                                                    <img onclick="showP('Vietnam')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideVietnam" style="float: right;display: none">
                                                    <img onclick="hideP('Vietnam')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                        </td>
                                    </tr>
                                    <tr class="priceVietnam" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>VIETTEL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vteprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup0Price()+"")%>">
                                            <div id="showPriceViettel" style="float: right">
                                                <img onclick="show('Viettel')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceViettel" style="float: right;display: none">
                                                <img onclick="hide('Viettel')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppViettel" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppViettel" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppViettel" style="display: none">
                                                Nhóm 09:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n9_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup9Price()+"")%>"/><br/>
                                                Nhóm 10:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n10_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup10Price()+"")%>"/><br/>
                                                Nhóm 11:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n11_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup11Price()+"")%>"/><br/>
                                                Nhóm 12:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n12_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup12Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppViettel" style="display: none">
                                                Nhóm 13:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n13_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup13Price()+"")%>"/><br/>
                                                Nhóm 14:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n14_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup14Price()+"")%>"/><br/>
                                                Nhóm 15:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_n15_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroup15Price()+"")%>"/><br/>
                                                Nhóm LC:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vte_nlc_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVte().getGroupLCPrice()+"")%>"/><br/>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceVietnam" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>VINA</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpcprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup0Price()+"")%>">
                                            <div id="showPriceVina" style="float: right">
                                                <img onclick="show('Vina')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceVina" style="float: right;display: none">
                                                <img onclick="hide('Vina')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppVina" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppVina" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppVina" style="display: none">
                                                Nhóm 09:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n9_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup9Price()+"")%>"/><br/>
                                                Nhóm 10:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n10_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup10Price()+"")%>"/><br/>
                                                Nhóm 11:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n11_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup11Price()+"")%>"/><br/>
                                                Nhóm 12:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n12_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup12Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppVina" style="display: none">
                                                Nhóm 13:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n13_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup13Price()+"")%>"/><br/>
                                                Nhóm 14:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n14_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup14Price()+"")%>"/><br/>
                                                Nhóm 15:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_n15_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroup15Price()+"")%>"/><br/>
                                                Nhóm LC:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="gpc_nlc_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVina().getGroupLCPrice()+"")%>"/><br/>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceVietnam" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>MOBI</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vmsprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup0Price()+"")%>">
                                            <div id="showPriceMobi" style="float: right">
                                                <img onclick="show('Mobi')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceMobi" style="float: right;display: none">
                                                <img onclick="hide('Mobi')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMobi" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMobi" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMobi" style="display: none">
                                                Nhóm 09:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n9_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup9Price()+"")%>"/><br/>
                                                Nhóm 10:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n10_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup10Price()+"")%>"/><br/>
                                                Nhóm 11:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n11_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup11Price()+"")%>"/><br/>
                                                Nhóm 12:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n12_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup12Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMobi" style="display: none">
                                                Nhóm 13:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n13_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup13Price()+"")%>"/><br/>
                                                Nhóm 14:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n14_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup14Price()+"")%>"/><br/>
                                                Nhóm 15:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_n15_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroup15Price()+"")%>"/><br/>
                                                Nhóm LC:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vms_nlc_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMobi().getGroupLCPrice()+"")%>"/><br/>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceVietnam" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>VIETNAM MOBILE</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnmprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup0Price()+"")%>">
                                            <div id="showPriceVnm" style="float: right">
                                                <img onclick="show('Vnm')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceVnm" style="float: right;display: none">
                                                <img onclick="hide('Vnm')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppVnm" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppVnm" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppVnm" style="display: none">
                                                Nhóm 09:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n9_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup9Price()+"")%>"/><br/>
                                                Nhóm 10:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n10_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup10Price()+"")%>"/><br/>
                                                Nhóm 11:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n11_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup11Price()+"")%>"/><br/>
                                                Nhóm 12:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n12_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup12Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppVnm" style="display: none">
                                                Nhóm 13:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n13_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup13Price()+"")%>"/><br/>
                                                Nhóm 14:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n14_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup14Price()+"")%>"/><br/>
                                                Nhóm 15:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_n15_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroup15Price()+"")%>"/><br/>
                                                Nhóm LC:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vnm_nlc_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVnm().getGroupLCPrice()+"")%>"/><br/>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceVietnam" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>BEELINE</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="blprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup0Price()+"")%>">
                                            <div id="showPriceBl" style="float: right">
                                                <img onclick="show('Bl')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceBl" style="float: right;display: none">
                                                <img onclick="hide('Bl')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppBl" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppBl" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppBl" style="display: none">
                                                Nhóm 09:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n9_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup9Price()+"")%>"/><br/>
                                                Nhóm 10:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n10_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup10Price()+"")%>"/><br/>
                                                Nhóm 11:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n11_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup11Price()+"")%>"/><br/>
                                                Nhóm 12:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n12_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup12Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppBl" style="display: none">
                                                Nhóm 13:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n13_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup13Price()+"")%>"/><br/>
                                                Nhóm 14:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n14_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup14Price()+"")%>"/><br/>
                                                Nhóm 15:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_n15_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroup15Price()+"")%>"/><br/>
                                                Nhóm LC:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bl_nlc_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBl().getGroupLCPrice()+"")%>"/><br/>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceVietnam" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>ITELECOM</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddgprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup0Price()+"")%>">
                                            <div id="showPriceDDg" style="float: right">
                                                <img onclick="show('DDg')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceDDg" style="float: right;display: none">
                                                <img onclick="hide('DDg')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppDDg" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppDDg" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppDDg" style="display: none">
                                                Nhóm 09:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n9_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup9Price()+"")%>"/><br/>
                                                Nhóm 10:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n10_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup10Price()+"")%>"/><br/>
                                                Nhóm 11:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n11_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup11Price()+"")%>"/><br/>
                                                Nhóm 12:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n12_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup12Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppDDg" style="display: none">
                                                Nhóm 13:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n13_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup13Price()+"")%>"/><br/>
                                                Nhóm 14:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n14_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup14Price()+"")%>"/><br/>
                                                Nhóm 15:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_n15_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroup15Price()+"")%>"/><br/>
                                                Nhóm LC:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ddg_nlc_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDdg().getGroupLCPrice()+"")%>"/><br/>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><h3>Campuchia</h3></td>
                                        <td colspan="5">
                                                <div id="showCampuchia" style="float: right">
                                                    <img onclick="showP('Campuchia')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideCampuchia" style="float: right;display: none">
                                                    <img onclick="hideP('Campuchia')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                        </td>
                                    </tr>
                                    <tr class="priceCampuchia" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>CELLCARD</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="cellcardprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getCellcard().getGroup0Price()+"")%>">
                                            <div id="showPriceCellcard" style="float: right">
                                                <img onclick="show('Cellcard')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceCellcard" style="float: right;display: none">
                                                <img onclick="hide('Cellcard')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppCellcard" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="cellcard_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getCellcard().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="cellcard_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getCellcard().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="cellcard_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getCellcard().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="cellcard_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getCellcard().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppCellcard" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="cellcard_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getCellcard().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="cellcard_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getCellcard().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="cellcard_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getCellcard().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="cellcard_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getCellcard().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppCellcard" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppCellcard" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceCampuchia" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>METFONE</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="metfoneprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getMetfone().getGroup0Price()+"")%>">
                                            <div id="showPriceMetfone" style="float: right">
                                                <img onclick="show('Metfone')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceMetfone" style="float: right;display: none">
                                                <img onclick="hide('Metfone')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMetfone" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="metfone_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMetfone().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="metfone_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMetfone().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="metfone_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMetfone().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="metfone_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMetfone().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMetfone" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="metfone_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMetfone().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="metfone_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMetfone().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="metfone_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMetfone().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="metfone_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMetfone().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMetfone" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMetfone" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceCampuchia" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>BEELINE CAMPUCHIA</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="beelineCampuchiaprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup0Price()+"")%>">
                                            <div id="showPriceBeelineCampuchia" style="float: right">
                                                <img onclick="show('BeelineCampuchia')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceBeelineCampuchia" style="float: right;display: none">
                                                <img onclick="hide('BeelineCampuchia')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppBeelineCampuchia" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="beelineCampuchia_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="beelineCampuchia_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="beelineCampuchia_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="beelineCampuchia_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppBeelineCampuchia" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="beelineCampuchia_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="beelineCampuchia_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="beelineCampuchia_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="beelineCampuchia_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBeelineCampuchia().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppBeelineCampuchia" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppBeelineCampuchia" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceCampuchia" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>SMART</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="smartprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getSmart().getGroup0Price()+"")%>">
                                            <div id="showPriceSmart" style="float: right">
                                                <img onclick="show('Smart')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceSmart" style="float: right;display: none">
                                                <img onclick="hide('Smart')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppSmart" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="smart_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getSmart().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="smart_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getSmart().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="smart_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getSmart().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="smart_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getSmart().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppSmart" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="smart_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getSmart().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="smart_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getSmart().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="smart_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getSmart().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="smart_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getSmart().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppSmart" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppSmart" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceCampuchia" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>QBMORE</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="qbmoreprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getQbmore().getGroup0Price()+"")%>">
                                            <div id="showPriceQbmore" style="float: right">
                                                <img onclick="show('Qbmore')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceQbmore" style="float: right;display: none">
                                                <img onclick="hide('Qbmore')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppQbmore" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="qbmore_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getQbmore().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="qbmore_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getQbmore().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="qbmore_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getQbmore().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="qbmore_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getQbmore().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppQbmore" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="qbmore_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getQbmore().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="qbmore_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getQbmore().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="qbmore_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getQbmore().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="qbmore_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getQbmore().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppQbmore" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppQbmore" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceCampuchia" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>EXCELL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="excellprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getExcell().getGroup0Price()+"")%>">
                                            <div id="showPriceExcell" style="float: right">
                                                <img onclick="show('Excell')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceExcell" style="float: right;display: none">
                                                <img onclick="hide('Excell')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppExcell" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="excell_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getExcell().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="excell_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getExcell().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="excell_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getExcell().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="excell_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getExcell().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppExcell" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="excell_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getExcell().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="excell_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getExcell().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="excell_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getExcell().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="excell_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getExcell().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppExcell" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppExcell" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><h3>Dongtimor</h3></td>
                                        <td colspan="5">
                                                <div id="showDongtimor" style="float: right">
                                                    <img onclick="showP('Dongtimor')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideDongtimor" style="float: right;display: none">
                                                    <img onclick="hideP('Dongtimor')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                        </td>
                                    </tr>
                                    <tr class="priceDongtimor" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>TELEMOR</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telemorprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelemor().getGroup0Price()+"")%>">
                                            <div id="showPriceTelemor" style="float: right">
                                                <img onclick="show('Telemor')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceTelemor" style="float: right;display: none">
                                                <img onclick="hide('Telemor')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTelemor" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telemor_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelemor().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telemor_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelemor().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telemor_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelemor().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telemor_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelemor().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTelemor" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telemor_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelemor().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telemor_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelemor().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telemor_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelemor().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telemor_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelemor().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTelemor" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTelemor" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceDongtimor" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>TIMOR TELECOM</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="timortelecomprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getTimortelecom().getGroup0Price()+"")%>">
                                            <div id="showPriceTimortelecom" style="float: right">
                                                <img onclick="show('Timortelecom')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceTimortelecom" style="float: right;display: none">
                                                <img onclick="hide('Timortelecom')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTimortelecom" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="timortelecom_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTimortelecom().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="timortelecom_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTimortelecom().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="timortelecom_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTimortelecom().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="timortelecom_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTimortelecom().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTimortelecom" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="timortelecom_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTimortelecom().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="timortelecom_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTimortelecom().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="timortelecom_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTimortelecom().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="timortelecom_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTimortelecom().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTimortelecom" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTimortelecom" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><h3>Mozambique</h3></td>
                                        <td colspan="5">
                                                <div id="showMozambique" style="float: right">
                                                    <img onclick="showP('Mozambique')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideMozambique" style="float: right;display: none">
                                                    <img onclick="hideP('Mozambique')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                        </td>
                                    </tr>
                                    <tr class="priceMozambique" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>MOVITEL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="movitelprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getMovitel().getGroup0Price()+"")%>">
                                            <div id="showPriceMovitel" style="float: right">
                                                <img onclick="show('Movitel')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceMovitel" style="float: right;display: none">
                                                <img onclick="hide('Movitel')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMovitel" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="movitel_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMovitel().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="movitel_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMovitel().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="movitel_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMovitel().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="movitel_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMovitel().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMovitel" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="movitel_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMovitel().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="movitel_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMovitel().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="movitel_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMovitel().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="movitel_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMovitel().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMovitel" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMovitel" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceMozambique" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>MCEL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mcelprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getMcel().getGroup0Price()+"")%>">
                                            <div id="showPriceMcel" style="float: right">
                                                <img onclick="show('Mcel')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceMcel" style="float: right;display: none">
                                                <img onclick="hide('Mcel')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMcel" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mcel_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMcel().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mcel_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMcel().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mcel_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMcel().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mcel_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMcel().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMcel" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mcel_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMcel().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mcel_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMcel().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mcel_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMcel().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mcel_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMcel().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMcel" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMcel" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><h3>Lao</h3></td>
                                        <td colspan="5">
                                                <div id="showLao" style="float: right">
                                                    <img onclick="showP('Lao')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideLao" style="float: right;display: none">
                                                    <img onclick="hideP('Lao')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                        </td>
                                    </tr>
                                    <tr class="priceLao" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>UNITEL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="unitelprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getUnitel().getGroup0Price()+"")%>">
                                            <div id="showPriceUnitel" style="float: right">
                                                <img onclick="show('Unitel')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceUnitel" style="float: right;display: none">
                                                <img onclick="hide('Unitel')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppUnitel" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="unitel_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getUnitel().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="unitel_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getUnitel().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="unitel_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getUnitel().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="unitel_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getUnitel().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppUnitel" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="unitel_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getUnitel().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="unitel_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getUnitel().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="unitel_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getUnitel().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="unitel_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getUnitel().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppUnitel" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppUnitel" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceLao" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>ETL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="etlprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getEtl().getGroup0Price()+"")%>">
                                            <div id="showPriceEtl" style="float: right">
                                                <img onclick="show('Etl')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceEtl" style="float: right;display: none">
                                                <img onclick="hide('Etl')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppEtl" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="etl_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getEtl().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="etl_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getEtl().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="etl_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getEtl().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="etl_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getEtl().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppEtl" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="etl_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getEtl().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="etl_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getEtl().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="etl_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getEtl().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="etl_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getEtl().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppEtl" style="display: none">
                                                
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppEtl" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceLao" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>TANGO</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="tangoprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getTango().getGroup0Price()+"")%>">
                                            <div id="showPriceTango" style="float: right">
                                                <img onclick="show('Tango')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceTango" style="float: right;display: none">
                                                <img onclick="hide('Tango')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTango" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="tango_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTango().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="tango_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTango().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="tango_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTango().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="tango_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTango().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTango" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="tango_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTango().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="tango_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTango().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="tango_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTango().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="tango_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTango().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTango" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTango" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceLao" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>LAOTEL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="laotelprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getLaotel().getGroup0Price()+"")%>">
                                            <div id="showPriceLaotel" style="float: right">
                                                <img onclick="show('Laotel')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceLaotel" style="float: right;display: none">
                                                <img onclick="hide('Laotel')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppLaotel" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="laotel_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLaotel().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="laotel_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLaotel().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="laotel_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLaotel().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="laotel_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLaotel().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppLaotel" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="laotel_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLaotel().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="laotel_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLaotel().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="laotel_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLaotel().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="laotel_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLaotel().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppLaotel" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppLaotel" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><h3>Mianmar</h3></td>
                                        <td colspan="5">
                                                <div id="showMianmar" style="float: right">
                                                    <img onclick="showP('Mianmar')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideMianmar" style="float: right;display: none">
                                                    <img onclick="hideP('Mianmar')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                        </td>
                                    </tr>
                                    <tr class="priceMianmar" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>MYTEL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mytelprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getMytel().getGroup0Price()+"")%>">
                                            <div id="showPriceMytel" style="float: right">
                                                <img onclick="show('Mytel')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceMytel" style="float: right;display: none">
                                                <img onclick="hide('Mytel')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMytel" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mytel_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMytel().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mytel_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMytel().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mytel_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMytel().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mytel_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMytel().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMytel" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mytel_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMytel().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mytel_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMytel().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mytel_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMytel().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mytel_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMytel().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMytel" style="display: none">
                                                
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMytel" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceMianmar" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>MPT</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mptprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getMpt().getGroup0Price()+"")%>">
                                            <div id="showPriceMpt" style="float: right">
                                                <img onclick="show('Mpt')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceMpt" style="float: right;display: none">
                                                <img onclick="hide('Mpt')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMpt" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mpt_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMpt().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mpt_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMpt().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mpt_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMpt().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mpt_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMpt().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMpt" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mpt_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMpt().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mpt_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMpt().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mpt_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMpt().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mpt_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMpt().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMpt" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMpt" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceMianmar" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>OOREDO</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ooredoprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getOoredo().getGroup0Price()+"")%>">
                                            <div id="showPriceOoredo" style="float: right">
                                                <img onclick="show('Ooredo')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceOoredo" style="float: right;display: none">
                                                <img onclick="hide('Ooredo')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppOoredo" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ooredo_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOoredo().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ooredo_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOoredo().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ooredo_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOoredo().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ooredo_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOoredo().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppOoredo" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ooredo_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOoredo().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ooredo_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOoredo().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ooredo_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOoredo().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="ooredo_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOoredo().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppOoredo" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppOoredo" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceMianmar" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>TELENOR</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telenorprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelenor().getGroup0Price()+"")%>">
                                            <div id="showPriceTelenor" style="float: right">
                                                <img onclick="show('Telenor')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceTelenor" style="float: right;display: none">
                                                <img onclick="hide('Telenor')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTelenor" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telenor_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelenor().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telenor_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelenor().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telenor_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelenor().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telenor_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelenor().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTelenor" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telenor_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelenor().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telenor_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelenor().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telenor_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelenor().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telenor_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelenor().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTelenor" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTelenor" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><h3>Haiti</h3></td>
                                        <td colspan="5">
                                                <div id="showHaiti" style="float: right">
                                                    <img onclick="showP('Haiti')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideHaiti" style="float: right;display: none">
                                                    <img onclick="hideP('Haiti')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                        </td>
                                    </tr>
                                    <tr class="priceHaiti" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>NATCOM</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="natcomprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getNatcom().getGroup0Price()+"")%>">
                                            <div id="showPriceNatcom" style="float: right">
                                                <img onclick="show('Natcom')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceNatcom" style="float: right;display: none">
                                                <img onclick="hide('Natcom')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppNatcom" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="natcom_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNatcom().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="natcom_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNatcom().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="natcom_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNatcom().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="natcom_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNatcom().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppNatcom" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="natcom_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNatcom().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="natcom_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNatcom().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="natcom_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNatcom().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="natcom_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNatcom().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppNatcom" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppNatcom" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceHaiti" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>DIGICEL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="digicelprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getDigicel().getGroup0Price()+"")%>">
                                            <div id="showPriceDigicel" style="float: right">
                                                <img onclick="show('Digicel')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceDigicel" style="float: right;display: none">
                                                <img onclick="hide('Digicel')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppDigicel" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="digicel_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDigicel().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="digicel_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDigicel().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="digicel_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDigicel().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="digicel_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDigicel().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppDigicel" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="digicel_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDigicel().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="digicel_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDigicel().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="digicel_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDigicel().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="digicel_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getDigicel().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppDigicel" style="display: none">
                                            
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppDigicel" style="display: none">
                                            
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceHaiti" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>COMCEL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="comcelprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getComcel().getGroup0Price()+"")%>">
                                            <div id="showPriceComcel" style="float: right">
                                                <img onclick="show('Comcel')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceComcel" style="float: right;display: none">
                                                <img onclick="hide('Comcel')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppComcel" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="comcel_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getComcel().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="comcel_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getComcel().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="comcel_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getComcel().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="comcel_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getComcel().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppComcel" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="comcel_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getComcel().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="comcel_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getComcel().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="comcel_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getComcel().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="comcel_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getComcel().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppComcel" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppComcel" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><h3>Burundi</h3></td>
                                        <td colspan="5">
                                                <div id="showBurundi" style="float: right">
                                                    <img onclick="showP('Burundi')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideBurundi" style="float: right;display: none">
                                                    <img onclick="hideP('Burundi')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                        </td>
                                    </tr>
                                    <tr class="priceBurundi" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>LUMITEL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lumitelprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getLumitel().getGroup0Price()+"")%>">
                                            <div id="showPriceLumitel" style="float: right">
                                                <img onclick="show('Lumitel')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceLumitel" style="float: right;display: none">
                                                <img onclick="hide('Lumitel')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppLumitel" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lumitel_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLumitel().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lumitel_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLumitel().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lumitel_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLumitel().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lumitel_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLumitel().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppLumitel" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lumitel_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLumitel().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lumitel_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLumitel().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lumitel_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLumitel().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lumitel_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLumitel().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppLumitel" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppLumitel" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceBurundi" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>AFRICELL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="africellprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getAfricell().getGroup0Price()+"")%>">
                                            <div id="showPriceAfricell" style="float: right">
                                                <img onclick="show('Africell')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceAfricell" style="float: right;display: none">
                                                <img onclick="hide('Africell')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppAfricell" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="africell_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getAfricell().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="africell_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getAfricell().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="africell_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getAfricell().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="africell_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getAfricell().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppAfricell" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="africell_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getAfricell().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="africell_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getAfricell().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="africell_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getAfricell().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="africell_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getAfricell().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppAfricell" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppAfricell" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceBurundi" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>LACELLSU</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lacellsuprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getLacellsu().getGroup0Price()+"")%>">
                                            <div id="showPriceLacellsu" style="float: right">
                                                <img onclick="show('Lacellsu')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceLacellsu" style="float: right;display: none">
                                                <img onclick="hide('Lacellsu')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppLacellsu" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lacellsu_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLacellsu().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lacellsu_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLacellsu().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lacellsu_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLacellsu().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lacellsu_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLacellsu().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppLacellsu" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lacellsu_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLacellsu().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lacellsu_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLacellsu().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lacellsu_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLacellsu().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="lacellsu_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getLacellsu().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppLacellsu" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppLacellsu" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><h3>Cameron</h3></td>
                                        <td colspan="5">
                                                <div id="showCameron" style="float: right">
                                                    <img onclick="showP('Cameron')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideCameron" style="float: right;display: none">
                                                    <img onclick="hideP('Cameron')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                        </td>
                                    </tr>
                                    <tr class="priceCameron" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>NEXTTEL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="nexttelprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getNexttel().getGroup0Price()+"")%>">
                                            <div id="showPriceNexttel" style="float: right">
                                                <img onclick="show('Nexttel')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceNexttel" style="float: right;display: none">
                                                <img onclick="hide('Nexttel')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppNexttel" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="nexttel_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNexttel().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="nexttel_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNexttel().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="nexttel_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNexttel().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="nexttel_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNexttel().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppNexttel" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="nexttel_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNexttel().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="nexttel_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNexttel().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="nexttel_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNexttel().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="nexttel_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getNexttel().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppNexttel" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppNexttel" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceCameron" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>MTN</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mtnprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getMtn().getGroup0Price()+"")%>">
                                            <div id="showPriceMtn" style="float: right">
                                                <img onclick="show('Mtn')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceMtn" style="float: right;display: none">
                                                <img onclick="hide('Mtn')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMtn" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mtn_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMtn().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mtn_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMtn().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mtn_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMtn().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mtn_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMtn().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMtn" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mtn_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMtn().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mtn_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMtn().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mtn_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMtn().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="mtn_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getMtn().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMtn" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppMtn" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceCameron" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>ORANGE</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="orangeprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getOrange().getGroup0Price()+"")%>">
                                            <div id="showPriceOrange" style="float: right">
                                                <img onclick="show('Orange')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceOrange" style="float: right;display: none">
                                                <img onclick="hide('Orange')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppOrange" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="orange_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOrange().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="orange_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOrange().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="orange_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOrange().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="orange_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOrange().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppOrange" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="orange_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOrange().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="orange_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOrange().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="orange_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOrange().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="orange_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getOrange().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppOrange" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppOrange" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><h3>Tanzania</h3></td>
                                        <td colspan="5">
                                                <div id="showTanzania" style="float: right">
                                                    <img onclick="showP('Tanzania')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hideTanzania" style="float: right;display: none">
                                                    <img onclick="hideP('Tanzania')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                        </td>
                                    </tr>
                                    <tr class="priceTanzania" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>HALOTEL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="halotelprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getHalotel().getGroup0Price()+"")%>">
                                            <div id="showPriceHalotel" style="float: right">
                                                <img onclick="show('Halotel')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceHalotel" style="float: right;display: none">
                                                <img onclick="hide('Halotel')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppHalotel" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="halotel_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getHalotel().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="halotel_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getHalotel().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="halotel_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getHalotel().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="halotel_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getHalotel().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppHalotel" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="halotel_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getHalotel().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="halotel_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getHalotel().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="halotel_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getHalotel().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="halotel_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getHalotel().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppHalotel" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppHalotel" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceTanzania" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>VODACOM</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vodacomprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getVodacom().getGroup0Price()+"")%>">
                                            <div id="showPriceVodacom" style="float: right">
                                                <img onclick="show('Vodacom')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceVodacom" style="float: right;display: none">
                                                <img onclick="hide('Vodacom')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppVodacom" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vodacom_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVodacom().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vodacom_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVodacom().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vodacom_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVodacom().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vodacom_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVodacom().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppVodacom" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vodacom_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVodacom().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vodacom_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVodacom().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vodacom_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVodacom().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="vodacom_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getVodacom().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppVodacom" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppVodacom" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="priceTanzania" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>ZANTEL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="zantelprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getZantel().getGroup0Price()+"")%>">
                                            <div id="showPriceZantel" style="float: right">
                                                <img onclick="show('Zantel')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceZantel" style="float: right;display: none">
                                                <img onclick="hide('Zantel')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppZantel" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="zantel_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getZantel().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="zantel_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getZantel().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="zantel_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getZantel().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="zantel_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getZantel().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppZantel" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="zantel_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getZantel().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="zantel_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getZantel().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="zantel_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getZantel().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="zantel_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getZantel().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppVodacom" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppVodacom" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><h3>Peru</h3></td>
                                        <td colspan="5">
                                                <div id="showPeru" style="float: right">
                                                    <img onclick="showP('Peru')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                                </div>
                                                <div id="hidePeru" style="float: right;display: none">
                                                    <img onclick="hideP('Peru')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                                </div>
                                        </td>
                                    </tr>
                                    <tr class="pricePeru" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>BITEL</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bitelprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getBitel().getGroup0Price()+"")%>">
                                            <div id="showPriceBitel" style="float: right">
                                                <img onclick="show('Bitel')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceBitel" style="float: right;display: none">
                                                <img onclick="hide('Bitel')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppBitel" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bitel_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBitel().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bitel_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBitel().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bitel_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBitel().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bitel_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBitel().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppBitel" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bitel_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBitel().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bitel_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBitel().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bitel_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBitel().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="bitel_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getBitel().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppBitel" style="display: none">
                                                
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppBitel" style="display: none">
                                            
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="pricePeru" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>CLARO</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="claroprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getClaro().getGroup0Price()+"")%>">
                                            <div id="showPriceClaro" style="float: right">
                                                <img onclick="show('Claro')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceClaro" style="float: right;display: none">
                                                <img onclick="hide('Claro')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppClaro" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="claro_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getClaro().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="claro_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getClaro().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="claro_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getClaro().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="claro_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getClaro().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppClaro" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="claro_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getClaro().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="claro_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getClaro().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="claro_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getClaro().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="claro_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getClaro().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppClaro" style="display: none">
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppClaro" style="display: none">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="pricePeru" style="display: none">
                                        <td></td>
                                        <td align="left" class="boder_right"><b>TELEFONICA</b></td>
                                        <td colspan="1">
                                            Nhóm 0 :  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telefonicaprice" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelefonica().getGroup0Price()+"")%>">
                                            <div id="showPriceTelefonica" style="float: right">
                                                <img onclick="show('Telefonica')" src="<%= request.getContextPath()%>/admin/resource/images/Add.png"/>
                                            </div>
                                            <div id="hidePriceTelefonica" style="float: right;display: none">
                                                <img onclick="hide('Telefonica')" src="<%=request.getContextPath()%>/admin/resource/images/delete.jpg" style="width: 16px;height: 16px;"/></a>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTelefonica" style="display: none">
                                                Nhóm 01:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telefonica_n1_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelefonica().getGroup1Price()+"")%>"/><br/>
                                                Nhóm 02:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telefonica_n2_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelefonica().getGroup2Price()+"")%>"/><br/>
                                                Nhóm 03:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telefonica_n3_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelefonica().getGroup3Price()+"")%>"/><br/>
                                                Nhóm 04:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telefonica_n4_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelefonica().getGroup4Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTelefonica" style="display: none">
                                                Nhóm 05:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telefonica_n5_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelefonica().getGroup5Price()+"")%>"/><br/>
                                                Nhóm 06:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telefonica_n6_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelefonica().getGroup6Price()+"")%>"/><br/>
                                                Nhóm 07:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telefonica_n7_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelefonica().getGroup7Price()+"")%>"/><br/>
                                                Nhóm 08:  <input class="form-control" onkeyup="this.value=FormatNumber(this.value);" type="text" name="telefonica_n8_price" size="5" value="<%=Tool.dinhDangTienTe(telco.getTelefonica().getGroup8Price()+"")%>"/><br/>
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTelefonica" style="display: none">
                                                
                                            </div>
                                        </td>
                                        <td colspan="1">
                                            <div class="sppTelefonica" style="display: none">
                                            
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="7" align="center">
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
                                            <input class="button" onclick="window.location.href = '<%=request.getContextPath() + "/admin/billing/index.jsp"%>'" type="reset" name="reset" value="Hủy"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>
                </div>   
                <div class="clear"></div>
            </div>
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html> 