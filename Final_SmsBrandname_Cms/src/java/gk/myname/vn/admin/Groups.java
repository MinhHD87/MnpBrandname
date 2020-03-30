package gk.myname.vn.admin;
// Generated Jul 16, 2011 10:32:42 PM by Hibernate Tools 3.2.1.GA

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import org.apache.log4j.Logger;

/**
 * Groups generated by hbm2java
 */
public class Groups implements java.io.Serializable {

    public Logger logger = Logger.getLogger(Groups.class);
    public static final HashMap<Integer, Groups> CACHE_ALL = new HashMap<>();

    static {
        Groups gDao = new Groups();
        ArrayList<Groups> all = gDao.listAllGroups();
        for (Groups one : all) {
            CACHE_ALL.put(one.getGroupID(), one);
        }
    }

    public static Groups getByID(int id) {
        Groups one = CACHE_ALL.get(id);
        return one;
    }

    public static void reload(Groups g) {
        if (g != null) {
            CACHE_ALL.put(g.getGroupID(), g);
        }
    }

    public static void reloadAll() {
        Groups gDao = new Groups();
        ArrayList<Groups> all = gDao.listAllGroups();
        for (Groups one : all) {
            CACHE_ALL.put(one.getGroupID(), one);
        }
    }

    public boolean create(Groups g) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO GROUP_ACCOUNT(NAME,DESCRIPTION,CREATE_DATE,CREATE_BY,STATUS) "
                + "                      values(?   ,    ?      ,  NOW()    ,    ?    ,  ?   )";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, g.getName());
            pstm.setString(i++, g.getDescription());
            pstm.setInt(i++, g.getCreateBy());
            pstm.setBoolean(i++, g.getStatus());
            if (pstm.executeUpdate() == 1) {
                ok = true;
                DBPool.releadRsPstm(null, pstm);
                sql = "SELECT @@IDENTITY AS 'Identity';";
                pstm = conn.prepareStatement(sql);
                rs = pstm.executeQuery();
                if (rs.next()) {
                    int currentID = rs.getInt(1);
                    g = getGroupByID(currentID);
                    if (g != null) {
                        reload(g);
                    }
                }

            }
        } catch (Exception ex) {
            ex.printStackTrace();
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(null, pstm, conn);
        }
        return ok;
    }

    public ArrayList listAllGroups() {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String querySQl = "select * from group_account";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(querySQl);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Groups group = new Groups();
                group.setGroupID(rs.getInt("GROUP_ID"));
                group.setName(rs.getString("NAME"));
                group.setDescription(rs.getString("DESCRIPTION"));
                group.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                group.setCreateBy(rs.getInt("CREATE_BY"));
                group.setStatus(rs.getBoolean("STATUS"));
                group.setAllAccId();
                all.add(group);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }
//

    public ArrayList<Groups> listGroupByID(long[] groupID) {
        ArrayList all = new ArrayList();
        Groups group = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "select * FROM group_account where 1 != 1 ";
        for (int i = 0; i < groupID.length; i++) {
            sql += " or GROUP_ID = ? ";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            for (int i = 0; i < groupID.length; i++) {
                pstm.setLong(i + 1, groupID[i]);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                group = new Groups();
                group.setGroupID(rs.getInt("GROUP_ID"));
                group.setName(rs.getString("NAME"));
                group.setDescription(rs.getString("DESCRIPTION"));
                group.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                group.setCreateBy(rs.getInt("CREATE_BY"));
                group.setStatus(rs.getBoolean("STATUS"));
                group.setAllAccId();
                all.add(group);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public Groups getGroupByID(int id) {
        Groups group = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String querySQl = "select * from group_account where GROUP_ID=?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(querySQl);
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                group = new Groups();
                group.setGroupID(rs.getInt("GROUP_ID"));
                group.setName(rs.getString("NAME"));
                group.setDescription(rs.getString("DESCRIPTION"));
                group.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                group.setCreateBy(rs.getInt("CREATE_BY"));
                group.setStatus(rs.getBoolean("STATUS"));
                group.setAllAccId();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return group;
    }

    public boolean del(int id) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "delete from group_account where GROUP_ID=?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            if (pstm.executeUpdate() == 1) {
                ok = true;
                CACHE_ALL.remove(id);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(null, pstm, conn);
        }
        return ok;
    }

    public boolean updateGroup(Groups group) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pst = null;
        String sql = "UPDATE group_account  set NAME =?,"
                + " DESCRIPTION = ? ,"
                + " UPDATE_DATE = NOW(),"
                + " UPDATE_BY = ?,STATUS = ? WHERE GROUP_ID = ?";
        try {
            conn = DBPool.getConnection();
            pst = conn.prepareStatement(sql);
            int i = 1;
            pst.setString(i++, group.getName());
            pst.setString(i++, group.getDescription());
            pst.setInt(i++, group.getUpdateBy());
            pst.setBoolean(i++, group.getStatus());
            pst.setInt(i++, group.getGroupID());
            if (pst.executeUpdate() == 1) {
                ok = true;
                reload(group);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(null, pst, conn);
        }
        return ok;
    }
    //*************
    private int groupID;
    private String name;
    private String description;
    private Timestamp createDate;
    private int createBy;
    private Timestamp updateDate;
    private int updateBy;
    private boolean status;
    private ArrayList allAccId;

    public Groups() {
    }

    public ArrayList getAllAccId() {
        return allAccId;
    }

    public void setAllAccId(ArrayList allAccId) {
        this.allAccId = allAccId;
    }

    public void setAllAccId() {
        this.allAccId = GroupAccDetail.getAllAccID(groupID);
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public int getCreateBy() {
        return createBy;
    }

    public void setCreateBy(int createBy) {
        this.createBy = createBy;
    }

    public Timestamp getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Timestamp updateDate) {
        this.updateDate = updateDate;
    }

    public int getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(int updateBy) {
        this.updateBy = updateBy;
    }

    public int getGroupID() {
        return groupID;
    }

    public void setGroupID(int groupID) {
        this.groupID = groupID;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean getStatus() {
        return this.status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
