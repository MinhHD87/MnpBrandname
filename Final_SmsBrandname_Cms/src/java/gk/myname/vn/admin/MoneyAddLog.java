package gk.myname.vn.admin;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.Md5;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

public class MoneyAddLog {

    static final Logger logger = Logger.getLogger(MoneyAddLog.class);
    public static final boolean debugRight = true;

    public boolean addLogs(MoneyAddLog oneAcc) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "INSERT INTO MONEYADD_LOGS(ACCOUNTBILLING,USERNAMEADD,MONEYS,TIME_ADD,RESULTADD) VALUES(?,?,?,NOW(),?)";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, oneAcc.getAccountbilling());
            pstm.setString(i++, oneAcc.getUsernameadd());
            pstm.setInt(i++, oneAcc.getMoneys());
            pstm.setInt(i++, oneAcc.getResultadd());
            
            if (pstm.executeUpdate() == 1) {
                ok = true;
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(null, pstm, conn);
        }
        return ok;
    }

    public ArrayList<MoneyAddLog> getAllLog(int page, int max, String accountbilling, String useradd, int resultadd) {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM MONEYADD_LOGS WHERE (1=1)";
        if (!Tool.checkNull(accountbilling)) {
            sql += " AND ACCOUNTBILLING = ?";
        }
        if (!Tool.checkNull(useradd)) {
            sql += " AND USERNAMEADD = ?";
        }
//        if (!Tool.checkNull(resultadd)) {
//            sql += " AND RESULTADD = ?";
//        }
        sql += " ORDER BY TIME_ADD DESC LIMIT ?,?";
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            
            if (!Tool.checkNull(accountbilling)) {
                pstm.setString(i++, accountbilling);
            }
            if (!Tool.checkNull(useradd)) {
                pstm.setString(i++, useradd);
            }
//            if (!Tool.checkNull(resultadd)) {
//                pstm.setInt(i++, resultadd);
//            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                MoneyAddLog acc = new MoneyAddLog();
                acc.setId(rs.getLong("ID"));
                acc.setAccountbilling(rs.getString("ACCOUNTBILLING"));
                acc.setUsernameadd(rs.getString("USERNAMEADD"));
                acc.setMoneys(rs.getInt("MONEYS"));
                acc.setTime_add(rs.getTimestamp("TIME_ADD"));
                acc.setResultadd(rs.getInt("RESULTADD"));
                all.add(acc);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }
    
    public ArrayList<MoneyAddLog> getAllLog(int page, int max, String keyString) {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM MONEYADD_LOGS WHERE (1=1)";
        if (!Tool.checkNull(keyString)) {
            sql += " AND (ACCOUNTBILLING = ? OR USERNAMEADD = ?)";
        }
        
//        if (!Tool.checkNull(resultadd)) {
//            sql += " AND RESULTADD = ?";
//        }
        sql += " ORDER BY TIME_ADD DESC LIMIT ?,?";
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            
            if (!Tool.checkNull(keyString)) {
                pstm.setString(i++, keyString);
                pstm.setString(i++, keyString);
            }
            
//            if (!Tool.checkNull(resultadd)) {
//                pstm.setInt(i++, resultadd);
//            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                MoneyAddLog acc = new MoneyAddLog();
                acc.setId(rs.getLong("ID"));
                acc.setAccountbilling(rs.getString("ACCOUNTBILLING"));
                acc.setUsernameadd(rs.getString("USERNAMEADD"));
                acc.setMoneys(rs.getInt("MONEYS"));
                acc.setTime_add(rs.getTimestamp("TIME_ADD"));
                acc.setResultadd(rs.getInt("RESULTADD"));
                all.add(acc);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }
    
    
//    public static ArrayList<MoneyAddLog> getAllPrepaid() {
//        ArrayList all = new ArrayList();
//        Connection conn = null;
//        PreparedStatement pstm = null;
//        ResultSet rs = null;
//        String sql = "SELECT USERNAME,FULL_NAME,PREPAID,BALANCE,GPC_PRICE,VTE_PRICE,VMS_PRICE,VNM_PRICE,BL_PRICE,STATUS FROM ACCOUNTS "
//                + "WHERE (USER_TYPE = ? OR USER_TYPE = ?)";
//                sql += " AND PREPAID = 1";
//        
//        sql += " ORDER BY USERNAME DESC";
//        Tool.debug(sql);
//        try {
//            conn = DBPool.getConnection();
//            pstm = conn.prepareStatement(sql);
//            int i = 1;
//            pstm.setInt(i++, TYPE.AGENCY.val);
//            pstm.setInt(i++, TYPE.AGENCY_MANAGER.val);
//            
//            
//            rs = pstm.executeQuery();
//            while (rs.next()) {
//                MoneyAddLog acc = new MoneyAddLog();
//                acc.setUsername(rs.getString("USERNAME"));
//                acc.setFullname(rs.getString("FULL_NAME"));
//                acc.setPrepaid(rs.getInt("PREPAID"));
//                acc.setBalance(rs.getInt("BALANCE"));
//                acc.setGpc_Price(rs.getInt("GPC_PRICE"));
//                acc.setVte_Price(rs.getInt("VTE_PRICE"));
//                acc.setVms_Price(rs.getInt("VMS_PRICE"));
//                acc.setVnm_Price(rs.getInt("VNM_PRICE"));
//                acc.setBl_Price(rs.getInt("BL_PRICE"));
//                acc.setStatus(rs.getInt("STATUS"));
//                all.add(acc);
//            }
//        } catch (SQLException ex) {
//            logger.error(Tool.getLogMessage(ex));
//        } finally {
//            DBPool.freeConn(rs, pstm, conn);
//        }
//        return all;
//    }

    public int countAllLog(String accountbilling, String useradd, int resultadd) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM MONEYADD_LOGS WHERE (1=1)";
        if (!Tool.checkNull(accountbilling)) {
            sql += " AND ACCOUNTBILLING = ?";
        }
        if (!Tool.checkNull(useradd)) {
            sql += " AND USERNAMEADD = ?";
        }
//        if (!Tool.checkNull(resultadd)) {
//            sql += " AND RESULTADD = ?";
//        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(accountbilling)) {
                pstm.setString(i++, accountbilling);
            }
            if (!Tool.checkNull(useradd)) {
                pstm.setString(i++, useradd);
            }
//            if (!Tool.checkNull(resultadd)) {
//                pstm.setInt(i++, resultadd);
//            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
    
    
    public int countAllLog(String keyString) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM MONEYADD_LOGS WHERE (1=1)";
        if (!Tool.checkNull(keyString)) {
            sql += " AND (ACCOUNTBILLING = ? OR USERNAMEADD=?)";
        }
        
//        if (!Tool.checkNull(resultadd)) {
//            sql += " AND RESULTADD = ?";
//        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(keyString)) {
                pstm.setString(i++, keyString);
                pstm.setString(i++, keyString);
            }
            
//            if (!Tool.checkNull(resultadd)) {
//                pstm.setInt(i++, resultadd);
//            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
    
//    public MoneyAddLog getByUsername(String username) {
//        MoneyAddLog acc = null;
//        Connection conn = null;
//        PreparedStatement pstm = null;
//        ResultSet rs = null;
//        String sql = "SELECT USERNAME,FULL_NAME,PREPAID,BALANCE,GPC_PRICE,VTE_PRICE,VMS_PRICE,VNM_PRICE,BL_PRICE,STATUS FROM ACCOUNTS  WHERE USERNAME = ?";
//        try {
//            conn = DBPool.getConnection();
//            pstm = conn.prepareStatement(sql);
//            pstm.setString(1, username);
//            rs = pstm.executeQuery();
//            if (rs.next()) {
//                acc = new MoneyAddLog();
//                acc.setUsername(rs.getString("USERNAME"));
//                acc.setFullname(rs.getString("FULL_NAME"));
//                acc.setPrepaid(rs.getInt("PREPAID"));
//                acc.setBalance(rs.getInt("BALANCE"));
//                acc.setGpc_Price(rs.getInt("GPC_PRICE"));
//                acc.setVte_Price(rs.getInt("VTE_PRICE"));
//                acc.setVms_Price(rs.getInt("VMS_PRICE"));
//                acc.setVnm_Price(rs.getInt("VNM_PRICE"));
//                acc.setBl_Price(rs.getInt("BL_PRICE"));
//                acc.setStatus(rs.getInt("STATUS"));
//            }
//        } catch (SQLException ex) {
//            logger.error(Tool.getLogMessage(ex));
//        } finally {
//            DBPool.freeConn(rs, pstm, conn);
//        }
//        return acc;
//    }

    long id;
    String accountbilling;
    String usernameadd;
    int moneys;
    Timestamp time_add;
    int resultadd;

    

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getAccountbilling() {
        return accountbilling;
    }

    public void setAccountbilling(String accountbilling) {
        this.accountbilling = accountbilling;
    }

    public String getUsernameadd() {
        return usernameadd;
    }

    public void setUsernameadd(String usernameadd) {
        this.usernameadd = usernameadd;
    }

    public int getMoneys() {
        return moneys;
    }

    public void setMoneys(int moneys) {
        this.moneys = moneys;
    }

    public Timestamp getTime_add() {
        return time_add;
    }

    public void setTime_add(Timestamp time_add) {
        this.time_add = time_add;
    }

    public int getResultadd() {
        return resultadd;
    }

    public void setResultadd(int resultadd) {
        this.resultadd = resultadd;
    }

    

    

}
