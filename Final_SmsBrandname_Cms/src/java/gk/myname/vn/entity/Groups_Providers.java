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
import org.apache.log4j.Logger;

/**
 *
 * @author HTC-PC
 */
public class Groups_Providers {
    static final Logger logger = Logger.getLogger(Groups_Providers.class);
    
    private int group_id;
    private int provider_id;
    private int number;
    private Provider provider;

    public Groups_Providers() {
    }

    public Groups_Providers(int group_id, int provider_id, int number) {
        this.group_id = group_id;
        this.provider_id = provider_id;
        this.number = number;
    }

    public Provider getProvider() {
        return provider;
    }

    public void setProvider(Provider provider) {
        this.provider = provider;
    }

    public int getGroup_id() {
        return group_id;
    }

    public void setGroup_id(int group_id) {
        this.group_id = group_id;
    }

    public int getProvider_id() {
        return provider_id;
    }

    public void setProvider_id(int provider_id) {
        this.provider_id = provider_id;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }
    
    public boolean add(Groups_Providers groups_Providers) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            String sql = " INSERT INTO groups_providers( GROUP_ID, PROVIDER_ID, NUMBER ) "
                       + " VALUES(                              ?,           ?,      ? ) ";
            
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            
            pstm.setInt(i++, groups_Providers.getGroup_id());
            pstm.setInt(i++, groups_Providers.getProvider_id());
            pstm.setInt(i++, groups_Providers.getNumber());
            
            result = pstm.executeUpdate() == 1;
        } catch (SQLException e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(pstm, conn);
        }
        return result;
    }
    
    public int count(int groupId, int providerId) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select count(*) from groups_providers where 1=1 and GROUP_ID = ? and PROVIDER_ID = ? ";
            
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            
            pstm.setInt(i++, groupId);
            pstm.setInt(i++, providerId);
                
            rs = pstm.executeQuery();
            while (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (SQLException e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
    
    public boolean delete(int groupId, int providerId) {
        String sql = "DELETE FROM groups_providers WHERE GROUP_ID = ? AND PROVIDER_ID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, groupId);
            pstmt.setInt(2, providerId);
            int tm = pstmt.executeUpdate();
            if (tm == 1) {
                return true;
            }
        } catch (SQLException e) {
        } finally {
            DBPool.freeConn(pstmt, conn);
        }
        return false;
    }
    
    public ArrayList<Groups_Providers> findAllByGroupId(int groupId) {
        ArrayList<Groups_Providers> list = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select * from groups_providers where 1 = 1";
            sql += " AND GROUP_ID = ? ";
            
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            
            pstm.setInt(i++, groupId);
            
            rs = pstm.executeQuery();
            while (rs.next()) {
                Groups_Providers groups_Providers = new Groups_Providers();
                groups_Providers.setGroup_id(rs.getInt("GROUP_ID"));
                groups_Providers.setProvider_id(rs.getInt("PROVIDER_ID"));
                groups_Providers.setNumber(rs.getInt("NUMBER"));
                list.add(groups_Providers);
            }
        } catch (SQLException e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        
        list.forEach((Groups_Providers _item) -> {
            Provider pro = Provider.getbyId(_item.getProvider_id());
            _item.setProvider(pro);
        });
        return list;
    }
}
