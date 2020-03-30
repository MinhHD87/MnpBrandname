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
import java.util.ArrayList;
import org.apache.log4j.Logger;

/**
 *
 * @author MinhKudo
 */
public class Subsidiary {

    static final Logger logger = Logger.getLogger(Subsidiary.class);

    public int id;
    public String name;
    public String address;
    public String bank_acc;
    public String bank_add;
    public String business_code;
    public String phone;
    public String fax;
    public String manager;
    public int status;

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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getBank_acc() {
        return bank_acc;
    }

    public void setBank_acc(String bank_acc) {
        this.bank_acc = bank_acc;
    }

    public String getBank_add() {
        return bank_add;
    }

    public void setBank_add(String bank_add) {
        this.bank_add = bank_add;
    }

    public String getBusiness_code() {
        return business_code;
    }

    public void setBusiness_code(String business_code) {
        this.business_code = business_code;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public ArrayList<Subsidiary> listID() {
        ArrayList<Subsidiary> list = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select ID,NAME from subsidiary ";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Subsidiary sub = new Subsidiary();
                sub.setId(rs.getInt("ID"));
                sub.setName(rs.getString("NAME"));
                list.add(sub);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return list;
    }

    public ArrayList<Subsidiary> findList(int max, int page, String name, String bank_acc, String business_code, String phone, String fax, int status) {
        ArrayList<Subsidiary> list = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select * from subsidiary where 1=1 ";
            if (!Tool.checkNull(name)) {
                sql += " AND NAME LIKE ?";
            }
            if (!Tool.checkNull(bank_acc)) {
                sql += " AND BANK_ACC LIKE ?";
            }
            if (!Tool.checkNull(business_code)) {
                sql += " AND BUSINESS_CODE LIKE ?";
            }
            if (!Tool.checkNull(phone)) {
                sql += " AND PHONE LIKE ?";
            }
            if (!Tool.checkNull(fax)) {
                sql += " AND FAX LIKE ?";
            }
            if (status != -1) {
                sql += " AND STATUS = ?";
            }
            sql += " ORDER BY ID DESC LIMIT ?,?";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, "%" + name + "%");
            }
            if (!Tool.checkNull(bank_acc)) {
                pstm.setString(i++, "%" + bank_acc + "%");
            }
            if (!Tool.checkNull(business_code)) {
                pstm.setString(i++, "%" + business_code + "%");
            }
            if (!Tool.checkNull(phone)) {
                pstm.setString(i++, "%" + phone + "%");
            }
            if (!Tool.checkNull(fax)) {
                pstm.setString(i++, "%" + fax + "%");
            }
            if (status != -1) {
                pstm.setInt(i++, status);
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Subsidiary sub = new Subsidiary();
                sub.setId(rs.getInt("ID"));
                sub.setName(rs.getString("NAME"));
                sub.setAddress(rs.getString("ADDRESS"));
                sub.setBank_acc(rs.getString("BANK_ACC"));
                sub.setBank_add(rs.getString("BANK_ADD"));
                sub.setBusiness_code(rs.getString("BUSINESS_CODE"));
                sub.setPhone(rs.getString("PHONE"));
                sub.setFax(rs.getString("FAX"));
                sub.setManager(rs.getString("MANAGER"));
                sub.setStatus(rs.getInt("STATUS"));
                list.add(sub);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return list;
    }

    public int count(String name, String bank_acc, String business_code, String phone, String fax, int status) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select count(*) from subsidiary where 1=1 ";
            if (!Tool.checkNull(name)) {
                sql += " AND NAME LIKE ?";
            }
            if (!Tool.checkNull(bank_acc)) {
                sql += " AND BANK_ACC LIKE ?";
            }
            if (!Tool.checkNull(business_code)) {
                sql += " AND BUSINESS_CODE LIKE ?";
            }
            if (!Tool.checkNull(phone)) {
                sql += " AND PHONE LIKE ?";
            }
            if (!Tool.checkNull(fax)) {
                sql += " AND FAX LIKE ?";
            }
            if (status != -1) {
                sql += " AND STATUS = ?";
            }
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, "%" + name + "%");
            }
            if (!Tool.checkNull(bank_acc)) {
                pstm.setString(i++, "%" + bank_acc + "%");
            }
            if (!Tool.checkNull(business_code)) {
                pstm.setString(i++, "%" + business_code + "%");
            }
            if (!Tool.checkNull(phone)) {
                pstm.setString(i++, "%" + phone + "%");
            }
            if (!Tool.checkNull(fax)) {
                pstm.setString(i++, "%" + fax + "%");
            }
            if (status != -1) {
                pstm.setInt(i++, status);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean delete(int id) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            String sql = "DELETE from subsidiary where id =? ";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            result = pstm.executeUpdate() == 1;
            return true;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(pstm, conn);
        }
        return result;
    }

    public boolean add(Subsidiary acc) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            String sql = " INSERT INTO subsidiary(NAME,ADDRESS,BANK_ACC,BANK_ADD,BUSINESS_CODE,PHONE,FAX,MANAGER,STATUS) "
                    + "VALUES(   ?,      ?,       ?,       ?,            ?,    ?,  ?,      ?,     ?) ";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, acc.getName());
            pstm.setString(i++, acc.getAddress());
            pstm.setString(i++, acc.getBank_acc());
            pstm.setString(i++, acc.getBank_add());
            pstm.setString(i++, acc.getBusiness_code());
            pstm.setString(i++, acc.getPhone());
            pstm.setString(i++, acc.getFax());
            pstm.setString(i++, acc.getManager());
            pstm.setInt(i++, acc.getStatus());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(pstm, conn);
        }
        return result;
    }

    public Subsidiary getID(int id) {
        Subsidiary sub = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT * from subsidiary where id = ?";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                sub = new Subsidiary();
                sub.setId(rs.getInt("ID"));
                sub.setName(rs.getString("NAME"));
                sub.setAddress(rs.getString("ADDRESS"));
                sub.setBank_acc(rs.getString("BANK_ACC"));
                sub.setBank_add(rs.getString("BANK_ADD"));
                sub.setBusiness_code(rs.getString("BUSINESS_CODE"));
                sub.setPhone(rs.getString("PHONE"));
                sub.setFax(rs.getString("FAX"));
                sub.setManager(rs.getString("MANAGER"));
                sub.setStatus(rs.getInt("STATUS"));
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return sub;
    }

    public boolean update(Subsidiary acc) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            String sql = "UPDATE subsidiary "
                    + "SET NAME=?, ADDRESS=?,BANK_ACC=?,BANK_ADD=?,BUSINESS_CODE=?,PHONE=?,fax=?,MANAGER=?,`STATUS`=? "
                    + "WHERE id = ? ";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, acc.getName());
            pstm.setString(i++, acc.getAddress());
            pstm.setString(i++, acc.getBank_acc());
            pstm.setString(i++, acc.getBank_add());
            pstm.setString(i++, acc.getBusiness_code());
            pstm.setString(i++, acc.getPhone());
            pstm.setString(i++, acc.getFax());
            pstm.setString(i++, acc.getManager());
            pstm.setInt(i++, acc.getStatus());
            pstm.setInt(i++, acc.getId());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(pstm, conn);
        }
        return result;
    }
}
