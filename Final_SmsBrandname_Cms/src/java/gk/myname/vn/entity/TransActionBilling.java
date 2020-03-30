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
public class TransActionBilling {

    static final Logger logger = Logger.getLogger(TransActionBilling.class);

    public ArrayList<TransActionBilling> getAllTransActionBilling(int page, int max,
            String userSender, String type, 
            //            String provider, 
            String stRequest, String endRequest, String transbilID, String telco) {
        ArrayList<TransActionBilling> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * "
                + " FROM TRANSACTION_BILLING"
                + " WHERE 1=1 ";
        if (!Tool.checkNull(userSender)) {
            sql += " AND ACCOUNT_NAME = ?";
        }
        if (!type.equals("-1")&&!Tool.checkNull(type)) {
            sql += " AND TYPE_TRANS = ?";
        }
        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(TIME_ACTION,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(TIME_ACTION,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
        }
        if (!Tool.checkNull(transbilID)) {
            sql += " AND BILLING_TRANS = ?";
        }
        if (!Tool.checkNull(telco)) {
            sql += " AND TELCO = ?";
        }
        
        
        sql += " ORDER BY TIME_ACTION DESC LIMIT ?,?";
//        Tool.debug(sql);
//        Tool.debug("userSender="+userSender);
//        Tool.debug("type="+type);
//        Tool.debug("stRequest="+stRequest);
//        Tool.debug("endRequest="+endRequest);
//        Tool.debug("transbilID="+transbilID);
//        Tool.debug("telco="+telco);
        int start = (page - 1) * max;
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            
            if (!type.equals("-1")&&!Tool.checkNull(type)) {
                pstm.setString(i++, type);
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            if (!Tool.checkNull(transbilID)) {
                pstm.setString(i++, transbilID);
            }
            if (!Tool.checkNull(telco)) {
                pstm.setString(i++, telco);
            }
            
            pstm.setInt(i++, start);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                TransActionBilling one = new TransActionBilling();
                one.setId(rs.getInt("ID"));
                one.setBilling_trans(rs.getString("BILLING_TRANS"));
                one.setType_trans(rs.getString("TYPE_TRANS"));
                one.setMoney_trans(rs.getInt("MONEY_TRANS"));
                one.setAccount_name(rs.getString("ACCOUNT_NAME"));
                one.setAction_account(rs.getString("ACTION_ACCOUNT"));
                one.setUnit_price(rs.getInt("UNIT_PRICE"));
                one.setNumber_unit(rs.getInt("NUMBER_UNIT"));
                one.setTelco(rs.getString("TELCO"));
                one.setTime_action(rs.getTimestamp("TIME_ACTION"));
                one.setBalance_trans(rs.getInt("BALANCE_TRANS"));
                one.setBalance_before(rs.getInt("BALANCE_BEFORE"));
                one.setComment_note(rs.getString("COMMENT_NOTE"));
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
    
    
    

    public int countAllTransActionBilling(String userSender, String type, 
            //            String provider, 
            String stRequest, String endRequest, String transbilID, String telco) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT COUNT(*) "
                + " FROM TRANSACTION_BILLING"
                + " WHERE 1=1 ";
        if (!Tool.checkNull(userSender)) {
            sql += " AND ACCOUNT_NAME = ?";
        }
        if (!type.equals("-1")&&!Tool.checkNull(type)) {
            sql += " AND TYPE_TRANS = ?";
        }
        if (!Tool.checkNull(stRequest)) {
            sql += " AND DATEDIFF(TIME_ACTION,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s') ) >=0";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND DATEDIFF(TIME_ACTION,STR_TO_DATE(?, '%d/%m/%Y %H:%i:%s')) <=0";
        }
        if (!Tool.checkNull(transbilID)) {
            sql += " AND BILLING_TRANS = ?";
        }
        if (!Tool.checkNull(telco)) {
            sql += " AND TELCO = ?";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            
            if (!type.equals("-1")&&!Tool.checkNull(type)) {
                pstm.setString(i++, type);
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            if (!Tool.checkNull(transbilID)) {
                pstm.setString(i++, transbilID);
            }
            if (!Tool.checkNull(telco)) {
                pstm.setString(i++, telco);
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
    
    
    int id;
    String billing_trans;
    String type_trans;
    int money_trans;
    String account_name;
    String action_account;
    int unit_price;
    int number_unit;
    String telco;
    Timestamp time_action;
    int balance_trans;
    int balance_before;
    String comment_note;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBilling_trans() {
        return billing_trans;
    }

    public void setBilling_trans(String billing_trans) {
        this.billing_trans = billing_trans;
    }

    public String getType_trans() {
        return type_trans;
    }

    public void setType_trans(String type_trans) {
        this.type_trans = type_trans;
    }

    public int getMoney_trans() {
        return money_trans;
    }

    public void setMoney_trans(int money_trans) {
        this.money_trans = money_trans;
    }

    public String getAccount_name() {
        return account_name;
    }

    public void setAccount_name(String account_name) {
        this.account_name = account_name;
    }

    public String getAction_account() {
        return action_account;
    }

    public void setAction_account(String action_account) {
        this.action_account = action_account;
    }

    public int getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(int unit_price) {
        this.unit_price = unit_price;
    }

    public int getNumber_unit() {
        return number_unit;
    }

    public void setNumber_unit(int number_unit) {
        this.number_unit = number_unit;
    }

    public String getTelco() {
        return telco;
    }

    public void setTelco(String telco) {
        this.telco = telco;
    }

    public Timestamp getTime_action() {
        return time_action;
    }

    public void setTime_action(Timestamp time_action) {
        this.time_action = time_action;
    }

    public int getBalance_trans() {
        return balance_trans;
    }

    public void setBalance_trans(int balance_trans) {
        this.balance_trans = balance_trans;
    }

    public String getComment_note() {
        return comment_note;
    }

    public void setComment_note(String comment_note) {
        this.comment_note = comment_note;
    }

    public int getBalance_before() {
        return balance_before;
    }

    public void setBalance_before(int balance_before) {
        this.balance_before = balance_before;
    }
    
    
}
