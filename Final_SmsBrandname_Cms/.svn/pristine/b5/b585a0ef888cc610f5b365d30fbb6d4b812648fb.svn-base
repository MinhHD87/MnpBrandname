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
 * @author TUANPLA
 */
public class AlertNotify {

    final Logger logger = Logger.getLogger(AlertNotify.class);

    public static enum KIND {

        MONITOR(1, "Monitor he thong"),
        ALER(2, "Alert Error"), //--
        ALL(3, "Monitor & Alert"), //--
        ;

        public int val;
        public String desc;

        public static String getname(int val) {
            String result = "unKnow";
            for (KIND one : KIND.values()) {
                if (one.val == val) {
                    result = one.desc;
                    break;
                }
            }
            return result;
        }

        private KIND(int val, String desc) {
            this.val = val;
            this.desc = desc;
        }
    }

    public static enum TYPE {

        EMAIL(1, "Alert Email"),
        SMS(2, "Alert SMS Brand"), //--
        SMS_NOMAL(3, "Alert SMS Thuong"), //--
        ALL(4, "Alert Email And SMS"), //--
        ;

        public int val;
        public String desc;

        public static String getname(int val) {
            String result = "unKnow";
            for (TYPE one : TYPE.values()) {
                if (one.val == val) {
                    result = one.desc;
                    break;
                }
            }
            return result;
        }

        private TYPE(int val, String desc) {
            this.val = val;
            this.desc = desc;
        }
    }

    public ArrayList<AlertNotify> getbyAll(int page, int max, String phoneEmail) {
        ArrayList<AlertNotify> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM MONITOR_APP A WHERE 1=1";
        try {
            if (!Tool.checkNull(phoneEmail)) {
                sql += " AND (RECEIVER_NUMBER = ? OR EMAIL = ?)";
            }
            sql += " ORDER BY A.ID DESC LIMIT ?,? ";
            conn = DBPool.getConnection();
            pstm = conn.prepareCall(sql);
            int i = 1;
            if (!Tool.checkNull(phoneEmail)) {
                pstm.setString(i++, phoneEmail);
                pstm.setString(i++, phoneEmail);
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                AlertNotify one = new AlertNotify();
                one.setNotifyId(rs.getInt("ID"));
                one.setPhone(rs.getString("RECEIVER_NUMBER"));
                one.setMessage(rs.getString("MESSAGE"));
                one.setLabelId(rs.getInt("LABEL_ID"));
                one.setKind(rs.getInt("KIND"));
                one.setType(rs.getInt("TYPE"));
                one.setContentEmail(rs.getString("CONTENT_EMAIL"));
                one.setStartTime(rs.getInt("START_TIME_ALERT"));
                one.setEndTime(rs.getInt("END_TIME_ALERT"));
                one.setEmail(rs.getString("EMAIL"));
                one.setLastNotify(new Timestamp(rs.getLong("LAST_NOTIFY")));
                one.setNextNotify(new Timestamp(rs.getLong("NEXT_NOTIFY")));
                one.setDelay(rs.getInt("DELAY_NOTIFY"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public int countAll(String phoneEmail) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM MONITOR_APP WHERE 1=1 ";
        try {
            if (!Tool.checkNull(phoneEmail)) {
                sql += " AND (RECEIVER_NUMBER like ? OR EMAIL like ?)";
            }
            conn = DBPool.getConnection();
            pstm = conn.prepareCall(sql);
            Tool.debug(sql);
            int i = 1;
            if (!Tool.checkNull(phoneEmail)) {
                pstm.setString(i++, "%" + phoneEmail + "%");
                pstm.setString(i++, "%" + phoneEmail + "%");
            }
            Tool.debug("i=" + i);
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

    public boolean add(AlertNotify one) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO MONITOR_APP(RECEIVER_NUMBER,MESSAGE,LABEL_ID,KIND,TYPE,CONTENT_EMAIL,START_TIME_ALERT,END_TIME_ALERT,EMAIL,DELAY_NOTIFY) "
                + "                    VALUES(         ?      ,   ?   ,    ?   , ?  , ?  ,     ?       ,        ?       ,     ?        , ?   ,    ?      )";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, one.getPhone());
            pstm.setString(i++, one.getMessage());
            pstm.setInt(i++, one.getLabelId());
            pstm.setInt(i++, one.getKind());
            pstm.setInt(i++, one.getType());
            pstm.setString(i++, one.getContentEmail());
            pstm.setInt(i++, one.getStartTime());
            pstm.setInt(i++, one.getEndTime());
            pstm.setString(i++, one.getEmail());
            pstm.setInt(i++, one.getDelay());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public AlertNotify getbyId(int id) {
        AlertNotify result = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM MONITOR_APP A WHERE ID=?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareCall(sql);
            int i = 1;
            pstm.setInt(i++, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = new AlertNotify();
                result.setNotifyId(rs.getInt("ID"));
                result.setPhone(rs.getString("RECEIVER_NUMBER"));
                result.setMessage(rs.getString("MESSAGE"));
                result.setLabelId(rs.getInt("LABEL_ID"));
                result.setKind(rs.getInt("KIND"));
                result.setType(rs.getInt("TYPE"));
                result.setContentEmail(rs.getString("CONTENT_EMAIL"));
                result.setStartTime(rs.getInt("START_TIME_ALERT"));
                result.setEndTime(rs.getInt("END_TIME_ALERT"));
                result.setEmail(rs.getString("EMAIL"));
                result.setLastNotify(new Timestamp(rs.getLong("LAST_NOTIFY")));
                result.setNextNotify(new Timestamp(rs.getLong("NEXT_NOTIFY")));
                result.setDelay(rs.getInt("DELAY_NOTIFY"));
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean update(AlertNotify one) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE MONITOR_APP SET RECEIVER_NUMBER = ?,MESSAGE = ?,LABEL_ID = ?,KIND = ?,TYPE = ?,"
                + " CONTENT_EMAIL = ?,START_TIME_ALERT = ?,END_TIME_ALERT = ?,EMAIL = ?,DELAY_NOTIFY = ? WHERE ID = ? ";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, one.getPhone());
            pstm.setString(i++, one.getMessage());
            pstm.setInt(i++, one.getLabelId());
            pstm.setInt(i++, one.getKind());
            pstm.setInt(i++, one.getType());
            pstm.setString(i++, one.getContentEmail());
            pstm.setInt(i++, one.getStartTime());
            pstm.setInt(i++, one.getEndTime());
            pstm.setString(i++, one.getEmail());
            pstm.setInt(i++, one.getDelay());
            pstm.setInt(i++, one.getNotifyId());
            result = pstm.executeUpdate() == 1;
            Tool.debug("update Result =" + result);
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean del(int id) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "DELETE FROM MONITOR_APP WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
//*******************
    private int notifyId;
    private String phone;
    private String message;
    private int labelId;
    private int kind;       // 1 Monitor 2: Alert 3: ALL
    private int type;       // 1: Alert Email 2: Phone 3 ALL
    private String contentEmail;
    private int startTime;
    private int endTime;
    private String email;
    private Timestamp lastNotify;
    private Timestamp nextNotify;
    private int delay;

    public int getNotifyId() {
        return notifyId;
    }

    public void setNotifyId(int notifyId) {
        this.notifyId = notifyId;
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

    public int getLabelId() {
        return labelId;
    }

    public void setLabelId(int labelId) {
        this.labelId = labelId;
    }

    public int getKind() {
        return kind;
    }

    public void setKind(int kind) {
        this.kind = kind;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getContentEmail() {
        return contentEmail;
    }

    public void setContentEmail(String contentEmail) {
        this.contentEmail = contentEmail;
    }

    public int getStartTime() {
        return startTime;
    }

    public void setStartTime(int startTime) {
        this.startTime = startTime;
    }

    public int getEndTime() {
        return endTime;
    }

    public void setEndTime(int endTime) {
        this.endTime = endTime;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Timestamp getLastNotify() {
        return lastNotify;
    }

    public void setLastNotify(Timestamp lastNotify) {
        this.lastNotify = lastNotify;
    }

    public Timestamp getNextNotify() {
        return nextNotify;
    }

    public void setNextNotify(Timestamp nextNotify) {
        this.nextNotify = nextNotify;
    }

    public int getDelay() {
        return delay;
    }

    public void setDelay(int delay) {
        this.delay = delay;
    }

}
