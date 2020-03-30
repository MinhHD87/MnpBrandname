/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import org.apache.log4j.Logger;

/**
 *
 * @author Centurion
 */
public class MsgBrandSubmit {

    static final Logger logger = Logger.getLogger(MsgBrandSubmit.class);

    /**
     * Danh cho thong ke tren CMS Admin
     *
     * @param userSender
     * @param cpCode
     * @param label
     * @param type
     * @param provider
     * @param stRequest
     * @param endRequest
     * @param oper
     * @param result
     * @param groupBr
     * @return
     */
    public ArrayList<MsgBrandSubmit> distinctSubm(String userSender, String cpCode, String label, int type, String provider, String stRequest,
            String endRequest, String oper, int result, String groupBr) {
        ArrayList<MsgBrandSubmit> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
            String sql = " SELECT DISTINCT CP_CODE ";
        sql += " FROM MSG_BRAND_SUBMIT " + buidPartition(stRequest) + " A WHERE 1=1 ";
        if (!Tool.checkNull(userSender)) {
            sql += " AND USER_SENDER = ?";
        }
        if (!Tool.checkNull(cpCode)) {
            // Neu thong ke theo CP Code bo qua user
            sql += " AND (CP_CODE = ? OR CP_CODE Like ?)";
        }
        if (!Tool.checkNull(label)) {
            sql += " AND upper(LABEL) = upper(?) ";
        }
        if (type != -1) {
            sql += " AND TYPE = ?";
        }
        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
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
        sql += " GROUP BY CP_CODE,OPER,Cast(LABEL As BINARY),RESULT,TYPE,SEND_TO,BR_GROUP";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(cpCode)) {
                pstm.setString(i++, cpCode);
                pstm.setString(i++, cpCode + "_%");
            }
            if (!Tool.checkNull(label)) {
                pstm.setString(i++, label);
            }
            if (type != -1) {
                pstm.setInt(i++, type);
            }
            if (!Tool.checkNull(provider)) {
                pstm.setString(i++, provider);
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            if (!Tool.checkNull(groupBr)) {
                pstm.setString(i++, groupBr);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                MsgBrandSubmit one = new MsgBrandSubmit();
                one.setCpCode(rs.getString("CP_CODE"));
                one.setOper(rs.getString("OPER"));
                one.setLabel(rs.getString("LABEL"));
                one.setTotalSms(rs.getInt("TOTAL_SMS"));
                one.setResult(rs.getInt("RESULT"));
                one.setType(rs.getInt("TYPE"));
                one.setSendTo(rs.getString("SEND_TO"));
                one.setBrGroup(rs.getString("BR_GROUP"));
                all.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }
    public ArrayList<MsgBrandSubmit> statisticSubm(String userSender, String cpCode, String label, int type, String provider, String stRequest,
            String endRequest, String oper, int result, String groupBr) {
        ArrayList<MsgBrandSubmit> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = " SELECT SUM(TOTAL_SMS) AS TOTAL_SMS,CP_CODE,OPER,Cast(LABEL As BINARY) as LABEL,RESULT,TYPE,SEND_TO,BR_GROUP  ";
        if (!Tool.checkNull(provider)) {
            sql += ",SEND_TO ";
        }
        sql += " FROM MSG_BRAND_SUBMIT " + buidPartition(stRequest) + " A WHERE 1=1 ";
        if (!Tool.checkNull(userSender)) {
            sql += " AND USER_SENDER = ?";
        }
        if (!Tool.checkNull(cpCode)) {
            // Neu thong ke theo CP Code bo qua user
            sql += " AND (CP_CODE = ? OR CP_CODE Like ?)";
        }
        if (!Tool.checkNull(label)) {
            sql += " AND upper(LABEL) = upper(?) ";
        }
        if (type != -1) {
            sql += " AND TYPE = ?";
        }
        if (!Tool.checkNull(provider)) {
            sql += " AND UPPER(SEND_TO) = ?";
        }
        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
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
        sql += " GROUP BY CP_CODE,OPER,Cast(LABEL As BINARY),RESULT,TYPE,SEND_TO,BR_GROUP";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(cpCode)) {
                pstm.setString(i++, cpCode);
                pstm.setString(i++, cpCode + "_%");
            }
            if (!Tool.checkNull(label)) {
                pstm.setString(i++, label);
            }
            if (type != -1) {
                pstm.setInt(i++, type);
            }
            if (!Tool.checkNull(provider)) {
                pstm.setString(i++, provider);
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            if (!Tool.checkNull(groupBr)) {
                pstm.setString(i++, groupBr);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                MsgBrandSubmit one = new MsgBrandSubmit();
                one.setCpCode(rs.getString("CP_CODE"));
                one.setOper(rs.getString("OPER"));
                one.setLabel(rs.getString("LABEL"));
                one.setTotalSms(rs.getInt("TOTAL_SMS"));
                one.setResult(rs.getInt("RESULT"));
                one.setType(rs.getInt("TYPE"));
                one.setSendTo(rs.getString("SEND_TO"));
                one.setBrGroup(rs.getString("BR_GROUP"));
                all.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public ArrayList<MsgBrandSubmit> statisticSubm_CPCODE(String cpCode, String label, int type, String provider, String stRequest, String endRequest,
            String oper, int result, String groupBr) {
        ArrayList<MsgBrandSubmit> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = " SELECT SUM(TOTAL_SMS) AS TOTAL_SMS,OPER,LABEL,RESULT,TYPE,SEND_TO,BR_GROUP  ";
        if (!Tool.checkNull(provider)) {
            sql += ",SEND_TO ";
        }
        sql += " FROM MSG_BRAND_SUBMIT " + buidPartition(stRequest) + " A WHERE 1=1 ";
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
            sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
        }
        if (!Tool.checkNull(cpCode)) {
            sql += " AND CP_CODE = ?";
        }
        if (!Tool.checkNull(label)) {
            sql += " AND upper(LABEL) = upper('" + label + "') ";
        }
        if (!Tool.checkNull(provider)) {
            sql += " AND UPPER(SEND_TO) = ?";
        }
        sql += " GROUP BY OPER,LABEL,RESULT,TYPE,SEND_TO,BR_GROUP";
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
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }

            if (!Tool.checkNull(cpCode)) {
                pstm.setString(i++, cpCode);
            }
            if (!Tool.checkNull(provider)) {
                pstm.setString(i++, provider);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                MsgBrandSubmit one = new MsgBrandSubmit();
                one.setOper(rs.getString("OPER"));
                one.setLabel(rs.getString("LABEL"));
                one.setTotalSms(rs.getInt("TOTAL_SMS"));
                one.setResult(rs.getInt("RESULT"));
                one.setType(rs.getInt("TYPE"));
                one.setSendTo(rs.getString("SEND_TO"));
                one.setBrGroup(rs.getString("BR_GROUP"));
                all.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public ArrayList<MsgBrandSubmit> statisticAllLogAgency(String userSender, String cp_code, String label, String stRequest, String endRequest, String oper, String result) {
        ArrayList<MsgBrandSubmit> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = " SELECT SUM(TOTAL_SMS) AS TOTAL_SMS,OPER,LABEL,RESULT  ";
        sql += " FROM MSG_BRAND_SUBMIT " + buidPartition(stRequest) + " WHERE 1=1 ";
        if (!Tool.checkNull(oper)) {
            sql += " AND OPER = ?";
        }
        if (!Tool.checkNull(result)) {
            sql += " AND RESULT = ?";
        }
        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
        }
        if (!Tool.checkNull(userSender)) {
            sql += " AND USER_SENDER = ?";
        }
        if (!Tool.checkNull(cp_code)) {
            sql += " AND (CP_CODE = ? OR CP_CODE Like ?)";
        }
        if (!Tool.checkNull(label)) {
            sql += " AND LABEL = ? ";
        }
        sql += " GROUP BY OPER,LABEL,RESULT";
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            if (!Tool.checkNull(result)) {
                pstm.setString(i++, result);
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, cp_code);
                pstm.setString(i++, cp_code + "_%");
            }
            if (!Tool.checkNull(label)) {
                pstm.setString(i++, label);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                MsgBrandSubmit one = new MsgBrandSubmit();
                one.setOper(rs.getString("OPER"));
                one.setLabel(rs.getString("LABEL"));
                one.setTotalSms(rs.getInt("TOTAL_SMS"));
                one.setResult(rs.getInt("RESULT"));
                all.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    /**
     * Danh cho Report Qua Email
     *
     * @param userSender
     * @param label
     * @param stRequest
     * @param endRequest
     * @return
     */
    public ArrayList<MsgBrandSubmit> statisticAllLogReport(String userSender, String label, String stRequest, String endRequest) {
        ArrayList<MsgBrandSubmit> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM ( SELECT SUM(TOTAL_SMS) AS TOTAL_SMS,OPER,LABEL,RESULT,TYPE,SEND_TO  ";

        sql += " FROM MSG_BRAND_SUBMIT " + buidPartition(stRequest) + " WHERE 1=1 ";

        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
        }

        if (!Tool.checkNull(userSender)) {
            sql += " AND USER_SENDER = ?";
        }
        if (!Tool.checkNull(label)) {
            sql += " AND upper(LABEL) = upper('" + label + "') ";
        }

        sql += " GROUP BY OPER,LABEL,RESULT,TYPE,SEND_TO";
        sql += " ) B WHERE B.TOTAL_SMS > 100 ORDER BY B.TOTAL_SMS DESC,b.SEND_TO";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;

            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }

            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }

            rs = pstm.executeQuery();
            while (rs.next()) {
                MsgBrandSubmit one = new MsgBrandSubmit();
                one.setOper(rs.getString("OPER"));
                one.setLabel(rs.getString("LABEL"));
                one.setTotalSms(rs.getInt("TOTAL_SMS"));
                one.setResult(rs.getInt("RESULT"));
                one.setType(rs.getInt("TYPE"));
                one.setSendTo(rs.getString("SEND_TO"));
                all.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public ArrayList<MsgBrandSubmit> getMsgSubmitLog(int page, int max, String userSender, String cp_code, String _label, int type, int result,
            String provider, String stRequest, String endRequest, String phone, String telco, int err_code, String tranId) {
        ArrayList<MsgBrandSubmit> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM MSG_BRAND_SUBMIT " + buidPartition(stRequest)
                + " A WHERE 1=1 ";
        if (type != -1) {
            sql += " AND A.TYPE = ?";
        }
        if (result != -1) {
            if (result == 1) {
                sql += " AND A.RESULT = 1";
            } else {
                sql += " AND A.RESULT != 1";
            }
        }
        if (err_code != -2) {
            sql += " AND A.RESULT = ?";
        }
        if (!Tool.checkNull(cp_code)) {
            sql += " AND (A.CP_CODE = ? OR A.CP_CODE like ?)";
        }
        if (!Tool.checkNull(phone)) {
            sql += " AND A.PHONE like ?";
        }
        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(A.REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(A.REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
        }
        if (!Tool.checkNull(userSender)) {
            sql += " AND A.USER_SENDER = ?";
        }
        if (!Tool.checkNull(_label)) {
            sql += " AND upper(A.LABEL) = upper(?) ";
        }
        if (!Tool.checkNull(provider)) {
            sql += " AND UPPER(A.SEND_TO) = ?";
        }
        if (!Tool.checkNull(telco)) {
            sql += " AND A.OPER = ?";
        }
        if (!Tool.checkNull(tranId)) {
            sql += " AND A.TRANS_ID = ?";
        }
        sql += " ORDER BY REQUEST_TIME DESC LIMIT ?,?";
        int start = (page - 1) * max;
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (type != -1) {
                pstm.setInt(i++, type);
            }
            if (err_code != -2) {
                pstm.setInt(i++, err_code);
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, cp_code);
                pstm.setString(i++, cp_code + "_%");
            }
            if (!Tool.checkNull(phone)) {
                pstm.setString(i++, "%" + phone);
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }

            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(_label)) {
                pstm.setString(i++, _label);
            }
            if (!Tool.checkNull(provider)) {
                pstm.setString(i++, provider);
            }
            if (!Tool.checkNull(telco)) {
                pstm.setString(i++, telco);
            }
            if (!Tool.checkNull(tranId)) {
                pstm.setString(i++, tranId);
            }
            pstm.setInt(i++, start);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                MsgBrandSubmit one = new MsgBrandSubmit();
                one.setId(rs.getInt("ID"));
                one.setPhone(rs.getString("PHONE"));
                one.setOper(rs.getString("OPER"));
                one.setMessage(rs.getString("MESSAGE"));
                one.setTotalSms(rs.getInt("TOTAL_SMS"));
                one.setTotalPrice(rs.getInt("SMS_PRICE"));
                one.setLabel(rs.getString("LABEL"));
                one.setUserSender(rs.getString("USER_SENDER"));
                one.setRequestTime(rs.getTimestamp("REQUEST_TIME"));
                one.setLogTime(rs.getTimestamp("LOG_TIME"));
                one.setTimeSend(rs.getTimestamp("SEND_TIME"));
                one.setResult(rs.getInt("RESULT"));
                one.setErrInfo(rs.getString("ERROR_INFO"));
                one.setType(rs.getInt("TYPE"));
                one.setSendTo(rs.getString("SEND_TO"));
                one.setLbNode(rs.getString("LB_NODE"));
                one.setBrGroup(rs.getString("BR_GROUP"));
                one.setTranId(rs.getString("TRANS_ID"));
                one.setSysId(rs.getString("SYS_ID"));
                all.add(one);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public int countMsgSubmitLog(String userSender, String cp_code, String _Label, int type, int result, String provider, String stRequest,
            String endRequest, String _phone, String telco, int err_code, String tranId) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM MSG_BRAND_SUBMIT " + buidPartition(stRequest) + " WHERE 1=1 ";
        if (type != -1) {
            sql += " AND TYPE = ?";
        }
        if (result != -1) {
            if (result == 1) {
                sql += " AND RESULT = 1";
            } else {
                sql += " AND RESULT != 1";
            }
        }
        if (err_code != -2) {
            sql += " AND RESULT = ?";
        }
        if (!Tool.checkNull(cp_code)) {
            sql += " AND (CP_CODE = ? OR CP_CODE like ?)";
        }
        if (!Tool.checkNull(_phone)) {
            sql += " AND PHONE like ?";
        }
        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
        }

        if (!Tool.checkNull(userSender)) {
            sql += " AND USER_SENDER = ?";
        }
        if (!Tool.checkNull(_Label)) {
            sql += " AND upper(LABEL) = upper('" + _Label + "') ";
        }
        if (!Tool.checkNull(provider)) {
            sql += " AND UPPER(SEND_TO) = ?";
        }
        if (!Tool.checkNull(telco)) {
            sql += " AND OPER = ?";
        }
        if (!Tool.checkNull(tranId)) {
            sql += " AND TRANS_ID = ?";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (type != -1) {
                pstm.setInt(i++, type);
            }
            if (err_code != -2) {
                pstm.setInt(i++, err_code);
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, cp_code);
                pstm.setString(i++, cp_code + "_%");
            }
            if (!Tool.checkNull(_phone)) {
                pstm.setString(i++, "%" + _phone);
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }

            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(provider)) {
                pstm.setString(i++, provider);
            }
            if (!Tool.checkNull(telco)) {
                pstm.setString(i++, telco);
            }
            if (!Tool.checkNull(tranId)) {
                pstm.setString(i++, tranId);
            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return count;
    }

    public MsgBrandSubmit getById(int id, String date) {
        MsgBrandSubmit one = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM MSG_BRAND_SUBMIT " + buidPartition(date) + " WHERE ID = ? ORDER BY REQUEST_TIME DESC";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                one = new MsgBrandSubmit();
                one.setId(rs.getInt("ID"));
                one.setPhone(rs.getString("PHONE"));
                one.setOper(rs.getString("OPER"));
                one.setMessage(rs.getString("MESSAGE"));
                one.setTotalSms(rs.getInt("TOTAL_SMS"));
                one.setTotalPrice(rs.getInt("SMS_PRICE"));
                one.setLabel(rs.getString("LABEL"));
                one.setUserSender(rs.getString("USER_SENDER"));
                one.setRequestTime(rs.getTimestamp("REQUEST_TIME"));
                one.setTimeSend(rs.getTimestamp("SEND_TIME"));
                one.setResult(rs.getInt("RESULT"));
                one.setType(rs.getInt("TYPE"));
                one.setLbNode(rs.getString("LB_NODE"));
                one.setErrInfo(rs.getString("ERROR_INFO"));
                one.setTranId(rs.getString("TRANS_ID"));
                one.setSysId(rs.getString("SYS_ID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return one;
    }

    public MsgBrandSubmit get_Week_ById(int id, String date) {
        MsgBrandSubmit one = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM MSG_BRAND_SUBMIT_WEEK " + buidPartition(date) + " WHERE ID = ? ORDER BY REQUEST_TIME DESC";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                one = new MsgBrandSubmit();
                one.setId(rs.getInt("ID"));
                one.setPhone(rs.getString("PHONE"));
                one.setOper(rs.getString("OPER"));
                one.setMessage(rs.getString("MESSAGE"));
                one.setTotalSms(rs.getInt("TOTAL_SMS"));
                one.setTotalPrice(rs.getInt("SMS_PRICE"));
                one.setLabel(rs.getString("LABEL"));
                one.setUserSender(rs.getString("USER_SENDER"));
                one.setRequestTime(rs.getTimestamp("REQUEST_TIME"));
                one.setTimeSend(rs.getTimestamp("SEND_TIME"));
                one.setResult(rs.getInt("RESULT"));
                one.setType(rs.getInt("TYPE"));
                one.setLbNode(rs.getString("LB_NODE"));
                one.setErrInfo(rs.getString("ERROR_INFO"));
                one.setSysId(rs.getString("SYS_ID"));
                one.setTranId(rs.getString("TRANS_ID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return one;
    }

    private static String buidPartition(String date) {
        String result = "";
        if (!Tool.checkNull(date)) {
            try {
                String[] arr = date.split("/");
                if (arr.length == 3) {
                    if (arr[2].length() == 4) {
                        arr[2] = arr[2].substring(2);
                    }
                    result = "PARTITION(P_" + arr[1] + "_" + arr[2] + ")";
                }
            } catch (Exception e) {
                logger.error(Tool.getLogMessage(e));
            }
        }
        return result;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCpCode() {
        return cpCode;
    }

    public void setCpCode(String cpCode) {
        this.cpCode = cpCode;
    }

    public String getOper() {
        return oper;
    }

    public void setOper(String oper) {
        this.oper = oper;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public Timestamp getTimeSend() {
        return timeSend;
    }

    public void setTimeSend(Timestamp timeSend) {
        this.timeSend = timeSend;
    }

    public Timestamp getLogTime() {
        return logTime;
    }

    public void setLogTime(Timestamp logTime) {
        this.logTime = logTime;
    }

    public int getResult() {
        return result;
    }

    public void setResult(int result) {
        this.result = result;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getTotalSms() {
        return totalSms;
    }

    public void setTotalSms(int totalSms) {
        this.totalSms = totalSms;
    }

    public Timestamp getRequestTime() {
        return requestTime;
    }

    public void setRequestTime(Timestamp requestTime) {
        this.requestTime = requestTime;
    }

    public String getErrInfo() {
        return errInfo;
    }

    public void setErrInfo(String errInfo) {
        this.errInfo = errInfo;
    }

    public String getTranId() {
        return tranId;
    }

    public void setTranId(String tranId) {
        this.tranId = tranId;
    }

    public String getSendTo() {
        return sendTo;
    }

    public void setSendTo(String sendTo) {
        this.sendTo = sendTo;
    }

    public String getLbNode() {
        return lbNode;
    }

    public void setLbNode(String lbNode) {
        this.lbNode = lbNode;
    }

    public String getBrGroup() {
        return brGroup;
    }

    public void setBrGroup(String brGroup) {
        this.brGroup = brGroup;
    }

    public String getSysId() {
        return sysId;
    }

    public void setSysId(String sysId) {
        this.sysId = sysId;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }
    
    

    public String getUserSender() {
        return userSender;
    }

    public void setUserSender(String userSender) {
        this.userSender = userSender;
    }

    int id;
    String phone;
    String cpCode;
    String oper;
    String message;
    int totalSms;
    String label;
    String userSender;
    Timestamp requestTime;
    Timestamp logTime;
    Timestamp timeSend;
    int result;
    int type;
    String errInfo;
    String tranId;
    String sendTo;
    String brGroup;
    String lbNode;
    String sysId;
    int totalPrice;
}
