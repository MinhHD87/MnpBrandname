/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.SMSUtils;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import org.apache.log4j.Logger;

/**
 *
 * @author Centurion
 */
public class ListCustomer {

    static final Logger logger = Logger.getLogger(ListCustomer.class);

    public ArrayList<String> getList(int gid, int rootAccId) {
        ArrayList<String> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT PHONE FROM LIST_CUSTOMER WHERE ROOT_ACCID = ? AND G_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, rootAccId);
            pstm.setInt(i++, gid);
            rs = pstm.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("PHONE"));
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return list;
    }

    public ArrayList<ListCustomer> getCustomer(int page, int rootid, int max, String phone, int gid) {
        ArrayList<ListCustomer> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = " SELECT B.* FROM LIST_CUSTOMER B WHERE B.ROOT_ACCID = ? ";
        if (!Tool.checkNull(phone)) {
            sql += " AND B.PHONE LIKE ? ";
        }
        if (gid != 0) {
            sql += " AND B.G_ID = ? ";
        }
        sql += " ORDER BY B.ID DESC LIMIT ?,?";
//        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, rootid);
            if (!Tool.checkNull(phone)) {
                pstm.setString(i++, "%" + phone + "%");
            }
            if (gid != 0) {
                pstm.setInt(i++, gid);
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                ListCustomer one = new ListCustomer();
                one.setId(rs.getInt("ID"));
                one.setRootAccId(rs.getInt("ROOT_ACCID"));
                one.setPhone(rs.getString("PHONE"));
                one.setOperator(rs.getString("OPERATOR"));
                one.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                one.setCreateBy(rs.getInt("CREATE_BY"));
                one.setName(rs.getString("NAME"));
                one.setNote(rs.getString("NOTE"));
                all.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public int countCustomer(int rootid, String phone, int gid) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM LIST_CUSTOMER WHERE ROOT_ACCID = ?";
        if (!Tool.checkNull(phone)) {
            sql += " AND PHONE LIKE ?";
        }
        if (gid != 0) {
            sql += " AND G_ID = ?";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, rootid);
            if (!Tool.checkNull(phone)) {
                pstm.setString(i++, "%" + phone + "%");
            }
            if (gid != 0) {
                pstm.setInt(i++, gid);
            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return count;
    }

    public static int addPhone(ArrayList<ListCustomer> data, int rootAccId, int createBy, int gid) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "";
        try {
            if (data != null && !data.isEmpty()) {
                sql += "INSERT IGNORE  LIST_CUSTOMER(ROOT_ACCID,G_ID,PHONE,OPERATOR,CREATE_DATE,CREATE_BY,NAME,NOTE) "
                        + "                   VALUES(     ?    , ?  ,  ?  ,    ?   , NOW()     ,    ?    , ?  , ?  )";
                conn = DBPool.getConnection();
                pstm = conn.prepareStatement(sql);
                int i = 1;
                for (ListCustomer one : data) {
                    try {
                        String oper = SMSUtils.buildMobileOperator(one.getPhone());
                        if (oper.equalsIgnoreCase("OTHER")) {
                            continue;
                        }
                        pstm.setInt(i++, rootAccId);
                        pstm.setInt(i++, gid);
                        pstm.setString(i++, SMSUtils.phoneTo84(one.getPhone()));
                        pstm.setString(i++, oper);
                        pstm.setInt(i++, createBy);
                        pstm.setString(i++, one.getName());
                        pstm.setString(i++, one.getNote());
                        if (pstm.executeUpdate() > 0) {
                            result += 1;
                        } else {
                            Tool.debug("thuc thi nhung khong insert duoc thang nao");
                        }
                        pstm.clearParameters();
                    } catch (Exception e) {
                        pstm.clearParameters();
                        System.out.println("addPhone 2 LIST_CUSTOMER: " + e.getMessage() + "|" + one);
                    }
                    i = 1;
                }
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;

    }

    public static boolean del(int id) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "DELETE FROM LIST_CUSTOMER WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            if (pstm.executeUpdate() == 1) {
                flag = true;
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return flag;
    }

    //--
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRootAccId() {
        return rootAccId;
    }

    public void setRootAccId(int rootAccId) {
        this.rootAccId = rootAccId;
    }

    public int getgId() {
        return gId;
    }

    public void setgId(int gId) {
        this.gId = gId;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    int id;
    int rootAccId;
    int gId;
    String phone;
    String operator;
    Timestamp createDate;
    int createBy;
    String name;
    String note;
}
