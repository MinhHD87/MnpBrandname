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
import org.apache.log4j.Logger;

/**
 *
 * @author tuanp
 */
public class MsgTemplate {

    static final Logger logger = Logger.getLogger(MsgTemplate.class);

    public boolean addNew(MsgTemplate one) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO MSG_TEMP(TEMPLATE,TMP_DESC,USER_ID,CREATE_DATE) VALUES(?,?,?,NOW())";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, one.getTemplate());
            pstm.setString(i++, one.getDesc());
            pstm.setInt(i++, one.getUserId());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean update(MsgTemplate one) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE  MSG_TEMP SET TEMPLATE = ?, TMP_DESC=?, USER_ID = ? Where ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, one.getTemplate());
            pstm.setString(i++, one.getDesc());
            pstm.setInt(i++, one.getUserId());
            pstm.setInt(i++, one.getId());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public MsgTemplate findById(int id) {
        MsgTemplate result = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM  MSG_TEMP Where ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = new MsgTemplate();
                result.setId(rs.getInt("ID"));
                result.setTemplate(rs.getString("TEMPLATE"));
                result.setDesc(rs.getString("TMP_DESC"));
                result.setUserId(rs.getInt("USER_ID"));
                result.setCreateDate(rs.getTimestamp("CREATE_DATE"));
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean delById(int id) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "DELETE FROM  MSG_TEMP Where ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            return pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public ArrayList<MsgTemplate> findByAll(int id) {
        ArrayList<MsgTemplate> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM  MSG_TEMP WHERE USER_ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            rs = pstm.executeQuery();
            while (rs.next()) {
                MsgTemplate one = new MsgTemplate();
                one.setId(rs.getInt("ID"));
                one.setTemplate(rs.getString("TEMPLATE"));
                one.setDesc(rs.getString("TMP_DESC"));
                one.setUserId(rs.getInt("USER_ID"));
                one.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
    int id;
    String template;
    String desc;
    int userId;
    Timestamp createDate;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTemplate() {
        return template;
    }

    public void setTemplate(String template) {
        this.template = template;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

}
