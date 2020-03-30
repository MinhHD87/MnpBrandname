/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.DateProc;
import gk.myname.vn.utils.SendMail;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import org.apache.log4j.Logger;

/**
 *
 * @author Cường <duongcuong96 at gmail dot com>
 */
public class AppConfig {

    static final Logger logger = Logger.getLogger(AppConfig.class);
    private static final Map<String, String> CACHE = new HashMap<>(); // chua data cua table config

    static {
        ArrayList<AppConfig> list = getAll();
        for (AppConfig one : list) {
            CACHE.put(one.getConfig_key(), one.getConfig_value());
        }
    }

    private static void reload(String key, String value) {
        CACHE.put(key, value);
    }

    private static void remove(String key) {
        CACHE.remove(key);
    }
//    entity : 
    private int id;
    private String config_key;
    private String config_value;
    private String create_date;
    private String update_date;
    private String create_by;
    private String update_by;
    private String cf_desc;

    public static ArrayList<AppConfig> getAll() {
        ArrayList arr = new ArrayList();
        String sql = null;
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rs = null;

        try {
            sql = "SELECT * FROM CONFIG_DB";
            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                AppConfig tmp_app = new AppConfig();
                tmp_app.setID(rs.getInt("ID"));
                tmp_app.setConfig_key(rs.getString("CONFIG_KEY"));
                tmp_app.setCf_desc(rs.getString("CF_DESC"));
                tmp_app.setConfig_value(rs.getString("CONFIG_VALUE"));
                tmp_app.setCreate_by(rs.getString("CREATE_BY"));
                tmp_app.setUpdate_by(rs.getString("UPDATE_BY"));
                tmp_app.setCreate_date(rs.getString("CREATE_DATE"));
                tmp_app.setUpdate_date(rs.getString("UPDATE_DATE"));
                arr.add(tmp_app);
            }
        } catch (SQLException e) {
            System.out.println("Error AppConfig.getAll() : ");
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstmt, conn);
        }

        return arr;
    }

    public boolean insertConfig(AppConfig conf) {
        String sql = "INSERT INTO CONFIG_DB(CONFIG_KEY , CONFIG_VALUE , CREATE_DATE , CREATE_BY , CF_DESC   )"
                + "                 VALUES (    ?      ,      ?       ,   NOW()     ,      ?    , ?         )";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {

            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            int i = 1;
            pstmt.setString(i++, conf.getConfig_key());
            pstmt.setString(i++, conf.getConfig_value());
            pstmt.setString(i++, conf.getCreate_by());
            pstmt.setString(i++, conf.getCf_desc());

            int tmp = pstmt.executeUpdate();
            if (tmp == 1) {
                reload(conf.getConfig_key(), conf.getConfig_value());
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(pstmt, conn);
        }

        return false;
    }

    public boolean updateConfig(AppConfig conf) {

        String sql = "UPDATE CONFIG_DB "
                + "   SET  CONFIG_VALUE = ? , UPDATE_DATE = ? , UPDATE_BY = ? , CF_DESC = ? "
                + " WHERE ID = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            int i = 1;
            pstmt.setString(i++, conf.getConfig_value());
            pstmt.setTimestamp(i++, DateProc.getCurrentTimestamp());
            pstmt.setString(i++, conf.getUpdate_by());
            pstmt.setString(i++, conf.getCf_desc());
            pstmt.setInt(i++, conf.getID());
            int tmp = pstmt.executeUpdate();
            if (tmp == 1) {
                reload(conf.getConfig_key(), conf.getConfig_value());
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(pstmt, conn);
        }
        return false;
    }

    public boolean deleteConfigById(int id) {
        String sql = "DELETE FROM CONFIG_DB WHERE ID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            AppConfig conf = getConfigById(id);
            pstmt.setInt(1, conf.getID());
            int tm = pstmt.executeUpdate();
            if (tm == 1) {
                remove(conf.getConfig_key());
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(pstmt, conn);
        }
        return false;
    }

    public AppConfig getConfigById(int id) {
        String sql = "SELECT *  FROM CONFIG_DB WHERE ID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        AppConfig appConfig = new AppConfig();
        try {
            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                appConfig.setID(rs.getInt("ID"));
                appConfig.setConfig_value(rs.getString("CONFIG_VALUE"));
                appConfig.setConfig_key(rs.getString("CONFIG_KEY"));
                appConfig.setCf_desc(rs.getString("CF_DESC"));
                appConfig.setCreate_by(rs.getString("CREATE_BY"));
                appConfig.setUpdate_by(rs.getString("UPDATE_BY"));
                appConfig.setCreate_date(rs.getString("CREATE_DATE"));
                appConfig.setUpdate_date(rs.getString("UPDATE_DATE"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstmt, conn);
        }
        return appConfig;
    }

    public AppConfig getConfigByKey(String key) {
        AppConfig app = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT * FROM CONFIG_DB WHERE CONFIG_KEY = ? ";
            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, key);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                app = new AppConfig();
                app.setID(rs.getInt("ID"));
                app.setConfig_key(rs.getString("CONFIG_KEY"));
                app.setConfig_value(rs.getString("CONFIG_VALUE"));
                app.setCf_desc(rs.getString("CF_DESC"));
                app.setCreate_by(rs.getString("CREATE_BY"));
                app.setCreate_date(rs.getString("CREATE_DATE"));
                app.setUpdate_by(rs.getString("UPDATE_BY"));
                app.setUpdate_date(rs.getString("UPDATE_DATE"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstmt, conn);
        }

        return app;
    }

    public static String getConfigValueCache(String key) {
        if (CACHE.get(key) != null) {
            return CACHE.get(key);
        } else {
            return "";
        }
    }

    public static int getConfigValueInt(String key,int defaultVal) {
        if (CACHE.get(key) != null) {
            return Tool.string2Integer(CACHE.get(key));
        } else {
            return defaultVal;
        }
    }

    public boolean sendAlertMail_Money(String subject, String content) {
        String mailList = getConfigValueCache("ALERT_LIST_MAIL_MONEY");
        int isSendMailOn = getConfigValueInt("CAN_SEND_MAIL",0);
        if (isSendMailOn >= 1) {
            return SendMail.sendMail(subject, content, mailList);
        } else {
            System.out.println("---- Khong gui Email canh bao vi CAN_SEND_MAIL khong duoc dat gia tri >= 1 ! ---- ");
            return false;
        }
    }
    public boolean sendAlertMail_Error(String subject, String content) {
        String mailList = getConfigValueCache("ALERT_LIST_MAIL_ERROR");
        int isSendMailOn = getConfigValueInt("CAN_SEND_MAIL",0);
        if (isSendMailOn >= 1) {
            return SendMail.sendMail(subject, content, mailList);
        } else {
            System.out.println("---- Khong gui Email canh bao vi CAN_SEND_MAIL khong duoc dat gia tri >= 1 ! ---- ");
            return false;
        }
    }

    public void setID(int ID) {
        this.id = ID;
    }

    public void setConfig_key(String config_key) {
        this.config_key = config_key;
    }

    public void setConfig_value(String config_value) {
        this.config_value = config_value;
    }

    public void setCreate_by(String create_by) {
        this.create_by = create_by;
    }

    public void setUpdate_by(String update_by) {
        this.update_by = update_by;
    }

    public void setCf_desc(String cf_desc) {
        this.cf_desc = cf_desc;
    }

    public int getID() {
        return id;
    }

    public void setCreate_date(String create_date) {
        this.create_date = create_date;
    }

    public void setUpdate_date(String update_date) {
        this.update_date = update_date;
    }

    public String getCreate_date() {
        return create_date;
    }

    public String getUpdate_date() {
        return update_date;
    }

    public String getConfig_key() {
        return config_key;
    }

    public String getConfig_value() {
        return config_value;
    }

    public String getCreate_by() {
        return create_by;
    }

    public String getUpdate_by() {
        return update_by;
    }

    public String getCf_desc() {
        return cf_desc;
    }

}
