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
public class KeysBlackList {

    public ArrayList<KeysBlackList> findAll(int page, int max, String oper, String keyVn, String keyEn, String brandname) {
        ArrayList<KeysBlackList> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM KEYS_BLACKLIST WHERE 1=1";
        try {
            if (!Tool.checkNull(oper)) {
                sql += " AND TELCO like ?";
            }
            if (!Tool.checkNull(keyVn)) {
                sql += " AND KEY_VN like ?";
            }
            if (!Tool.checkNull(keyEn)) {
                sql += " AND KEY_EN like ?";
            }
            if (!Tool.checkNull(brandname)) {
                sql += " AND BRANDNAME= ?";
            }
            sql += " LIMIT ?,?";
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            if (!Tool.checkNull(keyVn)) {
                pstm.setString(i++, keyVn);
            }
            if (!Tool.checkNull(keyEn)) {
                pstm.setString(i++, keyEn);
            }
            if (!Tool.checkNull(brandname)) {
                pstm.setString(i++, brandname);
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                KeysBlackList one = new KeysBlackList();
                one.setId(rs.getInt("ID"));
                one.setTelco(rs.getString("TELCO"));
                one.setKey_vn(rs.getString("KEY_VN"));
                one.setKey_en(rs.getString("KEY_EN"));
                one.setBrandname(rs.getString("BRANDNAME"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public int countAll(String oper, String keyVn, String keyEn, String brandname) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM KEYS_BLACKLIST WHERE 1=1";
        try {
            if (!Tool.checkNull(oper)) {
                sql += " AND TELCO like ?";
            }
            if (!Tool.checkNull(keyVn)) {
                sql += " AND KEY_VN like ?";
            }
            if (!Tool.checkNull(keyEn)) {
                sql += " AND KEY_EN like ?";
            }
            if (!Tool.checkNull(brandname)) {
                sql += " AND BRANDNAME= ?";
            }
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            if (!Tool.checkNull(keyVn)) {
                pstm.setString(i++, keyVn);
            }
            if (!Tool.checkNull(keyEn)) {
                pstm.setString(i++, keyEn);
            }
            if (!Tool.checkNull(brandname)) {
                pstm.setString(i++, brandname);
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
    
    
    public ArrayList<String> getAllBrandDistand() {
        ArrayList<String> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT DISTINCT BRAND_LABEL FROM BRAND_LABEL WHERE 1=1 ";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            
            rs = pstm.executeQuery();
            while (rs.next()) {
                String curBrandname = rs.getString("BRAND_LABEL");
                all.add(curBrandname);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public boolean addNew(KeysBlackList one) {
        boolean result = Boolean.FALSE;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO KEYS_BLACKLIST(TELCO,KEY_VN,KEY_EN,BRANDNAME) Values(?,?,?,?)";
        try {
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(i++, one.getTelco());
            pstm.setString(i++, one.getKey_vn());
            pstm.setString(i++, one.getKey_en());
            pstm.setString(i++, one.getBrandname());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean update(KeysBlackList one) {
        boolean result = Boolean.FALSE;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE KEYS_BLACKLIST SET TELCO =?,KEY_VN =?,KEY_EN =?,BRANDNAME=? WHERE ID = ?";
        try {
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(i++, one.getTelco());
            pstm.setString(i++, one.getKey_vn());
            pstm.setString(i++, one.getKey_en());
            pstm.setString(i++, one.getBrandname());
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
        String sql = "DELETE FROM KEYS_BLACKLIST WHERE ID = ?";
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
    private String telco;
    private String key_en;
    private String key_vn;
    private String brandname;
    private int status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTelco() {
        return telco;
    }

    public void setTelco(String telco) {
        this.telco = telco;
    }

    public String getKey_en() {
        return key_en;
    }

    public void setKey_en(String key_en) {
        this.key_en = key_en;
    }

    public String getKey_vn() {
        return key_vn;
    }

    public void setKey_vn(String key_vn) {
        this.key_vn = key_vn;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getBrandname() {
        return brandname;
    }

    public void setBrandname(String brandname) {
        this.brandname = brandname;
    }
    
    

}
