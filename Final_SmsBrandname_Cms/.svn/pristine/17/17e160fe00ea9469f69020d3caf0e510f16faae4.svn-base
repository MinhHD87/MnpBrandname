package gk.myname.vn.entity;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import org.apache.log4j.Logger;

/**
 *
 * @author Administrator
 */
public class Email_tmp_config {

    static final Logger logger = Logger.getLogger(Email_tmp_config.class);

    public ArrayList<Email_tmp_config> view() {
        ArrayList<Email_tmp_config> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM EMAIL_TMP_CONFIG WHERE 1 = 1";
        Tool.debug(sql);

        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Email_tmp_config one = new Email_tmp_config();
                one.setId(rs.getInt("ID"));
                one.setName(rs.getString("NAME"));
                one.setDes(rs.getString("DES"));
                one.setContent(rs.getString("CONTENT"));
                one.setStatus(rs.getInt("STATUS"));
                all.add(one);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }
    
    public ArrayList<Email_tmp_config> getAll(int page, int max, String name, String des, String content, int status) {
        ArrayList<Email_tmp_config> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM EMAIL_TMP_CONFIG WHERE 1 = 1";

        if (!Tool.checkNull(name)) {
            sql += " AND NAME LIKE ?";
        }
        if (status != -1) {
            sql += " AND STATUS = ?";
        }
        sql += " ORDER BY ID ASC LIMIT ?,?";
        Tool.debug(sql);

        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, name);
            }
            if (status != -1) {
                pstm.setInt(i++, status);
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();

            while (rs.next()) {
                Email_tmp_config one = new Email_tmp_config();
                one.setId(rs.getInt("ID"));
                one.setName(rs.getString("NAME"));
                one.setDes(rs.getString("DES"));
                one.setContent(rs.getString("CONTENT"));
                one.setStatus(rs.getInt("STATUS"));
                all.add(one);
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public Email_tmp_config getbyid(int id) {
        Email_tmp_config result = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM EMAIL_TMP_CONFIG WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = new Email_tmp_config();
                result.setId(rs.getInt("ID"));
                result.setName(rs.getString("NAME"));
                result.setDes(rs.getString("DES"));
                result.setContent(rs.getString("CONTENT"));
                result.setStatus(rs.getInt("STATUS"));
            }

        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean addNew(Email_tmp_config one) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO EMAIL_TMP_CONFIG (NAME,DES,CONTENT,STATUS,CREATE_BY)  "
                + "VALUE( ?   , ? , ?    , ? , ?)";
        try {
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(i++, one.getName());
            pstm.setString(i++, one.getDes());
            pstm.setString(i++, one.getContent());
            pstm.setInt(i++, one.getStatus());
            pstm.setString(i++, one.getCreateBy());
            result = (pstm.executeUpdate() == 1);
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean update(Email_tmp_config one) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = " UPDATE EMAIL_TMP_CONFIG SET NAME = ?,DES= ?,CONTENT= ? ,STATUS =?,UPDATE_BY = ? WHERE ID = ?";
        try {
            int i = 1;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(i++, one.getName());
            pstm.setString(i++, one.getDes());
            pstm.setString(i++, one.getContent());
            pstm.setInt(i++, one.getStatus());
            pstm.setString(i++, one.getUpdateBy());
            pstm.setInt(i++, one.getId());
            result = (pstm.executeUpdate() == 1);
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
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
        String sql = "DELETE FROM EMAIL_TMP_CONFIG WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            result = (pstm.executeUpdate() == 1);
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public int countAll(String name, int status) {
        int count = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = " SELECT count(*) FROM EMAIL_TMP_CONFIG WHERE 1 = 1 ";
        try {
            if (!Tool.checkNull(name)) {
                sql += " AND NAME LIKE ?";
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
            if (status != -1) {
                pstm.setInt(i++, status);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return count;
    }
    int id;
    String name;
    String des;
    String content;
    int status;
    Timestamp createDate;
    String createBy;
    Timestamp updateDate;
    String updateBy;

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

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
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

}
