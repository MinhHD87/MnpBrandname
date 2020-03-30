/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.admin.Account;
import gk.myname.vn.db.DBPool;
import static gk.myname.vn.entity.BrandLabel.reload;
import static gk.myname.vn.utils.ExcelUtil.normalizeCellType;
import gk.myname.vn.utils.SMSUtils;
import gk.myname.vn.utils.Tool;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author tuanp
 */
public class MsgBrandAds {

    static final Logger logger = Logger.getLogger(MsgBrandAds.class);
    
    public boolean update(MsgBrandAds mba) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE MSG_BRAND_ADS_RESULT SET PHONE = ?, OPER = ?, MESSAGE = ?, TOTAL_SMS = ?, LABEL = ?, USER_SENDER = ?, TRANS_ID = ?,"
                + " RESULT = ?, TIME_SEND = ?, SEND_TO = ?, BR_GROUP = ?, CP_CODE = ?, STATUS = ?"
                + " WHERE ID = ? ";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, mba.getPhone());
            pstm.setString(i++, mba.getOper());
            pstm.setString(i++, mba.getMessage());
            pstm.setInt(i++, mba.getTotalMsg());
            pstm.setString(i++, mba.getLabel());
            pstm.setString(i++, mba.getUserSender());
            pstm.setString(i++, mba.getTranId());
            pstm.setString(i++, mba.getResult());
            pstm.setString(i++, mba.getTimeSend());
            pstm.setString(i++, mba.getSendTo());
            pstm.setString(i++, mba.getBrGroup());
            pstm.setString(i++, mba.getCpCode());
            pstm.setInt(i++, mba.getStatus());
            
            pstm.setInt(i++, mba.getId());
            if( pstm.executeUpdate() == 1) {
                result = true;
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public ArrayList<MsgBrandAds> staticAll(String startTime, String endTime, String result, String user, String label) {
        ArrayList<MsgBrandAds> allList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT DATE_FORMAT(TIME_SEND_SEARCH,'%d/%m/%Y') AS TIME_SEND_SEARCH,SUM(TOTAL_SMS) AS TOTAL_SMS,USER_SENDER,LABEL,OPER "
                + " FROM MSG_BRAND_ADS_RESULT WHERE 1=1 ";
        try {
            if (!Tool.checkNull(user)) {
                sql += " AND USER_SENDER = ?";
            }
            if (!Tool.checkNull(label)) {
                sql += " AND LABEL = ?";
            }
            if (!Tool.checkNull(startTime)) {
                sql += " AND DATEDIFF(TIME_SEND_SEARCH,STR_TO_DATE(?, '%d/%m/%Y') ) >=0";
            }
            if (!Tool.checkNull(endTime)) {
                sql += " AND DATEDIFF(TIME_SEND_SEARCH,STR_TO_DATE(?, '%d/%m/%Y')) <=0";
            }
            if (!Tool.checkNull(result)) {
                sql += " AND UPPER(RESULT) = UPPER(?)";
            }
            sql += " GROUP BY DATE_FORMAT(TIME_SEND_SEARCH,'%d/%m/%Y'),USER_SENDER,LABEL,OPER ORDER BY TIME_SEND_SEARCH ASC";
            Tool.debug(sql);
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(user)) {
                pstm.setString(i++, user);
            }
            if (!Tool.checkNull(label)) {
                pstm.setString(i++, label);
            }
            if (!Tool.checkNull(startTime)) {
                pstm.setString(i++, startTime);
            }
            if (!Tool.checkNull(endTime)) {
                pstm.setString(i++, endTime);
            }
            if (!Tool.checkNull(result)) {
                pstm.setString(i++, result);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                MsgBrandAds oneAds = new MsgBrandAds();
                oneAds.setOper(rs.getString("OPER"));
                oneAds.setTotalMsg(rs.getInt("TOTAL_SMS"));
                oneAds.setLabel(rs.getString("LABEL"));
                oneAds.setUserSender(rs.getString("USER_SENDER"));
                oneAds.setTimeSend(rs.getString("TIME_SEND_SEARCH"));
                allList.add(oneAds);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return allList;
    }

    public ArrayList<MsgBrandAds> findByAll(int page, int maxrow, String campaign, String phone, String startTime, String endTime, String result, String user, String telco, String label) {
        ArrayList<MsgBrandAds> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM  MSG_BRAND_ADS_RESULT WHERE 1=1";
        try {
            if (!Tool.checkNull(user)) {
                sql += " AND USER_SENDER = ?";
            }
            if (!Tool.checkNull(campaign)) {
                sql += " AND TRANS_ID = ?";
            }
            if (!Tool.checkNull(telco)) {
                sql += " AND OPER = ?";
            }
            if (!Tool.checkNull(label)) {
                sql += " AND LABEL = ?";
            }
            if (!Tool.checkNull(phone)) {
                sql += " AND PHONE like ?";
            }
            if (!Tool.checkNull(startTime)) {
                sql += " AND DATEDIFF(TIME_SEND_SEARCH,STR_TO_DATE(?, '%d/%m/%Y') ) >=0";
            }
            if (!Tool.checkNull(endTime)) {
                sql += " AND DATEDIFF(TIME_SEND_SEARCH,STR_TO_DATE(?, '%d/%m/%Y')) <=0";
            }
            if (!Tool.checkNull(result)) {
                sql += " AND RESULT = ? ";
            }
            sql += " ORDER BY CAMPAIGN_TIME DESC  LIMIT ?,?";
            int start = (page - 1) * maxrow;
            Tool.debug(sql);
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(user)) {
                pstm.setString(i++, user);
            }
            if (!Tool.checkNull(campaign)) {
                pstm.setString(i++, campaign);
            }
            if (!Tool.checkNull(telco)) {
                pstm.setString(i++, telco);
            }
            if (!Tool.checkNull(label)) {
                pstm.setString(i++, label);
            }
            if (!Tool.checkNull(phone)) {
                pstm.setString(i++, "%" + phone);
            }
            if (!Tool.checkNull(startTime)) {
                pstm.setString(i++, startTime);
            }
            if (!Tool.checkNull(endTime)) {
                pstm.setString(i++, endTime);
            }
            if (!Tool.checkNull(result)) {
                pstm.setString(i++, result);
            }
            pstm.setInt(i++, start);
            pstm.setInt(i++, maxrow);
            rs = pstm.executeQuery();
            while (rs.next()) {
                MsgBrandAds one = new MsgBrandAds();
                one.setId(rs.getInt("ID"));
                one.setPhone(rs.getString("PHONE"));
                one.setOper(rs.getString("OPER"));
                one.setMessage(rs.getString("MESSAGE"));
                one.setTotalMsg(rs.getInt("TOTAL_SMS"));
                one.setLabel(rs.getString("LABEL"));
                one.setUserSender(rs.getString("USER_SENDER"));
                one.setResult(rs.getString("RESULT"));
                one.setTranId(rs.getString("TRANS_ID"));
                one.setTimeSend(rs.getString("TIME_SEND"));
                one.setCampaignTime(rs.getTimestamp("CAMPAIGN_TIME"));
                one.setSendTo(rs.getString("SEND_TO"));
                one.setBrGroup(rs.getString("BR_GROUP"));
                one.setCpCode(rs.getString("CP_CODE"));
                one.setStatus(rs.getInt("STATUS"));
                list.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return list;
    }
    
    public MsgBrandAds findById (int id) {
        MsgBrandAds mba = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM  MSG_BRAND_ADS_RESULT WHERE 1=1 AND ID = ?";
        try {
            Tool.debug(sql);
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            rs = pstm.executeQuery();
            while (rs.next()) {
                mba = new MsgBrandAds();
                mba.setId(rs.getInt("ID"));
                mba.setPhone(rs.getString("PHONE"));
                mba.setOper(rs.getString("OPER"));
                mba.setMessage(rs.getString("MESSAGE"));
                mba.setTotalMsg(rs.getInt("TOTAL_SMS"));
                mba.setLabel(rs.getString("LABEL"));
                mba.setUserSender(rs.getString("USER_SENDER"));
                mba.setResult(rs.getString("RESULT"));
                mba.setTranId(rs.getString("TRANS_ID"));
                mba.setTimeSend(rs.getString("TIME_SEND"));
                mba.setCampaignTime(rs.getTimestamp("CAMPAIGN_TIME"));
                mba.setSendTo(rs.getString("SEND_TO"));
                mba.setBrGroup(rs.getString("BR_GROUP"));
                mba.setCpCode(rs.getString("CP_CODE"));
                mba.setStatus(rs.getInt("STATUS"));
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return mba;
    }
    
    public boolean delForEver(int id) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "DELETE FROM MSG_BRAND_ADS_RESULT WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            if (pstm.executeUpdate() == 1) {
                flag = true;
                reload();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return flag;
    }

    public int countByAll(String campaign, String phone, String startTime, String endTime, String result, String user, String telco, String label) {
        int counter = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM  MSG_BRAND_ADS_RESULT WHERE 1=1 ";
        try {
            if (!Tool.checkNull(user)) {
                sql += " AND USER_SENDER = ?";
            }
            if (!Tool.checkNull(campaign)) {
                sql += " AND TRANS_ID = ?";
            }
            if (!Tool.checkNull(telco)) {
                sql += " AND OPER = ?";
            }
            if (!Tool.checkNull(label)) {
                sql += " AND LABEL = ?";
            }
            if (!Tool.checkNull(phone)) {
                sql += " AND PHONE like ?";
            }
            if (!Tool.checkNull(startTime)) {
                sql += " AND DATEDIFF(TIME_SEND_SEARCH,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
            }
            if (!Tool.checkNull(endTime)) {
                sql += " AND DATEDIFF(TIME_SEND_SEARCH,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
            }
            if (!Tool.checkNull(result)) {
                sql += " AND RESULT = ?";
            }
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(user)) {
                pstm.setString(i++, user);
            }
            if (!Tool.checkNull(campaign)) {
                pstm.setString(i++, campaign);
            }
            if (!Tool.checkNull(telco)) {
                pstm.setString(i++, telco);
            }
            if (!Tool.checkNull(label)) {
                pstm.setString(i++, label);
            }
            if (!Tool.checkNull(phone)) {
                pstm.setString(i++, "%" + phone);
            }
            if (!Tool.checkNull(startTime)) {
                pstm.setString(i++, startTime);
            }
            if (!Tool.checkNull(endTime)) {
                pstm.setString(i++, endTime);
            }
            if (!Tool.checkNull(result)) {
                pstm.setString(i++, result);
            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                counter = rs.getInt(1);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return counter;
    }

    public boolean addNewMsg(ArrayList<MsgBrandAds> listData, String timeSearch) {
        boolean _result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
//        String sql = "INSERT INTO MSG_BRAND_ADS_RESULT(PHONE,OPER,MESSAGE,TOTAL_SMS,LABEL,USER_SENDER,RESULT,TRANS_ID,TIME_SEND_SEARCH          , TIME_SEND,CAMPAIGN_TIME       ,SEND_TO,BR_GROUP,CP_CODE,STATUS)"
//                + "                             VALUES(  ?  , ?  ,   ?   ,    ?    ,  ?  ,    ?      ,  ?   ,   ?    ,STR_TO_DATE(?, '%d/%m/%Y'),       ?  ,CONVERT(?, DATETIME),   ?   ,    ?   ,   ?   ,    ? )";
        String sql = "INSERT INTO MSG_BRAND_ADS_RESULT(PHONE,OPER,MESSAGE,TOTAL_SMS,LABEL,USER_SENDER,RESULT,TRANS_ID,TIME_SEND_SEARCH          , TIME_SEND,SEND_TO,BR_GROUP,CP_CODE,STATUS,CAMPAIGN_STRING_TIME)"
                + "                             VALUES(  ?  , ?  ,   ?   ,    ?    ,  ?  ,    ?      ,  ?   ,   ?    ,STR_TO_DATE(?, '%d/%m/%Y'),       ?  ,   ?   ,    ?   ,   ?   ,    ? ,?)";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            if (listData != null && !listData.isEmpty()) {
                for (MsgBrandAds one : listData) {
                    System.out.println(one.toString());
                    int i = 1;
                    try {
                        pstm.setString(i++, one.getPhone());
                        pstm.setString(i++, one.getOper());
                        pstm.setString(i++, one.getMessage());
                        pstm.setInt(i++, one.getTotalMsg());
                        pstm.setString(i++, one.getLabel());
                        pstm.setString(i++, one.getUserSender());
                        pstm.setString(i++, one.getResult());
                        pstm.setString(i++, one.getTranId());
                        pstm.setString(i++, timeSearch);
                        pstm.setString(i++, one.getTimeSend());
//                        System.out.println(one.getCampaignTime());
//                        pstm.setString(i++, one.getCampaignTime().toString());
                        pstm.setString(i++, one.getSendTo());
                        pstm.setString(i++, one.getBrGroup());
                        pstm.setString(i++, one.getCpCode());
                        pstm.setInt(i++, one.getStatus());
                        pstm.setString(i++, one.getCampaignTime().toString());
                        if (pstm.executeUpdate() == 1) {
                            _result = true;
                            reload();
                        } else {
                            Tool.debug("Khong Thuc Thi Duoc...");
                        }
                    } catch (SQLException e) {
                        logger.error(one.toJson() + ": " + Tool.getLogMessage(e));
                    }
                }
            }
        } catch (SQLException e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return _result;
    }

    public String toJson() {
        JSONObject obj = JSONObject.fromObject(this);
        return obj.toString();
    }

    public static ArrayList<MsgBrandAds> readXsl(InputStream ipt, int sheetNum, Campaign cp, String sendTo, String group) {
        ArrayList<MsgBrandAds> allRow = new ArrayList<>();
        try {
            //Get the workbook instance for XLS file
            HSSFWorkbook workbook = new HSSFWorkbook(ipt);
            //Get first sheet from the workbook
            HSSFSheet oneSheet = workbook.getSheetAt(sheetNum);
            // Duyet qua tung dong cua mot sheet
            for (Row _oneRow : oneSheet) {
                MsgBrandAds onemsg = new MsgBrandAds();
                // Duyet qua tung cell cua mot dong

                String label = normalizeCellType(_oneRow.getCell(0));       // Khong Dung
                String message = normalizeCellType(_oneRow.getCell(1));
                String phone = normalizeCellType(_oneRow.getCell(2));
                String totalmsg = normalizeCellType(_oneRow.getCell(3));
                String timeSend = normalizeCellType(_oneRow.getCell(4));
                String oper = SMSUtils.buildMobileOperator(phone);
                if (oper.equalsIgnoreCase("OTHER")) {
                    continue;
                }
//                String oper = normalizeCellType(_oneRow.getCell(5));  // Khong Dung
                String result = normalizeCellType(_oneRow.getCell(6));
                if (result.equalsIgnoreCase("Success")) {
                    result = "1";
                }
                if (result.equalsIgnoreCase("Failed")) {
                    result = "0";
                }
                //--
                onemsg.setPhone(phone);
                onemsg.setOper(SMSUtils.buildMobileOperator(phone));
                onemsg.setMessage(message);
                onemsg.setTotalMsg(Tool.string2Integer(totalmsg));
                onemsg.setLabel(label);
                Account acc = Account.getAccount(cp.getUserSender());
                onemsg.setUserSender(cp.getUserSender());
                onemsg.setResult(result);
                onemsg.setTranId(cp.getCampaignId());
                onemsg.setTimeSend(timeSend);
                // Addition
                onemsg.setCampaignTime(cp.getEndTime());
                onemsg.setSendTo(sendTo);
                onemsg.setBrGroup(group);
                onemsg.setCpCode(acc.getCpCode());
                onemsg.setStatus(0);        // Chua Duyet sau khi Upload
                allRow.add(onemsg);
            }
        } catch (Exception ex) {
            logger.error(Tool.getLogMessage(ex));
        }
        return allRow;
    }

    public static ArrayList<MsgBrandAds> readXslx(InputStream ipt, int sheetNum, Campaign cp, String sendTo, String group) {
        ArrayList<MsgBrandAds> allRow = new ArrayList<>();
        try {
            //Get the workbook instance for XLS file
            XSSFWorkbook workbook = new XSSFWorkbook(ipt);
            //Get first sheet from the workbook
            XSSFSheet oneSheet = workbook.getSheetAt(sheetNum);
            for (Row _oneRow : oneSheet) {
                MsgBrandAds onemsg = new MsgBrandAds();
                // Duyet qua tung cell cua mot dong
                String label = normalizeCellType(_oneRow.getCell(0));       // Khong Dung
                String message = normalizeCellType(_oneRow.getCell(1));
                String phone = normalizeCellType(_oneRow.getCell(2));
                String totalmsg = normalizeCellType(_oneRow.getCell(3));
                String timeSend = normalizeCellType(_oneRow.getCell(4));
                String oper = SMSUtils.buildMobileOperator(phone);
                if (oper.equalsIgnoreCase("OTHER")) {
                    continue;
                }
//                String oper = normalizeCellType(_oneRow.getCell(5));        // Khong Dung
                String result = normalizeCellType(_oneRow.getCell(6));
                if (result.equalsIgnoreCase("Success")) {
                    result = "1";
                }
                if (result.equalsIgnoreCase("Failed")) {
                    result = "0";
                }
                onemsg.setLabel(label);
                onemsg.setMessage(message);
                onemsg.setPhone(phone);
                onemsg.setTotalMsg(Tool.string2Integer(totalmsg));
                onemsg.setTimeSend(timeSend);
                onemsg.setOper(SMSUtils.buildMobileOperator(phone));
                onemsg.setResult(result);
                allRow.add(onemsg);
                // Addition
                onemsg.setUserSender(cp.getUserSender());
                onemsg.setTranId(cp.getCampaignId());
                onemsg.setCampaignTime(cp.getEndTime());
                onemsg.setSendTo(sendTo);
                onemsg.setBrGroup(group);
                Account acc = Account.getAccount(cp.getUserSender());
                onemsg.setCpCode(acc != null ? acc.getCpCode() : "?");
                onemsg.setStatus(0);        // Chua Duyet sau khi Upload
            }
        } catch (Exception ex) {
            logger.error(Tool.getLogMessage(ex));
        }
        return allRow;
    }
    //--
    int id;
    String phone;
    String oper;
    String message;
    int totalMsg;
    String label;
    String userSender;
    String result;
    String tranId; // is campaign ID
    String timeSend;
    Timestamp campaignTime;
    String sendTo;
    String brGroup;
    String cpCode;
    int status;

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

    public int getTotalMsg() {
        return totalMsg;
    }

    public void setTotalMsg(int totalMsg) {
        this.totalMsg = totalMsg;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getUserSender() {
        return userSender;
    }

    public void setUserSender(String userSender) {
        this.userSender = userSender;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getTranId() {
        return tranId;
    }

    public void setTranId(String tranId) {
        this.tranId = tranId;
    }

    public String getTimeSend() {
        return timeSend;
    }

    public void setTimeSend(String timeSend) {
        this.timeSend = timeSend;
    }

    public Timestamp getCampaignTime() {
        return campaignTime;
    }

    public void setCampaignTime(Timestamp campaignTime) {
        this.campaignTime = campaignTime;
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

    public String getCpCode() {
        return cpCode;
    }

    public void setCpCode(String cpCode) {
        this.cpCode = cpCode;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "MsgBrandAds{" + "id=" + id + ", phone=" + phone + ", oper=" + oper + ", message=" + message + ", totalMsg=" + totalMsg + ", label=" + label + ", userSender=" + userSender + ", result=" + result + ", tranId=" + tranId + ", timeSend=" + timeSend + ", campaignTime=" + campaignTime + ", sendTo=" + sendTo + ", brGroup=" + brGroup + ", cpCode=" + cpCode + ", status=" + status + '}';
    }
    
    

}
