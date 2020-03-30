/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.DateProc;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import org.apache.log4j.Logger;

/**
 *
 * @author Private
 */
public class CDRSubmit {

    static final Logger logger = Logger.getLogger(CDRSubmit.class);

    public ArrayList<CDRSubmit> statisticSubmByDay(String userSender,
            String stRequest, String endRequest, int type) {
        ArrayList<CDRSubmit> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = " SELECT SUM(TOTAL_COUNT) AS TOTAL_SMS,DATE_FORMAT(LOG_DATE,'%d/%m/%Y') AS DATE_ORDER  ";

        sql += " FROM CDR_SUBMIT A WHERE A.RESULT = 1 ";
        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(LOG_DATE,STR_TO_DATE(?, '%d/%m/%Y') ) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(LOG_DATE,STR_TO_DATE(?, '%d/%m/%Y')) <=0";
        }
        if (!userSender.equals("0")) {
            sql += " AND USER_SENDER = ?";
        }
        if (type != -1) {
            sql += " AND TYPE = ?";
        }
        
        sql += " GROUP BY RESULT,DATE_FORMAT(LOG_DATE,'%d/%m/%Y')";

        sql += " ORDER BY DATE_FORMAT(LOG_DATE,'%d/%m/%Y') ASC";

        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;

            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest);
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest);
            }
            if (!userSender.equals("0")) {
                pstm.setString(i++, userSender);
            }
            if (type != -1) {
                pstm.setInt(i++, type);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                CDRSubmit one = new CDRSubmit();
                one.setTotalMsg(rs.getInt("TOTAL_SMS"));
                one.setLogDate(rs.getString("DATE_ORDER"));
                all.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public ArrayList<CDRSubmit> statisticSubm_ByDay(String userSender, String cp_code, String label, int type, String provider,
            String oper, int result, String groupBr, String stRequest, String endRequest) {
        ArrayList<CDRSubmit> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = " SELECT SUM(TOTAL_COUNT) AS TOTAL_COUNT,OPER,CAST(LABEL As BINARY) as LABEL,RESULT,TYPE,BR_GROUP,"
                + "DATE_FORMAT(LOG_DATE,'%d/%m/%Y') AS DATE_ORDER,GATEWAY  ";

        sql += " FROM CDR_SUBMIT A WHERE 1=1 ";
        if (type != -1) {
            sql += " AND TYPE = ?";
        }
        if (!Tool.checkNull(oper)) {
            sql += " AND OPER = ?";
        }
        if (result == 1) {
            sql += " AND RESULT = 1";
        } else if (result == -1) {
            sql += " AND RESULT != 1";
        }
        if (!Tool.checkNull(groupBr)) {
            sql += " AND BR_GROUP = ?";
        }
        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(LOG_DATE,STR_TO_DATE(?, '%d/%m/%Y') ) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(LOG_DATE,STR_TO_DATE(?, '%d/%m/%Y')) <=0";
        }
        if (!Tool.checkNull(userSender)) {
            sql += " AND USER_SENDER = ?";
        }
        if (!Tool.checkNull(cp_code)) {
            sql += " AND (CP_CODE = ? OR CP_CODE LIKE ?)";
        }
        if (!Tool.checkNull(label)) {
            sql += " AND upper(LABEL) = upper('" + label + "') ";
        }
        if (!Tool.checkNull(provider)) {
            sql += " AND UPPER(GATEWAY) = ?";
        }
        sql += " GROUP BY OPER,LABEL,RESULT,TYPE,BR_GROUP,DATE_FORMAT(LOG_DATE,'%d/%m/%Y'),GATEWAY";

        sql += " ORDER BY DATE_FORMAT(LOG_DATE,'%d/%m/%Y') ASC";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (type != -1) {
                pstm.setInt(i++, type);
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }

            if (!Tool.checkNull(groupBr)) {
                pstm.setString(i++, groupBr);
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest);
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest);
            }
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, cp_code);
                pstm.setString(i++, cp_code + "_%");
            }
            if (!Tool.checkNull(provider)) {
                pstm.setString(i++, provider);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                CDRSubmit one = new CDRSubmit();
                one.setOper(rs.getString("OPER"));
                one.setLabel(rs.getString("LABEL"));
                one.setTotalMsg(rs.getInt("TOTAL_COUNT"));
                one.setResult(rs.getInt("RESULT"));
                one.setType(rs.getString("TYPE"));
                one.setGateWay(rs.getString("GATEWAY"));
                one.setBrGroup(rs.getString("BR_GROUP"));
                one.setLogDate(rs.getString("DATE_ORDER"));
                all.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public ArrayList<CDRSubmit> statisticSale(String userSender, String cp_code, String label, int type, String stRequest,
            String endRequest, String oper, String result, String groupBr) {
        ArrayList<CDRSubmit> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT SUM(TOTAL_COUNT) AS TOTAL_COUNT,USER_SENDER,OPER,CAST(LABEL As BINARY) as LABEL,RESULT,TYPE,BR_GROUP "
                + "FROM CDR_SUBMIT WHERE 1=1 ";
        if (type != -1) {
            sql += " AND TYPE = ?";
        }
        if (!Tool.checkNull(oper)) {
            sql += " AND OPER = ?";
        }
        if (!Tool.checkNull(result)) {
            sql += " AND RESULT = ?";
        }
        if (!Tool.checkNull(groupBr)) {
            sql += " AND BR_GROUP = ?";
        }
        if (!Tool.checkNull(stRequest)) {
            sql += " AND LOG_DATE >= STR_TO_DATE(?,'%d/%m/%Y')";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND LOG_DATE <= STR_TO_DATE(?,'%d/%m/%Y')";
        }
        if (!Tool.checkNull(userSender)) {
            sql += " AND USER_SENDER = ?";
        }
        if (!Tool.checkNull(cp_code)) {
            sql += " AND (CP_CODE = ? OR CP_CODE Like ?)";
        }
        if (!Tool.checkNull(label)) {
            sql += " AND upper(LABEL) = upper('" + label + "') ";
        }
        sql += " GROUP BY USER_SENDER,OPER,LABEL,RESULT,TYPE,GATEWAY,BR_GROUP ORDER BY TOTAL_COUNT DESC";
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (type != -1) {
                pstm.setInt(i++, type);
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            if (!Tool.checkNull(result)) {
                pstm.setString(i++, result);
            }
            if (!Tool.checkNull(groupBr)) {
                pstm.setString(i++, groupBr);
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest);
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest);
            }
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, cp_code);
                pstm.setString(i++, cp_code + "_%");
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                CDRSubmit one = new CDRSubmit();
                one.setOper(rs.getString("OPER"));
                one.setLabel(rs.getString("LABEL"));
                one.setTotalMsg(rs.getInt("TOTAL_COUNT"));
                one.setResult(rs.getInt("RESULT"));
                one.setType(rs.getString("TYPE"));
                one.setBrGroup(rs.getString("BR_GROUP"));
                one.setUser(rs.getString("USER_SENDER"));
                all.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public ArrayList<CDRSubmit> statisticSale_forDL(String cp_code, String label, int type, String stRequest,
            String endRequest, String oper, String result, String groupBr) {
        ArrayList<CDRSubmit> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT SUM(TOTAL_COUNT) AS TOTAL_COUNT,CP_CODE,OPER,CAST(LABEL As BINARY) as LABEL,RESULT,TYPE,GATEWAY,BR_GROUP "
                + "FROM CDR_SUBMIT WHERE 1=1 ";
        if (type != -1) {
            sql += " AND TYPE = ?";
        }
        if (!Tool.checkNull(oper)) {
            sql += " AND OPER = ?";
        }
        if (!Tool.checkNull(result)) {
            sql += " AND RESULT = ?";
        }
        if (!Tool.checkNull(groupBr)) {
            sql += " AND BR_GROUP = ?";
        }
        if (!Tool.checkNull(stRequest)) {
            sql += " AND LOG_DATE >= STR_TO_DATE(?,'%d/%m/%Y')";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND LOG_DATE <= STR_TO_DATE(?,'%d/%m/%Y')";
        }
        if (!Tool.checkNull(cp_code)) {
            sql += " AND (CP_CODE = ? OR CP_CODE Like ?)";
        }
        if (!Tool.checkNull(label)) {
            sql += " AND upper(LABEL) = upper('" + label + "') ";
        }
        sql += " GROUP BY CP_CODE,OPER,LABEL,RESULT,TYPE,GATEWAY,GATEWAY,BR_GROUP ORDER BY TOTAL_COUNT DESC";
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (type != -1) {
                pstm.setInt(i++, type);
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            if (!Tool.checkNull(result)) {
                pstm.setString(i++, result);
            }
            if (!Tool.checkNull(groupBr)) {
                pstm.setString(i++, groupBr);
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest);
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest);
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, cp_code);
                pstm.setString(i++, cp_code + "_%");
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                CDRSubmit one = new CDRSubmit();
                one.setOper(rs.getString("OPER"));
                one.setLabel(rs.getString("LABEL"));
                one.setTotalMsg(rs.getInt("TOTAL_COUNT"));
                one.setResult(rs.getInt("RESULT"));
                one.setType(rs.getString("TYPE"));
                one.setBrGroup(rs.getString("BR_GROUP"));
                one.setGateWay(rs.getString("GATEWAY"));
                one.setCpCode(rs.getString("CP_CODE"));
                all.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public ArrayList<CDRSubmit> statisticBuy(String label, int type, String provider, String stRequest,
            String endRequest, String oper, String result, String groupBr) {
        ArrayList<CDRSubmit> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT SUM(TOTAL_COUNT) AS TOTAL_COUNT,OPER,CAST(LABEL As BINARY) as LABEL,RESULT,TYPE,GATEWAY,BR_GROUP "
                + "FROM CDR_SUBMIT WHERE 1=1 ";
        if (type != -1) {
            sql += " AND TYPE = ?";
        }
        if (!Tool.checkNull(oper)) {
            sql += " AND OPER = ?";
        }
        if (!Tool.checkNull(result)) {
            sql += " AND RESULT = ?";
        }
        if (!Tool.checkNull(groupBr)) {
            sql += " AND BR_GROUP = ?";
        }
        if (!Tool.checkNull(stRequest)) {
            sql += " AND LOG_DATE >= STR_TO_DATE(?,'%d/%m/%Y %H:%i:%s')";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND LOG_DATE <= STR_TO_DATE(?,'%d/%m/%Y %H:%i:%s')";
        }
        if (!Tool.checkNull(label)) {
            sql += " AND upper(LABEL) = upper('" + label + "') ";
        }
        if (!Tool.checkNull(provider)) {
            sql += " AND UPPER(GATEWAY) = ?";
        }
        sql += " GROUP BY OPER,Cast(LABEL As BINARY),RESULT,TYPE,GATEWAY,BR_GROUP,GATEWAY ORDER BY TOTAL_COUNT DESC";
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (type != -1) {
                pstm.setInt(i++, type);
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            if (!Tool.checkNull(result)) {
                pstm.setString(i++, result);
            }
            if (!Tool.checkNull(groupBr)) {
                pstm.setString(i++, groupBr);
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            if (!Tool.checkNull(provider)) {
                pstm.setString(i++, provider);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                CDRSubmit one = new CDRSubmit();
                one.setOper(rs.getString("OPER"));
                one.setLabel(rs.getString("LABEL"));
                one.setTotalMsg(rs.getInt("TOTAL_COUNT"));
                one.setResult(rs.getInt("RESULT"));
                one.setType(rs.getString("TYPE"));
                one.setBrGroup(rs.getString("BR_GROUP"));
                one.setGateWay(rs.getString("GATEWAY"));
                all.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public String buildContentCDR() {
        String lastDay = DateProc.Timestamp2DDMMYYYY(DateProc.getNextDateN(DateProc.createTimestamp(), -1));
        String str = "<h2>Sản lượng [SMS BRAND HTC] ngày:" + lastDay + "</h2><br/>";
        MsgBrandSubmit dao = new MsgBrandSubmit();
        ArrayList<MsgBrandSubmit> allLog = dao.statisticAllLogReport(
                "", //  userSender
                "", //  label
                lastDay, // Start Send
                lastDay // End Send
        );
        str += "<style> #rounded-corner { width:auto; text-align: left; border-collapse: collapse; } #rounded-corner thead th.rounded-company { width:26px; background: #60c8f2 url('../images/left.jpg') left top no-repeat; } #rounded-corner thead th.rounded-q4 { background: #60c8f2 url('../images/right.jpg') right top no-repeat; } #rounded-corner th { padding: 8px; font-weight: normal; font-size: 13px; color: #039; background: #60c8f2; } #rounded-corner td { padding: 8px; background: #ecf8fd; border-top: 1px solid #fff; color: #669; } #rounded-corner tfoot td.rounded-foot-left { background: #ecf8fd url('../images/botleft.jpg') left bottom no-repeat; } #rounded-corner tfoot td.rounded-foot-right { background: #ecf8fd url('../images/botright.jpg') right bottom no-repeat; } #rounded-corner tbody tr:hover td { background: #d2e7f0; } </style>";
        str += "<table align=\"center\" id=\"rounded-corner\" summary=\"Msc Joint Stock Company\" >";
        str += "<thead>\n"
                + "                <tr>\n"
                + "                   <th scope=\"col\" class=\"rounded-company\">STT</th>\n"
                + "                   <th scope=\"col\" class=\"rounded\">Brand Name</th>\n"
                + "                   <th scope=\"col\" class=\"rounded\">Nhà mạng</th>\n"
                + "                   <th scope=\"col\" class=\"rounded\">Tổng SMS</th>\n"
                + "                   <th scope=\"col\" class=\"rounded\">Kết quả gửi</th> \n"
                + "                   <th scope=\"col\" class=\"rounded\">Loại tin</th>\n"
                + "                   <th scope=\"col\" class=\"rounded\">Hướng gửi</th>\n"
                + "                </tr>\n"
                + "</thead>\n"
                + "<tbody>";

        int count = 1; //Bien dung de dem so dong
        int total = 0;
        for (MsgBrandSubmit oneBrand : allLog) {
            if (oneBrand.getResult() == 1) {
                total += oneBrand.getTotalSms();
            }
            str += "<tr>\n"
                    + " <td class=\"boder_right\">" + (count++) + "</td>\n"
                    + " <td class=\"boder_right\" align=\"left\">\n"
                    + "    " + oneBrand.getLabel() + "\n"
                    + " </td>\n"
                    + " <td class=\"boder_right\" align=\"center\">\n"
                    + "    " + oneBrand.getOper() + "\n"
                    + " </td>\n"
                    + " <td class=\"boder_right\" align=\"left\">\n"
                    + "    " + oneBrand.getTotalSms() + "\n"
                    + " </td>\n"
                    + " <td class=\"boder_right\" align=\"left\"><span class=\"redBold\">" + oneBrand.getResult() + "</span> &nbsp;(" + oneBrand.getErrInfo() + ")</td>\n"
                    + " <td align=\"center\">" + getType(oneBrand.getType()) + "</td>\n"
                    + " <td align=\"center\">" + oneBrand.getSendTo() + "</td>\n"
                    + "</tr>";
        }
        str += "<tr>\n"
                + "<td class=\"boder_right\" colspan=\"3\" style=\"font-weight: bold;color: blue\">Tổng MT thành công</td>\n"
                + "<td colspan=\"4\" style=\"font-weight: bold;color: blue\" align=\"left\">" + total + "</td>\n"
                + "</tr>";
        str += "</tbody>";
        str += "</table>";
        return str;
    }

    public HashMap getErrorsList() {
        HashMap ht = new HashMap();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT CAST(LABEL As BINARY) as LABEL,SUM(TOTAL_COUNT) AS TOTAL_COUNT"
                + " FROM  CDR_SUBMIT  "
                + " WHERE DATE_FORMAT(LOG_DATE,'%d/%m/%Y') = DATE_FORMAT(NOW(),'%d/%m/%Y') AND RESULT = 0"
                + " GROUP BY LABEL";
        try {
            conn = DBPool.getConnection();
            if (conn != null) {
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    System.out.println("brand key :  " + rs.getString("LABEL") + "  errors_key : " + rs.getInt("TOTAL_COUNT"));
                    ht.put(rs.getString("LABEL"), new CdrStatisEntityTmp(rs.getInt("TOTAL_COUNT")));
                }
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
            ex.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstmt, conn);
        }

        return ht;
    }

    private static String getType(int type) {
        if (type == BrandLabel.TYPE.CSKH.val) {
            return "CSKH";
        } else if (type == BrandLabel.TYPE.QC.val) {
            return "Tin QC";
        } else {
            return type + "";
        }
    }
    //
    int id;
    String logDate;
    String user;
    String label;
    int totalMsg;
    String type;
    String gateWay;
    int result;
    String oper;
    String brGroup;
    String lbNode;
    String cpCode;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLogDate() {
        return logDate;
    }

    public void setLogDate(String logDate) {
        this.logDate = logDate;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public int getTotalMsg() {
        return totalMsg;
    }

    public void setTotalMsg(int totalMsg) {
        this.totalMsg = totalMsg;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getGateWay() {
        return gateWay;
    }

    public void setGateWay(String gateWay) {
        this.gateWay = gateWay;
    }

    public int getResult() {
        return result;
    }

    public void setResult(int result) {
        this.result = result;
    }

    public String getOper() {
        return oper;
    }

    public void setOper(String oper) {
        this.oper = oper;
    }

    public String getBrGroup() {
        return brGroup;
    }

    public void setBrGroup(String brGroup) {
        this.brGroup = brGroup;
    }

    public String getLbNode() {
        return lbNode;
    }

    public void setLbNode(String lbNode) {
        this.lbNode = lbNode;
    }

    public String getCpCode() {
        return cpCode;
    }

    public void setCpCode(String cpCode) {
        this.cpCode = cpCode;
    }

}
