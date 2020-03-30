/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.db.DBPool;
import static gk.myname.vn.entity.BrandLabel.logger;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Private
 */
public class PhoneBlackList {

    public ArrayList<PhoneBlackList> findAll(int page, int max, String phone, String oper) {
        ArrayList<PhoneBlackList> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM PHONEBLACKLIST WHERE 1=1";
        try {
            if (!Tool.checkNull(phone)) {
                sql += " AND NUMBER like ?";
            }
            if (!Tool.checkNull(oper)) {
                sql += " AND TELCO like ?";
            }
            
            sql += " LIMIT ?,?";
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            if (!Tool.checkNull(phone)) {
                pstm.setString(i++, phone);
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                PhoneBlackList one = new PhoneBlackList();
                one.setId(rs.getInt("ID"));
                one.setNumber(rs.getString("NUMBER"));
                one.setTelco(rs.getString("TELCO"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public int countAll(String phone, String oper) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM PHONEBLACKLIST WHERE 1=1";
        try {
            if (!Tool.checkNull(phone)) {
                sql += " AND NUMBER like ?";
            }
            if (!Tool.checkNull(oper)) {
                sql += " AND TELCO like ?";
            }
            
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            if (!Tool.checkNull(phone)) {
                pstm.setString(i++, phone);
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
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

    public boolean addNew(PhoneBlackList one) {
        boolean result = Boolean.FALSE;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO PHONEBLACKLIST(NUMBER,TELCO) Values(?,?)";
        try {
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(i++, one.getNumber());
            pstm.setString(i++, one.getTelco());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean update(PhoneBlackList one) {
        boolean result = Boolean.FALSE;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE PHONEBLACKLIST SET NUMBER =?,TELCO =? WHERE ID = ?";
        try {
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(i++, one.getNumber());
            pstm.setString(i++, one.getTelco());
            pstm.setInt(i++, one.getId());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean delete(int id) {
        boolean result = Boolean.FALSE;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "DELETE FROM PHONEBLACKLIST WHERE ID = ?";
        try {
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(i++, id);
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
    private int id;
    private String number;
    private String telco;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getTelco() {
        return telco;
    }

    public void setTelco(String telco) {
        this.telco = telco;
    }

    
}
