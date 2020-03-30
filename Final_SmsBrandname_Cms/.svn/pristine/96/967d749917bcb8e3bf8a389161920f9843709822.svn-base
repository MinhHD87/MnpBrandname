package gk.myname.vn.admin;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.Tool;
import java.sql.*;
import java.util.ArrayList;
import org.apache.log4j.Logger;

public class GroupAccDetail {

    static Logger logger = Logger.getLogger(GroupAccDetail.class);

    public boolean removeAcc(int groupId, int accId) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "DELETE FROM group_acc_detail WHERE GROUP_ID = ? AND ACC_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, groupId);
            pstm.setInt(2, accId);
            if (pstm.executeUpdate() == 1) {
                flag = true;
                Groups.reloadAll();
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return flag;
    }

    public boolean create(int uid, int[] gIDs, int createBy) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "INSERT INTO GROUP_ACC_DETAIL(ACC_ID,GROUP_ID,CREATE_BY,CREATE_DATE)";
        int count = 1;
        if (gIDs != null && gIDs.length > 0) {
            for (int one : gIDs) {
                sql += " values(?,?,?,NOW())";
                if (count < gIDs.length) {
                    sql += ",";
                }
                count++;
            }
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (gIDs != null && gIDs.length > 0) {
                for (int one : gIDs) {
                    pstm.setInt(i++, uid);
                    pstm.setInt(i++, one);
                    pstm.setInt(i++, createBy);
                }
            }
            if (pstm.executeUpdate() == 1) {
                ok = true;
                Groups.reloadAll();
            }
        } catch (Exception ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(null, pstm, conn);
        }
        return ok;
    }

    public static ArrayList getAllAccID(int gid) {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT ACC_ID FROM group_acc_detail WHERE GROUP_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, gid);
            rs = pstm.executeQuery();
            while (rs.next()) {
                all.add(rs.getInt("ACC_ID"));
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public static boolean checkExitAcc(int accID, Groups g) {
        boolean flag = false;
        ArrayList<Integer> all = g.getAllAccId();
        try {
            for (Integer one : all) {
                if (one == accID) {
                    flag = true;
                    break;
                }
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        }
        return flag;
    }

    /**
     *
     * @param id
     * @return
     */
    public boolean delByAdminID(long id) {

        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String querySQl = "delete from group_acc_detail where admin_id=?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(querySQl);
            pstm.setLong(1, id);
            if (pstm.executeUpdate() == 1) {
                ok = true;
            }
        } catch (Exception ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(null, pstm, conn);
        }
        return ok;
    }
    private int adminID;
    private int groupID;
    private int createBy;
    private Timestamp creatDate;
    private int updateby;
    private Timestamp updateDate;

    public Logger getLogger() {
        return logger;
    }

    public void setLogger(Logger logger) {
        this.logger = logger;
    }

    public int getAdminID() {
        return adminID;
    }

    public void setAdminID(int adminID) {
        this.adminID = adminID;
    }

    public int getGroupID() {
        return groupID;
    }

    public void setGroupID(int groupID) {
        this.groupID = groupID;
    }

    public int getCreateBy() {
        return createBy;
    }

    public void setCreateBy(int createBy) {
        this.createBy = createBy;
    }

    public Timestamp getCreatDate() {
        return creatDate;
    }

    public void setCreatDate(Timestamp creatDate) {
        this.creatDate = creatDate;
    }

    public int getUpdateby() {
        return updateby;
    }

    public void setUpdateby(int updateby) {
        this.updateby = updateby;
    }

    public Timestamp getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Timestamp updateDate) {
        this.updateDate = updateDate;
    }
}
