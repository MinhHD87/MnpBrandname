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
public class MsgBrandRequest {

    static final Logger logger = Logger.getLogger(MsgBrandRequest.class);

    public ArrayList<MsgBrandRequest> statisticReq(String userSender, String cp_code, String label, int type,
            //            String provider,
            String stRequest,
            String endRequest, String oper, int result
    //            ,String groupBr
    ) {
        ArrayList<MsgBrandRequest> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = " SELECT SUM(TOTAL_SMS) AS TOTAL_SMS,OPER,Cast(LABEL As BINARY) as LABEL,RESULT,TYPE  ";

        sql += " FROM MSG_BRAND_INCOME " + buidPartition(stRequest) + " A WHERE 1=1 ";
        if (!Tool.checkNull(userSender)) {
            sql += " AND USER_SENDER = ?";
        }
        if (!Tool.checkNull(cp_code)) {
            sql += " AND (CP_CODE = ? OR CP_CODE like ?)";
        }
        if (!Tool.checkNull(label)) {
            sql += " AND upper(A.LABEL) = upper(?) ";
        }
        if (type != -1) {
            sql += " AND A.TYPE = ?";
        }
//        if (!Tool.checkNull(provider)) {
//            sql += " AND UPPER(SEND_TO) = ?";
//        }

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
            sql += " AND A.RESULT = 1";
        } else if (result == -1) {
            sql += " AND A.RESULT != 1";
        }
//        if (!Tool.checkNull(groupBr)) {
//            sql += " AND A.BR_GROUP = ?";
//        }
        sql += " GROUP BY OPER,Cast(LABEL As BINARY),RESULT,TYPE";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
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
            if (type != -1) {
                pstm.setInt(i++, type);
            }
//            if (!Tool.checkNull(provider)) {
//                pstm.setString(i++, provider);
//            }

            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
//            if (!Tool.checkNull(groupBr)) {
//                pstm.setString(i++, groupBr);
//            }

            rs = pstm.executeQuery();
            while (rs.next()) {
                MsgBrandRequest one = new MsgBrandRequest();
                one.setOper(rs.getString("OPER"));
                one.setLabel(rs.getString("LABEL"));
                one.setTotalSms(rs.getInt("TOTAL_SMS"));
                one.setResult(rs.getInt("RESULT"));
                one.setType(rs.getInt("TYPE"));
//                one.setSendTo(rs.getString("SEND_TO"));
//                one.setBrGroup(rs.getString("BR_GROUP"));
                all.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public ArrayList<MsgBrandRequest> getAllLog_MsgReq(int page, int max,
            String userSender, String cp_code, String _label, int type, int result,
            //            String provider, 
            String stRequest, String endRequest, String _phone, String telco, int err_code, String tranId) {
        ArrayList<MsgBrandRequest> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* "
                + " FROM MSG_BRAND_INCOME " + buidPartition(stRequest) + " A "
                + " WHERE 1=1 ";
        if (!Tool.checkNull(userSender)) {
            sql += " AND A.USER_SENDER = ?";
        }
        if (!Tool.checkNull(cp_code)) {
            sql += " AND (A.CP_CODE = ? OR A.CP_CODE Like ?) ";
        }
        if (!Tool.checkNull(_label)) {
            sql += " AND upper(A.LABEL) = upper(?) ";
        }
        if (type != -1) {
            sql += " AND A.TYPE = ?";
        }
        if (result != -1) {
            if (result == 99) {
                sql += " AND A.RESULT = 99";
            } else {
                sql += " AND A.RESULT != 99";
            }
        }
//        if (!Tool.checkNull(provider)) {
//            sql += " AND UPPER(A.SEND_TO) = ?";
//        }

        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(A.REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(A.REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
        }
        if (!Tool.checkNull(_phone)) {
            sql += " AND A.PHONE like ?";
        }
        if (!Tool.checkNull(telco)) {
            sql += " AND A.OPER = ?";
        }
        if (err_code != -1) {
            sql += " AND A.RESULT = ?";
        }
        if (!Tool.checkNull(tranId)) {
            sql += " AND A.TRANS_ID = ?";
        }
        sql += " ORDER BY A.REQUEST_TIME DESC LIMIT ?,?";
        Tool.debug(sql);
        int start = (page - 1) * max;
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, cp_code);
                pstm.setString(i++, cp_code + "_%");
            }
            if (!Tool.checkNull(_label)) {
                pstm.setString(i++, _label);
            }
            if (type != -1) {
                pstm.setInt(i++, type);
            }
//            if (!Tool.checkNull(provider)) {
//                pstm.setString(i++, provider);
//            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            if (!Tool.checkNull(_phone)) {
                pstm.setString(i++, "%" + _phone);
            }
            if (!Tool.checkNull(telco)) {
                pstm.setString(i++, telco);
            }
            if (err_code != -1) {
                pstm.setInt(i++, err_code);
            }
            if (!Tool.checkNull(tranId)) {
                pstm.setString(i++, tranId);
            }
            pstm.setInt(i++, start);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                MsgBrandRequest one = new MsgBrandRequest();
                one.setId(rs.getInt("ID"));
                one.setPhone(rs.getString("PHONE"));
                one.setOper(rs.getString("OPER"));
                one.setMessage(rs.getString("MESSAGE"));
                one.setTotalSms(rs.getInt("TOTAL_SMS"));
                one.setLabel(rs.getString("LABEL"));
                one.setUserSender(rs.getString("USER_SENDER"));
                one.setRequestTime(rs.getTimestamp("REQUEST_TIME"));
//                one.setLogTime(rs.getTimestamp("LOG_TIME"));
                one.setResult(rs.getInt("RESULT"));
                one.setErrInfo(rs.getString("ERROR_INFO"));
                one.setType(rs.getInt("TYPE"));
//                one.setSendTo(rs.getString("SEND_TO"));
//                one.setBrGroup(rs.getString("BR_GROUP"));
//                one.setProcessTime(rs.getLong("PROCESSTIME"));
                one.setLbNode(rs.getString("LB_NODE"));
                one.setCpCode(rs.getString("CP_CODE"));
                one.setTranId(rs.getString("TRANS_ID"));
                one.setSysId(rs.getString("SYS_ID"));
                one.setPriceSMS(rs.getInt("SMS_PRICE"));
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

    public int countAllLog_MsgReq(String userSender, String cp_code, String _Label, int type, int result,
            //            String provider, 
            String stRequest, String endRequest, String _phone, String telco, int err_code, String tranId) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM MSG_BRAND_INCOME " + buidPartition(stRequest) + " A WHERE 1=1 ";
        if (!Tool.checkNull(userSender)) {
            sql += " AND A.USER_SENDER = ?";
        }
        if (!Tool.checkNull(cp_code)) {
            sql += " AND (A.CP_CODE = ? OR A.CP_CODE Like ?) ";
        }
        if (!Tool.checkNull(_Label)) {
            sql += " AND upper(A.LABEL) = upper(?) ";
        }
        if (type != -1) {
            sql += " AND A.TYPE = ?";
        }
        if (result != -1) {
            if (result == 99) {
                sql += " AND A.RESULT = 99";
            } else {
                sql += " AND A.RESULT != 99";
            }
        }
//        if (!Tool.checkNull(provider)) {
//            sql += " AND UPPER(A.SEND_TO) = ?";
//        }

        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(A.REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(A.REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
        }
        if (!Tool.checkNull(_phone)) {
            sql += " AND A.PHONE like ?";
        }

        if (!Tool.checkNull(telco)) {
            sql += " AND A.OPER = ?";
        }
        if (err_code != -1) {
            sql += " AND A.RESULT = ?";
        }
        if (!Tool.checkNull(tranId)) {
            sql += " AND A.TRANS_ID = ?";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, cp_code);
                pstm.setString(i++, cp_code + "_%");
            }
            if (!Tool.checkNull(_Label)) {
                pstm.setString(i++, _Label);
            }
            if (type != -1) {
                pstm.setInt(i++, type);
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            if (!Tool.checkNull(_phone)) {
                pstm.setString(i++, "%" + _phone);
            }
//            if (!Tool.checkNull(provider)) {
//                pstm.setString(i++, provider);
//            }
            if (!Tool.checkNull(telco)) {
                pstm.setString(i++, telco);
            }
            if (err_code != -1) {
                pstm.setInt(i++, err_code);
            }
            if (!Tool.checkNull(tranId)) {
                pstm.setString(i++, tranId);
            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return count;
    }

    public MsgBrandRequest getById(int id, String date) {
        MsgBrandRequest one = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM MSG_BRAND_INCOME " + buidPartition(date) + " WHERE ID = ? ORDER BY REQUEST_TIME DESC";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                one = new MsgBrandRequest();
                one.setId(rs.getInt("ID"));
                one.setPhone(rs.getString("PHONE"));
                one.setOper(rs.getString("OPER"));
                one.setMessage(rs.getString("MESSAGE"));
                one.setTotalSms(rs.getInt("TOTAL_SMS"));
                one.setLabel(rs.getString("LABEL"));
                one.setUserSender(rs.getString("USER_SENDER"));
                one.setRequestTime(rs.getTimestamp("REQUEST_TIME"));
                one.setResult(rs.getInt("RESULT"));
                one.setType(rs.getInt("TYPE"));
//                one.setProcessTime(rs.getLong("PROCESSTIME"));
                one.setLbNode(rs.getString("LB_NODE"));
                one.setCpCode(rs.getString("CP_CODE"));
                one.setErrInfo(rs.getString("ERROR_INFO"));
                one.setTranId(rs.getString("TRANS_ID"));
                one.setSysId(rs.getString("SYS_ID"));
                one.setPriceSMS(rs.getInt("SMS_PRICE"));
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

    public String getUserSender() {
        return userSender;
    }

    public void setUserSender(String userSender) {
        this.userSender = userSender;
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

    public String getBrGroup() {
        return brGroup;
    }

    public void setBrGroup(String brGroup) {
        this.brGroup = brGroup;
    }

    public long getProcessTime() {
        return processTime;
    }

    public void setProcessTime(long processTime) {
        this.processTime = processTime;
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

    public String getSysId() {
        return sysId;
    }

    public void setSysId(String sysId) {
        this.sysId = sysId;
    }

    public int getPriceSMS() {
        return priceSMS;
    }

    public void setPriceSMS(int priceSMS) {
        this.priceSMS = priceSMS;
    }
    
    

    int id;
    String phone;
    String oper;
    String message;
    int totalSms;
    String label;
    String userSender;
    Timestamp requestTime;
    Timestamp logTime;
    int result;
    int type;
    String errInfo;
    String tranId;
    String sendTo;
    String brGroup;
    long processTime;
    String lbNode;
    String cpCode;
    String sysId;
    int priceSMS;

}
