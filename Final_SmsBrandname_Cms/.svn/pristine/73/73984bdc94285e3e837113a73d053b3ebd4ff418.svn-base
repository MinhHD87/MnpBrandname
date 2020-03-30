/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.admin.Account;
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
public class MsgBrandCustomer {

    static final Logger logger = Logger.getLogger(MsgBrandCustomer.class);

    public static enum RESULT {

        SUCCESS(1),
        FAIL(0);
        public int val;

        private RESULT(int val) {
            this.val = val;
        }
    }

    public static int addQueueCustomer(ArrayList<String> listPhone, String message, String label, Account userlogin, int type, Timestamp timeSend) {
        int addNew = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO MSG_BRAND_CUSTOMER(PHONE,OPER,MESSAGE,LABEL,USER_SENDER,REQUEST_TIME,TYPE,RESULT,INFO,SCHEDULE_TIME)"
                + "                           VALUES( ?   , ?  ,   ?   ,  ?  ,    ?     ,     NOW()  , ?  ,   ?  ,  ? ,     ?       )";
        int maxQuata = userlogin.getMaxBrand();
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);

            for (String onePhone : listPhone) {
                String info = "";
                int result = 1;     // TODO = 1 se lay len de gui di nhe ....
                int i = 1;
                int totalMsg = 0;
                String oper = SMSUtils.buildMobileOperator(onePhone);
                if (type == BrandLabel.TYPE.CSKH.val) {
                    totalMsg = SMSUtils.countSmsBrandCSKH(message, oper);
                }
                if (type == BrandLabel.TYPE.QC.val) {
                    totalMsg = SMSUtils.countSmsBrandQC(message, oper);
                }
                if (totalMsg == SMSUtils.REJECT_MSG_LENG) {
                    result = 0;
                    info = "Invalid Message Leng max 459 charactor";
                }
                if (maxQuata - totalMsg < 0) {
                    // Khong du gio han
                    result = 0;
                    info = "Over Quata Send SMS";
                }
//                System.out.println("Result =" + result + "|info=" + info);
                try {
                    pstm.setString(i++, onePhone);
                    pstm.setString(i++, oper);
                    pstm.setString(i++, message);
                    pstm.setString(i++, label);
                    pstm.setString(i++, userlogin.getUserName());
                    pstm.setInt(i++, type);
                    pstm.setInt(i++, result);
                    pstm.setString(i++, info);
                    pstm.setTimestamp(i++, timeSend);
                    if (pstm.executeUpdate() == 1) {
                        addNew += 1;
                        if (result == 1) {// Dung thi moi tru tin
                            if (maxQuata - totalMsg >= 0) {
                                maxQuata = maxQuata - totalMsg;
                            }
                        }
                    }
                } catch (Exception e) {
//                    e.printStackTrace();
                    logger.error(Tool.getLogMessage(e));
                }
                pstm.clearParameters();
            }
        } catch (Exception e1) {
//            e1.printStackTrace();
            logger.error(Tool.getLogMessage(e1));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
            // Update lai Quata SMS cua User
            userlogin.setMaxBrand(maxQuata);
            userlogin.updateQuata(userlogin.getAccID(), maxQuata);
        }
        return addNew;
    }

    public static int addQueueCustomerMulti(ArrayList<SMSMultiContent> data, String label, Account userlogin, int type, Timestamp timeSend) {
        int addNew = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO MSG_BRAND_CUSTOMER(PHONE,OPER,MESSAGE,LABEL,USER_SENDER,REQUEST_TIME,TYPE,RESULT,INFO,SCHEDULE_TIME)"
                + "                           VALUES( ?   , ?  ,   ?   ,  ?  ,    ?      ,     NOW()  , ?  ,   ?  ,  ? ,     ?       )";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int maxQuata = userlogin.getMaxBrand();
            for (SMSMultiContent one : data) {
                String info = "";
                int result = 1;
                int i = 1;
                int totalMsg = 0;
                String oper = SMSUtils.buildMobileOperator(one.getPhone());
                if (type == BrandLabel.TYPE.CSKH.val) {
                    totalMsg = SMSUtils.countSmsBrandCSKH(one.getMess(), oper);
                }
                if (type == BrandLabel.TYPE.QC.val) {
                    totalMsg = SMSUtils.countSmsBrandQC(one.getMess(), oper);
                }
                if (totalMsg == SMSUtils.REJECT_MSG_LENG) {
                    result = 0;
                    info = "Invalid Message Leng max 459 charactor";
                }
                if (maxQuata - totalMsg < 0) {
                    // Khong du gio han
                    result = 0;
                    info = "Over Quata Send SMS";
                }
                try {
                    pstm.setString(i++, one.getPhone());
                    pstm.setString(i++, oper);
                    pstm.setString(i++, one.getMess());
                    pstm.setString(i++, label);
                    pstm.setString(i++, userlogin.getUserName());
                    pstm.setInt(i++, type);
                    pstm.setInt(i++, result);
                    pstm.setString(i++, info);
                    pstm.setTimestamp(i++, timeSend);
                    if (pstm.executeUpdate() == 1) {
                        addNew += 1;
                        if (result == 1) {// Dung thi moi tru tin
                            if (maxQuata - totalMsg >= 0) {
                                maxQuata = maxQuata - totalMsg;
                            }
                        }
                    }
                } catch (Exception e) {
                    logger.error(Tool.getLogMessage(e));
                }
                pstm.clearParameters();
            }
            // Update lai Quata SMS cua User
            userlogin.setMaxBrand(maxQuata);
            userlogin.updateQuata(userlogin.getAccID(), maxQuata);
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return addNew;
    }

    public MsgBrandCustomer getById(int id) {
        MsgBrandCustomer one = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM MSG_BRAND_CUSTOMER WHERE ID = ? ORDER BY REQUEST_TIME DESC";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                one = new MsgBrandCustomer();
                one.setId(rs.getInt("ID"));
                one.setPhone(rs.getString("PHONE"));
                one.setOper(rs.getString("OPER"));
                one.setMessage(rs.getString("MESSAGE"));
                one.setLabel(rs.getString("LABEL"));
                one.setUserSender(rs.getInt("USER_SENDER"));
                one.setRequestTime(rs.getTimestamp("REQUEST_TIME"));
                one.setType(rs.getInt("TYPE"));
                one.setScheduleTime(rs.getTimestamp("SCHEDULE_TIME"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return one;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getOper() {
        return oper;
    }

    public void setOper(String oper) {
        this.oper = oper;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public int getUserSender() {
        return userSender;
    }

    public void setUserSender(int userSender) {
        this.userSender = userSender;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public Timestamp getRequestTime() {
        return requestTime;
    }

    public void setRequestTime(Timestamp requestTime) {
        this.requestTime = requestTime;
    }

    public int getResult() {
        return result;
    }

    public void setResult(int result) {
        this.result = result;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

    public Timestamp getScheduleTime() {
        return scheduleTime;
    }

    public void setScheduleTime(Timestamp scheduleTime) {
        this.scheduleTime = scheduleTime;
    }

    int id;
    String phone;
    String oper;
    String message;
    String label;
    int userSender;
    Timestamp requestTime;
    int type;
    int result;
    String info;
    Timestamp scheduleTime;
}
