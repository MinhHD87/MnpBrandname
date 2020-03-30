/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.admin.Account;
import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

/**
 *
 * @author Centurion
 */
public class GroupCustomer {

    public static final HashMap<Integer, ArrayList<GroupCustomer>> CACHE = new HashMap<>();

    static {
        GroupCustomer gDao = new GroupCustomer();
        // Lay ra danh sach khach hang
        Collection<Account> custom = Account.CACHE.values();
        for (Account one : custom) {
//            lay ra Group khach hang cua khach hang
            ArrayList<GroupCustomer> listGroup = gDao.getAll(one.getAccID(), null);
            if (listGroup != null && !listGroup.isEmpty()) {
                // put to cache
                CACHE.put(one.getAccID(), listGroup);
            }
        }
    }

    private static void reload() {
        GroupCustomer gDao = new GroupCustomer();
        // Lay ra danh sach khach hang
        ArrayList<Account> custom = new Account().getAllAccount(Account.TYPE.USER.val, null);
        CACHE.clear();
        for (Account one : custom) {
//            lay ra Group khach hang cua khach hang
            ArrayList<GroupCustomer> listGroup = gDao.getAll(one.getAccID(), null);
            if (listGroup != null && !listGroup.isEmpty()) {
                // put to cache
                CACHE.put(one.getAccID(), listGroup);
            }
        }
    }

    public static ArrayList<GroupCustomer> getListCache(int rootAccid) {
        ArrayList<GroupCustomer> listGroup = CACHE.get(rootAccid);
        if (listGroup == null || listGroup.isEmpty()) {
            listGroup = new ArrayList<>();
        }
        return listGroup;
    }

    public ArrayList<GroupCustomer> getAll(int rootAccid, String key) {
        ArrayList<GroupCustomer> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM GROUP_CUSTOMER WHERE STATUS = 1 AND ROOT_ACCID = ? ";
        if (!Tool.checkNull(key)) {
            sql += " AND G_NAME like ?";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, rootAccid);
            if (!Tool.checkNull(key)) {
                pstm.setString(2, "%" + key + "%");
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                GroupCustomer one = new GroupCustomer();
                one.setId(rs.getInt("ID"));
                one.setRootAccid(rs.getInt("ROOT_ACCID"));
                one.setGname(rs.getString("G_NAME"));
                one.setgDesc(rs.getString("G_DESC"));
                one.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                one.setCreateBy(rs.getInt("CREATE_BY"));
                one.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                one.setUpdateBy(rs.getInt("UPDATE_BY"));
                one.setStatus(rs.getInt("STATUS"));
                list.add(one);
            }
        } catch (Exception e) {
            Tool.debug(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return list;
    }

    public GroupCustomer getbyID(int id) {
        GroupCustomer result = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM GROUP_CUSTOMER WHERE ID = ? ";

        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            while (rs.next()) {
                result = new GroupCustomer();
                result.setId(rs.getInt("ID"));
                result.setRootAccid(rs.getInt("ROOT_ACCID"));
                result.setGname(rs.getString("G_NAME"));
                result.setgDesc(rs.getString("G_DESC"));
                result.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                result.setCreateBy(rs.getInt("CREATE_BY"));
                result.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                result.setUpdateBy(rs.getInt("UPDATE_BY"));
                result.setStatus(rs.getInt("STATUS"));
            }
        } catch (Exception e) {
            Tool.debug(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean add(GroupCustomer one) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO GROUP_CUSTOMER(ROOT_ACCID,G_NAME,G_DESC,CREATE_DATE,CREATE_BY,UPDATE_DATE,UPDATE_BY,STATUS)"
                + "                       VALUES(    ?     ,   ?  ,   ?  ,  NOW()    ,   ?     ,  NOW()    ,    ?    ,  ?   )";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, one.getRootAccid());
            pstm.setString(i++, one.getGname());
            pstm.setString(i++, one.getgDesc());
            pstm.setInt(i++, one.getCreateBy());
            pstm.setInt(i++, one.getUpdateBy());
            pstm.setInt(i++, one.getStatus());
            if (pstm.executeUpdate() == 1) {
                flag = true;
                reload();
            }
        } catch (Exception e) {
            Tool.debug(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return flag;
    }

    public boolean update(GroupCustomer one) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE GROUP_CUSTOMER SET G_NAME = ?,G_DESC = ?,UPDATE_DATE = NOW(),UPDATE_BY = ? WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, one.getGname());
            pstm.setString(i++, one.getgDesc());
            pstm.setInt(i++, one.getUpdateBy());
            pstm.setInt(i++, one.getId());
            if (pstm.executeUpdate() == 1) {
                flag = true;
                reload();
            }
        } catch (Exception e) {
            Tool.debug(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return flag;
    }

    public boolean customDel(int id, int updateBy) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
//        String sql = "UPDATE GROUP_CUSTOMER SET STATUS = ?,UPDATE_BY = ? WHERE ID = ?";
        String sql = "DELETE FROM GROUP_CUSTOMER WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            if (pstm.executeUpdate() == 1) {
                pstm.close();
                pstm = conn.prepareStatement("DELETE FROM list_customer WHERE G_ID = ?");
                pstm.setInt(1, id);
                pstm.execute();
                pstm.close();
                flag = true;
                reload();
            }
        } catch (Exception e) {
            Tool.debug(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return flag;
    }
    //--
    int id;
    int rootAccid;
    String gname;
    String gDesc;
    Timestamp createDate;
    int createBy;
    Timestamp updateDate;
    int updateBy;
    int status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRootAccid() {
        return rootAccid;
    }

    public void setRootAccid(int rootAccid) {
        this.rootAccid = rootAccid;
    }

    public String getGname() {
        return gname;
    }

    public void setGname(String gname) {
        this.gname = gname;
    }

    public String getgDesc() {
        return gDesc;
    }

    public void setgDesc(String gDesc) {
        this.gDesc = gDesc;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
