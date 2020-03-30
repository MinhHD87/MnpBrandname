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
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import org.apache.log4j.Logger;

/**
 *
 * @author TUANPLA
 */
public class Money_info {

    static final Logger logger = Logger.getLogger(Money_info.class);

    public ArrayList<Money_info> getBlance() {
        ArrayList<Money_info> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* "
                + "FROM MONEY_VAS_VTE A ORDER BY A.LAST_TIME DESC LIMIT 10";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Money_info one = new Money_info();
                one.setAmount(rs.getString("AMOUNT"));
                one.setLasTime(rs.getTimestamp("LAST_TIME"));
                one.setInfo(rs.getString("INFO"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public Money_info getBlanceNew() {
        Tool.debug("Lay So du Tu DB");
        Money_info one = new Money_info();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* "
                + "FROM MONEY_VAS_VTE A ORDER BY A.LAST_TIME DESC LIMIT 1";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            if (rs.next()) {
                one.setAmount(rs.getString("AMOUNT"));
                one.setLasTime(rs.getTimestamp("LAST_TIME"));
                one.setInfo(rs.getString("INFO"));
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return one;
    }

    public long getLastMoney() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT AMOUNT FROM MONEY_VAS_VTE ORDER BY LAST_TIME DESC LIMIT 1 ";
        try {
            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstmt, conn);
        }
        return 0;
    }

    String amount;
    Timestamp lasTime;
    String info;

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public Timestamp getLasTime() {
        return lasTime;
    }

    public void setLasTime(Timestamp lasTime) {
        this.lasTime = lasTime;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

}
