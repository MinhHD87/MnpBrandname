/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.admin;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.Tool;
import java.sql.CallableStatement;
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
public class Permission {

    static Logger logger = Logger.getLogger(Permission.class);

    public ArrayList getRoleGroupModule(int gId) {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT M.MODULE_ID,M.RESOURCE,M.NAME,G.ID,G.GROUP_ID,G.ALL_RIGHT,G.VIEW_RIGHT,G.VIEW_SHORT,G.ADD_RIGHT,G.EDIT_RIGHT,G.DEL_RIGHT,G.UPLOAD "
                + " FROM MODULES M LEFT JOIN GROUP_PERMISSION G on M.MODULE_ID = G.MODULE_ID AND M.STATUS =1 AND G.GROUP_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, gId);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Permission permis = new Permission();
                permis.setModelId(rs.getInt("MODULE_ID"));
                permis.setResource(rs.getString("RESOURCE"));
                permis.setModuleName(rs.getString("NAME"));
                permis.setGropId(rs.getInt("GROUP_ID"));
                permis.setSpecial(Tool.getBoolean(rs.getInt("ALL_RIGHT")));
                permis.setView(Tool.getBoolean(rs.getInt("VIEW_RIGHT")));
                permis.setViewShort(Tool.getBoolean(rs.getInt("VIEW_SHORT")));
                permis.setAdd(Tool.getBoolean(rs.getInt("ADD_RIGHT")));
                permis.setEdit(Tool.getBoolean(rs.getInt("EDIT_RIGHT")));
                permis.setDel(Tool.getBoolean(rs.getInt("DEL_RIGHT")));
                permis.setUpload(Tool.getBoolean(rs.getInt("UPLOAD")));
                all.add(permis);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstm, conn);

        }
        return all;
    }

    public ArrayList getRoleAccModule(int accID) {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT M.MODULE_ID,M.RESOURCE,M.NAME"
                + " ,U.ID,U.ACC_ID,U.ALL_RIGHT,U.VIEW_RIGHT,U.VIEW_SHORT,U.ADD_RIGHT,U.EDIT_RIGHT,U.DEL_RIGHT,U.UPLOAD "
                + " FROM MODULES M LEFT JOIN USER_PERMISSION U on M.MODULE_ID = U.MODULE_ID AND M.STATUS =1 AND U.ACC_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, accID);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Permission permis = new Permission();
                permis.setModelId(rs.getInt("MODULE_ID"));
                permis.setResource(rs.getString("RESOURCE"));
                permis.setModuleName(rs.getString("NAME"));
                permis.setUserId(rs.getInt("ACC_ID"));
                permis.setSpecial(Tool.getBoolean(rs.getInt("ALL_RIGHT")));
                permis.setView(Tool.getBoolean(rs.getInt("VIEW_RIGHT")));
                permis.setViewShort(Tool.getBoolean(rs.getInt("VIEW_SHORT")));
                permis.setAdd(Tool.getBoolean(rs.getInt("ADD_RIGHT")));
                permis.setEdit(Tool.getBoolean(rs.getInt("EDIT_RIGHT")));
                permis.setDel(Tool.getBoolean(rs.getInt("DEL_RIGHT")));
                permis.setUpload(Tool.getBoolean(rs.getInt("UPLOAD")));
                all.add(permis);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    private String buildCol(int per) {
        String col = "";
        if (per == PER.SPECIAL.val) {
            col = "ALL_RIGHT";
        }
        if (per == PER.VIEW.val) {
            col = "VIEW_RIGHT";
        }
        if (per == PER.VIEW_SHORT.val) {
            col = "VIEW_SHORT";
        }
        if (per == PER.ADD.val) {
            col = "ADD_RIGHT";
        }
        if (per == PER.EDIT.val) {
            col = "EDIT_RIGHT";
        }
        if (per == PER.DEL.val) {
            col = "DEL_RIGHT";
        }
        if (per == PER.UPLOAD.val) {
            col = "UPLOAD";
        }
        return col;
    }

    public void cleanUserRole(int accID, int per) {
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "";
        String col = buildCol(per);
        if (col.equals("")) {
            return;
        }
        try {
            conn = DBPool.getConnection();
            sql = "UPDATE USER_PERMISSION SET " + col + " = ? WHERE ACC_ID = ?";
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, 0);
            pstm.setInt(2, accID);
            pstm.execute();
            Account.outerReload();
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
    }

    public void mapUsertRole(String[] arr, int per) {
        Connection conn = null;
        CallableStatement cstm = null;
        String sql = "{call proc_updateAccountPermission(?,?,?)}";
        String col = buildCol(per);
        if (col.equals("")) {
            return;
        }
        try {
            if (arr != null && arr.length > 0) {
                conn = DBPool.getConnection();
                for (String one : arr) {
                    String[] tem = one.split("_");
                    if (tem.length == 2) {
                        cstm = conn.prepareCall(sql);
                        cstm.setInt(1, Tool.string2Integer(tem[0]));
                        cstm.setInt(2, Tool.string2Integer(tem[1]));
                        cstm.setInt(3, per);
                        cstm.execute();
                    }
                }
                Account.outerReload();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(null, cstm, conn);
        }
    }

    /**
     * Update for add User into Group
     *
     * @param gid
     * @param uid
     */
    public static void updateUserRole(int gid, int uid) {
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            Permission perDao = new Permission();
            // Lay tat ca cac quyen cua nhom
            ArrayList<Permission> perGroups = perDao.getRoleGroupModule(gid);
            // update quyen sang User
            conn = DBPool.getConnection();
            // Duyet qua tung Permission cua Group
            for (Permission oneGper : perGroups) {
                pstm = conn.prepareStatement("SELECT count(*) FROM user_permission WHERE ACC_ID = ? AND MODULE_ID = ?");
                pstm.setInt(1, uid);
                pstm.setInt(2, oneGper.getModelId());
                rs = pstm.executeQuery();
                if (rs.next()) {
                    int tem = rs.getInt(1);
                    DBPool.releadRsPstm(rs, pstm);
                    int i = 1;
                    if (tem == 1) {
                        // CO roi
                        pstm = conn.prepareStatement("UPDATE user_permission SET ALL_RIGHT = ?, VIEW_RIGHT = ?,VIEW_SHORT=?,ADD_RIGHT = ?,EDIT_RIGHT=?,DEL_RIGHT=?,UPLOAD=? WHERE ACC_ID = ? AND MODULE_ID = ?");
                        pstm.setBoolean(i++, oneGper.isSpecial());
                        pstm.setBoolean(i++, oneGper.isView());
                        pstm.setBoolean(i++, oneGper.isViewShort());
                        pstm.setBoolean(i++, oneGper.isAdd());
                        pstm.setBoolean(i++, oneGper.isEdit());
                        pstm.setBoolean(i++, oneGper.isDel());
                        pstm.setBoolean(i++, oneGper.isUpload());
                        pstm.setInt(i++, uid);
                        pstm.setInt(i++, oneGper.getModelId());
                        pstm.execute();
                    } else {
                        // Chua co
                        pstm = conn.prepareStatement("INSERT INTO user_permission(ACC_ID,MODULE_ID,ALL_RIGHT,VIEW_RIGHT,VIEW_SHORT,ADD_RIGHT,EDIT_RIGHT,DEL_RIGHT,UPLOAD)"
                                + "VALUES(?,?,?,?,?,?,?,?,?)");
                        pstm.setInt(i++, uid);
                        pstm.setInt(i++, oneGper.getModelId());
                        pstm.setBoolean(i++, oneGper.isSpecial());
                        pstm.setBoolean(i++, oneGper.isView());
                        pstm.setBoolean(i++, oneGper.isViewShort());
                        pstm.setBoolean(i++, oneGper.isAdd());
                        pstm.setBoolean(i++, oneGper.isEdit());
                        pstm.setBoolean(i++, oneGper.isDel());
                        pstm.setBoolean(i++, oneGper.isUpload());
                        pstm.execute();
                    }
                }
            }
            Account.outerReload();
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
    }

    /**
     * Remove Role Of User in Group
     *
     * @param gid
     * @param uid
     */
    public static void removeUserRole(int gid, int uid) {
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            Permission perDao = new Permission();
            // Lay tat ca cac quyen cua nhom
            ArrayList<Permission> perGroups = perDao.getRoleGroupModule(gid);
            // update quyen sang User
            conn = DBPool.getConnection();
            for (Permission oneGper : perGroups) {
                // Khong can check co roi hay chua chi can upate duoc thi duoc ma khong duoc thi thoi
                DBPool.releadRsPstm(rs, pstm);
                int i = 1;
                pstm = conn.prepareStatement("UPDATE user_permission SET ALL_RIGHT = 0, VIEW_RIGHT = 0,VIEW_SHORT=0,ADD_RIGHT = 0,EDIT_RIGHT=0,DEL_RIGHT=0,UPLOAD=0 WHERE ACC_ID = ? AND MODULE_ID = ?");
                // CO roi
                pstm.setInt(i++, uid);
                pstm.setInt(i++, oneGper.getModelId());
                pstm.execute();
            }
            Account.outerReload();
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
    }

    public static void updateRoleUserOfGroup(int gid) {
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            Permission perDao = new Permission();
            // Lay tat ca cac quyen cua nhom
            ArrayList<Permission> perGroups = perDao.getRoleGroupModule(gid);
            Groups gDao = new Groups();
            gDao = gDao.getGroupByID(gid);
            if (gDao != null && gDao.getAllAccId().size() > 0) {
                ArrayList allAccID = gDao.getAllAccId();
                conn = DBPool.getConnection();
                for (Permission onePerGroup : perGroups) {
                    String sql = "UPDATE USER_PERMISSION SET ALL_RIGHT=?,VIEW_RIGHT=?,VIEW_SHORT=?,ADD_RIGHT=?,EDIT_RIGHT=?,DEL_RIGHT=?,UPLOAD=?"
                            + " where MODULE_ID = ? ";
                    if (allAccID != null && allAccID.size() > 0) {
                        sql += "AND (";
                        for (int i = 0; i < allAccID.size(); i++) {
                            sql += " ACC_ID = ? ";
                            if (i != allAccID.size() - 1) {
                                sql += " OR ";
                            }
                        }
                        sql += ")";
                    }

                    pstm = conn.prepareStatement(sql);
                    int k = 1;
                    pstm.setBoolean(k++, onePerGroup.isSpecial());
                    pstm.setBoolean(k++, onePerGroup.isView());
                    pstm.setBoolean(k++, onePerGroup.isViewShort());
                    pstm.setBoolean(k++, onePerGroup.isAdd());
                    pstm.setBoolean(k++, onePerGroup.isEdit());
                    pstm.setBoolean(k++, onePerGroup.isDel());
                    pstm.setBoolean(k++, onePerGroup.isUpload());
                    pstm.setInt(k++, onePerGroup.getModelId());
                    if (allAccID != null && allAccID.size() > 0) {
                        for (int i = 0; i < allAccID.size(); i++) {
                            int accID = (int) allAccID.get(i);
                            pstm.setInt(k++, accID);
                        }
                    }
                    pstm.execute();
                }
                Account.outerReload();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
    }

    public void cleanRoleGroup(int groupID, int per) {
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "";
        String col = buildCol(per);
        if (col.equals("")) {
            return;
        }
        try {
            conn = DBPool.getConnection();
            sql = "UPDATE GROUP_PERMISSION SET " + col + " = ? WHERE GROUP_ID = ?";
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, 0);
            pstm.setInt(2, groupID);
            pstm.execute();
            Account.outerReload();
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
    }

    public void mapRoleGroup(String[] arr, int per) {
        Connection conn = null;
        CallableStatement cstm = null;
        String sql = "{call proc_updateGroupPermission(?,?,?)}";
        String col = buildCol(per);
        if (col.equals("")) {
            return;
        }
        try {
            if (arr != null && arr.length > 0) {
                conn = DBPool.getConnection();
                for (String one : arr) {
                    String[] tem = one.split("_");
                    if (tem.length == 2) {
                        cstm = conn.prepareCall(sql);
                        cstm.setInt(1, Tool.string2Integer(tem[0]));
                        cstm.setInt(2, Tool.string2Integer(tem[1]));
                        cstm.setInt(3, per);
                        cstm.execute();
                    }
                }
                Account.outerReload();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(null, cstm, conn);
        }
    }

    public static enum PER {

        SPECIAL(0),
        VIEW(1),
        ADD(2),
        EDIT(3),
        DEL(4),
        VIEW_SHORT(5),
        UPLOAD(6),;
        public int val;

        private PER(int val) {
            this.val = val;
        }
    }
    int id;
    int gropId;
    int userId;
    int modelId;
    boolean view;
    boolean add;
    boolean edit;
    boolean del;
    boolean special;
    boolean viewShort;
    boolean upload;
    // Add build For Module
    String resource;
    String moduleName;
    int status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getModelId() {
        return modelId;
    }

    public void setModelId(int modelId) {
        this.modelId = modelId;
    }

    public boolean isView() {
        return view;
    }

    public void setView(boolean view) {
        this.view = view;
    }

    public boolean isAdd() {
        return add;
    }

    public void setAdd(boolean add) {
        this.add = add;
    }

    public boolean isEdit() {
        return edit;
    }

    public void setEdit(boolean edit) {
        this.edit = edit;
    }

    public boolean isDel() {
        return del;
    }

    public void setDel(boolean del) {
        this.del = del;
    }

    public boolean isSpecial() {
        return special;
    }

    public void setSpecial(boolean special) {
        this.special = special;
    }

    public int getGropId() {
        return gropId;
    }

    public void setGropId(int gropId) {
        this.gropId = gropId;
    }

    public String getResource() {
        return resource;
    }

    public void setResource(String resource) {
        this.resource = resource;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public static Logger getLogger() {
        return logger;
    }

    public static void setLogger(Logger logger) {
        Permission.logger = logger;
    }

    public boolean isViewShort() {
        return viewShort;
    }

    public void setViewShort(boolean viewShort) {
        this.viewShort = viewShort;
    }

    public boolean isUpload() {
        return upload;
    }

    public void setUpload(boolean upload) {
        this.upload = upload;
    }

}
