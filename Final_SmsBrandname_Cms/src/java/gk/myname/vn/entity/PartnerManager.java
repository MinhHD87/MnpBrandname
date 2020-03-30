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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import org.apache.log4j.Logger;

/**
 *
 * @author TUANPLA
 */
public class PartnerManager {

    static final Logger logger = Logger.getLogger(PartnerManager.class);

    private static final HashMap<String, PartnerManager> CACHE = new HashMap<>();

    static {
        ArrayList<PartnerManager> list = getAll();
        synchronized (CACHE) {
            if (list != null && !list.isEmpty()) {
                for (PartnerManager one : list) {
                    if (!Tool.checkNull(one.getCode())) {
                        CACHE.put(one.getCode().toUpperCase(), one);
                    }
                }
            }
            CACHE.notifyAll();
        }
    }

    private void reload() {
        ArrayList<PartnerManager> list = getAll();
        synchronized (CACHE) {
            CACHE.clear();
            if (list != null && !list.isEmpty()) {
                for (PartnerManager one : list) {
                    if (!Tool.checkNull(one.getCode())) {
                        CACHE.put(one.getCode().toUpperCase(), one);
                    }
                }
            }
            CACHE.notifyAll();
        }
    }

    public static boolean hasChild(int id) {
        boolean result = false;
        synchronized (CACHE) {
            Collection<PartnerManager> coll = CACHE.values();
            for (PartnerManager one : coll) {
                if (one.getParentId() == id) {
                    result = true;
                    break;
                }
            }
            CACHE.notifyAll();
            return result;
        }
    }

    public boolean hasChild() {
        boolean result = false;
        synchronized (CACHE) {
            Collection<PartnerManager> coll = CACHE.values();
            for (PartnerManager one : coll) {
                if (one.getParentId() == id) {
                    result = true;
                    break;
                }
            }
            CACHE.notifyAll();
            return result;
        }
    }

    public boolean hasParent() {
        boolean result = false;
        synchronized (CACHE) {
            Collection<PartnerManager> coll = CACHE.values();
            for (PartnerManager one : coll) {
                if (one.getId() == parentId) {
                    result = true;
                    break;
                }
            }
            CACHE.notifyAll();
            return result;
        }
    }

    public static PartnerManager getCacheById(int id) {
        PartnerManager result = null;
        synchronized (CACHE) {
            Collection<PartnerManager> coll = CACHE.values();
            for (PartnerManager one : coll) {
                if (one != null && one.getId() == id) {
                    result = one;
                    break;
                }

            }
            CACHE.notifyAll();
            return result;
        }
    }

    public static PartnerManager getCacheByCode(String code) {
        PartnerManager result = null;
        synchronized (CACHE) {
            Collection<PartnerManager> coll = CACHE.values();
            for (PartnerManager one : coll) {
                if (one != null && one.getCode().equals(code)) {
                    result = one;
                    break;
                }

            }
            CACHE.notifyAll();
            return result;
        }
    }

    public PartnerManager getParentCache() {
        PartnerManager result = null;
        synchronized (CACHE) {
            Collection<PartnerManager> coll = CACHE.values();
            for (PartnerManager one : coll) {
                if (one != null && one.getId() == parentId) {
                    result = one;
                    break;
                }

            }
            CACHE.notifyAll();
            return result;
        }
    }

    public ArrayList<PartnerManager> getChildCache() {
        ArrayList<PartnerManager> result = new ArrayList<>();
        synchronized (CACHE) {
            Collection<PartnerManager> coll = CACHE.values();
            for (PartnerManager one : coll) {
                if (one.getParentId() == id) {
                    result.add(one);
                }
            }
            CACHE.notifyAll();
            return result;
        }
    }

    public static ArrayList<PartnerManager> getAllCache() {
        synchronized (CACHE) {
            ArrayList<PartnerManager> result = new ArrayList<>(CACHE.values());
            return result;
        }
    }

    public static ArrayList<PartnerManager> getAll() {
        ArrayList<PartnerManager> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM PARTNER_MANAGER A ";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                PartnerManager one = new PartnerManager();
                one.setId(rs.getInt("ID"));
                one.setParentId(rs.getInt("PARENT_ID"));
                one.setName(rs.getString("NAME"));
                one.setDesc(rs.getString("PN_DESC"));
                one.setCode(rs.getString("PN_CODE"));
                one.setAddress(rs.getString("ADDRESS"));
                one.setPhone(rs.getString("PHONE"));
                one.setEmail(rs.getString("EMAIL"));
                one.setBusinessCode(rs.getString("BUSINESS_CODE"));
                one.setBankAcc(rs.getString("BANK_ACC"));
                one.setBankAdd(rs.getString("BANK_ADD"));
                one.setManager(rs.getString("MANAGER"));
                one.setLastUpdate(rs.getTimestamp("LAST_UPDATE"));
                one.setDel(rs.getBoolean("IS_DEL"));
                one.setStatus(rs.getInt("STATUS"));
                result.add(one);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public ArrayList<PartnerManager> getAll(int page, int max, String name, String code, int status) {
        ArrayList<PartnerManager> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM PARTNER_MANAGER A  WHERE 1=1 ";
        try {
            if (!Tool.checkNull(name)) {
                sql += " AND A.NAME LIKE ?";
            }
            if (!Tool.checkNull(code)) {
                sql += " AND A.PN_CODE = ?";
            }
            if (status != -1) {
                sql += " AND A.STATUS = ?";
            }
            sql += " ORDER BY A.ID DESC LIMIT ?,?";

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            //--
            int i = 1;
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, "%" + name + "%");
            }
            if (!Tool.checkNull(code)) {
                pstm.setString(i++, code);
            }
            if (status != -1) {
                pstm.setInt(i++, status);
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                PartnerManager one = new PartnerManager();
                one.setId(rs.getInt("ID"));
                one.setParentId(rs.getInt("PARENT_ID"));
                one.setName(rs.getString("NAME"));
                one.setDesc(rs.getString("PN_DESC"));
                one.setCode(rs.getString("PN_CODE"));
                one.setAddress(rs.getString("ADDRESS"));
                one.setPhone(rs.getString("PHONE"));
                one.setEmail(rs.getString("EMAIL"));
                one.setBusinessCode(rs.getString("BUSINESS_CODE"));
                one.setBankAcc(rs.getString("BANK_ACC"));
                one.setBankAdd(rs.getString("BANK_ADD"));
                one.setManager(rs.getString("MANAGER"));
                one.setLastUpdate(rs.getTimestamp("LAST_UPDATE"));
                one.setDel(rs.getBoolean("IS_DEL"));
                one.setStatus(rs.getInt("STATUS"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public int countAll(String name, String code, int status) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM PARTNER_MANAGER WHERE 1=1";
        try {
            if (!Tool.checkNull(name)) {
                sql += " AND NAME LIKE ?";
            }
            if (!Tool.checkNull(code)) {
                sql += " AND PN_CODE = ?";
            }
            if (status != -1) {
                sql += " AND IS_DEL = ?";
            }
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, "%" + name + "%");
            }
            if (!Tool.checkNull(code)) {
                pstm.setString(i++, code);
            }
            if (status != -1) {
                pstm.setInt(i++, status);
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
    
    //PHONG THEM
    public static String getNameCompany(String code) {
        String result = "";
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT NAME FROM PARTNER_MANAGER A  WHERE PN_CODE = ? ";
        try {

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            //--
            pstm.setString(1, code);
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = rs.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
    
    public static int getIDCompany(String code) {
        int result = -1;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT ID FROM PARTNER_MANAGER A  WHERE PN_CODE = ? ";
        try {

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            //--
            pstm.setString(1, code);
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = rs.getInt("ID");
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
    //KET THUC PHONG THEM

    public ArrayList<PartnerManager> getAllSubPartner(int page, int max, String name, String code, int status) {
        ArrayList<PartnerManager> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM PARTNER_MANAGER A  WHERE 1=1 ";
        try {
            if (!Tool.checkNull(name)) {
                sql += " AND A.NAME LIKE ?";
            }
            if (!Tool.checkNull(code)) {
                sql += " AND A.PN_CODE like ?";
            }
            if (status != -2) {
                sql += " AND A.STATUS = ?";
            }
            sql += " ORDER BY A.ID DESC LIMIT ?,?";

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            //--
            int i = 1;
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, "%" + name + "%");
            }
            if (!Tool.checkNull(code)) {
                pstm.setString(i++, code + "_%");
            }
            if (status != -2) {
                pstm.setInt(i++, status);
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                PartnerManager one = new PartnerManager();
                one.setId(rs.getInt("ID"));
                one.setParentId(rs.getInt("PARENT_ID"));
                one.setName(rs.getString("NAME"));
                one.setDesc(rs.getString("PN_DESC"));
                one.setCode(rs.getString("PN_CODE"));
                one.setAddress(rs.getString("ADDRESS"));
                one.setPhone(rs.getString("PHONE"));
                one.setEmail(rs.getString("EMAIL"));
                one.setBusinessCode(rs.getString("BUSINESS_CODE"));
                one.setBankAcc(rs.getString("BANK_ACC"));
                one.setBankAdd(rs.getString("BANK_ADD"));
                one.setManager(rs.getString("MANAGER"));
                one.setLastUpdate(rs.getTimestamp("LAST_UPDATE"));
                one.setDel(rs.getBoolean("IS_DEL"));
                one.setStatus(rs.getInt("STATUS"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public int countAllSubPartner(String name, String code, int status) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM PARTNER_MANAGER WHERE 1=1";
        try {
            if (!Tool.checkNull(name)) {
                sql += " AND NAME LIKE ?";
            }
            if (!Tool.checkNull(code)) {
                sql += " AND PN_CODE like ?";
            }
            if (status != -2) {
                sql += " AND STATUS = ?";
            }
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, "%" + name + "%");
            }
            if (!Tool.checkNull(code)) {
                pstm.setString(i++, code + "_%");
            }
            if (status != -2) {
                pstm.setInt(i++, status);
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

    public ArrayList<PartnerManager> searchByKey(String key) {
        ArrayList<PartnerManager> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM PARTNER_MANAGER A  WHERE 1=1 ";
        try {
            if (!Tool.checkNull(key)) {
                sql += " AND (UPPER(A.NAME) LIKE UPPER(?) OR UPPER(A.PN_CODE) like UPPER(?) )";
            }
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            //--
            int i = 1;
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                PartnerManager one = new PartnerManager();
                one.setId(rs.getInt("ID"));
                one.setParentId(rs.getInt("PARENT_ID"));
                one.setName(rs.getString("NAME"));
                one.setDesc(rs.getString("PN_DESC"));
                one.setCode(rs.getString("PN_CODE"));
                one.setAddress(rs.getString("ADDRESS"));
                one.setPhone(rs.getString("PHONE"));
                one.setEmail(rs.getString("EMAIL"));
                one.setBusinessCode(rs.getString("BUSINESS_CODE"));
                one.setBankAcc(rs.getString("BANK_ACC"));
                one.setBankAdd(rs.getString("BANK_ADD"));
                one.setManager(rs.getString("MANAGER"));
                one.setLastUpdate(rs.getTimestamp("LAST_UPDATE"));
                one.setDel(rs.getBoolean("IS_DEL"));
                one.setStatus(rs.getInt("STATUS"));
                result.add(one);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean addNew(PartnerManager one) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO PARTNER_MANAGER(PARENT_ID,NAME,PN_DESC,PN_CODE,ADDRESS,PHONE,EMAIL,BUSINESS_CODE,BANK_ACC,BANK_ADD,MANAGER,IS_DEL,STATUS)"
                + "                        VALUES(    ?    , ?  ,  ?    ,   ?   ,  ?    ,   ? ,  ?  ,         ?   ,  ?     ,   ?    ,   ?   ,   ?  ,   ?  )";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, one.getParentId());
            pstm.setString(i++, one.getName());
            pstm.setString(i++, one.getDesc());
            pstm.setString(i++, one.getCode());
            pstm.setString(i++, one.getAddress());
            pstm.setString(i++, one.getPhone());
            pstm.setString(i++, one.getEmail());
            pstm.setString(i++, one.getBusinessCode());
            pstm.setString(i++, one.getBankAcc());
            pstm.setString(i++, one.getBankAdd());
            pstm.setString(i++, one.getManager());
            pstm.setBoolean(i++, one.isDel());
            pstm.setInt(i++, one.getStatus());
            result = pstm.executeUpdate() == 1;
            if (result) {
                reload();
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean edit(PartnerManager one) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE PARTNER_MANAGER SET PARENT_ID = ?, NAME =?,PN_DESC =?,PN_CODE =?,ADDRESS = ?,PHONE = ?, EMAIL = ?,BUSINESS_CODE =?,BANK_ACC = ?,BANK_ADD = ?,MANAGER = ?,LAST_UPDATE = NOW(),IS_DEL =?,STATUS=? WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, one.getParentId());
            pstm.setString(i++, one.getName());
            pstm.setString(i++, one.getDesc());
            pstm.setString(i++, one.getCode());
            pstm.setString(i++, one.getAddress());
            pstm.setString(i++, one.getPhone());
            pstm.setString(i++, one.getEmail());
            pstm.setString(i++, one.getBusinessCode());
            pstm.setString(i++, one.getBankAcc());
            pstm.setString(i++, one.getBankAdd());
            pstm.setString(i++, one.getManager());
            pstm.setBoolean(i++, one.isDel());
            pstm.setInt(i++, one.getStatus());
            pstm.setInt(i++, one.getId());
            result = pstm.executeUpdate() == 1;
            if (result) {
                reload();
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public PartnerManager getByID(int id) {
        PartnerManager result = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM  PARTNER_MANAGER A  WHERE ID = ? ";
        try {

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            //--
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = new PartnerManager();
                result.setId(rs.getInt("ID"));
                result.setParentId(rs.getInt("PARENT_ID"));
                result.setName(rs.getString("NAME"));
                result.setDesc(rs.getString("PN_DESC"));
                result.setCode(rs.getString("PN_CODE"));
                result.setAddress(rs.getString("ADDRESS"));
                result.setPhone(rs.getString("PHONE"));
                result.setEmail(rs.getString("EMAIL"));
                result.setBusinessCode(rs.getString("BUSINESS_CODE"));
                result.setBankAcc(rs.getString("BANK_ACC"));
                result.setBankAdd(rs.getString("BANK_ADD"));
                result.setManager(rs.getString("MANAGER"));
                result.setLastUpdate(rs.getTimestamp("LAST_UPDATE"));
                result.setDel(rs.getBoolean("IS_DEL"));
                result.setStatus(rs.getInt("STATUS"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public PartnerManager getByCode(String code) {
        PartnerManager result = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM  PARTNER_MANAGER A  WHERE PN_CODE = ? ";
        try {

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            //--
            pstm.setString(1, code);
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = new PartnerManager();
                result.setId(rs.getInt("ID"));
                result.setParentId(rs.getInt("PARENT_ID"));
                result.setName(rs.getString("NAME"));
                result.setDesc(rs.getString("PN_DESC"));
                result.setCode(rs.getString("PN_CODE"));
                result.setAddress(rs.getString("ADDRESS"));
                result.setPhone(rs.getString("PHONE"));
                result.setEmail(rs.getString("EMAIL"));
                result.setBusinessCode(rs.getString("BUSINESS_CODE"));
                result.setBankAcc(rs.getString("BANK_ACC"));
                result.setBankAdd(rs.getString("BANK_ADD"));
                result.setManager(rs.getString("MANAGER"));
                result.setLastUpdate(rs.getTimestamp("LAST_UPDATE"));
                result.setDel(rs.getBoolean("IS_DEL"));
                result.setStatus(rs.getInt("STATUS"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean del(int id) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE PARTNER_MANAGER SET STATUS = 404 WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            result = pstm.executeUpdate() == 1;
            if (result) {
                reload();
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean del_ever(int id) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "DELETE FROM PARTNER_MANAGER WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            result = pstm.executeUpdate() == 1;
            if (result) {
                reload();
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
    
    //--
    int id;
    int parentId;
    String name;
    String desc;
    String code;
    String address;
    String phone;
    String email;
    String businessCode;
    String bankAcc;
    String bankAdd;
    String manager;
    Timestamp lastUpdate;
    boolean del;
    int status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Timestamp getLastUpdate() {
        return lastUpdate;
    }

    public void setLastUpdate(Timestamp lastUpdate) {
        this.lastUpdate = lastUpdate;
    }

    public boolean isDel() {
        return del;
    }

    public void setDel(boolean del) {
        this.del = del;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getBusinessCode() {
        return businessCode;
    }

    public void setBusinessCode(String businessCode) {
        this.businessCode = businessCode;
    }

    public String getBankAcc() {
        return bankAcc;
    }

    public void setBankAcc(String bankAcc) {
        this.bankAcc = bankAcc;
    }

    public String getBankAdd() {
        return bankAdd;
    }

    public void setBankAdd(String bankAdd) {
        this.bankAdd = bankAdd;
    }

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

}
