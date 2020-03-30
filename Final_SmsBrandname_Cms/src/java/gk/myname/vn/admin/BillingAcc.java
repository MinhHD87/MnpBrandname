package gk.myname.vn.admin;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.entity.Provider_Telco;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.apache.log4j.Logger;

public class BillingAcc {

    static final Logger logger = Logger.getLogger(BillingAcc.class);
    public static final boolean debugRight = true;

    public boolean updateBilling(BillingAcc oneAcc) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "UPDATE ACCOUNTS set PREPAID = ?, GPC_PRICE = ?, VTE_PRICE = ?, VMS_PRICE=?, VNM_PRICE=?, BL_PRICE=?, DDG_PRICE=?, BALANCE=?, GPC_PE=?, VTE_PE=?, VMS_PE=?, VNM_PE=?, BL_PE=?, DDG_PE=?, MONTHLY_PRICE_ACTIVE=?, SMS_QUOTA=?, ALARMMONEY=?  WHERE USERNAME = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, oneAcc.getPrepaid());
            pstm.setInt(i++, oneAcc.getBalance());
            pstm.setInt(i++, oneAcc.getMonthly_price_active());
            pstm.setInt(i++, oneAcc.getSms_quota());
            pstm.setInt(i++, oneAcc.getAlarmmoney());
            pstm.setString(i++, oneAcc.getUsername());
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

    public boolean addPrice(BillingAcc oneAcc) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "UPDATE ACCOUNTS set PREPAID = ?,  BALANCE=?, MONTHLY_PRICE_ACTIVE=?, SMS_QUOTA=?, ALARMMONEY=?, SELL_PRICE = ? WHERE USERNAME = ?";
        String Sell_price = Provider_Telco.toStringJson(oneAcc.getSell_price());
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, oneAcc.getPrepaid());
            pstm.setInt(i++, oneAcc.getBalance());
            pstm.setInt(i++, oneAcc.getMonthly_price_active());
            pstm.setInt(i++, oneAcc.getSms_quota());
            pstm.setInt(i++, oneAcc.getAlarmmoney());
            pstm.setString(i++, Sell_price);
            pstm.setString(i++, oneAcc.getUsername());

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

    public ArrayList<BillingAcc> getAllAgentcy(int page, int max, String key, int status) {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT USERNAME,FULL_NAME,PREPAID,BALANCE,STATUS,SMS_QUOTA,MONTHLY_PRICE_ACTIVE,ALARMMONEY,SELL_PRICE,ID_TEMPLATE FROM ACCOUNTS "
                + "WHERE STATUS=1 AND USER_TYPE != ?";
        sql += " AND PREPAID = ?";
        if (!Tool.checkNull(key)) {
            sql += " AND (USERNAME like ?  OR FULL_NAME like ? OR CP_CODE = ?)";
        }
        sql += " ORDER BY USERNAME DESC LIMIT ?,?";
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, TYPE.ADMIN.val);
            pstm.setInt(i++, status);
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, key);
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                BillingAcc acc = new BillingAcc();
                acc.setUsername(rs.getString("USERNAME"));
                acc.setFullname(rs.getString("FULL_NAME"));
                acc.setPrepaid(rs.getInt("PREPAID"));
                acc.setBalance(rs.getInt("BALANCE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setSms_quota(rs.getInt("SMS_QUOTA"));
                acc.setMonthly_price_active(rs.getInt("MONTHLY_PRICE_ACTIVE"));
                acc.setAlarmmoney(rs.getInt("ALARMMONEY"));
                acc.setSell_price(rs.getString("SELL_PRICE"));
                acc.setId_template(rs.getInt("ID_TEMPLATE"));

                all.add(acc);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public static ArrayList<BillingAcc> getAllAccBilling() {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT USERNAME,FULL_NAME,PREPAID,BALANCE,STATUS,SMS_QUOTA,MONTHLY_PRICE_ACTIVE,ALARMMONEY,SELL_PRICE FROM ACCOUNTS "
                + "WHERE STATUS=1 ";
        sql += " AND PREPAID = 1";

        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;

            rs = pstm.executeQuery();
            while (rs.next()) {
                BillingAcc acc = new BillingAcc();
                acc.setUsername(rs.getString("USERNAME"));
                acc.setFullname(rs.getString("FULL_NAME"));
                acc.setPrepaid(rs.getInt("PREPAID"));
                acc.setBalance(rs.getInt("BALANCE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setSms_quota(rs.getInt("SMS_QUOTA"));
                acc.setMonthly_price_active(rs.getInt("MONTHLY_PRICE_ACTIVE"));
                acc.setAlarmmoney(rs.getInt("ALARMMONEY"));
                acc.setSell_price(rs.getString("SELL_PRICE"));
                all.add(acc);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public static ArrayList<BillingAcc> getAllPrepaid() {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT USERNAME,FULL_NAME,PREPAID,BALANCE,STATUS,SMS_QUOTA,MONTHLY_PRICE_ACTIVE,ALARMMONEY,SELL_PRICE FROM ACCOUNTS "
                + "WHERE USER_TYPE != ? ";
        sql += " AND PREPAID = 1";
        sql += " ORDER BY USERNAME DESC";
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, TYPE.ADMIN.val);
            rs = pstm.executeQuery();
            while (rs.next()) {
                BillingAcc acc = new BillingAcc();
                acc.setUsername(rs.getString("USERNAME"));
                acc.setFullname(rs.getString("FULL_NAME"));
                acc.setPrepaid(rs.getInt("PREPAID"));
                acc.setBalance(rs.getInt("BALANCE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setSms_quota(rs.getInt("SMS_QUOTA"));
                acc.setMonthly_price_active(rs.getInt("MONTHLY_PRICE_ACTIVE"));
                acc.setAlarmmoney(rs.getInt("ALARMMONEY"));
                acc.setSell_price(rs.getString("SELL_PRICE"));
                all.add(acc);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public int countAllAgentcy(String key, int status) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM ACCOUNTS "
                + "WHERE USER_TYPE != ? ";
        sql += " AND PREPAID = ?";
        if (!Tool.checkNull(key)) {
            sql += " AND (USERNAME like ?  OR FULL_NAME like ? OR CP_CODE = ?)";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, TYPE.ADMIN.val);
            pstm.setInt(i++, status);
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, key);
            }
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

    public BillingAcc getByUsername(String username) {
        BillingAcc acc = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT USERNAME,FULL_NAME,PREPAID,BALANCE,STATUS,SMS_QUOTA,MONTHLY_PRICE_ACTIVE,ALARMMONEY,SELL_PRICE FROM ACCOUNTS WHERE USERNAME = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, username);
            rs = pstm.executeQuery();
            if (rs.next()) {
                acc = new BillingAcc();
                acc.setUsername(rs.getString("USERNAME"));
                acc.setFullname(rs.getString("FULL_NAME"));
                acc.setPrepaid(rs.getInt("PREPAID"));
                acc.setBalance(rs.getInt("BALANCE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setSms_quota(rs.getInt("SMS_QUOTA"));
                acc.setMonthly_price_active(rs.getInt("MONTHLY_PRICE_ACTIVE"));
                acc.setAlarmmoney(rs.getInt("ALARMMONEY"));
                acc.setSell_price(rs.getString("SELL_PRICE"));
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return acc;
    }

    public boolean addTemp(BillingAcc addTemp) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "UPDATE ACCOUNTS set ID_TEMPLATE = ?  WHERE USERNAME = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, addTemp.getId_template());
            pstm.setString(i++, addTemp.getUsername());
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
    
    private String username;
    private String fullname;
    private int prepaid;
    private int balance;
    private int status;
    Provider_Telco telco;
    private int sms_quota;
    private int monthly_price_active;
    private int alarmmoney;
    private int id_template;

    public static enum STATUS {

        ACTIVE(1),
        LOCK(0),
        DEL(404);
        public int val;

        private STATUS(int val) {
            this.val = val;
        }
    }

    public static enum TYPE {

        USER(0, "Người dùng"), // Create Ads - Manager allow Createby Id                  USER
        ADMIN(1, "Quyền quản trị"), // ADMIN
        AGENCY(2, "Đại lý"), // Duoc phep ket noi gui Qua API  // TODO co nen cho tao tk con hay khong ??
        AGENCY_MANAGER(3, "Quản lý Đại lý") // Chi co quyen quan ly thong ke, khong duoc lam gi ca cao hon quyen user la duoc thong ke nhieu dai ly
        ;
        public int val;
        public String name;

        private TYPE(int val, String name) {
            this.val = val;
            this.name = name;
        }
    }

    public static String getTypeName(int type) {
        String name = "Ko có quyền";
        for (TYPE one : TYPE.values()) {
            if (type == one.val) {
                name = one.name;
                break;
            }
        }
        return name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getPrepaid() {
        return prepaid;
    }

    public void setPrepaid(int prepaid) {
        this.prepaid = prepaid;
    }

    public int getBalance() {
        return balance;
    }

    public void setBalance(int balance) {
        this.balance = balance;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public int getSms_quota() {
        return sms_quota;
    }

    public void setSms_quota(int sms_quota) {
        this.sms_quota = sms_quota;
    }

    public int getMonthly_price_active() {
        return monthly_price_active;
    }

    public void setMonthly_price_active(int monthly_price_active) {
        this.monthly_price_active = monthly_price_active;
    }

    public int getAlarmmoney() {
        return alarmmoney;
    }

    public void setAlarmmoney(int alarmmoney) {
        this.alarmmoney = alarmmoney;
    }

    public Provider_Telco getSell_price() {
        return telco;
    }

    public void setSell_price(Provider_Telco telco) {
        this.telco = telco;
    }

    public void setSell_price(String strJson) {
        this.telco = Provider_Telco.json2Object(strJson);
    }

    public int getId_template() {
        return id_template;
    }

    public void setId_template(int id_template) {
        this.id_template = id_template;
    }
}
