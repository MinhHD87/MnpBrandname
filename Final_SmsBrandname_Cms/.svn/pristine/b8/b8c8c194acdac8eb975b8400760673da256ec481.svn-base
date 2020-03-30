package gk.myname.vn.entity;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import org.apache.log4j.Logger;

public class Complain_log {

    static final Logger logger = Logger.getLogger(Complain_log.class);

    public ArrayList<Complain_log> staticComplain_log(int page, int row, String stRequest, String endRequest, String name, String oper,
            String label, String userSender, String provider) {
        ArrayList<Complain_log> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM COMPLAIN_LOG WHERE 1 = 1 ";
        if (!Tool.checkNull(stRequest)) {
            sql += " AND CREATE_DATE >= STR_TO_DATE(?,'%d/%m/%Y %H:%i:%s')";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND CREATE_DATE <= STR_TO_DATE(?,'%d/%m/%Y %H:%i:%s')";
        }
        if (!Tool.checkNull(name)) {
            sql += " AND NAME = ?";
        }
        if (!Tool.checkNull(oper)) {
            sql += " AND OPER = ?";
        }
        if (!Tool.checkNull(label)) {
            sql += " AND upper(LABEL) = upper('" + label + "') ";
        }
        if (!Tool.checkNull(userSender)) {
            sql += " AND USER_SENDER = ?";
        }
        if (!Tool.checkNull(provider)) {
            sql += " AND UPPER(SEND_TO) = ?";
        }
        sql += " ORDER BY ID DESC LIMIT ?,?";
        Tool.debug("userSender: " + userSender);
        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, name);
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(provider)) {
                pstm.setString(i++, provider);
            }
            pstm.setInt(i++, (page - 1) * row);
            pstm.setInt(i++, row);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Complain_log one = new Complain_log();
                one.setId(rs.getInt("ID"));
                one.setUserSender(rs.getString("USER_SENDER"));
                one.setLabel(rs.getString("LABEL"));
                one.setPhone(rs.getString("PHONE"));
                one.setOper(rs.getString("OPER"));
                one.setSend_to(rs.getString("SEND_TO"));
                one.setComplain(rs.getString("COMPLAIN"));
                one.setName(rs.getString("NAME"));
                one.setCreate_by(rs.getString("CREATE_BY"));
                one.setCreate_date(rs.getTimestamp("CREATE_DATE"));
                one.setResult(rs.getString("RESULT"));
                one.setStatus(rs.getInt("STATUS"));
                all.add(one);
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public int count(String stRequest, String endRequest, String name, String oper, String label, String userSender, String provider) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = " SELECT count(*) FROM COMPLAIN_LOG WHERE 1 = 1 ";
        if (!Tool.checkNull(stRequest)) {
            sql += " AND CREATE_DATE >= STR_TO_DATE(?,'%d/%m/%Y %H:%i:%s')";
        }
        if (!Tool.checkNull(endRequest)) {
            sql += " AND CREATE_DATE <= STR_TO_DATE(?,'%d/%m/%Y %H:%i:%s')";
        }
        if (!Tool.checkNull(name)) {
            sql += " AND NAME = ?";
        }
        if (!Tool.checkNull(oper)) {
            sql += " AND OPER = ?";
        }
        if (!Tool.checkNull(label)) {
            sql += " AND upper(LABEL) = upper('" + label + "') ";
        }
        if (!Tool.checkNull(userSender)) {
            sql += " AND USER_SENDER = ?";
        }
        if (!Tool.checkNull(provider)) {
            sql += " AND UPPER(SEND_TO) = ?";
        }

        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;

            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, name);
            }
            if (!Tool.checkNull(oper)) {
                pstm.setString(i++, oper);
            }
            if (!Tool.checkNull(userSender)) {
                pstm.setString(i++, userSender);
            }
            if (!Tool.checkNull(provider)) {
                pstm.setString(i++, provider);
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

    public Complain_log getbyid(int id) {
        Complain_log cl = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM COMPLAIN_LOG WHERE ID = ? ";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                cl = new Complain_log();
                cl.setId(rs.getInt("ID"));
                cl.setName(rs.getString("NAME"));
                cl.setUserSender(rs.getString("USER_SENDER"));
                cl.setLabel(rs.getString("LABEL"));
                cl.setPhone(rs.getString("PHONE"));
                cl.setOper(rs.getString("OPER"));
                cl.setSend_to(rs.getString("SEND_TO"));
                cl.setComplain(rs.getString("COMPLAIN"));
                cl.setCreate_date(rs.getTimestamp("CREATE_DATE"));
                cl.setCreate_by(rs.getString("CREATE_BY"));
                cl.setUpdate_date(rs.getTimestamp("UPDATE_DATE"));
                cl.setUpdate_by(rs.getString("UPDATE_BY"));
                cl.setResult(rs.getString("RESULT"));
                cl.setStatus(rs.getInt("STATUS"));
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return cl;
    }

    public boolean addnew(Complain_log one) {
        boolean cl = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO COMPLAIN_LOG( USER_SENDER, NAME,  LABEL, PHONE, OPER, SEND_TO ,COMPLAIN,CREATE_DATE, CREATE_BY , RESULT)"
                + "VALUE                      (      ?     ,    ?,     ? ,  ?   ,  ?  ,   ?     , ?      ,   NOW()   ,     ?     ,     ? )";
        try {
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(i++, one.getUserSender());
            pstm.setString(i++, one.getName());
            pstm.setString(i++, one.getLabel());
            pstm.setString(i++, one.getPhone());
            pstm.setString(i++, one.getOper());
            pstm.setString(i++, one.getSend_to());
            pstm.setString(i++, one.getComplain());
            pstm.setString(i++, one.getCreate_by());
            pstm.setString(i++, one.getResult());
            cl = (pstm.executeUpdate() == 1);
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return cl;
    }

    public boolean edit(Complain_log one) {
        boolean cl = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE COMPLAIN_LOG SET NAME = ?, LABEL= ?, PHONE = ?, OPER = ?, SEND_TO = ?,COMPLAIN = ?, UPDATE_DATE= NOW(), UPDATE_BY = ?,"
                + "RESULT= ?, STATUS = ? WHERE ID= ?";
        try {
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(i++, one.getName());
            pstm.setString(i++, one.getLabel());
            pstm.setString(i++, one.getPhone());
            pstm.setString(i++, one.getOper());
            pstm.setString(i++, one.getSend_to());
            pstm.setString(i++, one.getComplain());
            pstm.setString(i++, one.getUpdate_by());
            pstm.setString(i++, one.getResult());
            pstm.setInt(i++, one.getStatus());
            pstm.setInt(i++, one.getId());

            cl = (pstm.executeUpdate() == 1);

        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return cl;
    }

    public boolean del(int id) {
        boolean cl = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = " DELETE FROM COMPLAIN_LOG WHERE ID = ? ";
        try {
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(i++, id);
            cl = (pstm.executeUpdate() == 1);
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return cl;
    }

    public static enum STATUS {

        ALL(-2, "Tất cả"),
        WAIT(0, "Chờ xử lý"),
        PROCESSING(1, "Đang xử lý"),
        FINISH(2, "Đã xử lý"),;

        public int val;
        public String desc;

        private STATUS(int val, String desc) {
            this.val = val;
            this.desc = desc;
        }

        public static String getDesc(int val) {
            String str = "Unknow";
            for (STATUS one : STATUS.values()) {
                if (one.val == val) {
                    str = one.desc;
                    break;
                }
            }
            return str;
        }
    }
    int id;
    String name;
    String userSender;
    String label;
    String phone;
    String oper;
    String send_to;
    String complain;
    Timestamp create_date;
    String create_by;
    Timestamp update_date;
    String update_by;
    String result;
    int status;

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

    public String getUserSender() {
        return userSender;
    }

    public void setUserSender(String userSender) {
        this.userSender = userSender;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
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

    public String getSend_to() {
        return send_to;
    }

    public void setSend_to(String send_to) {
        this.send_to = send_to;
    }

    public String getComplain() {
        return complain;
    }

    public void setComplain(String complain) {
        this.complain = complain;
    }

    public Timestamp getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Timestamp creat_date) {
        this.create_date = creat_date;
    }

    public String getCreate_by() {
        return create_by;
    }

    public void setCreate_by(String creat_by) {
        this.create_by = creat_by;
    }

    public Timestamp getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(Timestamp update_date) {
        this.update_date = update_date;
    }

    public String getUpdate_by() {
        return update_by;
    }

    public void setUpdate_by(String update_by) {
        this.update_by = update_by;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
