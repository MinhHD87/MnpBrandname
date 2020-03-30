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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author tuanp
 */
public class EmailConfigManager {

    private static final Map<String, EmailConfigManager> CACHE = new HashMap<>();

    static {
        ArrayList<EmailConfigManager> list = getAll();
        for (EmailConfigManager one : list) {
            CACHE.put(one.getEmail(), one);
        }
    }

    private static void reload() {
        synchronized (CACHE) {
            CACHE.clear();
            ArrayList<EmailConfigManager> list = getAll();
            for (EmailConfigManager one : list) {
                CACHE.put(one.getEmail(), one);
            }
            CACHE.notifyAll();
        }

    }

    public static ArrayList<EmailConfigManager> getAll(int page, String email, String fromname, String securentype, int status) {
        ArrayList arr = new ArrayList();
        String sql = null;
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rs = null;

        try {
            sql = "SELECT * FROM EMAIL_MANAGER ";
            sql += " WHERE 1 = 1";
            if (!Tool.checkNull(email)) {
                sql += " AND EMAIL = ?";
            }
            if (!Tool.checkNull(fromname)) {
                sql += " AND FROM_NAME = ?";
            }
            if (!Tool.checkNull(securentype)) {
                sql += " AND SECURE_TYPE = ?";
            }
            if (status != -1) {
                sql += " AND STATUS = ?";
            }

            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(email)) {
                pstmt.setString(i++, email);
            }
            if (!Tool.checkNull(fromname)) {
                pstmt.setString(i++, fromname);
            }
            if (!Tool.checkNull(securentype)) {
                pstmt.setString(i++, securentype);
            }
            if (status != -1) {
                pstmt.setInt(i++, status);
            }

            rs = pstmt.executeQuery();
            while (rs.next()) {
                EmailConfigManager one = new EmailConfigManager();
                one.setId(rs.getInt("ID"));
                one.setMaildesc(rs.getString("MAIL_DESC"));
                one.setFromname(rs.getString("FROM_NAME"));
                one.setEmail(rs.getString("EMAIL"));
                one.setPassmail(rs.getString("PASS_MAIL"));
                one.setHostemail(rs.getString("HOST_MAIL"));
                one.setPortmail(rs.getString("PORT_MAIL"));
                one.setSecurentype(rs.getString("SECURE_TYPE"));
                one.setStatus(rs.getInt("STATUS"));
                arr.add(one);
            }
        } catch (SQLException e) {
            System.out.println("Error EmailConfigManager.getAll() : ");
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstmt, conn);
        }

        return arr;
    }

    public static ArrayList<EmailConfigManager> getAll() {
        ArrayList arr = new ArrayList();
        String sql = null;
        PreparedStatement pstmt = null;
        Connection conn = null;
        ResultSet rs = null;

        try {
            sql = "SELECT * FROM EMAIL_MANAGER";
            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                EmailConfigManager one = new EmailConfigManager();
                one.setId(rs.getInt("ID"));
                one.setMaildesc(rs.getString("MAIL_DESC"));
                one.setFromname(rs.getString("FROM_NAME"));
                one.setEmail(rs.getString("EMAIL"));
                one.setPassmail(rs.getString("PASS_MAIL"));
                one.setHostemail(rs.getString("HOST_MAIL"));
                one.setPortmail(rs.getString("PORT_MAIL"));
                one.setSecurentype(rs.getString("SECURE_TYPE"));
                one.setStatus(rs.getInt("STATUS"));
                arr.add(one);
            }
        } catch (SQLException e) {
            System.out.println("Error EmailConfigManager.getAll() : ");
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstmt, conn);
        }

        return arr;
    }

    public boolean insertConfig(EmailConfigManager conf) {
        String sql = "INSERT INTO EMAIL_MANAGER(MAIL_DESC,FROM_NAME,EMAIL,PASS_MAIL,HOST_MAIL,PORT_MAIL,SECURE_TYPE,STATUS   )"
                + "                            VALUES ( ?       ,  ?       ,  ?   ,  ?    ,   ?     ,     ?    ,   ?      ,   ?   )";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            int i = 1;
            pstmt.setString(i++, conf.getMaildesc());
            pstmt.setString(i++, conf.getFromname());
            pstmt.setString(i++, conf.getEmail());
            pstmt.setString(i++, conf.getPassmail());
            pstmt.setString(i++, conf.getHostemail());
            pstmt.setString(i++, conf.getPortmail());
            pstmt.setString(i++, conf.getSecurentype());
            pstmt.setInt(i++, conf.getStatus());
            int tmp = pstmt.executeUpdate();
            if (tmp == 1) {
                reload();
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(pstmt, conn);
        }

        return false;
    }

    public boolean updateConfig(EmailConfigManager conf) {

        String sql = "UPDATE EMAIL_MANAGER SET MAIL_DESC=?,FROM_NAME=?,EMAIL=?,PASS_MAIL=?,HOST_MAIL=?,PORT_MAIL=?,SECURE_TYPE=?,STATUS=? WHERE ID=? ";

        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            int i = 1;
            pstmt.setString(i++, conf.getMaildesc());
            pstmt.setString(i++, conf.getFromname());
            pstmt.setString(i++, conf.getEmail());
            pstmt.setString(i++, conf.getPassmail());
            pstmt.setString(i++, conf.getHostemail());
            pstmt.setString(i++, conf.getPortmail());
            pstmt.setString(i++, conf.getSecurentype());
            pstmt.setInt(i++, conf.getStatus());
            pstmt.setInt(i++, conf.getId());
            int tmp = pstmt.executeUpdate();

            if (tmp == 1) {
                reload();
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
        String sql = "DELETE FROM EMAIL_MANAGER WHERE ID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            EmailConfigManager conf = getConfigById(id);
            pstmt.setInt(1, conf.getId());
            int tm = pstmt.executeUpdate();
            if (tm == 1) {
                CACHE.remove(conf.getEmail());
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(pstmt, conn);
        }
        return false;
    }

    public EmailConfigManager getConfigById(int id) {
        String sql = "SELECT *  FROM EMAIL_MANAGER WHERE ID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        EmailConfigManager emConfig = new EmailConfigManager();
        try {
            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                emConfig.setId(rs.getInt("ID"));
                emConfig.setMaildesc(rs.getString("MAIL_DESC"));
                emConfig.setFromname(rs.getString("FROM_NAME"));
                emConfig.setEmail(rs.getString("EMAIL"));
                emConfig.setPassmail(rs.getString("PASS_MAIL"));
                emConfig.setHostemail(rs.getString("HOST_MAIL"));
                emConfig.setPortmail(rs.getString("PORT_MAIL"));
                emConfig.setSecurentype(rs.getString("SECURE_TYPE"));
                emConfig.setStatus(rs.getInt("STATUS"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstmt, conn);
        }
        return emConfig;
    }

    //em Minh thêm
    public ArrayList<EmailConfigManager> listID() {
        ArrayList<EmailConfigManager> list = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "select ID,EMAIL from email_manager";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                EmailConfigManager emailconfig = new EmailConfigManager();
                emailconfig.setId(rs.getInt("ID"));
                emailconfig.setEmail(rs.getString("EMAIL"));
                list.add(emailconfig);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return list;
    }

    int id;
    String email;
    String maildesc;
    String passmail;
    String hostemail;
    String portmail;
    String fromname;
    int status;
    String securentype;

    public String getHostemail() {
        return hostemail;
    }

    public void setHostemail(String hostemail) {
        this.hostemail = hostemail;
    }

    public String getSecurentype() {
        return securentype;
    }

    public void setSecurentype(String securentype) {
        this.securentype = securentype;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMaildesc() {
        return maildesc;
    }

    public void setMaildesc(String maildesc) {
        this.maildesc = maildesc;
    }

    public String getPassmail() {
        return passmail;
    }

    public void setPassmail(String passmail) {
        this.passmail = passmail;
    }

    public String getPortmail() {
        return portmail;
    }

    public void setPortmail(String portmail) {
        this.portmail = portmail;
    }

    public String getFromname() {
        return fromname;
    }

    public void setFromname(String fromname) {
        this.fromname = fromname;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
