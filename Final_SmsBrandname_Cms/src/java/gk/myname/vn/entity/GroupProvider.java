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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import org.apache.log4j.Logger;

/**
 *
 * @author HTC-PC
 */
public class GroupProvider {
    static final Logger logger = Logger.getLogger(GroupProvider.class);
    
    private int id;
    private String name;
    private String description;
    private int status;
    private int createdBy;
    private String createdDate;
    private int updatedBy;
    private String updatedDate;
    private ArrayList<Groups_Providers> groups_Providerses;

    public GroupProvider() {
    }

    public GroupProvider(String name, String description, int status, int createdBy, String createdDate, int updatedBy, String updatedDate) {
        this.name = name;
        this.description = description;
        this.status = status;
        this.createdBy = createdBy;
        this.createdDate = createdDate;
        this.updatedBy = updatedBy;
        this.updatedDate = updatedDate;
    }

    public GroupProvider(int id, String name, String description, int status, int createdBy, String createdDate, int updatedBy, String updatedDate) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.status = status;
        this.createdBy = createdBy;
        this.createdDate = createdDate;
        this.updatedBy = updatedBy;
        this.updatedDate = updatedDate;
    }

    public ArrayList<Groups_Providers> getGroups_Providerses() {
        if (groups_Providerses == null) {
            groups_Providerses = new ArrayList<>();
        }
        return groups_Providerses;
    }

    public void setGroups_Providerses(ArrayList<Groups_Providers> groups_Providerses) {
        this.groups_Providerses = groups_Providerses;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public int getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(int updatedBy) {
        this.updatedBy = updatedBy;
    }

    public String getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(String updatedDate) {
        this.updatedDate = updatedDate;
    }

    @Override
    public String toString() {
        return "GroupProvider{" + "id=" + id + ", name=" + name + ", description=" + description + ", status=" + status + ", createdBy=" + createdBy + ", createdDate=" + createdDate + ", updatedBy=" + updatedBy + ", updatedDate=" + updatedDate + '}';
    }
    
    public ArrayList<GroupProvider> findAll(int max, int page, String name, int status) {
        ArrayList<GroupProvider> list = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select * from group_provider where 1 = 1";
            if (!Tool.checkNull(name)) {
                sql += " AND NAME LIKE ?";
            }
            sql += " AND STATUS = ? ";                
            sql += " ORDER BY ID DESC LIMIT ?,?";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, "%" + name + "%");
            }
            pstm.setInt(i++, status);
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                GroupProvider groupProvider = new GroupProvider();
                groupProvider.setId(rs.getInt("ID"));
                groupProvider.setName(rs.getString("NAME"));
                groupProvider.setDescription(rs.getString("DESCRIPTION"));
                groupProvider.setStatus(rs.getInt("STATUS"));
                groupProvider.setCreatedBy(rs.getInt("CREATEDBY"));
                groupProvider.setCreatedDate(rs.getDate("CREATEDDATE")+"");
                groupProvider.setUpdatedBy(rs.getInt("UPDATEDBY"));
                groupProvider.setUpdatedDate(rs.getDate("UPDATEDDATE")+"");
                list.add(groupProvider);
            }
        } catch (SQLException e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return list;
    }
    
    public int count(String name, int status) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select count(*) from group_provider where 1=1 ";
            if (!Tool.checkNull(name)) {
                sql += " AND NAME LIKE ?";
            }
                sql += " AND STATUS = ? ";

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, "%" + name + "%");
            }
                pstm.setInt(i++, status);
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
    
    public boolean add(GroupProvider groupProvider) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        
        try {
            String sql = " INSERT INTO group_provider( NAME, DESCRIPTION, STATUS, CREATEDBY, CREATEDDATE ) "
                       + " VALUES(                        ?,           ?,      ?,         ?,       NOW() ) ";
            
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            
            pstm.setString(i++, groupProvider.getName());
            pstm.setString(i++, groupProvider.getDescription());
            pstm.setInt(i++, groupProvider.getStatus());
            pstm.setInt(i++, groupProvider.getCreatedBy());
            
            result = pstm.executeUpdate() == 1;
            
        } catch (SQLException e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(pstm, conn);
        }
        return result;
    }
    
    public boolean edit(GroupProvider groupProvider) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            String sql = " UPDATE group_provider SET NAME = ? , DESCRIPTION = ? , STATUS = ? , UPDATEDBY = ? , UPDATEDDATE = NOW() "
                       + " WHERE ID = ? ";
            
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            
            pstm.setString(i++, groupProvider.getName());
            pstm.setString(i++, groupProvider.getDescription());
            pstm.setInt(i++, groupProvider.getStatus());
            pstm.setInt(i++, groupProvider.getUpdatedBy());
            
            pstm.setInt(i++, groupProvider.getId());
            
            result = pstm.executeUpdate() == 1;
        } catch (SQLException e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(pstm, conn);
        }
        return result;
    }
    
    public GroupProvider findById(int id) {
        GroupProvider groupProvider = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select * from group_provider where 1 = 1 AND ID = ?";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            
            pstm.setInt(i++, id);
            
            rs = pstm.executeQuery();
            while (rs.next()) {
                
                groupProvider = new GroupProvider();
                groupProvider.setId(rs.getInt("ID"));
                groupProvider.setName(rs.getString("NAME"));
                groupProvider.setDescription(rs.getString("DESCRIPTION"));
                groupProvider.setStatus(rs.getInt("STATUS"));
                groupProvider.setCreatedBy(rs.getInt("CREATEDBY"));
                groupProvider.setCreatedDate(rs.getDate("CREATEDDATE")+"");
                groupProvider.setUpdatedBy(rs.getInt("UPDATEDBY"));
                groupProvider.setUpdatedDate(rs.getDate("UPDATEDDATE")+"");
                
            }
        } catch (SQLException e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        Groups_Providers gp = new Groups_Providers();
        
        ArrayList<Groups_Providers> grp = gp.findAllByGroupId(id);
        if (grp.size() > 0) {
            groupProvider.setGroups_Providerses(gp.findAllByGroupId(id));
        }
        return groupProvider;
    }
    
    public GroupProvider findByName(String name) {
        GroupProvider groupProvider = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select * from group_provider where 1 = 1 AND NAME = ?";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            
            pstm.setString(i++, name);
            
            rs = pstm.executeQuery();
            while (rs.next()) {
                
                groupProvider = new GroupProvider();
                groupProvider.setId(rs.getInt("ID"));
                groupProvider.setName(rs.getString("NAME"));
                groupProvider.setDescription(rs.getString("DESCRIPTION"));
                groupProvider.setStatus(rs.getInt("STATUS"));
                groupProvider.setCreatedBy(rs.getInt("CREATEDBY"));
                groupProvider.setCreatedDate(rs.getDate("CREATEDDATE")+"");
                groupProvider.setUpdatedBy(rs.getInt("UPDATEDBY"));
                groupProvider.setUpdatedDate(rs.getDate("UPDATEDDATE")+"");
                
            }
        } catch (SQLException e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return groupProvider;
    }
}
