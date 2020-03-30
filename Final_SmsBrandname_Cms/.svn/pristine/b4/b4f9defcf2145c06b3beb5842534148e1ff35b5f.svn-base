/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.multipart.request.MultipartFile;
import gk.myname.vn.utils.FileUtils;
import gk.myname.vn.utils.Tool;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import org.apache.log4j.Logger;

/**
 *
 * @author Centurion
 */
public class BrandLabel_Declare {

    static final Logger logger = Logger.getLogger(BrandLabel_Declare.class);
    public static final HashMap<String, ArrayList<BrandLabel_Declare>> CACHE = new HashMap<>();
    public static final String BRAND_FILE_DECLARE = "/data/webroot/upload/brand/declare";

    public boolean checkHasFile() {
        boolean result = false;
        try {
            String dir = BRAND_FILE_DECLARE + "/" + brandLabel.toLowerCase() + "-" + id;
            File f = new File(dir);
            if (f.exists()) {
                File[] listFiles = f.listFiles();
                if (listFiles != null && listFiles.length > 0) {
                    result = true;
                }
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        }
        return result;
    }

    public ArrayList<BrandLabel_Declare> getBrDeclare(int page, int maxRow, String brand, String cpuser, String cp_code, int status) {
        ArrayList<BrandLabel_Declare> all = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM BRAND_LABEL_DECLARE WHERE 1=1 ";
        if (status != -2) {
            sql += " AND STATUS = ?";
        }
        if (!Tool.checkNull(brand)) {
            sql += " AND BRAND_LABEL like ? ";
        }
        if (!cpuser.equals("0")) {
            sql += " AND USER_OWNER = ? ";
        }
        if (!Tool.checkNull(cp_code)) {
            sql += " AND CP_CODE = ? ";
        }
        sql += " ORDER BY ID DESC LIMIT ?,?";
//        Tool.debug(sql);
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (status != -2) {
                pstm.setInt(i++, status);
            }
            if (!Tool.checkNull(brand)) {
                pstm.setString(i++, brand);
            }
            if (!cpuser.equals("0")) {
                pstm.setString(i++, cpuser);
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, cp_code);
            }
            pstm.setInt(i++, (page - 1) * maxRow);
            pstm.setInt(i++, maxRow);
            rs = pstm.executeQuery();
            while (rs.next()) {
                BrandLabel_Declare one = new BrandLabel_Declare();
                one.setId(rs.getInt("ID"));
                one.setUserOwner(rs.getString("USER_OWNER"));
                one.setCp_code(rs.getString("CP_CODE"));
                one.setBrandLabel(rs.getString("BRAND_LABEL"));
                one.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                one.setCreateBy(rs.getString("CREATE_BY"));
                one.setStatus(rs.getInt("STATUS"));
                String strDecl = rs.getString("BR_DECLARE");
                one.setDeclare(DeclareOption.json2Objec(strDecl));
                all.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return all;
    }

    public int countBrDeclare(String brand, String cpuser, String cp_code, int status) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM BRAND_LABEL_DECLARE WHERE 1=1 ";
        if (status != -2) {
            sql += " AND STATUS = ?";
        } else {
            sql += " AND (STATUS =  " + BrandLabel.STATUS.WAIT.val + " OR STATUS = " + BrandLabel.STATUS.PROCESS.val + " OR STATUS = " + BrandLabel.STATUS.REJECT.val + " )";
        }
        if (!Tool.checkNull(brand)) {
            sql += " AND BRAND_LABEL  like ? ";
        }
        if (!cpuser.equals("0")) {
            sql += " AND USER_OWNER = ?";
        }
        if (!Tool.checkNull(cp_code)) {
            sql += " AND (CP_CODE = ? OR CP_CODE like ?) ";
        }
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (status != -2) {
                pstm.setInt(i++, status);
            }
            if (!Tool.checkNull(brand)) {
                pstm.setString(i++, brand);
            }
            if (!cpuser.equals("0")) {
                pstm.setString(i++, cpuser);
            }
            if (!Tool.checkNull(cp_code)) {
                pstm.setString(i++, cp_code);
                pstm.setString(i++, cp_code + "_%");
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

    public boolean addNewNotFile(BrandLabel_Declare oneBrand) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO BRAND_LABEL_DECLARE(USER_OWNER,CP_CODE,BRAND_LABEL,CREATE_DATE,CREATE_BY,STATUS,BR_DECLARE)"
                + "                            VALUES(    ?     ,   ?   ,    ?      ,   NOW()   ,    ?    ,   ?  ,   ?      )";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            //--
            int i = 1;
            pstm.setString(i++, oneBrand.getUserOwner());
            pstm.setString(i++, oneBrand.getCp_code());
            pstm.setString(i++, oneBrand.getBrandLabel());
            pstm.setString(i++, oneBrand.getCreateBy());
            pstm.setInt(i++, oneBrand.getStatus());
            pstm.setString(i++, oneBrand.getDeclare().toStringJson());
            if (pstm.executeUpdate() == 1) {
                DBPool.releadRsPstm(rs, pstm);
                sql = "SELECT @@IDENTITY AS 'Identity';";
                pstm = conn.prepareStatement(sql);
                rs = pstm.executeQuery();
                if (rs.next()) {
                    flag = true;
                }
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return flag;
    }
    
    //--
    public boolean addNew(BrandLabel_Declare oneBrand, MultipartFile file) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO BRAND_LABEL_DECLARE(USER_OWNER,CP_CODE,BRAND_LABEL,CREATE_DATE,CREATE_BY,STATUS,BR_DECLARE)"
                + "                            VALUES(    ?     ,   ?   ,    ?      ,   NOW()   ,    ?    ,   ?  ,   ?      )";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            //--
            int i = 1;
            pstm.setString(i++, oneBrand.getUserOwner());
            pstm.setString(i++, oneBrand.getCp_code());
            pstm.setString(i++, oneBrand.getBrandLabel());
            pstm.setString(i++, oneBrand.getCreateBy());
            pstm.setInt(i++, oneBrand.getStatus());
            pstm.setString(i++, oneBrand.getDeclare().toStringJson());
            if (pstm.executeUpdate() == 1) {
                DBPool.releadRsPstm(rs, pstm);
                sql = "SELECT @@IDENTITY AS 'Identity';";
                pstm = conn.prepareStatement(sql);
                rs = pstm.executeQuery();
                if (rs.next()) {
                    int currentID = rs.getInt(1);
                    if (file != null) {
                        String rootPath = BrandLabel.BRAND_FILE_DECLARE + "/" + oneBrand.getBrandLabel().toLowerCase() + "-" + currentID + "/" + file.getName();
                        File f = new File(BrandLabel.BRAND_FILE_DECLARE + "/" + oneBrand.getBrandLabel().toLowerCase() + "-" + currentID);
                        if (!f.exists()) {
                            f.mkdirs();
                        }
                        FileUtils.writeFileToDisk(file.getByteFromFile(), rootPath);
                        flag = true;
                    }
                }
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return flag;
    }

    public boolean update(BrandLabel_Declare one) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE BRAND_LABEL_DECLARE SET USER_OWNER = ?,CP_CODE = ?,BRAND_LABEL = ?,CREATE_BY = ? ,STATUS = ?  WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, one.getUserOwner());
            pstm.setString(i++, one.getCp_code());
            pstm.setString(i++, one.getBrandLabel());
            pstm.setString(i++, one.getCreateBy());
            pstm.setInt(i++, one.getStatus());

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
    public BrandLabel_Declare getById(int id) {
        BrandLabel_Declare one = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM BRAND_LABEL_DECLARE WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                one = new BrandLabel_Declare();
                one.setId(rs.getInt("ID"));
                one.setUserOwner(rs.getString("USER_OWNER"));
                one.setCp_code(rs.getString("CP_CODE"));
                one.setBrandLabel(rs.getString("BRAND_LABEL"));
                one.setCreateDate(rs.getTimestamp("CREATE_DATE"));
                one.setCreateBy(rs.getString("CREATE_BY"));
                one.setStatus(rs.getInt("STATUS"));
                one.setDeclare(DeclareOption.json2Objec(rs.getString("BR_DECLARE")));
            }
        } catch (Exception e) {
            Tool.debug(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return one;
    }
//

    public boolean delete(int id,String exInfo) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE BRAND_LABEL_DECLARE SET STATUS = ?,EX_INFO = ? WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, Tool.STATUS.DEL.val);
            pstm.setString(i++, exInfo);
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
//

    public boolean delForEver(int id) {
        boolean flag = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "DELETE FROM BRAND_LABEL_DECLARE WHERE ID = ?";
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBrandLabel() {
        return brandLabel;
    }

    public void setBrandLabel(String brandLabel) {
        this.brandLabel = brandLabel;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getUserOwner() {
        return userOwner;
    }

    public void setUserOwner(String userOwner) {
        this.userOwner = userOwner;
    }

    public String getCp_code() {
        return cp_code;
    }

    public void setCp_code(String cp_code) {
        this.cp_code = cp_code;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public DeclareOption getDeclare() {
        return declare;
    }

    public void setDeclare(DeclareOption declare) {
        this.declare = declare;
    }

    int id;
    String userOwner;
    String cp_code;
    String brandLabel;
    Timestamp createDate;
    String createBy;
    int status;
    String desc;
    DeclareOption declare;
}
