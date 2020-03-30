package gk.myname.vn.entity;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import org.apache.log4j.Logger;

public class Template_sms {

    static final Logger logger = Logger.getLogger(Template_sms.class);
    public static ArrayList<Template_sms> CACHE = new ArrayList<>();


    int id;
    int id_template_send;
    int id_provider;
    String content;
    String key1;
    String key2;
    String key3;
    String key4;
    String key5;
    String key6;
    String key7;
    String key8;
    String key9;
    String key10;
    String createdby;
    Timestamp createddate;
    String updatedby;
    Timestamp updateddate;
    int status;
    String description;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_template_send() {
        return id_template_send;
    }

    public void setId_template_send(int id_template_send) {
        this.id_template_send = id_template_send;
    }

    public int getId_provider() {
        return id_provider;
    }

    public void setId_provider(int id_provider) {
        this.id_provider = id_provider;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getKey1() {
        return key1;
    }

    public void setKey1(String key1) {
        this.key1 = key1;
    }

    public String getKey2() {
        return key2;
    }

    public void setKey2(String key2) {
        this.key2 = key2;
    }

    public String getKey3() {
        return key3;
    }

    public void setKey3(String key3) {
        this.key3 = key3;
    }

    public String getKey4() {
        return key4;
    }

    public void setKey4(String key4) {
        this.key4 = key4;
    }

    public String getKey5() {
        return key5;
    }

    public void setKey5(String key5) {
        this.key5 = key5;
    }

    public String getKey6() {
        return key6;
    }

    public void setKey6(String key6) {
        this.key6 = key6;
    }

    public String getKey7() {
        return key7;
    }

    public void setKey7(String key7) {
        this.key7 = key7;
    }

    public String getKey8() {
        return key8;
    }

    public void setKey8(String key8) {
        this.key8 = key8;
    }

    public String getKey9() {
        return key9;
    }

    public void setKey9(String key9) {
        this.key9 = key9;
    }

    public String getKey10() {
        return key10;
    }

    public void setKey10(String key10) {
        this.key10 = key10;
    }

    public String getCreatedby() {
        return createdby;
    }

    public void setCreatedby(String createdby) {
        this.createdby = createdby;
    }

    public Timestamp getCreateddate() {
        return createddate;
    }

    public void setCreateddate(Timestamp createddate) {
        this.createddate = createddate;
    }

    public String getUpdatedby() {
        return updatedby;
    }

    public void setUpdatedby(String updatedby) {
        this.updatedby = updatedby;
    }

    public Timestamp getUpdateddate() {
        return updateddate;
    }

    public void setUpdateddate(Timestamp updateddate) {
        this.updateddate = updateddate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    public static ArrayList<Template_sms> getCACHE() {
        return CACHE;
    }

    public static void setCACHE(ArrayList<Template_sms> CACHE) {
        Template_sms.CACHE = CACHE;
    }
    static {
        CACHE = getALL();
    }

    private void reload() {
        CACHE.clear();
        CACHE = getALL();
    }

    public static int GetId_template_send() {
        int result = 0;
        CACHE.forEach((one) -> {
            one.getId_template_send();
        });
        return result;
    }

    public Template_sms(int id, int id_template_send, int id_provider, String content, String key1, String key2, String key3, String key4, String key5, String key6, String key7, String key8, String key9, String key10, String createdby, Timestamp createddate, String updatedby, Timestamp updateddate, int status, String description) {
        this.id = id;
        this.id_template_send = id_template_send;
        this.id_provider = id_provider;
        this.content = content;
        this.key1 = key1;
        this.key2 = key2;
        this.key3 = key3;
        this.key4 = key4;
        this.key5 = key5;
        this.key6 = key6;
        this.key7 = key7;
        this.key8 = key8;
        this.key9 = key9;
        this.key10 = key10;
        this.createdby = createdby;
        this.createddate = createddate;
        this.updatedby = updatedby;
        this.updateddate = updateddate;
        this.status = status;
        this.description = description;
    }

    public Template_sms() {
    }

    @Override
    public String toString() {
        return "Template_sms{" + "id=" + id + ", id_template_send=" + id_template_send + ", id_provider=" + id_provider + ", content=" + content + ", key1=" + key1 + ", key2=" + key2 + ", key3=" + key3 + ", key4=" + key4 + ", key5=" + key5 + ", key6=" + key6 + ", key7=" + key7 + ", key8=" + key8 + ", key9=" + key9 + ", key10=" + key10 + ", createdby=" + createdby + ", createddate=" + createddate + ", updatedby=" + updatedby + ", updateddate=" + updateddate + ", status=" + status + ", description=" + description + '}';
    }

    public ArrayList<Template_sms> getList(int page, int maxRow, String content, String description, int status) {
        ArrayList<Template_sms> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM TEMPLATE_SMS WHERE 1=1 ";

        if (!Tool.checkNull(content)) {
            sql += " AND CONTENT like ? ";
        }
        if (!Tool.checkNull(description)) {
            sql += " AND DESCRIPTION like ? ";
        }
        if (!Tool.checkNull(status)) {
            sql += " AND STATUS =? ";
        }
        sql += " ORDER BY ID DESC LIMIT ?,?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(content)) {
                pstm.setString(i++, '%' + content + '%');
            }
            if (!Tool.checkNull(description)) {
                pstm.setString(i++, '%' + description + '%');
            }
            if (!Tool.checkNull(status)) {
                pstm.setInt(i++, status);
            }
            pstm.setInt(i++, (page - 1) * maxRow);
            pstm.setInt(i++, maxRow);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Template_sms one = new Template_sms();
                one.setId(rs.getInt("ID"));
                one.setId_template_send(rs.getInt("ID_TEMPLATE_SEND"));
                one.setId_provider(rs.getInt("ID_PROVIDER"));
                one.setContent(rs.getString("CONTENT"));
                one.setKey1(rs.getString("KEY1"));
                one.setKey2(rs.getString("KEY2"));
                one.setKey3(rs.getString("KEY3"));
                one.setKey4(rs.getString("KEY4"));
                one.setKey5(rs.getString("KEY5"));
                one.setKey6(rs.getString("KEY6"));
                one.setKey7(rs.getString("KEY7"));
                one.setKey8(rs.getString("KEY8"));
                one.setKey9(rs.getString("KEY9"));
                one.setKey10(rs.getString("KEY10"));
                one.setCreatedby(rs.getString("CREATEDBY"));
                one.setCreateddate(rs.getTimestamp("CREATEDDATE"));
                one.setUpdatedby(rs.getString("UPDATEDBY"));
                one.setUpdateddate(rs.getTimestamp("UPDATEDDATE"));
                one.setStatus(rs.getInt("STATUS"));
                one.setDescription(rs.getString("DESCRIPTION"));
                all.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public int countTemp(String content, String description, int status) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM TEMPLATE_SMS WHERE 1=1 ";
        if (!Tool.checkNull(content)) {
            sql += " AND CONTENT like ? ";
        }
        if (!Tool.checkNull(description)) {
            sql += " AND DESCRIPTION like ? ";
        }
        if (!Tool.checkNull(status)) {
            sql += " AND STATUS =? ";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(content)) {
                pstm.setString(i++, '%' + content + '%');
            }
            if (!Tool.checkNull(description)) {
                pstm.setString(i++, '%' + description + '%');
            }
            if (!Tool.checkNull(status)) {
                pstm.setInt(i++, status);
            }
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean add(Template_sms temp) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            String sql = " INSERT INTO TEMPLATE_SMS(ID_TEMPLATE_SEND,ID_PROVIDER,CONTENT,KEY1,KEY2,KEY3,KEY4,KEY5,KEY6,KEY7,KEY8,KEY9,KEY10,CREATEDBY,CREATEDDATE,STATUS,DESCRIPTION) "
                    + " VALUES                 (              ?,         ?,       ?,   ?,   ?,   ?,  ?,   ?,    ?,   ?,  ?,    ?,    ?,         ?, NOW()      ,?    , ?) ";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, temp.getId_template_send());
            pstm.setInt(i++, temp.getId_provider());
            pstm.setString(i++, temp.getContent());
            pstm.setString(i++, temp.getKey1());
            pstm.setString(i++, temp.getKey2());
            pstm.setString(i++, temp.getKey3());
            pstm.setString(i++, temp.getKey4());
            pstm.setString(i++, temp.getKey5());
            pstm.setString(i++, temp.getKey6());
            pstm.setString(i++, temp.getKey7());
            pstm.setString(i++, temp.getKey8());
            pstm.setString(i++, temp.getKey9());
            pstm.setString(i++, temp.getKey10());
            pstm.setString(i++, temp.getCreatedby());
            pstm.setInt(i++, temp.getStatus());
            pstm.setString(i++, temp.getDescription());
            result = pstm.executeUpdate() == 1;
        } catch (SQLException e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(pstm, conn);
        }
        return result;
    }

    public boolean update(Template_sms one) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE TEMPLATE_SMS SET ID_TEMPLATE_SEND = ?,ID_PROVIDER = ?,CONTENT = ?,KEY1 = ?,KEY2 = ? ,KEY3 = ?,KEY4 = ?,KEY5 = ?,KEY6 = ?,KEY7 = ?,KEY8 = ?,KEY9 = ?,KEY10 = ?,UPDATEDBY = ?,UPDATEDDATE = NOW(),STATUS = ? ,DESCRIPTION  = ?  WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, getId_template_send());
            pstm.setInt(i++, getId_provider());
            pstm.setString(i++, getContent());
            pstm.setString(i++, getKey1());
            pstm.setString(i++, getKey2());
            pstm.setString(i++, getKey3());
            pstm.setString(i++, getKey4());
            pstm.setString(i++, getKey5());
            pstm.setString(i++, getKey6());
            pstm.setString(i++, getKey7());
            pstm.setString(i++, getKey8());
            pstm.setString(i++, getKey9());
            pstm.setString(i++, getKey10());
            pstm.setString(i++, getUpdatedby());
            pstm.setInt(i++, getStatus());
            pstm.setString(i++, getDescription());

            pstm.setInt(i++, one.getId());
            if (pstm.executeUpdate() == 1) {
                flag = true;
            }
        } catch (Exception e) {
            Tool.debug(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return flag;
    }

    public Template_sms getById(int id) {
        Template_sms one = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM TEMPLATE_SMS WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                one = new Template_sms();
                one.setId(rs.getInt("ID"));
                one.setId_template_send(rs.getInt("ID_TEMPLATE_SEND"));
                one.setId_provider(rs.getInt("ID_PROVIDER"));
                one.setContent(rs.getString("CONTENT"));
                one.setKey1(rs.getString("KEY1"));
                one.setKey2(rs.getString("KEY2"));
                one.setKey3(rs.getString("KEY3"));
                one.setKey4(rs.getString("KEY4"));
                one.setKey5(rs.getString("KEY5"));
                one.setKey6(rs.getString("KEY6"));
                one.setKey7(rs.getString("KEY7"));
                one.setKey8(rs.getString("KEY8"));
                one.setKey9(rs.getString("KEY9"));
                one.setKey10(rs.getString("KEY10"));
                one.setCreatedby(rs.getString("CREATEDBY"));
                one.setCreateddate(rs.getTimestamp("CREATEDDATE"));
                one.setUpdatedby(rs.getString("UPDATEDBY"));
                one.setUpdateddate(rs.getTimestamp("UPDATEDDATE"));
                one.setStatus(rs.getInt("STATUS"));
                one.setDescription(rs.getString("DESCRIPTION"));
            }
        } catch (Exception e) {
            Tool.debug(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return one;
    }

    public boolean del(int id) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "DELETE FROM TEMPLATE_SMS WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            if (pstm.executeUpdate() == 1) {
                flag = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return flag;
    }

    public static ArrayList<Template_sms> getALL() {
        ArrayList<Template_sms> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT T.* FROM TEMPLATE_SMS T";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Template_sms one = new Template_sms();
                one.setId(rs.getInt("ID"));
                one.setId_template_send(rs.getInt("ID_TEMPLATE_SEND"));
                one.setId_provider(rs.getInt("ID_PROVIDER"));
                one.setContent(rs.getString("CONTENT"));
                one.setKey1(rs.getString("KEY1"));
                one.setKey2(rs.getString("KEY2"));
                one.setKey3(rs.getString("KEY3"));
                one.setKey4(rs.getString("KEY4"));
                one.setKey5(rs.getString("KEY5"));
                one.setKey6(rs.getString("KEY6"));
                one.setKey7(rs.getString("KEY7"));
                one.setKey8(rs.getString("KEY8"));
                one.setKey9(rs.getString("KEY9"));
                one.setKey10(rs.getString("KEY10"));
                one.setCreatedby(rs.getString("CREATEDBY"));
                one.setCreateddate(rs.getTimestamp("CREATEDDATE"));
                one.setUpdatedby(rs.getString("UPDATEDBY"));
                one.setUpdateddate(rs.getTimestamp("UPDATEDDATE"));
                one.setStatus(rs.getInt("STATUS"));
                one.setDescription(rs.getString("DESCRIPTION"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }
}
