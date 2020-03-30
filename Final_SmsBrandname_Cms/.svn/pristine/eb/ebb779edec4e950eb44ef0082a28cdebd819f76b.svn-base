package gk.myname.vn.admin;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.entity.Provider_Telco;
import gk.myname.vn.utils.Md5;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

public class Account {

    static final Logger logger = Logger.getLogger(Account.class);
    public static final HashMap<Integer, Account> CACHE = new HashMap<>();
    public static final boolean debugRight = true;

    static {
        try {
            Account dao = new Account();
            ArrayList<Account> cache = dao.getAllAccount();
            for (Account one : cache) {
                CACHE.put(one.getAccID(), one);
            }
        } catch (Exception e) {
            System.out.println("Error when initialize : " + e);
        }
    }

    /**
     * Chi Lay ra Dai Ly Va Quan Ly Dai Ly
     *
     * @return
     */
    public static ArrayList<Account> getCPAgentcy() {
        synchronized (CACHE) {
            ArrayList<Account> result = new ArrayList<>();
            Collection<Account> all = CACHE.values();
            for (Account one : all) {
                if (one.getUserType() == TYPE.AGENCY.val || one.getUserType() == TYPE.AGENCY_MANAGER.val) {
                    result.add(one);
                }
            }
            CACHE.notifyAll();
            return result;
        }
    }

    public static ArrayList<Account> getAllCP() {
        synchronized (CACHE) {
            ArrayList<Account> result = new ArrayList<>();
            Collection<Account> all = CACHE.values();
            for (Account one : all) {
                if (one.getUserType() == TYPE.AGENCY.val || one.getUserType() == TYPE.USER.val) {
                    result.add(one);
                }
            }
            CACHE.notifyAll();
            return result;
        }
    }

    public static ArrayList<Account> getCPAgentcy(int parentId) {
        synchronized (CACHE) {
            ArrayList<Account> result = new ArrayList<>();
            Collection<Account> all = CACHE.values();
            Account owner = Account.getAccount(parentId);
            result.add(owner);
            for (Account one : all) {
                if (one.getUserType() == TYPE.AGENCY.val && one.getParentId() == parentId) {
                    result.add(one);
                }
            }
            CACHE.notifyAll();
            return result;
        }
    }

    public static void outerReload() {
        reload();
    }

    private static void reload() {
        synchronized (CACHE) {
            Account dao = new Account();
            ArrayList<Account> cache = dao.getAllAccount(null);
            CACHE.clear();
            for (Account one : cache) {
                CACHE.put(one.getAccID(), one);
            }
            CACHE.notifyAll();
        }
    }

    public static ArrayList<Account> getSubUserByCPCode(String cp_code) {
        synchronized (CACHE) {
            ArrayList<Account> listUser = new ArrayList<>();
            Collection<Account> coll = CACHE.values();
            for (Account one : coll) {
                // Thang nao co ParentId = thang dua vao thi lay ra ID cua no
                if (Tool.checkNull(one.getCpCode())) {
                    continue;
                }
                if (one.getCpCode().equals(cp_code) || one.getCpCode().startsWith(cp_code + "_")) {
                    listUser.add(one);
                }
            }
            CACHE.notifyAll();
            return listUser;
        }
    }

    public static String geFulltNameById(int id) {
        synchronized (CACHE) {
            Account one = CACHE.get(id);
            if (one != null) {
                return one.getFullName();
            } else {
                return "";
            }
        }
    }

    public static Account getAccount(int id) {
        synchronized (CACHE) {
            return CACHE.get(id);
        }
    }

    public static Account getAccount(String user) {
        synchronized (CACHE) {
            Account result = null;
            Collection<Account> coll = CACHE.values();
            for (Account one : coll) {
                if (one.getUserName().equals(user)) {
                    result = one;
                    break;
                }
            }
            CACHE.notifyAll();
            return result;
        }
    }


    public static boolean checkAccountExist(String user) {
        boolean result = false;
        synchronized (CACHE) {
            Collection<Account> coll = CACHE.values();
            for (Account one : coll) {
                if (one.getUserName().equals(user)) {
                    result = true;
                    break;
                }
            }
            CACHE.notifyAll();
            return result;
        }
    }

    public static Account getParent(int pid) {
        synchronized (CACHE) {
            Account result = null;
            Collection<Account> coll = CACHE.values();
            for (Account one : coll) {
                if (one.getAccID() == pid) {
                    result = one;
                    break;
                }
            }
            CACHE.notifyAll();
            return result;
        }
    }

    public static Account getAccount(HttpSession session) {
        Account acc = null;
        try {
            acc = (Account) session.getAttribute("userlogin");
            if (acc != null) {
                // Lay Lai Doi tuong moi neu da bi Reload
                acc = getAccount(acc.getAccID());
            }
        } catch (Exception e) {
            logger.error("Account.getAccount:" + Tool.getLogMessage(e));
        }
        return acc;
    }

    public static int getIdByUserName(String user) {
        synchronized (CACHE) {
            int id = 0;
            Collection<Account> coll = CACHE.values();
            for (Account one : coll) {
                if (one.getUserName().equalsIgnoreCase(user)) {
                    id = one.getAccID();
                    break;
                }
            }
            CACHE.notifyAll();
            return id;
        }
    }

    public static boolean checkUserByCpCode(String code) {
        boolean result = false;
        synchronized (CACHE) {
            Collection<Account> coll = CACHE.values();
            for (Account one : coll) {
                if (Tool.checkNull(one.getCpCode())) {
                    continue;
                }
                if (one.getCpCode().equalsIgnoreCase(code)) {
                    result = true;
                    break;
                }
            }
            CACHE.notifyAll();
            return result;
        }
    }

    public static String getNameById(int id) {
        synchronized (CACHE) {
            String name = "Unknow";
            Collection<Account> coll = CACHE.values();
            for (Account one : coll) {
                if (one.getAccID() == id) {
                    name = one.getUserName();
                    break;
                }
            }
            CACHE.notifyAll();
            return name;
        }
    }

    public static Account getCacheById(int id) {
        Account result = null;
        synchronized (CACHE) {
            Collection<Account> coll = CACHE.values();
            for (Account one : coll) {
                if (one != null && one.getAccID()== id) {
                    result = one;
                    break;
                }

            }
            CACHE.notifyAll();
            return result;
        }
    }

    public boolean addNew(Account oneAcc) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String querySQl = "INSERT INTO ACCOUNTS(PARENT_ID,USERNAME,PASSWORD,FULL_NAME,DESCRIPTION,ADDRESS,PHONE,EMAIL,MaxBrand,CREATE_DATE,CREATE_BY,UPDATE_DATE,UPDATE_BY,USER_TYPE,STATUS,IP_ALLOW,PHONE_SEND,PASS_SEND,CP_CODE,TPS,ADDRESS_RANGE,METHOD,CREATE_ROLE) "
                + "                      VALUES(    ?    ,    ?   ,    ?   ,     ?   ,       ?   ,  ?    ,  ?  ,   ? ,   ?    ,   NOW()   ,    ?    ,   NOW()   ,    ?    ,   ?     ,   ?  ,   ?    ,     ?    ,    ?    ,   ?   , ? ,      ?      ,   ?  ,   ?    )";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(querySQl);
            int i = 1;
            pstm.setInt(i++, oneAcc.getParentId());
            pstm.setString(i++, oneAcc.getUserName());
            pstm.setString(i++, Md5.encryptMD5(oneAcc.getPassWord()));
            pstm.setString(i++, oneAcc.getFullName());
            pstm.setString(i++, oneAcc.getDescription());
            pstm.setString(i++, oneAcc.getAddress());
            pstm.setString(i++, oneAcc.getPhone());
            pstm.setString(i++, oneAcc.getEmail());
            pstm.setInt(i++, oneAcc.getMaxBrand());
            pstm.setString(i++, oneAcc.getCreateBy());
            pstm.setString(i++, oneAcc.getUpdateBy());
            pstm.setInt(i++, oneAcc.getUserType());
            pstm.setInt(i++, oneAcc.getStatus());
            pstm.setString(i++, oneAcc.getIp_Allow());
            pstm.setString(i++, oneAcc.getPhone_Send());
            pstm.setString(i++, oneAcc.getPassSend());
            pstm.setString(i++, oneAcc.getCpCode());
            pstm.setInt(i++, oneAcc.getTps());
            pstm.setString(i++, oneAcc.getAddressRange());
            pstm.setString(i++, oneAcc.getMethod());
            pstm.setString(i++, oneAcc.getRole().toJson());
            if (pstm.executeUpdate() == 1) {
                reload();
                HashMap<String, String> option = new HashMap<>();
                option.put("user", oneAcc.getUserName());
                Tool.reload("loadAcc", "add", option);
                ok = true;
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return ok;
    }

    public boolean update(Account accUpdate) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "UPDATE ACCOUNTS SET PARENT_ID = ?, USERNAME = ?,";
        if (!Tool.checkNull(accUpdate.getPassWord())) {
            sql += "PASSWORD = ?,";
        }
        if (!Tool.checkNull(accUpdate.getPassSend())) {
            sql += "PASS_SEND = ?,";
        }
        sql += "FULL_NAME = ?,"
                + "DESCRIPTION = ?,"
                + "ADDRESS = ?,"
                + "PHONE = ?,"
                + "EMAIL = ?,"
                + "MaxBrand=?"
                + ",UPDATE_DATE = NOW(),UPDATE_BY = ?,"
                + "USER_TYPE = ?,"
                + "STATUS=?,"
                + "IP_ALLOW=?,"
                + "PHONE_SEND=?,"
                //+ "CP_CODE = ?,"
                + "TPS = ?,"
                + "ADDRESS_RANGE =?,"
                + "METHOD =?,"
                + "CREATE_ROLE = ? "
                + " where ACC_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, accUpdate.getParentId());
            pstm.setString(i++, accUpdate.getUserName());
            if (!Tool.checkNull(accUpdate.getPassWord())) {
                pstm.setString(i++, Md5.encryptMD5(accUpdate.getPassWord()));
            }
            if (!Tool.checkNull(accUpdate.getPassSend())) {
                pstm.setString(i++, accUpdate.getPassSend());
            }
            pstm.setString(i++, accUpdate.getFullName());
            pstm.setString(i++, accUpdate.getDescription());
            pstm.setString(i++, accUpdate.getAddress());
            pstm.setString(i++, accUpdate.getPhone());
            pstm.setString(i++, accUpdate.getEmail());
            pstm.setInt(i++, accUpdate.getMaxBrand());
            pstm.setString(i++, accUpdate.getUpdateBy());
            pstm.setInt(i++, accUpdate.getUserType());
            pstm.setInt(i++, accUpdate.getStatus());
            pstm.setString(i++, accUpdate.getIp_Allow());
            pstm.setString(i++, accUpdate.getPhone_Send());
            //pstm.setString(i++, accUpdate.getCpCode());
            pstm.setInt(i++, accUpdate.getTps());
            pstm.setString(i++, accUpdate.getAddressRange());
            pstm.setString(i++, accUpdate.getMethod());
            pstm.setString(i++, accUpdate.getRole().toJson());
            pstm.setInt(i++, accUpdate.getAccID());
            if (pstm.executeUpdate() == 1) {
                reload();
                flag = true;
                HashMap<String, String> option = new HashMap<>();
                option.put("id", accUpdate.getAccID() + "");
                Tool.reload("loadAcc", "update", option);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(null, pstm, conn);
        }
        return flag;
    }

    public boolean lockLogin(AccountRole role, int id) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "UPDATE ACCOUNTS SET CREATE_ROLE = ?  where ACC_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, role.toJson());
            pstm.setInt(i++, id);
            if (pstm.executeUpdate() == 1) {
                reload();
                flag = true;
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(null, pstm, conn);
        }
        return flag;
    }

    public boolean updatePass(int id, String newpass) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "update ACCOUNTS set PASSWORD = ? WHERE ACC_ID = ?";
        newpass = Md5.encryptMD5(newpass);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, newpass);
            pstm.setInt(2, id);
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

    public boolean updateQuata(int id, int quata) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "UPDATE ACCOUNTS set MaxBrand = ? WHERE ACC_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, quata);
            pstm.setInt(2, id);
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

    public boolean delete(int accID) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "DELETE FROM  ACCOUNTS WHERE ACC_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, accID);
            if (pstm.executeUpdate() == 1) {
                reload();
                ok = true;
                HashMap<String, String> option = new HashMap<>();
                option.put("id", accID + "");
                Tool.reload("loadAcc", "del", option);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(null, pstm, conn);
        }
        return ok;
    }

    public boolean deleteBlock(int accID) {
        boolean ok = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        String sql = "UPDATE  ACCOUNTS SET STATUS = ? WHERE ACC_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, STATUS.DEL.val);
            pstm.setInt(2, accID);
            if (pstm.executeUpdate() == 1) {
                reload();
                ok = true;
                HashMap<String, String> option = new HashMap<>();
                option.put("id", accID + "");
                Tool.reload("loadAcc", "del", option);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(null, pstm, conn);
        }
        return ok;
    }

    public ArrayList<Account> getAllAccount(int type, String key) {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM ACCOUNTS WHERE USER_TYPE = ? ";
        if (!Tool.checkNull(key)) {
            sql += " AND( USERNAME like ? or FULL_NAME like ?) ";
        }
        sql += " ORDER BY ACC_ID DESC,STATUS DESC";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, type);
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
            }

            rs = pstm.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
                acc.setPassWord(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MaxBrand"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                all.add(acc);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public ArrayList<Account> getAllByCp_Code(String key) {
        ArrayList<Account> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM ACCOUNTS WHERE 1 = 1 ";
        if (!Tool.checkNull(key)) {
            sql += " AND CP_CODE like ? ";
        }
        sql += " ORDER BY ACC_ID DESC,STATUS DESC";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
            }

            rs = pstm.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
                acc.setPassWord(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MaxBrand"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                all.add(acc);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public ArrayList<Account> getAllUser(int page, int max, String key) {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM ACCOUNTS A WHERE USER_TYPE = ? ";
        if (!Tool.checkNull(key)) {
            sql += " AND (USERNAME like ?  OR FULL_NAME like ?)";
        }
        sql += " ORDER BY A.ACC_ID DESC LIMIT ?,?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, TYPE.USER.val);
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
                acc.setPassWord(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MaxBrand"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                all.add(acc);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public ArrayList<Account> getAllUserWithStatus(int page, int max, String key, int status) {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM ACCOUNTS A WHERE USER_TYPE = ? ";
        if (!Tool.checkNull(key)) {
            sql += " AND (USERNAME like ?  OR FULL_NAME like ?)";
        }
        if (!Tool.checkNull(status)) {
            sql += " AND STATUS = ?";
        }
        sql += " ORDER BY A.ACC_ID DESC LIMIT ?,?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, TYPE.USER.val);
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
            }
            if (!Tool.checkNull(status)) {
                pstm.setInt(i++, status);
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
                acc.setPassWord(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MaxBrand"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                all.add(acc);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public int countAllUser(String key) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM ACCOUNTS WHERE USER_TYPE = ? ";
        if (!Tool.checkNull(key)) {
            sql += " AND (USERNAME like ?  OR FULL_NAME like ?)";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, TYPE.USER.val);
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public int countAllUserAndStatus(String key,int status) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM ACCOUNTS WHERE USER_TYPE = ? ";
        if (!Tool.checkNull(key)) {
            sql += " AND (USERNAME like ?  OR FULL_NAME like ?)";
        }
        if (!Tool.checkNull(status)) {
            sql += " AND STATUS = ?";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, TYPE.USER.val);
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
            }
            if (!Tool.checkNull(status)) {
                pstm.setInt(i++, status);
            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public ArrayList<Account> getAllAgentcy(int page, int max, String key, int status) {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM ACCOUNTS A "
                + "WHERE (USER_TYPE = ? OR USER_TYPE = ?)";
        if (status == -2) {
            sql += " AND STATUS !=404";
        } else {
            sql += " AND STATUS = ?";
        }
        if (!Tool.checkNull(key)) {
            sql += " AND (USERNAME like ?  OR FULL_NAME like ? OR CP_CODE = ?)";
        }
        sql += " ORDER BY A.ACC_ID DESC LIMIT ?,?";
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, TYPE.AGENCY.val);
            pstm.setInt(i++, TYPE.AGENCY_MANAGER.val);
            if (status != -2) {
                pstm.setInt(i++, status);
            }
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, key);
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
                acc.setPassWord(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MaxBrand"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                all.add(acc);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public int countAllAgentcy(String key, int status) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM ACCOUNTS WHERE (USER_TYPE = ? OR USER_TYPE = ?) ";
        if (status == -2) {
            sql += " AND STATUS !=404";
        } else {
            sql += " AND STATUS = ?";
        }
        if (!Tool.checkNull(key)) {
            sql += " AND (USERNAME like ?  OR FULL_NAME like ? OR CP_CODE = ?)";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, TYPE.AGENCY.val);
            pstm.setInt(i++, TYPE.AGENCY_MANAGER.val);
            if (status != -2) {
                pstm.setInt(i++, status);
            }
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, key);
            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public ArrayList<Account> getSubAccount(int page, int max, String cp_code, String key, int status) {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM ACCOUNTS A WHERE STATUS !=404 AND USER_TYPE = ? ";
        if (!Tool.checkNull(cp_code)) {
            sql += " AND CP_CODE = ? ";
        }
        if (!Tool.checkNull(key)) {
            sql += " AND (USERNAME like ?  OR FULL_NAME like ? OR CP_CODE = ?)";
        }
        if (status != -2) {
            if (status == 1) {
                sql += " AND CREATE_ROLE like '%\"lockLogin\":false%' ";
            } else {
                sql += " AND CREATE_ROLE like '%\"lockLogin\":true%' ";
            }
        }
        sql += " ORDER BY A.ACC_ID DESC LIMIT ?,?";
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, TYPE.USER.val);
            pstm.setString(i++, cp_code);
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, key);
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MaxBrand"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                all.add(acc);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public int countSubAccount(String cp_code, String key, int status) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM ACCOUNTS WHERE STATUS !=404 AND USER_TYPE = ? ";
        if (!Tool.checkNull(cp_code)) {
            sql += " AND CP_CODE = ? ";
        }
        if (!Tool.checkNull(key)) {
            sql += " AND (USERNAME like ?  OR FULL_NAME like ? OR CP_CODE = ?)";
        }
        if (status != -2) {
            if (status == 1) {
                sql += " AND CREATE_ROLE like '%\"lockLogin\":false%' ";
            } else {
                sql += " AND CREATE_ROLE like '%\"lockLogin\":true%' ";
            }
        }
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, TYPE.USER.val);
            pstm.setString(i++, cp_code);
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, key);
            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public ArrayList<Account> getKHAccount() {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM ACCOUNTS A WHERE STATUS != 404 AND USER_TYPE !=1 ";
        sql += " ORDER BY A.ACC_ID DESC";
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MaxBrand"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                all.add(acc);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public ArrayList<Account> getAgentAccount(int page, int max, String cp_code, String key, int status) {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM ACCOUNTS A WHERE STATUS != 404 AND USER_TYPE = ? ";
        if (!Tool.checkNull(cp_code)) {
            sql += " AND (CP_CODE like ? OR CP_CODE = ?)";
        }
        if (!Tool.checkNull(key)) {
            sql += " AND (USERNAME like ?  OR FULL_NAME like ? OR CP_CODE = ?)";
        }
        if (status != -2) {
            if (status == 1) {
                sql += " AND CREATE_ROLE like '%\"lockLogin\":false%' ";
            } else {
                sql += " AND CREATE_ROLE like '%\"lockLogin\":true%' ";
            }
        }
        sql += " ORDER BY A.ACC_ID DESC LIMIT ?,?";
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, TYPE.AGENCY.val);
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, cp_code + "_%");
                pstm.setString(i++, cp_code);
            }
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, key);
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MaxBrand"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                all.add(acc);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public int countAgentAccount(String cp_code, String key, int status) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM ACCOUNTS WHERE STATUS != 404 AND USER_TYPE = ? ";
        if (!Tool.checkNull(cp_code)) {
            sql += " AND (CP_CODE like ? OR CP_CODE = ?)";
        }
        if (!Tool.checkNull(key)) {
            sql += " AND (USERNAME like ?  OR FULL_NAME like ? OR CP_CODE = ?)";
        }
        if (status != -2) {
            if (status == 1) {
                sql += " AND CREATE_ROLE like '%\"lockLogin\":false%' ";
            } else {
                sql += " AND CREATE_ROLE like '%\"lockLogin\":true%' ";
            }
        }
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, TYPE.AGENCY.val);
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, cp_code + "_%");
                pstm.setString(i++, cp_code);
            }
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, key);
            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public ArrayList<Account> getAllAccount(String key) {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM ACCOUNTS WHERE 1=1 ";
        if (!Tool.checkNull(key)) {
            sql += " AND( USERNAME like ? or FULL_NAME like ?) ";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(key)) {
                pstm.setString(i++, "%" + key + "%");
                pstm.setString(i++, "%" + key + "%");
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
                acc.setPassWord(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MaxBrand"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                all.add(acc);
                acc.setPermission();
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public ArrayList<Account> getAllAccount() {
        ArrayList all = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM ACCOUNTS ";

        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
                acc.setPassWord(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MaxBrand"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                all.add(acc);
                acc.setPermission();
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    
    //PHONG GET CP_CODE
    public static String getCpCode(String user) {
        String cp = "";

        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT cp_code FROM ACCOUNTS WHERE username = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, user);
            rs = pstm.executeQuery();
            if (rs.next()) {
                cp = rs.getString("cp_code");
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }

        return cp;
    }

    public static Account getDaiLy(String code) {
        Account acc = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM ACCOUNTS WHERE CP_CODE = ? AND USER_TYPE = 2";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, code);
            rs = pstm.executeQuery();
            if (rs.next()) {
                acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
                acc.setPassWord(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MaxBrand"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                acc.setPermission();
                acc.setSell_price(rs.getString("SELL_PRICE"));
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }

        return acc;
    }

    public Account getByID(int accID) {
        Account acc = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM ACCOUNTS  WHERE ACC_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, accID);
            rs = pstm.executeQuery();
            if (rs.next()) {
                acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
                acc.setPassWord(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MaxBrand"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                acc.setPermission();
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return acc;
    }

    public Account checkLoginUerPasMd5(String userName, String passwordEncript) {
        Account acc = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM ACCOUNTS  WHERE upper(USERNAME) = upper(?) AND PASSWORD = ? AND STATUS = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, userName);
            pstm.setString(2, passwordEncript);
            pstm.setInt(3, STATUS.ACTIVE.val);
            rs = pstm.executeQuery();
            if (rs.next()) {
                acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
                acc.setPassWord(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MaxBrand"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                acc.setPermission();
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return acc;
    }

    public Account checkLogin(String userName, String password) {
        Account acc = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM ACCOUNTS  WHERE upper(USERNAME) = upper(?) AND PASSWORD = ? AND STATUS = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, userName);
            pstm.setString(2, Md5.encryptMD5(password));
            pstm.setInt(3, STATUS.ACTIVE.val);
            rs = pstm.executeQuery();
            if (rs.next()) {
                acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
//                acc.setPassWord(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MAXBRAND"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                acc.setPermission();
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return acc;
    }

    public Account checkLoginUser(String userName, String password) {
        Account acc = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM ACCOUNTS  WHERE upper(USERNAME) = upper(?) AND PASSWORD = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, userName);
            pstm.setString(2, Md5.encryptMD5(password));
            rs = pstm.executeQuery();
            if (rs.next()) {
                acc = new Account();
                acc.setAccID(rs.getInt("ACC_ID"));
                acc.setParentId(rs.getInt("PARENT_ID"));
                acc.setUserName(rs.getString("USERNAME"));
//                acc.setPassWord(rs.getString("PASSWORD"));
                acc.setFullName(rs.getString("FULL_NAME"));
                acc.setDescription(rs.getString("DESCRIPTION"));
                acc.setAddress(rs.getString("ADDRESS"));
                acc.setPhone(rs.getString("PHONE"));
                acc.setEmail(rs.getString("EMAIL"));
                acc.setMaxBrand(rs.getInt("MAXBRAND"));
                acc.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                acc.setCreateBy(rs.getString("CREATE_BY"));
                acc.setUpdateDate(rs.getTimestamp("UPDATE_DATE"));
                acc.setUpdateBy(rs.getString("UPDATE_BY"));
                acc.setUserType(rs.getInt("USER_TYPE"));
                acc.setStatus(rs.getInt("STATUS"));
                acc.setIp_Allow(rs.getString("IP_ALLOW"));
                acc.setPhone_Send(rs.getString("PHONE_SEND"));
                acc.setPassSend(rs.getString("PASS_SEND"));
                acc.setCpCode(rs.getString("CP_CODE"));
                acc.setTps(rs.getInt("TPS"));
                acc.setAddressRange(rs.getString("ADDRESS_RANGE"));
                acc.setMethod(rs.getString("METHOD"));
                String strRole = rs.getString("CREATE_ROLE");
                AccountRole _role = AccountRole.json2Objec(strRole);
                acc.setRole(_role);
                acc.setPermission();
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return acc;
    }

    public boolean checkRight(String uri, int per) {
        boolean right = false;
        // Lay ra modul dang truy xuat
        int moduleId = Modules.getModuleID(uri);
        for (Permission one : permission) {
            // Duyet qua tat ca cac Quyen cua nguoi dung
            if (one.getModelId() == moduleId) {
                // Lay duoc module khop
                if (one.isSpecial()) {
                    return one.isSpecial();
                } else if (per == Permission.PER.VIEW.val) {
                    return one.isView();
                } else if (per == Permission.PER.ADD.val) {
                    return one.isAdd();
                } else if (per == Permission.PER.EDIT.val) {
                    return one.isEdit();
                } else if (per == Permission.PER.DEL.val) {
                    return one.isDel();
                }
                break;
            }
        }
        return right || debugRight;
    }

    public boolean checkView(HttpServletRequest request) {
        boolean right = false;
        String uri = Tool.getURI(request);
        // Lay ra modul dang truy xuat
        int moduleId = Modules.getModuleID(uri);
        for (Permission one : permission) {
            // Duyet qua tat ca cac Quyen cua nguoi dung
            if (one.getModelId() == moduleId) {
                // Lay duoc module khop
                if (one.isSpecial()) {
                    return one.isSpecial();
                } else {
                    return one.isView();
                }
            }
        }
        return right || debugRight;
    }

    public boolean checkViewShort(HttpServletRequest request) {
        boolean right = false;
        String uri = Tool.getURI(request);
        // Lay ra modul dang truy xuat
        int moduleId = Modules.getModuleID(uri);
        for (Permission one : permission) {
            // Duyet qua tat ca cac Quyen cua nguoi dung
            if (one.getModelId() == moduleId) {
                // Lay duoc module khop
                if (one.isSpecial()) {
                    return one.isSpecial();
                } else {
                    return one.isViewShort();
                }
            }
        }
        return right || debugRight;
    }

    public boolean checkAdd(HttpServletRequest request) {
        boolean right = false;
        String uri = Tool.getURI(request);
        // Lay ra modul dang truy xuat
        int moduleId = Modules.getModuleID(uri);
        for (Permission one : permission) {
            // Duyet qua tat ca cac Quyen cua nguoi dung
            if (one.getModelId() == moduleId) {
                // Lay duoc module khop
                if (one.isSpecial()) {
                    return one.isSpecial();
                } else {
                    return one.isAdd();
                }
            }
        }
        return right || debugRight;
    }

    public boolean checkEdit(HttpServletRequest request) {
        boolean right = false;
        String uri = Tool.getURI(request);
        // Lay ra modul dang truy xuat
        int moduleId = Modules.getModuleID(uri);
        for (Permission one : permission) {
            // Duyet qua tat ca cac Quyen cua nguoi dung
            if (one.getModelId() == moduleId) {
                // Lay duoc module khop
                if (one.isSpecial()) {
                    return one.isSpecial();
                } else {
                    return one.isEdit();
                }
            }
        }
        return right || debugRight;
    }

    public boolean checkDel(HttpServletRequest request) {
        boolean right = false;
        String uri = Tool.getURI(request);
        // Lay ra modul dang truy xuat
        int moduleId = Modules.getModuleID(uri);
        for (Permission one : permission) {
            // Duyet qua tat ca cac Quyen cua nguoi dung
            if (one.getModelId() == moduleId) {
                // Lay duoc module khop
                if (one.isSpecial()) {
                    return one.isSpecial();
                } else {
                    return one.isDel();
                }
            }
        }
        return right || debugRight;
    }

    public boolean checkUpload(HttpServletRequest request) {
        boolean right = false;
        String uri = Tool.getURI(request);
        // Lay ra modul dang truy xuat
        int moduleId = Modules.getModuleID(uri);
        for (Permission one : permission) {
            // Duyet qua tat ca cac Quyen cua nguoi dung
            if (one.getModelId() == moduleId) {
                // Lay duoc module khop
                if (one.isSpecial()) {
                    return one.isSpecial();
                } else {
                    return one.isUpload();
                }
            }
        }
        return right || debugRight;
    }

    //--
    private int accID;
    private int parentId;
    private String userName;
    private String passWord;
    private String fullName;
    private String description;
    private String address;
    private String phone;
    private String email;
    private int maxBrand;
    private Timestamp createDate;
    private String createBy;
    private Timestamp updateDate;
    private String updateBy;
    private int userType;
    private int status;
    String ip_Allow;
    String phone_Send;
    String passSend;
    String cpCode;
    private int tps;
    private String addressRange;
    private String method;
    private ArrayList<Permission> permission;
    private AccountRole role;

    public static enum STATUS {

        ACTIVE(1),
        LOCK(0),
        DEL(404);
        public int val;

        private STATUS(int val) {
            this.val = val;
        }
    }

    public static enum TYPE {

        USER(0, "Người dùng"), // Create Ads - Manager allow Createby Id                  USER
        ADMIN(1, "Quyền quản trị"), // ADMIN
        AGENCY(2, "Đại lý"), // Duoc phep ket noi gui Qua API  // TODO co nen cho tao tk con hay khong ??
        AGENCY_MANAGER(3, "Quản lý Đại lý") // Chi co quyen quan ly thong ke, khong duoc lam gi ca cao hon quyen user la duoc thong ke nhieu dai ly
        ;
        public int val;
        public String name;

        private TYPE(int val, String name) {
            this.val = val;
            this.name = name;
        }
    }

    public static String getTypeName(int type) {
        String name = "Ko có quyền";
        for (TYPE one : TYPE.values()) {
            if (type == one.val) {
                name = one.name;
                break;
            }
        }
        return name;
    }

    public AccountRole getRole() {
        if (role == null) {
            return new AccountRole();
        }
        return role;
    }

    public void setRole(AccountRole role) {
        this.role = role;
    }

    public ArrayList<Permission> getPermission() {
        return permission;
    }

    public void setPermission(ArrayList<Permission> permission) {
        this.permission = permission;
    }

    public void setPermission() {
        this.permission = new Permission().getRoleAccModule(accID);
    }

    public int getAccID() {
        return accID;
    }

    public void setAccID(int accID) {
        this.accID = accID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public int getMaxBrand() {
        return maxBrand;
    }

    public void setMaxBrand(int maxBrand) {
        this.maxBrand = maxBrand;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Timestamp getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Timestamp updateDate) {
        this.updateDate = updateDate;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getUserType() {
        return userType;
    }

    public void setUserType(int userType) {
        this.userType = userType;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public String getIp_Allow() {
        return ip_Allow;
    }

    public void setIp_Allow(String ip_Allow) {
        this.ip_Allow = ip_Allow;
    }

    public String getPhone_Send() {
        return phone_Send;
    }

    public void setPhone_Send(String phone_Send) {
        this.phone_Send = phone_Send;
    }

    public String getPassSend() {
        return passSend;
    }

    public void setPassSend(String passSend) {
        this.passSend = passSend;
    }

    public String getCpCode() {
        return cpCode;
    }

    public void setCpCode(String cpCode) {
        this.cpCode = cpCode;
    }

    public int getTps() {
        return tps;
    }

    public void setTps(int tps) {
        this.tps = tps;
    }

    public String getAddressRange() {
        return addressRange;
    }

    public void setAddressRange(String addressRange) {
        this.addressRange = addressRange;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    Provider_Telco telco;

    public Provider_Telco getSell_price() {
        return telco;
    }

    public void setSell_price(Provider_Telco telco) {
        this.telco = telco;
    }

    public void setSell_price(String strJson) {
        this.telco = Provider_Telco.json2Object(strJson);
    }
}
