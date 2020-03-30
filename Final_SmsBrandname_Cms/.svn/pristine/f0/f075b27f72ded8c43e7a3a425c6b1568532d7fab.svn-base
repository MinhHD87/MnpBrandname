/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.SMSUtils;
import gk.myname.vn.utils.Tool;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.SQLException;
import org.apache.log4j.Logger;

/**
 *
 * @author Administrator
 */
public class KPI_Request {

    static final Logger logger = Logger.getLogger(KPI_Request.class);

    public ArrayList<KPI_Request> staticKPI_Request(int page, int row, String userSender,
            String oper, String cp_code, String result, String stRequest, String endRequest) {
        ArrayList<KPI_Request> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT SUM(TOTAL_COUNT) TOTAL_COUNT,LOG_DATE,USER_SENDER,OPER,"
                + "(CASE WHEN RESULT = ?  THEN  1  ELSE 0 END) AS RESULT"
                + " FROM KPI_REQUEST WHERE 1=1";
        if (!Tool.checkNull(stRequest)) {
            sql += " AND LOG_DATE >=STR_TO_DATE(?,'%d/%m/%Y %H:%i:%s')";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += "AND LOG_DATE <= STR_TO_DATE(?,'%d/%m/%Y %H:%i:%s')";
        }
        if (!Tool.checkNull(userSender)) {
            sql += "AND USER_SENDER = ?";
        }
        if (!Tool.checkNull(oper)) {
            sql += "AND OPER = ? ";
        }
        if (!Tool.checkNull(cp_code)) {
            sql += "AND CP_CODE = ? ";
        }
        if (!Tool.checkNull(result)) {
            if (result.equals("SUCCESS")) {
                sql += "AND RESULT = ? ";
            } else {
                sql += "AND RESULT < ? ";
            }
        }
        sql += "GROUP BY LOG_DATE,USER_SENDER,OPER,RESULT ORDER BY USER_SENDER DESC LIMIT ?,?";
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, SMSUtils.CODE.RECEIVED.val);
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + "00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + "23:59:59");
            }
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, cp_code + "_%");
            }
            if (!Tool.checkNull(result)) {
                pstm.setInt(i++, 99);
            }
            pstm.setInt(i++, (page - 1) * row);
            pstm.setInt(i++, row);
            rs = pstm.executeQuery();
            while (rs.next()) {
                KPI_Request one = new KPI_Request();
                one.setLog_Date(rs.getTimestamp("LOG_DATE"));
                one.setUserSender(rs.getString("USER_SENDER"));
                one.setOper(rs.getString("OPER"));
                one.setTotal_Count(rs.getInt("TOTAL_COUNT"));
                one.setResult(rs.getString("RESULT"));
                all.add(one);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public int countAll(String userSender, String oper,
            String cp_code, String result, String stRequest, String endRequest) {
        int count = 0;

        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = " SELECT count(*) FROM KPI_REQUEST WHERE 1 = 1 ";

        if (!Tool.checkNull(stRequest)) {
            sql += " AND LOG_DATE >=STR_TO_DATE(?,'%d/%m/%Y %H:%i:%s')";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += "AND LOG_DATE <= STR_TO_DATE(?,'%d/%m/%Y %H:%i:%s')";
        }
        if (!Tool.checkNull(userSender)) {
            sql += "AND USER_SENDER = ?";
        }
        if (!Tool.checkNull(oper)) {
            sql += "AND OPER = ? ";
        }
        if (!Tool.checkNull(result)) {
            if (result.equals("SUCCESS")) {
                sql += "AND RESULT = ? ";
            } else {
                sql += "AND RESULT < ? ";
            }
        }
        if (!Tool.checkNull(cp_code)) {
            sql += "AND CP_CODE = ? ";
        }
        sql += " GROUP BY LOG_DATE,USER_SENDER,OPER,RESULT";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;

            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + "00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + "23:59:59");
            }
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            if (!Tool.checkNull(result)) {
                pstm.setInt(i++, 99);
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, cp_code + "_%");
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                count++;
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return count;
    }

    int id;
    Timestamp log_Date;
    String userSender;
    int total_Count;
    String result;
    String oper;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Timestamp getLog_Date() {
        return log_Date;
    }

    public void setLog_Date(Timestamp log_Date) {
        this.log_Date = log_Date;
    }

    public String getUserSender() {
        return userSender;
    }

    public void setUserSender(String userSender) {
        this.userSender = userSender;
    }

    public int getTotal_Count() {
        return total_Count;
    }

    public void setTotal_Count(int total_Count) {
        this.total_Count = total_Count;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getOper() {
        return oper;
    }

    public void setOper(String oper) {
        this.oper = oper;
    }
}
