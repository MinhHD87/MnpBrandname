package gk.myname.vn.admin;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import org.apache.log4j.Logger;

public class LogAction extends Thread implements java.io.Serializable {

    public Logger logger = Logger.getLogger(LogAction.class);
    public static int VIEW_ACTION = 0;
    public static int ADD_ACTION = 1;
    public static int UPDATE_ACTION = 2;
    public static int DEL_ACTION = 3;
    //-------
    public static int ACTION_SUCCESS = 1;
    public static int ACTION_FALSE = 0;

    public LogAction() {
    }

    @Override
    public void run() {
        try {
            sleep(2 * 1000);
            LogThread(this);
        } catch (Exception e) {
            logger.error("AdminLog [ERROR]: " + Tool.getLogMessage(e));
        }
    }

    private void LogThread(LogAction one) {
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO ADMIN_LOG(IP,TIME_ACTION,URL_ACTION,ADMIN_ID,TABLE_ACTION,ACTION,ACTION_ID,STATU)"
                + " VALUES( ?,   NOW()   ,    ?     ,   ?    ,     ?      ,   ?  ,    ?    ,?)";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, one.getIp());
            pstm.setString(i++, one.getUrlAction());
            pstm.setLong(i++, one.getAdminID());
            pstm.setString(i++, one.getTableAction());
            pstm.setInt(i++, one.getAction());
            pstm.setLong(i++, one.getActionID());
            pstm.setInt(i++, one.getStatus());
            pstm.execute();
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
    }

    public void LogNomal(LogAction log) {
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO ADMIN_LOG(IP,TIME_ACTION,URL_ACTION,ADMIN_ID,TABLE_ACTION,ACTION,ACTION_ID,STATUS)"
                + " VALUES( ?,   NOW()   ,    ?     ,   ?    ,     ?      ,   ?  ,    ?    ,   ?)";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, log.getIp());
            pstm.setString(i++, log.getUrlAction());
            pstm.setLong(i++, log.getAdminID());
            pstm.setString(i++, log.getTableAction());
            pstm.setInt(i++, log.getAction());
            pstm.setLong(i++, log.getActionID());
            pstm.setInt(i++, log.getStatus());
            pstm.execute();
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
    }
    //----
    private long logId;
    private String ip;
    private Timestamp timeAction;
    private String urlAction;
    private long adminID;
    private String tableAction;
    private int action;
    private long actionID;   // ID cua noi dung Action
    private int status;     // 1 Success    0: false

    public LogAction(String ip, String urlAction, long adminID, String tableAction, int action, long actionID, int status) {
        this.ip = ip;
        this.urlAction = urlAction;
        this.adminID = adminID;
        this.tableAction = tableAction;
        this.action = action;
        this.actionID = actionID;
        this.status = status;
        Thread t = new Thread(this);
        t.start();
    }

    public long getLogId() {
        return logId;
    }

    public void setLogId(long logId) {
        this.logId = logId;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public Timestamp getTimeAction() {
        return timeAction;
    }

    public void setTimeAction(Timestamp timeAction) {
        this.timeAction = timeAction;
    }

    public String getUrlAction() {
        return urlAction;
    }

    public void setUrlAction(String urlAction) {
        this.urlAction = urlAction;
    }

    public long getAdminID() {
        return adminID;
    }

    public void setAdminID(long adminID) {
        this.adminID = adminID;
    }

    public String getTableAction() {
        return tableAction;
    }

    public void setTableAction(String tableAction) {
        this.tableAction = tableAction;
    }

    public int getAction() {
        return action;
    }

    public void setAction(int action) {
        this.action = action;
    }

    public long getActionID() {
        return actionID;
    }

    public void setActionID(long actionID) {
        this.actionID = actionID;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
