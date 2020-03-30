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
public class TempContent {

    public ArrayList<TempContent> findAll(int page, int max, String oper, String temp, String brandname, int active) {
        ArrayList<TempContent> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM TEMP_ACCEPT WHERE 1=1";
        try {
            if (!Tool.checkNull(oper)) {
                sql += " AND OPER like ?";
            }
            if (!Tool.checkNull(temp)) {
                sql += " AND TEMP like ?";
            }
            
            if (!Tool.checkNull(brandname)) {
                sql += " AND BRANDNAME= ?";
            }
            
            if (!Tool.checkNull(active)) {
                sql += " AND ACTIVE= ?";
            }
            sql += " LIMIT ?,?";
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            if (!Tool.checkNull(temp)) {
                pstm.setString(i++, temp);
            }
            
            if (!Tool.checkNull(brandname)) {
                pstm.setString(i++, brandname);
            }
            
            if (!Tool.checkNull(active)) {
                pstm.setInt(i++, active);
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                TempContent one = new TempContent();
                one.setId(rs.getInt("ID"));
                one.setOper(rs.getString("OPER"));
                one.setTemp(rs.getString("TEMP"));
                one.setBrandname(rs.getString("BRANDNAME"));
                one.setActive(rs.getInt("ACTIVE"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public int countAll(String oper, String temp, String brandname, int active) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM TEMP_ACCEPT WHERE 1=1";
        try {
            if (!Tool.checkNull(oper)) {
                sql += " AND OPER like ?";
            }
            if (!Tool.checkNull(temp)) {
                sql += " AND TEMP like ?";
            }
            
            if (!Tool.checkNull(brandname)) {
                sql += " AND BRANDNAME= ?";
            }
            
            if (!Tool.checkNull(active)) {
                sql += " AND ACTIVE= ?";
            }
            
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            if (!Tool.checkNull(temp)) {
                pstm.setString(i++, temp);
            }
            
            if (!Tool.checkNull(brandname)) {
                pstm.setString(i++, brandname);
            }
            
            if (!Tool.checkNull(active)) {
                pstm.setInt(i++, active);
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

    public boolean addNew(TempContent one) {
        boolean result = Boolean.FALSE;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO TEMP_ACCEPT(OPER,TEMP,BRANDNAME,ACTIVE) Values(?,?,?,?)";
        try {
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(i++, one.getOper());
            pstm.setString(i++, one.getTemp());
            pstm.setString(i++, one.getBrandname());
            pstm.setInt(i++, one.getActive());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean update(TempContent one) {
        boolean result = Boolean.FALSE;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE TEMP_ACCEPT SET OPER=?,TEMP=?,BRANDNAME=?,ACTIVE=? WHERE ID = ?";
        try {
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(i++, one.getOper());
            pstm.setString(i++, one.getTemp());
            pstm.setString(i++, one.getBrandname());
            pstm.setInt(i++, one.getActive());
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
        String sql = "DELETE FROM TEMP_ACCEPT WHERE ID = ?";
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
    private String oper;
    private String temp;
    private String brandname;
    private int active;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOper() {
        return oper;
    }

    public void setOper(String oper) {
        this.oper = oper;
    }

    public String getTemp() {
        return temp;
    }

    public void setTemp(String temp) {
        this.temp = temp;
    }

    public String getBrandname() {
        return brandname;
    }

    public void setBrandname(String brandname) {
        this.brandname = brandname;
    }

    public int getActive() {
        return active;
    }

    public void setActive(int active) {
        this.active = active;
    }

    

    
}
