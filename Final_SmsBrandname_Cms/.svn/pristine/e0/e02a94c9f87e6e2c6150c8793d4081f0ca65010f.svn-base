/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.naming.spi.DirStateFactory;

/**
 *
 * @author MinhKudo
 */
public class KpiSubmit {

    public int id;
    public Timestamp log_date;
    public String user_sender;
    public int total;
    public String result;
    public String oper;
    public String cp_code;
    public String send_to;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Timestamp getLog_date() {
        return log_date;
    }

    public void setLog_date(Timestamp log_date) {
        this.log_date = log_date;
    }

    public String getUser_sender() {
        return user_sender;
    }

    public void setUser_sender(String user_sender) {
        this.user_sender = user_sender;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
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

    public String getCp_code() {
        return cp_code;
    }

    public void setCp_code(String cp_code) {
        this.cp_code = cp_code;
    }

    public String getSend_to() {
        return send_to;
    }

    public void setSend_to(String send_to) {
        this.send_to = send_to;
    }

    public static ArrayList<KpiSubmit> excel(String date1, String date2, String user_sender, String oper, String cp_code) {
        ArrayList<KpiSubmit> list = new ArrayList();
        KpiSubmit kpiS = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT LOG_DATE ,USER_SENDER,TOTAL_COUNT,RESULT,OPER,CP_CODE,SEND_TO from kpi_submit where 1=1 ";
            if (!Tool.checkNull(date1)) {
                sql += " AND LOG_DATE >= STR_TO_DATE(?,'%d/%m/%Y') ";
            }
            if (!Tool.checkNull(date2)) {
                sql += " AND LOG_DATE <= STR_TO_DATE(?,'%d/%m/%Y') ";
            }
            if (!Tool.checkNull(user_sender)) {
                sql += " AND USER_SENDER LIKE ? ";
            }
            if (!Tool.checkNull(oper)) {
                sql += " AND OPER LIKE ? ";
            }
            if (!Tool.checkNull(cp_code)) {
                sql += " AND CP_CODE like ? ";
            }
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(date1)) {
                pstm.setString(i++, date1);
            }
            if (!Tool.checkNull(date2)) {
                pstm.setString(i++, date2 );
            }
            if (!Tool.checkNull(user_sender)) {
                pstm.setString(i++, "%" + user_sender + "%");
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, "%" + oper + "%");
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, "%" + cp_code + "%");
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                kpiS = new KpiSubmit();
                kpiS.setLog_date(rs.getTimestamp("LOG_DATE"));
                kpiS.setUser_sender(rs.getString("USER_SENDER"));
                kpiS.setTotal((rs.getInt("TOTAL_COUNT")));
                kpiS.setResult(rs.getString("RESULT"));
                kpiS.setOper(rs.getString("OPER"));
                kpiS.setCp_code(rs.getString("CP_CODE"));
                kpiS.setSend_to(rs.getString("SEND_TO"));
                list.add(kpiS);
            }
        } catch (Exception e) {

        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return list;
    }

    public static ArrayList<KpiSubmit> findList(int max, int page, String date1, String date2, String user_sender, String oper, String cp_code) {
        ArrayList<KpiSubmit> list = new ArrayList();
        KpiSubmit kpiS = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT * from kpi_submit where 1=1 ";
            if (!Tool.checkNull(date1)) {
                sql += " AND LOG_DATE >= STR_TO_DATE(?,'%d/%m/%Y') ";
            }
            if (!Tool.checkNull(date2)) {
                sql += " AND LOG_DATE <= STR_TO_DATE(?,'%d/%m/%Y') ";
            }
            if (!Tool.checkNull(user_sender)) {
                sql += " AND USER_SENDER LIKE ? ";
            }
            if (!Tool.checkNull(oper)) {
                sql += " AND OPER LIKE ? ";
            }
            if (!Tool.checkNull(cp_code)) {
                sql += " AND CP_CODE like ? ";
            }
            sql += " ORDER BY ID DESC LIMIT ?,?";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(date1)) {
                pstm.setString(i++, date1 );
            }
            if (!Tool.checkNull(date2)) {
                pstm.setString(i++, date2 );
            }
            if (!Tool.checkNull(user_sender)) {
                pstm.setString(i++, "%" + user_sender + "%");
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, "%" + oper + "%");
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, "%" + cp_code + "%");
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                kpiS = new KpiSubmit();
                kpiS.setId(rs.getInt("ID"));
                kpiS.setLog_date(rs.getTimestamp("LOG_DATE"));
                kpiS.setUser_sender(rs.getString("USER_SENDER"));
                kpiS.setTotal((rs.getInt("TOTAL_COUNT")));
                kpiS.setResult(rs.getString("RESULT"));
                kpiS.setOper(rs.getString("OPER"));
                kpiS.setCp_code(rs.getString("CP_CODE"));
                kpiS.setSend_to(rs.getString("SEND_TO"));
                list.add(kpiS);
            }
        } catch (Exception e) {

        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return list;
    }

    public int count(String date1, String date2, String user_sender, String oper, String cp_code) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select count(*) from kpi_submit where 1=1 ";
            if (!Tool.checkNull(date1)) {
                sql += " AND LOG_DATE >= STR_TO_DATE(?,'%d/%m/%Y') ";
            }
            if (!Tool.checkNull(date2)) {
                sql += " AND LOG_DATE <= STR_TO_DATE(?,'%d/%m/%Y') ";
            }
            if (!Tool.checkNull(user_sender)) {
                sql += " AND USER_SENDER LIKE ? ";
            }
            if (!Tool.checkNull(oper)) {
                sql += " AND OPER LIKE ? ";
            }
            if (!Tool.checkNull(cp_code)) {
                sql += " AND CP_CODE like ? ";
            }

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(date1)) {
                pstm.setString(i++, date1);
            }
            if (!Tool.checkNull(date2)) {
                pstm.setString(i++, date2 );
            }
            if (!Tool.checkNull(user_sender)) {
                pstm.setString(i++, "%" + user_sender + "%");
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, "%" + oper + "%");
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, "%" + cp_code + "%");
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (Exception e) {
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
}
