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
 * @author Private
 */
public class Campaign {

    static final Logger logger = Logger.getLogger(Campaign.class);
    public static final String LOCAL_PATH_ADS = "/data/webroot/upload/campaign/advertisement/";
    public static final String LOCAL_PATH_CUS_CARE = "/data/webroot/upload/campaign/customer_care/";
    public static final String LOCAL_PATH_ADS_RESULT = "/data/webroot/upload/campaign/ads_result/";

    public boolean allowEdit() {
        return status == Campaign.STATUS.WAIT.val || status == Campaign.STATUS.CONFIRM.val;
    }

    public ArrayList<Campaign> countStatistic(String startTime, String endTime, int status, String userSender) {
        ArrayList<Campaign> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT SUM(TOTAL_VTE) AS TOTAL_VTE,SUM(TOTAL_VINA) AS TOTAL_VINA"
                + "		,SUM(TOTAL_MOBI) AS TOTAL_MOBI, SUM(TOTAL_VNM) AS TOTAL_VNM,SUM(TOTAL_BL) AS TOTAL_BL,LABEL,USER_SENDER"
                + " from campaign  WHERE 1=1 ";
        try {
            if (!Tool.checkNull(userSender)) {
                sql += " AND USER_SENDER = ?";
            }
            if (!Tool.checkNull(startTime)) {
                sql += " AND DATEDIFF(END_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
            }
            if (!Tool.checkNull(endTime)) {
                sql += " AND DATEDIFF(END_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
            }
            if (status != -2) {
                sql += " AND STATUS = ?";
            }
            sql += " GROUP BY LABEL,USER_SENDER";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(startTime)) {
                pstm.setString(i++, startTime + " 00:00:00");
            }
            if (!Tool.checkNull(endTime)) {
                pstm.setString(i++, endTime + " 23:59:59");
            }
            if (status != -2) {
                pstm.setInt(i++, status);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                Campaign one = new Campaign();
                one.setVteTTsms(rs.getInt("TOTAL_VTE"));
                one.setMobiTTsms(rs.getInt("TOTAL_MOBI"));
                one.setVinaTTsms(rs.getInt("TOTAL_VINA"));
                one.setVnmTTsms(rs.getInt("TOTAL_VNM"));
                one.setBlTTsms(rs.getInt("TOTAL_BL"));
                one.setLabel(rs.getString("LABEL"));
                one.setUserSender(rs.getString("USER_SENDER"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean addNew(Campaign one) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO CAMPAIGN(NAME,CP_DESC,CAMPAIGN_ID,USER_SENDER,LABEL,MESSAGE,TOTAL_VTE,TOTAL_VINA,TOTAL_MOBI,TOTAL_VNM,TOTAL_BL,CREATE_BY,CREATE_DATE,END_TIME,STATUS)"
                + "                 VALUES( ?  ,     ? ,    ?      ,     ?     ,  ?  ,    ?  ,    ?    ,    ?     ,     ?    ,    ?    ,   ?    ,    ?    ,   NOW()   ,   ?    ,  ?   )";

        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, one.getName());
            pstm.setString(i++, one.getDesc());
            pstm.setString(i++, one.getCampaignId());
            pstm.setString(i++, one.getUserSender());
            pstm.setString(i++, one.getLabel());
            pstm.setString(i++, one.getMessage());
            pstm.setInt(i++, one.getVteTTsms());
            pstm.setInt(i++, one.getVinaTTsms());
            pstm.setInt(i++, one.getMobiTTsms());
            pstm.setInt(i++, one.getVnmTTsms());
            pstm.setInt(i++, one.getBlTTsms());
            pstm.setString(i++, one.getCreateBy());
            pstm.setTimestamp(i++, one.getEndTime());
            pstm.setInt(i++, one.getStatus());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean update(Campaign one) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE  CAMPAIGN SET NAME = ?,`CP_DESC`=?,USER_SENDER = ?, END_TIME = ?, STATUS = ? Where ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, one.getName());
            pstm.setString(i++, one.getDesc());
            pstm.setString(i++, one.getUserSender());
            pstm.setTimestamp(i++, one.getEndTime());
            pstm.setInt(i++, one.getStatus());
            pstm.setInt(i++, one.getId());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean confirm(int id, int _status, String reason) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE CAMPAIGN SET STATUS = ?,REASON = ? Where ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, _status);
            pstm.setString(i++, reason);
            pstm.setInt(i++, id);
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public Campaign findById(int id) {
        Campaign result = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM  CAMPAIGN Where ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = new Campaign();
                result.setId(rs.getInt("ID"));
                result.setName(rs.getString("NAME"));
                result.setDesc(rs.getString("CP_DESC"));
                result.setCampaignId(rs.getString("CAMPAIGN_ID"));
                result.setUserSender(rs.getString("USER_SENDER"));
                result.setLabel(rs.getString("LABEL"));
                result.setCreateBy(rs.getString("CREATE_BY"));
                result.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                result.setEndTime(rs.getTimestamp("END_TIME"));
                result.setType(rs.getInt("CP_TYPE"));
                result.setReason(rs.getString("REASON"));
                result.setStatus(rs.getInt("STATUS"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean delById(int id) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "DELETE FROM  CAMPAIGN Where ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            return pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public ArrayList<Campaign> findByUser(int status, String user) {
        ArrayList<Campaign> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM  CAMPAIGN WHERE STATUS= ? AND END_TIME >= NOW()";
        try {
            if (!Tool.checkNull(user)) {
                sql += " AND CREATE_BY = ?";
            }
            if (status != -2) {
                sql += " AND STATUS = ?";
            }
            Tool.debug(sql);
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, status);
            if (!Tool.checkNull(user)) {
                pstm.setString(i++, user);
            }
            if (status != -2) {
                pstm.setInt(i++, status);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                Campaign one = new Campaign();
                one.setId(rs.getInt("ID"));
                one.setName(rs.getString("NAME"));
                one.setDesc(rs.getString("CP_DESC"));
                one.setCampaignId(rs.getString("CAMPAIGN_ID"));
                one.setUserSender(rs.getString("USER_SENDER"));
                one.setCreateBy(rs.getString("CREATE_BY"));
                one.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                one.setEndTime(rs.getTimestamp("END_TIME"));
                one.setType(rs.getInt("CP_TYPE"));
                one.setReason(rs.getString("REASON"));
                one.setStatus(rs.getInt("STATUS"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public ArrayList<Campaign> findByAll(int page, int max, String campaign, int type, String name, String startTime, String endTime,
            String startCal, String endCal, int status, String userSender) {
        ArrayList<Campaign> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM  CAMPAIGN WHERE CP_TYPE = ?";
        try {
            if (!Tool.checkNull(userSender)) {
                sql += " AND USER_SENDER = ?";
            }
            if (!Tool.checkNull(campaign)) {
                sql += " AND CAMPAIGN_ID = ?";
            }
            if (!Tool.checkNull(name)) {
                sql += " AND NAME like ?";
            }
            if (!Tool.checkNull(startTime)) {
                sql += " AND DATEDIFF(CREATE_DATE,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
            }
            if (!Tool.checkNull(endTime)) {
                sql += " AND DATEDIFF(CREATE_DATE,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
            }
            if (!Tool.checkNull(startCal)) {
                sql += " AND DATEDIFF(END_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
            }
            if (!Tool.checkNull(endCal)) {
                sql += " AND DATEDIFF(END_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
            }
            if (status != -2) {
                sql += " AND STATUS = ?";
            }
            sql += " ORDER BY CREATE_DATE DESC LIMIT ?,?";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, type);
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(campaign)) {
                pstm.setString(i++, campaign);
            }
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, "%" + name + "%");
            }
            if (!Tool.checkNull(startTime)) {
                pstm.setString(i++, startTime + " 00:00:00");
            }
            if (!Tool.checkNull(endTime)) {
                pstm.setString(i++, endTime + " 23:59:59");
            }
            if (!Tool.checkNull(startCal)) {
                pstm.setString(i++, startCal + " 00:00:00");
            }
            if (!Tool.checkNull(endCal)) {
                pstm.setString(i++, endCal + " 23:59:59");
            }
            if (status != -2) {
                pstm.setInt(i++, status);
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            Tool.debug(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Campaign one = new Campaign();
                one.setId(rs.getInt("ID"));
                one.setName(rs.getString("NAME"));
                one.setDesc(rs.getString("CP_DESC"));
                one.setCampaignId(rs.getString("CAMPAIGN_ID"));
                one.setUserSender(rs.getString("USER_SENDER"));
                one.setLabel(rs.getString("LABEL"));
                one.setMessage(rs.getString("MESSAGE"));
                one.setVteTTsms(rs.getInt("TOTAL_VTE"));
                one.setMobiTTsms(rs.getInt("TOTAL_MOBI"));
                one.setVinaTTsms(rs.getInt("TOTAL_VINA"));
                one.setVnmTTsms(rs.getInt("TOTAL_VNM"));
                one.setBlTTsms(rs.getInt("TOTAL_BL"));
                one.setCreateBy(rs.getString("CREATE_BY"));
                one.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                one.setEndTime(rs.getTimestamp("END_TIME"));
                one.setType(rs.getInt("CP_TYPE"));
                one.setReason(rs.getString("REASON"));
                one.setStatus(rs.getInt("STATUS"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
    
    public ArrayList<Campaign> findAll() {
        ArrayList<Campaign> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM CAMPAIGN WHERE 1 = 1";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            Tool.debug(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Campaign one = new Campaign();
                one.setId(rs.getInt("ID"));
                one.setName(rs.getString("NAME"));
                one.setDesc(rs.getString("CP_DESC"));
                one.setCampaignId(rs.getString("CAMPAIGN_ID"));
                one.setUserSender(rs.getString("USER_SENDER"));
                one.setLabel(rs.getString("LABEL"));
                one.setMessage(rs.getString("MESSAGE"));
                one.setVteTTsms(rs.getInt("TOTAL_VTE"));
                one.setMobiTTsms(rs.getInt("TOTAL_MOBI"));
                one.setVinaTTsms(rs.getInt("TOTAL_VINA"));
                one.setVnmTTsms(rs.getInt("TOTAL_VNM"));
                one.setBlTTsms(rs.getInt("TOTAL_BL"));
                one.setCreateBy(rs.getString("CREATE_BY"));
                one.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                one.setEndTime(rs.getTimestamp("END_TIME"));
                one.setType(rs.getInt("CP_TYPE"));
                one.setReason(rs.getString("REASON"));
                one.setStatus(rs.getInt("STATUS"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public int countByAll(String campaign, int type, String name, String startTime, String endTime, String startCal, String endCal, int status, String userSender) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM  CAMPAIGN WHERE CP_TYPE=? ";
        try {
            if (!Tool.checkNull(userSender)) {
                sql += " AND USER_SENDER like ?";
            }
            if (!Tool.checkNull(campaign)) {
                sql += " AND CAMPAIGN_ID = ?";
            }
            if (!Tool.checkNull(name)) {
                sql += " AND NAME like ?";
            }
            if (!Tool.checkNull(startTime)) {
                sql += " AND DATEDIFF(CREATE_DATE,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
            }
            if (!Tool.checkNull(endTime)) {
                sql += " AND DATEDIFF(CREATE_DATE,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
            }
            if (!Tool.checkNull(endTime)) {
                sql += " AND DATEDIFF(CREATE_DATE,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
            }
            if (!Tool.checkNull(startCal)) {
                sql += " AND DATEDIFF(END_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
            }
            if (!Tool.checkNull(endCal)) {
                sql += " AND DATEDIFF(END_TIME,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
            }
            if (status != -2) {
                sql += " AND STATUS = ?";
            }
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, type);
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(campaign)) {
                pstm.setString(i++, campaign);
            }
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, "%" + name + "%");
            }
            if (!Tool.checkNull(startTime)) {
                pstm.setString(i++, startTime + " 00:00:00");
            }
            if (!Tool.checkNull(endTime)) {
                pstm.setString(i++, endTime + " 23:59:59");
            }
            if (!Tool.checkNull(startCal)) {
                pstm.setString(i++, startCal + " 00:00:00");
            }
            if (!Tool.checkNull(endCal)) {
                pstm.setString(i++, endCal + " 23:59:59");
            }
            if (status != -2) {
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

    public boolean isWait() {
        return status == STATUS.WAIT.val;
    }

    public boolean isSending() {
        return status == STATUS.SENDING.val;
    }

    public boolean isSended() {
        return status == STATUS.SENDED.val;
    }

    public boolean isConfirm() {
        return status == STATUS.CONFIRM.val;
    }

    public boolean isReject() {
        return status == STATUS.REJECT.val;
    }

    //--
    public static enum STATUS {

        WAIT(0, "Chờ Duyệt"),
        CONFIRM(1, "Duyệt Chờ Gửi"), //--
        SENDING(2, "Đang gửi"), //--
        SENDED(3, "Đã gửi"), //--
        REJECT(4, "Từ Chối"), //--
        ;

        public int val;
        public String desc;

        private STATUS(int val, String desc) {
            this.val = val;
            this.desc = desc;
        }

        public static String getDesc(int val) {
            String result = "Unknow";
            for (STATUS one : STATUS.values()) {
                if (one.val == val) {
                    result = one.desc;
                }
            }
            return result;
        }
    }

    public static enum TYPE {

        CSKH(1, "CSKH"),
        QC(0, "QC"), //--
        ;

        public int val;
        public String desc;

        private TYPE(int val, String desc) {
            this.val = val;
            this.desc = desc;
        }

        public static String getDesc(int val) {
            String result = "Unknow";
            for (STATUS one : STATUS.values()) {
                if (one.val == val) {
                    result = one.desc;
                }
            }
            return result;
        }
    }
    //--
    int id;
    String name;
    String desc;
    String campaignId;
    String userSender;
    String label;
    String message;
    int vteTTsms;
    int mobiTTsms;
    int vinaTTsms;
    int vnmTTsms;
    int blTTsms;
    String createBy;
    Timestamp createDate;
    Timestamp endTime;
    int type;
    int status;
    String reason;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public String getUserSender() {
        return userSender;
    }

    public void setUserSender(String userSender) {
        this.userSender = userSender;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public Timestamp getEndTime() {
        return endTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getVteTTsms() {
        return vteTTsms;
    }

    public void setVteTTsms(int vteTTsms) {
        this.vteTTsms = vteTTsms;
    }

    public int getMobiTTsms() {
        return mobiTTsms;
    }

    public void setMobiTTsms(int mobiTTsms) {
        this.mobiTTsms = mobiTTsms;
    }

    public int getVinaTTsms() {
        return vinaTTsms;
    }

    public void setVinaTTsms(int vinaTTsms) {
        this.vinaTTsms = vinaTTsms;
    }

    public int getVnmTTsms() {
        return vnmTTsms;
    }

    public void setVnmTTsms(int vnmTTsms) {
        this.vnmTTsms = vnmTTsms;
    }

    public int getBlTTsms() {
        return blTTsms;
    }

    public void setBlTTsms(int blTTsms) {
        this.blTTsms = blTTsms;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getReason() {
        if (reason == null) {
            return "";
        }
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public boolean notapproved() {
        return status == STATUS.WAIT.val;
    }
}
