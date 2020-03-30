/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.admin.Account;
import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.DateProc;
import gk.myname.vn.utils.SMSUtils;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import org.apache.log4j.Logger;

/**
 *
 * @author TUANPLA
 */
public class ResendEntity {

    static final Logger logger = Logger.getLogger(ResendEntity.class);

    public ArrayList<ResendEntity> getAllLog(int page, int max, String accName, int status, String transId) {
        ArrayList<ResendEntity> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM MSG_RESEND_BY_ADMIN A WHERE SEND_BY = ? ";
        try {
            if (status != -1) {
                sql += " AND STATUS = ?";
            }
            if (!Tool.checkNull(transId)) {
                sql += " AND TRAND_ID = ?";
            }
            sql += " ORDER BY A.REQUEST_TIME DESC LIMIT ?,?";
            int start = (page - 1) * max;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, accName);
            if (status != -1) {
                pstm.setInt(i++, status);
            }
            if (!Tool.checkNull(transId)) {
                pstm.setString(i++, transId);
            }
            pstm.setInt(i++, start);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                ResendEntity one = new ResendEntity();
                one.setId(rs.getInt("ID"));
                one.setUserSender(rs.getString("USER_SENDER"));
                one.setPhone(rs.getString("PHONE"));
                one.setLabel(rs.getString("LABEL"));
//                one.setMessage(rs.getString("MESSAGE"));
                one.setRequestTime(rs.getTimestamp("REQUEST_TIME"));
                one.setSendBy(rs.getString("SEND_BY"));
                one.setStatus(rs.getInt("STATUS"));
                one.setInfo(rs.getString("INFO"));
                one.setTrandId(rs.getString("TRAND_ID"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public int countAllLog(String accName, int status) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT COUNT(*) FROM MSG_RESEND_BY_ADMIN WHERE SEND_BY = ? ";
        try {
            if (status != -1) {
                sql += " AND STATUS = ?";
            }
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, accName);
            if (status != -1) {
                pstm.setInt(i++, status);
            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public ArrayList<ResendEntity> getAll_History_Log(int page, int max, String cpResend, int status, String phone, String stRequest, String endRequest) {
        ArrayList<ResendEntity> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM MSG_RESEND_BY_ADMIN_LOG A WHERE 1=1 ";
        try {
            if (status != -1) {
                sql += " AND STATUS = ?";
            }
            if (!Tool.checkNull(cpResend)) {
                sql += " AND USER_SENDER = ?";
            }
            if (!Tool.checkNull(phone)) {
                sql += " AND PHONE like ?";
            }
            if (!Tool.checkNull(stRequest)) {
                sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0 ";
            }
            if (!Tool.checkNull(endRequest)) {
                sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0 ";
            }
            sql += " ORDER BY A.REQUEST_TIME DESC LIMIT ?,?";
            int start = (page - 1) * max;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;

            if (status != -1) {
                pstm.setInt(i++, status);
            }
            if (!Tool.checkNull(cpResend)) {
                pstm.setString(i++, cpResend);
            }
            if (!Tool.checkNull(phone)) {
                pstm.setString(i++, phone);
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            pstm.setInt(i++, start);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                ResendEntity one = new ResendEntity();
                one.setId(rs.getInt("ID"));
                one.setUserSender(rs.getString("USER_SENDER"));
                one.setPhone(rs.getString("PHONE"));
                one.setLabel(rs.getString("LABEL"));
//                one.setMessage(rs.getString("MESSAGE"));
                one.setRequestTime(rs.getTimestamp("REQUEST_TIME"));
                one.setSendBy(rs.getString("SEND_BY"));
                one.setStatus(rs.getInt("STATUS"));
                one.setInfo(rs.getString("INFO"));
                one.setTrandId(rs.getString("TRAND_ID"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public int countAll_History_Log(String cpResend, int status, String phone, String stRequest, String endRequest) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT COUNT(*) FROM MSG_RESEND_BY_ADMIN_LOG WHERE 1=1 ";
        try {
            if (status != -1) {
                sql += " AND STATUS = ?";
            }
            if (!Tool.checkNull(cpResend)) {
                sql += " AND USER_SENDER = ?";
            }
            if (!Tool.checkNull(phone)) {
                sql += " AND PHONE like ?";
            }
            if (!Tool.checkNull(stRequest)) {
                sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0 ";
            }
            if (!Tool.checkNull(endRequest)) {
                sql += " AND DATEDIFF(REQUEST_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0 ";
            }
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (status != -1) {
                pstm.setInt(i++, status);
            }
            if (!Tool.checkNull(cpResend)) {
                pstm.setString(i++, cpResend);
            }
            if (!Tool.checkNull(phone)) {
                pstm.setString(i++, phone);
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public static ArrayList<ResendEntity> getTransIdProcess(String accName) {
        ArrayList<ResendEntity> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT TRAND_ID FROM MSG_RESEND_BY_ADMIN A WHERE SEND_BY = ? GROUP BY TRAND_ID";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, accName);
            rs = pstm.executeQuery();
            while (rs.next()) {
                ResendEntity one = new ResendEntity();
                one.setTrandId(rs.getString("TRAND_ID"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    private void insertData(ArrayList<ResendEntity> insertList) {
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "INSERT INTO  MSG_RESEND_BY_ADMIN(USER_SENDER,PHONE,LABEL,MESSAGE,REQUEST_TIME,SEND_BY,STATUS,INFO,TRAND_ID)"
                + "                             VALUES(    ?     ,  ?  ,  ?  ,   ?   ,  NOW()     ,    ?  ,  ?   ,  ? ,   ?    )";
        try {
            if (!insertList.isEmpty()) {
                conn = DBPool.getConnection();
                pstm = conn.prepareStatement(sql);
                String trasId = insertList.get(0).getSendBy() + "-" + DateProc.getDateTimeForName();
                for (ResendEntity one : insertList) {
                    try {
                        int i = 1;
                        pstm.setString(i++, one.getUserSender());
                        pstm.setString(i++, one.getPhone());
                        pstm.setString(i++, one.getLabel());
                        pstm.setString(i++, one.getMessage());
                        pstm.setString(i++, one.getSendBy());
                        pstm.setInt(i++, one.getStatus());
                        pstm.setString(i++, one.getInfo());
                        pstm.setString(i++, trasId);
                        pstm.execute();
                        pstm.clearParameters();
                    } catch (Exception e) {
                        logger.error(Tool.getLogMessage(e));
                    }
                }
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(pstm, conn);
        }
    }

    public void processListData(ArrayList<ResendEntity> lsData, String cpUser) {
        ArrayList<ResendEntity> insertList = new ArrayList<>();
        for (ResendEntity one : lsData) {
            Account acc = Account.getAccount(cpUser);
            if (acc == null || acc.getStatus() != Account.STATUS.ACTIVE.val) {
                one.setInfo("KH Chọn Gửi tin không đúng hoặc Tài khoản [" + cpUser + "] KH Bị khóa");
                one.setStatus(STATUS.ERROR.val);
                insertList.add(one);
                continue;
            }
            one.setUserSender(cpUser);
            String _phone = SMSUtils.phoneTo84(one.getPhone());
            boolean phoneValid = SMSUtils.validPhoneVN(_phone);
            if (!phoneValid) {
                one.setInfo("Format Phone Not Valid");
                one.setStatus(STATUS.ERROR.val);
                insertList.add(one);
                continue;
            }
            String oper = SMSUtils.buildMobileOperator(one.getPhone());
            int totalMsg = SMSUtils.countSmsBrandCSKH(one.getMessage(), oper);
            if (totalMsg == SMSUtils.REJECT_MSG_LENG) {
                one.setInfo("Quá tổng số tin nhắn cho phép");
                one.setStatus(STATUS.WAIT.val);
                insertList.add(one);
                continue;
            }
            BrandLabel brand = BrandLabel.getFromCache(cpUser, one.getLabel());
            if (brand != null) {
                one.setInfo("Wait confirm");
                one.setStatus(STATUS.WAIT.val);
                insertList.add(one);
            } else {
                one.setInfo("Nhãn gửi tin của KH không được cấp");
                one.setStatus(STATUS.ERROR.val);
                insertList.add(one);
            }
        }
        insertData(insertList);
    }

    public void updateProcessList(String transId) {
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE MSG_RESEND_BY_ADMIN SET STATUS = ?, INFO = ? WHERE TRAND_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, STATUS.READY.val);
            pstm.setString(i++, "Ready Send");
            pstm.setString(i++, transId);
            pstm.executeUpdate();
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
    }

    public void delProcessList(String transId) {
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "DELETE FROM MSG_RESEND_BY_ADMIN WHERE TRAND_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, transId);
            pstm.executeUpdate();
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
    }
//--
    int id;
    String userSender;
    String label;
    String phone;
    String message;
    Timestamp requestTime;
    String sendBy;
    int status;
    String info;
    String trandId;

    public String getTrandId() {
        return trandId;
    }

    public void setTrandId(String trandId) {
        this.trandId = trandId;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getRequestTime() {
        return requestTime;
    }

    public void setRequestTime(Timestamp requestTime) {
        this.requestTime = requestTime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserSender() {
        return userSender;
    }

    public void setUserSender(String userSender) {
        this.userSender = userSender;
    }

    public String getSendBy() {
        return sendBy;
    }

    public void setSendBy(String sendBy) {
        this.sendBy = sendBy;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public static enum STATUS {

        WAIT(0, "Chờ duyệt"),
        READY(1, "Sẵn sàng gửi"),
        ERROR(504, "Lỗi");
        public int val;
        public String desc;

        private STATUS(int val, String desc) {
            this.val = val;
            this.desc = desc;
        }

        public static String getDesc(int val) {
            String str = "Unknow";
            for (STATUS one : STATUS.values()) {
                if (one.val == val) {
                    str = one.desc;
                    break;
                }
            }
            return str;
        }
    }
}
