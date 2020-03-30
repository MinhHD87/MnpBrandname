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
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

/**
 *
 * @author tuanp
 */
public class UserAction {

    static final Logger logger = Logger.getLogger(UserAction.class);

    public UserAction(String user, String table, String type, String result, String info) {
        this.userName = user;
        this.tableAction = table;
        this.actionType = type;
        this.result = result;
        this.info = info;
    }

    public void logAction(HttpServletRequest request) {
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO user_action(USER_NAME,USER_IP,URL_ACTION,TABLE_ACTION,ACTION_TYPE,ACTION_DATE,RESULT,INFO)"
                + "                    VALUES(   ?     ,   ?   ,    ?     ,     ?      ,     ?     ,   NOW()   ,  ?   ,  ? )";
        try {
            String url = Tool.getFullURL(request);
            String ip = Tool.getClientIpAddr(request);
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, userName);
            pstm.setString(i++, ip);
            pstm.setString(i++, url);
            pstm.setString(i++, tableAction);
            pstm.setString(i++, actionType);
            pstm.setString(i++, result);
            pstm.setString(i++, info);
            pstm.execute();
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
    }

    public enum TABLE {
        accounts("accounts"),
        brand_label("brand_label"),
        brand_label_declare("brand_label_declare"),
        campaign("campaign"),
        client("client"),
        config_db("config_db"),
        group_acc_detail("group_acc_detail"),
        group_account("group_account"),
        group_customer("group_customer"),
        group_permission("group_permission"),
        ip_declare("ip_declare"),
        ip_manager("ip_manager"),
        list_customer("list_customer"),
        modules("modules"),
        monitor_app("monitor_app"),
        msg_brand_customer("msg_brand_customer"),
        partner_manager("partner_manager"),
        provider("provider"),
        user_permission("user_permission"), //--
        phone_blacklist("phoneblacklist"), //--
        ;

        public String val;

        private TABLE(String val) {
            this.val = val;
        }
    }

    public enum TYPE {
        ADD("ADD"),
        EDIT("EDIT"),
        DEL("DEL"),
        LOGIN("LOGIN"),
        EXPORT("EXPORT"),
        UPLOAD("UPLOAD"), //--
        ;

        public String val;

        private TYPE(String val) {
            this.val = val;
        }
    }

    public enum RESULT {
        SUCCESS("SUCCESS"),
        FAIL("FAIL"),
        EXCEPTION("EXCEPTION"),
        REJECT("REJECT"),;

        public String val;

        private RESULT(String val) {
            this.val = val;
        }
    }

    int id;
    String userName;
    String ip;
    String urlAction;
    String tableAction;
    String actionType;
    Timestamp actionDate;
    String result;
    String info;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getUrlAction() {
        return urlAction;
    }

    public void setUrlAction(String urlAction) {
        this.urlAction = urlAction;
    }

    public String getTableAction() {
        return tableAction;
    }

    public void setTableAction(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    public Timestamp getActionDate() {
        return actionDate;
    }

    public void setActionDate(Timestamp actionDate) {
        this.actionDate = actionDate;
    }

}
