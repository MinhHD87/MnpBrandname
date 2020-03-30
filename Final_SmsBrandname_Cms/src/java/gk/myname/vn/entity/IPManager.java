/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.Tool;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.log4j.Logger;

/**
 *
 * @author PHAM TUAN
 */
public class IPManager {

    static final Logger logger = Logger.getLogger(IPManager.class);

    public ArrayList<IPManager> getAll(int currentPage, int max, String user, String ip, int port, int type) {
        ArrayList<IPManager> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM ip_manager WHERE 1=1 ";
        try {
            if (!Tool.checkNull(user)) {
                sql += " AND USER_SENDER = ?";
            }
            if (!Tool.checkNull(ip)) {
                sql += " AND IP_REQUEST = ?";
            }
            if (port != 0) {
                sql += " AND PORT_REQUEST = ?";
            }
            if (type != -1) {
                sql += " AND TYPE = ?";
            }
            sql += " ORDER BY ID DESC LIMIT ?,?";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(user)) {
                pstm.setString(i++, user);
            }
            if (!Tool.checkNull(ip)) {
                pstm.setString(i++, ip);
            }
            if (port != 0) {
                pstm.setInt(i++, port);
            }
            if (type != -1) {
                pstm.setInt(i++, type);
            }
            pstm.setInt(i++, (currentPage - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                IPManager one = new IPManager();
                one.setId(rs.getInt("ID"));
                one.setUserSender(rs.getString("USER_SENDER"));
                one.setDesc(rs.getString("DESC"));
                one.setIpRequest(rs.getString("IP_REQUEST"));
                one.setPortRequest(rs.getInt("PORT_REQUEST"));
                one.setCreateDate(rs.getDate("CREATE_DATE"));
                one.setCreateBy(rs.getString("CREATE_BY"));
                one.setUpdateDate(rs.getDate("UPDATE_DATE"));
                one.setUpdateBy(rs.getString("UPDATE_BY"));
                one.setType(rs.getInt("TYPE"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public int countAll(String user, String ip, int port, int type) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT COUNT(*) FROM ip_manager WHERE 1=1 ";
        try {
            if (!Tool.checkNull(user)) {
                sql += " AND USER_SENDER = ?";
            }
            if (!Tool.checkNull(ip)) {
                sql += " AND IP_REQUEST = ?";
            }
            if (port != 0) {
                sql += " AND PORT_REQUEST = ?";
            }
            if (type != -1) {
                sql += " AND TYPE = ?";
            }
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(user)) {
                pstm.setString(i++, user);
            }
            if (!Tool.checkNull(ip)) {
                pstm.setString(i++, ip);
            }
            if (port != 0) {
                pstm.setInt(i++, port);
            }
            if (type != -1) {
                pstm.setInt(i++, type);
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

    public IPManager getById(int id) {
        IPManager result = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM ip_manager WHERE ID = ?";
        try {

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = new IPManager();
                result.setId(rs.getInt("ID"));
                result.setUserSender(rs.getString("USER_SENDER"));
                result.setDesc(rs.getString("DESC"));
                result.setIpRequest(rs.getString("IP_REQUEST"));
                result.setPortRequest(rs.getInt("PORT_REQUEST"));
                result.setCreateDate(rs.getDate("CREATE_DATE"));
                result.setCreateBy(rs.getString("CREATE_BY"));
                result.setUpdateDate(rs.getDate("UPDATE_DATE"));
                result.setUpdateBy(rs.getString("UPDATE_BY"));
                result.setType(rs.getInt("TYPE"));
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean addNew(IPManager one) {
        boolean result = Boolean.FALSE;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT IGNORE INTO ip_manager(USER_SENDER,`DESC`,IP_REQUEST,PORT_REQUEST,CREATE_DATE,CREATE_BY,UPDATE_DATE,UPDATE_BY,TYPE)"
                + "                   VALUES(    ?      , ?  ,   ?      ,     ?      ,    NOW()  ,   ?     ,     ?     ,   ?     ,  ? )";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, one.getUserSender());
            pstm.setString(i++, one.getDesc());
            pstm.setString(i++, one.getIpRequest());
            pstm.setInt(i++, one.getPortRequest());
            pstm.setString(i++, one.getCreateBy());
            pstm.setDate(i++, one.getUpdateDate());
            pstm.setString(i++, one.getUpdateBy());
            pstm.setInt(i++, one.getType());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean update(IPManager one) {
        boolean result = Boolean.FALSE;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE ip_manager SET `DESC` =?, UPDATE_DATE = NOW(), UPDATE_BY =?, TYPE =? WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, one.getDesc());
            pstm.setString(i++, one.getUpdateBy());
            pstm.setInt(i++, one.getType());
            pstm.setInt(i++, one.getId());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean delete(int id) {
        boolean result = Boolean.FALSE;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "DELETE FROM ip_manager WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public String executeAddIPCmd(String ip, int port) throws Exception {
        int result = doAddIPCmd(ip, port);
        HashMap<String, String> option = new HashMap<>();
        option.put("ip", ip);
        option.put("port", port + "");
        Tool.synFirewall("firewall", "add", option);
        if (result == 0) {
            return reloadFireWall();
        } else {
            return "false";
        }
    }

    private int doAddIPCmd(String ip, int port) {
        int iExitValue = 0;
        CommandLine executeAddIPCmd = new CommandLine("firewall-cmd");
        executeAddIPCmd.addArgument("--permanent");
        executeAddIPCmd.addArgument("--zone=public");
        executeAddIPCmd.addArgument("--add-rich-rule=\"\"rule family=ipv4 source address=" + ip + " port port=" + port + " protocol=tcp accept\"\"", false);
        DefaultExecutor oDefaultExecutor = new DefaultExecutor();
        oDefaultExecutor.setExitValue(0);
        try {
            iExitValue = oDefaultExecutor.execute(executeAddIPCmd);
        } catch (Exception e) {
            System.err.println("Execution failed.");
            e.printStackTrace();
        }
        return iExitValue;
    }

    public String executeRemoveIPCmd(String ip, int port) throws Exception {
        int remove = doRemoveIPCmd(ip, port);
        HashMap<String, String> option = new HashMap<>();
        option.put("ip", ip);
        option.put("port", port + "");
        Tool.synFirewall("firewall", "del", option);
        if (remove == 0) {
            return reloadFireWall();
        } else {
            return "false";
        }
    }

    private int doRemoveIPCmd(String ip, int port) {
        int iExitValue = 0;
        CommandLine executeAddIPCmd = new CommandLine("firewall-cmd");
        executeAddIPCmd.addArgument("--permanent");
        executeAddIPCmd.addArgument("--zone=public");
        executeAddIPCmd.addArgument("--remove-rich-rule=\"\"rule family=ipv4 source address=" + ip + " port port=" + port + " protocol=tcp accept\"\"", false);
        DefaultExecutor oDefaultExecutor = new DefaultExecutor();
        oDefaultExecutor.setExitValue(0);
        try {
            iExitValue = oDefaultExecutor.execute(executeAddIPCmd);
        } catch (Exception e) {
            System.err.println("Execution failed.");
            e.printStackTrace();
        }
        return iExitValue;
    }

    private String reloadFireWall() throws Exception {
        String cmd = "firewall-cmd --reload";
        return executeCommand(cmd);
    }

    public String checkFirewall() {
        String cmd = "firewall-cmd --list-rich-rules";
        return executeCommand(cmd);
    }
//    public void testPing() {
//        CommandLine commandLine = new CommandLine("firewall-cmd");
//        commandLine.addArgument("--permanent");
//        commandLine.addArgument("--zone=public");
//        commandLine.addArgument("--add-rich-rule=\"\"rule family=ipv4 source address=127.0.0.123/32 port port=1233 protocol=tcp accept\"\"", false);
//        DefaultExecutor oDefaultExecutor = new DefaultExecutor();
//        oDefaultExecutor.setExitValue(0);
//        try {
//            int iExitValue = oDefaultExecutor.execute(commandLine);
//            Tool.debug("iExitValue:" + iExitValue);
//        } catch (Exception e) {
//            System.err.println("Execution failed.");
//            e.printStackTrace();
//        }
//
//    }

    private String executeCommand(String command) {
//        Tool.debug("Execute Command:" + command);
        StringBuilder output = new StringBuilder();
        Process p;
        try {
            p = Runtime.getRuntime().exec(command);
//            int tmp = p.waitFor();
            p.waitFor();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    output.append(line + System.lineSeparator());
                }
                //Check result
//            int tmp = p.waitFor();
//            if (tmp == 0) {
//                System.out.println("executeCommand: Success!");
//            } else {
//                System.out.println("tmp:" + tmp);
//            }
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
//        Tool.debug("Execute Result:" + output.toString());
        return output.toString();
    }

    public boolean isReject() {
        return type == TYPE.REJECT.val;
    }

    public boolean isDeclare() {
        return type == TYPE.DECLARE.val;
    }

    public boolean isAccept() {
        return type == TYPE.ACCEPT.val;
    }

    public boolean isBlock() {
        return type == TYPE.BLOCK.val;
    }

    public static enum TYPE {

        REJECT(3, "REJECT"),
        DECLARE(2, "DECLARE"),
        ACCEPT(1, "ACCEPT"),
        BLOCK(0, "BLOCK"), //--
        ;

        public int val;
        public String desc;

        public static String getname(int val) {
            String result = "unKnow";
            for (TYPE one : TYPE.values()) {
                if (one.val == val) {
                    result = one.desc;
                    break;
                }
            }
            return result;
        }

        private TYPE(int val, String desc) {
            this.val = val;
            this.desc = desc;
        }
    }
    int id;
    String userSender;
    String desc;
    String ipRequest;
    int portRequest;
    Date createDate;
    String createBy;
    Date updateDate;
    String updateBy;
    int type;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserSender() {
        return userSender;
    }

    public void setUserSender(String userSender) {
        this.userSender = userSender;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getIpRequest() {
        return ipRequest;
    }

    public void setIpRequest(String ipRequest) {
        this.ipRequest = ipRequest;
    }

    public int getPortRequest() {
        return portRequest;
    }

    public void setPortRequest(int portRequest) {
        this.portRequest = portRequest;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

}
