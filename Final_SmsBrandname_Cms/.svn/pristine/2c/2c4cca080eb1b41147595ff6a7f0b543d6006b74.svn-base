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
import java.util.ArrayList;
import org.apache.log4j.Logger;

/**
 *
 * @author MinhKudo
 */
public class Complain_title {

    int id;
    String title;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    static final Logger logger = Logger.getLogger(Complain_title.class);
    public static ArrayList<Complain_title> CACHE = new ArrayList<>();

    static {
        CACHE = getAll();
    }

    private void reload() {
        CACHE.clear();
        CACHE = getAll();
    }
    public ArrayList<Complain_title> findList(int max, int page) {
        ArrayList<Complain_title> list = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select * from complain_title where 1 = 1 ORDER BY ID DESC LIMIT ?,?";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Complain_title title = new Complain_title();
                title.setId(rs.getInt("ID"));
                title.setTitle(rs.getString("TITLE"));
                list.add(title);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return list;
    }

    public int count() {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select count(*) from contract";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean delete(int id) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            String sql = "delete from complain_title where ID = ? ";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            result = pstm.executeUpdate() == 1;
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(pstm, conn);
        }
        return result;
    }

    public boolean add(Complain_title compl) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            String sql = " INSERT INTO complain_title(TITLE) "
                    + "         VALUES                  (?) ";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, compl.getTitle());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(pstm, conn);
        }
        return result;
    }

    public Complain_title findID(int id) {
        Complain_title title = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select * from complain_title where ID = ? ";

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                title = new Complain_title();
                title.setId(rs.getInt("ID"));
                title.setTitle(rs.getString("TITLE"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return title;
    }

    public boolean update(Complain_title title) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            String sql = "UPDATE complain_title SET TITLE = ? WHERE ID = ?";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, title.getTitle());
            pstm.setInt(i++, title.getId());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBPool.freeConn(pstm, conn);
        }
        return result;
    }

    public static ArrayList<Complain_title> getAll() {
        ArrayList<Complain_title> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM complain_title ORDER BY TITLE";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Complain_title one = new Complain_title();
                one.setId(rs.getInt("ID"));
                one.setTitle(rs.getString("TITLE"));
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
