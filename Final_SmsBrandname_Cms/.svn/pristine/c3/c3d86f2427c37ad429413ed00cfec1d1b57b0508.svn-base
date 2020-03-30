/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.admin;

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
 * @author TUANPLA
 */
public class Modules {

    static final Logger logger = Logger.getLogger(Modules.class);
    public static ArrayList<Modules> ALL_MODULE;

    static {
        Modules mdao = new Modules();
        ALL_MODULE = mdao.listAllModule();
    }

    private static void reload() {
        Modules mdao = new Modules();
        ALL_MODULE = mdao.listAllModule();
    }

    public static int getModuleID(String uri) {
        int mid = 0;
        for (Modules one : ALL_MODULE) {
            if (uri.startsWith(one.getResource())) {
                mid = one.getModulID();
                break;
            }
        }
        return mid;
    }
    //***************

    public ArrayList listAllModule() {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String querySQl = "select * from modules WHERE STATUS !=404 ORDER BY LENGTH(RESOURCE) DESC";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(querySQl);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Modules module = new Modules();
                module.setModulID(rs.getInt("MODULE_ID"));
                module.setResource(rs.getString("RESOURCE"));
                module.setName(rs.getString("NAME"));
                module.setDesc(rs.getString("DESCRIPTION"));
                module.setStatus(rs.getInt("STATUS"));
                all.add(module);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public boolean create(Modules g) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "INSERT INTO MODULES(RESOURCE,NAME,DESCRIPTION,STATUS) "
                + "                values( ?    ,?   ,     ?     ,  ?   )";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, g.getResource());
            pstm.setString(i++, g.getName());
            pstm.setString(i++, g.getDesc());
            pstm.setInt(i++, g.getStatus());
            if (pstm.executeUpdate() == 1) {
                reload();
                ok = true;
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(null, pstm, conn);
        }
        return ok;
    }

    public Modules getModuleByID(int id) {
        Modules module = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String querySQl = "select * from MODULES where MODULE_ID=?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(querySQl);
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            while (rs.next()) {
                module = new Modules();
                module.setModulID(rs.getInt("MODULE_ID"));
                module.setResource(rs.getString("RESOURCE"));
                module.setName(rs.getString("NAME"));
                module.setDesc(rs.getString("DESCRIPTION"));
                module.setStatus(rs.getInt("STATUS"));
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return module;
    }

    public boolean del(int id) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "DELETE from MODULES where MODULE_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            if (pstm.executeUpdate() == 1) {
                reload();
                ok = true;
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(null, pstm, conn);
        }
        return ok;
    }

    public boolean updateModule(Modules module) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "update MODULES  set RESOURCE = ?, NAME =?,"
                + " DESCRIPTION = ? ,"
                + " STATUS = ? WHERE MODULE_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, module.getResource());
            pstm.setString(i++, module.getName());
            pstm.setString(i++, module.getDesc());
            pstm.setInt(i++, module.getStatus());
            pstm.setInt(i++, module.getModulID());
            if (pstm.executeUpdate() == 1) {
                reload();
                ok = true;
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(null, pstm, conn);
        }
        return ok;
    }

    //********
    public int getModulID() {
        return modulID;
    }

    public void setModulID(int modulID) {
        this.modulID = modulID;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getResource() {
        return resource;
    }

    public void setResource(String resource) {
        this.resource = resource;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    private int modulID;
    private String resource;
    private String name;
    private String desc;
    private int status;
}
