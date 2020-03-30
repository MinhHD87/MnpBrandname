/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.db.DBConnect;
import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.DateProc;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import org.apache.log4j.Logger;

/**
 *
 * @author MinhKudo
 */
public class Contract {

    static final Logger logger = Logger.getLogger(Contract.class);

    int sub_id;
    int sub_id_new;
    String name_sub;
    int partner_id;
    int partner_id_new;
    String name_partner;
    String contract_no;
    Timestamp start_time;
    Timestamp expire_time;
    int auto_renew;
    String option_info;
    String file_path;
    int vte;
    int vms;
    int vina;
    int vnm;
    int bl;
    int email_id;
    String name_email;

    public int getSub_id() {
        return sub_id;
    }

    public void setSub_id(int sub_id) {
        this.sub_id = sub_id;
    }

    public int getSub_id_new() {
        return sub_id_new;
    }

    public void setSub_id_new(int sub_id_new) {
        this.sub_id_new = sub_id_new;
    }

    public String getName_sub() {
        return name_sub;
    }

    public void setName_sub(String name_sub) {
        this.name_sub = name_sub;
    }

    public int getPartner_id() {
        return partner_id;
    }

    public void setPartner_id(int partner_id) {
        this.partner_id = partner_id;
    }

    public int getPartner_id_new() {
        return partner_id_new;
    }

    public void setPartner_id_new(int partner_id_new) {
        this.partner_id_new = partner_id_new;
    }

    public String getName_partner() {
        return name_partner;
    }

    public void setName_partner(String name_partner) {
        this.name_partner = name_partner;
    }

    public String getContract_no() {
        return contract_no;
    }

    public void setContract_no(String contract_no) {
        this.contract_no = contract_no;
    }

    public Timestamp getStart_time() {
        return start_time;
    }

    public void setStart_time(Timestamp start_time) {
        this.start_time = start_time;
    }

    public Timestamp getExpire_time() {
        return expire_time;
    }

    public void setExpire_time(Timestamp expire_time) {
        this.expire_time = expire_time;
    }

    public int getAuto_renew() {
        return auto_renew;
    }

    public void setAuto_renew(int auto_renew) {
        this.auto_renew = auto_renew;
    }

    public String getOption_info() {
        return option_info;
    }

    public void setOption_info(String option_info) {
        this.option_info = option_info;
    }

    public String getFile_path() {
        return file_path;
    }

    public void setFile_path(String file_path) {
        this.file_path = file_path;
    }

    public int getVte() {
        return vte;
    }

    public void setVte(int vte) {
        this.vte = vte;
    }

    public int getVms() {
        return vms;
    }

    public void setVms(int vms) {
        this.vms = vms;
    }

    public int getVina() {
        return vina;
    }

    public void setVina(int vina) {
        this.vina = vina;
    }

    public int getVnm() {
        return vnm;
    }

    public void setVnm(int vnm) {
        this.vnm = vnm;
    }

    public int getBl() {
        return bl;
    }

    public void setBl(int bl) {
        this.bl = bl;
    }

    public int getEmail_id() {
        return email_id;
    }

    public void setEmail_id(int email_id) {
        this.email_id = email_id;
    }

    public String getName_email() {
        return name_email;
    }

    public void setName_email(String name_email) {
        this.name_email = name_email;
    }
    
    
    
    //PHONG THEM
    public static String getNumContract(int partnerID) {
        String rslt = "";
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT contract_no FROM contract WHERE PARTNER_ID = ?";

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, partnerID);
            rs = pstm.executeQuery();
            if (rs.next()) {
                rslt = rs.getString("contract_no");
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return rslt;
    }
    //HET PHONG THEM

    public ArrayList<Contract> findList(int max, int page, String contract_no, String stRequest, String endRequest) {
        ArrayList<Contract> list = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select S.NAME AS NAME_SUB,P.FULL_NAME AS NAME_PARTNER,C.SUB_ID,C.PARTNER_ID,"
                    + "C.CONTRACT_NO,C.START_TIME,C.EXPIRE_TIME,C.AUTO_RENEW,C.OPTION_INFO,"
                    + "C.FILE_PATH,C.VTE,C.VMS,C.VINA,C.VNM,C.BL,E.EMAIL "
                    + "from contract C LEFT JOIN subsidiary S ON S.ID = C.SUB_ID "
                    + "LEFT JOIN accounts P on P.ACC_ID = C.PARTNER_ID "
                    + "LEFT JOIN email_manager E on E.ID = C.EMAIL_ID "
                    + "where 1 = 1";
            if (!Tool.checkNull(contract_no)) {
                sql += " AND C.CONTRACT_NO LIKE ?";
            }
            if (!Tool.checkNull(stRequest)) {
                sql += " AND C.START_TIME >= STR_TO_DATE(?,'%d/%m/%Y %H:%i:%s') ";
            }
            if (!Tool.checkNull(endRequest)) {
                sql += " AND C.EXPIRE_TIME <= STR_TO_DATE(?,'%d/%m/%Y %H:%i:%s')";
            }
            sql += " ORDER BY C.SUB_ID DESC LIMIT ?,?";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(contract_no)) {
                pstm.setString(i++, "%" + contract_no + "%");
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            pstm.setInt(i++, (page - 1) * max);
            pstm.setInt(i++, max);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Contract contr = new Contract();
                contr.setName_sub(rs.getString("NAME_SUB"));
                contr.setName_partner(rs.getString("NAME_PARTNER"));
                contr.setSub_id(rs.getInt("SUB_ID"));
                contr.setPartner_id(rs.getInt("PARTNER_ID"));
                contr.setContract_no(rs.getString("CONTRACT_NO"));
                contr.setStart_time(rs.getTimestamp("START_TIME"));
                contr.setExpire_time(rs.getTimestamp("EXPIRE_TIME"));
                contr.setAuto_renew(rs.getInt("AUTO_RENEW"));
                contr.setOption_info(rs.getString("OPTION_INFO"));
                contr.setFile_path(rs.getString("FILE_PATH"));
                contr.setVte(rs.getInt("VTE"));
                contr.setVms(rs.getInt("VMS"));
                contr.setVina(rs.getInt("VINA"));
                contr.setVnm(rs.getInt("VNM"));
                contr.setBl(rs.getInt("BL"));
                contr.setName_email(rs.getString("EMAIL"));
                list.add(contr);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return list;
    }

    public int count(String contract_no, String stRequest, String endRequest) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select count(*) from contract where 1=1 ";
            if (!Tool.checkNull(contract_no)) {
                sql += " AND CONTRACT LIKE ?";
            }
            if (!Tool.checkNull(stRequest)) {
                sql += " AND START_TIME >= STR_TO_DATE(?,'%d/%m/%Y %H:%i:%s')";
            }
            if (!Tool.checkNull(endRequest)) {
                sql += " AND EXPIRE_TIME <= STR_TO_DATE(?,'%d/%m/%Y %H:%i:%s')";
            }

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(contract_no)) {
                pstm.setString(i++, "%" + contract_no + "%");
            }
            if (!Tool.checkNull(stRequest)) {
                pstm.setString(i++, stRequest + " 00:00:00");
            }
            if (!Tool.checkNull(endRequest)) {
                pstm.setString(i++, endRequest + " 23:59:59");
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                result = rs.getInt(1);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean add(Contract contr) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            String sql = " INSERT INTO contract(SUB_ID,PARTNER_ID,CONTRACT_NO,START_TIME,EXPIRE_TIME,AUTO_RENEW,OPTION_INFO,FILE_PATH,VTE,VMS,VINA,VNM,BL,EMAIL_ID) "
                    + " VALUES(     ?,         ?,          ?,         ?,          ?,         ?,         ?,        ?,  ?,  ?,   ?,  ?, ?,      ?) ";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, contr.getSub_id());
            pstm.setInt(i++, contr.getPartner_id());
            pstm.setString(i++, contr.getContract_no());
            pstm.setTimestamp(i++, contr.getStart_time());
            pstm.setTimestamp(i++, contr.getExpire_time());
            pstm.setInt(i++, contr.getAuto_renew());
            pstm.setString(i++, contr.getOption_info());
            pstm.setString(i++, contr.getFile_path());
            pstm.setInt(i++, contr.getVte());
            pstm.setInt(i++, contr.getVms());
            pstm.setInt(i++, contr.getVina());
            pstm.setInt(i++, contr.getVnm());
            pstm.setInt(i++, contr.getBl());
            pstm.setInt(i++, contr.getEmail_id());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(pstm, conn);
        }
        return result;
    }

    public Contract getID(int subID, int partnerID, String contractNo) {
        Contract contr = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select S.NAME AS NAME_SUB,P.FULL_NAME AS NAME_PARTNER,C.SUB_ID,C.PARTNER_ID,"
                    + "C.CONTRACT_NO,C.START_TIME,C.EXPIRE_TIME,C.AUTO_RENEW,C.OPTION_INFO,"
                    + "C.FILE_PATH,C.VTE,C.VMS,C.VINA,C.VNM,C.BL,E.EMAIL "
                    + "from contract C LEFT JOIN subsidiary S ON S.ID = C.SUB_ID "
                    + "LEFT JOIN accounts P on P.ACC_ID = C.PARTNER_ID "
                    + "LEFT JOIN email_manager E on E.ID = C.EMAIL_ID "
                    + "where C.SUB_ID = ? and C.PARTNER_ID = ? and C.CONTRACT_NO = ?";

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, subID);
            pstm.setInt(i++, partnerID);
            pstm.setString(i++, contractNo);
            rs = pstm.executeQuery();
            if (rs.next()) {
                contr = new Contract();
                contr.setName_sub(rs.getString("NAME_SUB"));
                contr.setName_partner(rs.getString("NAME_PARTNER"));
                contr.setSub_id(rs.getInt("SUB_ID"));
                contr.setPartner_id(rs.getInt("PARTNER_ID"));
                contr.setContract_no(rs.getString("CONTRACT_NO"));
                contr.setStart_time(rs.getTimestamp("START_TIME"));
                contr.setExpire_time(rs.getTimestamp("EXPIRE_TIME"));
                contr.setAuto_renew(rs.getInt("AUTO_RENEW"));
                contr.setOption_info(rs.getString("OPTION_INFO"));
                contr.setFile_path(rs.getString("FILE_PATH"));
                contr.setVte(rs.getInt("VTE"));
                contr.setVms(rs.getInt("VMS"));
                contr.setVina(rs.getInt("VINA"));
                contr.setVnm(rs.getInt("VNM"));
                contr.setBl(rs.getInt("BL"));
                contr.setName_email(rs.getString("EMAIL"));
                contr.setEmail_id(rs.getInt("EMAIL_ID"));
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return contr;
    }
    
    public Contract getFile(int subID, int partnerID, String contractNo) {
        Contract contr = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select C.FILE_PATH from contract C where C.SUB_ID = ? and C.PARTNER_ID = ? and C.CONTRACT_NO = ?";

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, subID);
            pstm.setInt(i++, partnerID);
            pstm.setString(i++, contractNo);
            rs = pstm.executeQuery();
            if (rs.next()) {
                contr = new Contract();
                contr.setFile_path(rs.getString("FILE_PATH"));
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return contr;
    }

    public boolean update(Contract contr) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            String sql = "UPDATE contract "
                    + "SET CONTRACT_NO = ? , START_TIME = ? , EXPIRE_TIME = ? , AUTO_RENEW = ? , OPTION_INFO = ? , VTE = ? , VMS = ? , VINA = ? , VNM = ? ,BL = ? , EMAIL_ID = ? ";
            if (!Tool.checkNull(contr.getFile_path())) {
                sql += " ,FILE_PATH = ? ";
            }
            if (contr.getSub_id_new() != 0) {
                sql += " , SUB_ID = ? ";
            }
            if (contr.getPartner_id_new() != 0) {
                sql += " , PARTNER_ID = ? ";
            }
            sql += " WHERE SUB_ID = ? and PARTNER_ID = ?";

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, contr.getContract_no());
            pstm.setTimestamp(i++, contr.getStart_time());
            pstm.setTimestamp(i++, contr.getExpire_time());
            pstm.setInt(i++, contr.getAuto_renew());
            pstm.setString(i++, contr.getOption_info());
            pstm.setInt(i++, contr.getVte());
            pstm.setInt(i++, contr.getVms());
            pstm.setInt(i++, contr.getVina());
            pstm.setInt(i++, contr.getVnm());
            pstm.setInt(i++, contr.getBl());
            pstm.setInt(i++, contr.getEmail_id());

            if (!Tool.checkNull(contr.getFile_path())) {
                pstm.setString(i++, contr.getFile_path());
            }
            if (contr.getSub_id_new() != 0) {
                pstm.setInt(i++, contr.getSub_id_new());
            }
            if (contr.getPartner_id_new() != 0) {
                pstm.setInt(i++, contr.getPartner_id_new());
            }
            pstm.setInt(i++, contr.getSub_id());
            pstm.setInt(i++, contr.getPartner_id());
            result = pstm.executeUpdate() == 1;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(pstm, conn);
        }
        return result;
    }

    public boolean delete(int subID, int partnerID, String contractNo) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            String sql = "delete from contract WHERE SUB_ID = ? and PARTNER_ID = ? and CONTRACT_NO = ?";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, subID);
            pstm.setInt(i++, partnerID);
            pstm.setString(i++, contractNo);
            result = pstm.executeUpdate() == 1;
            return true;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(pstm, conn);
        }
        return result;
    }

    public static ArrayList<Contract> list_partner(int subid) {
        ArrayList<Contract> list = new ArrayList();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select P.FULL_NAME AS NAME_PARTNER,C.PARTNER_ID "
                    + "from contract C LEFT JOIN subsidiary S ON S.ID = C.SUB_ID "
                    + "LEFT JOIN accounts P on P.ACC_ID = C.PARTNER_ID "
                    + "where 1 = 1 ";
            if (subid != 0) {
                sql += " and SUB_ID = ?";
            }
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (subid != 0) {
                pstm.setInt(i++, subid);
            }
            rs = pstm.executeQuery();
            while (rs.next()) {
                Contract contr = new Contract();
                contr.setName_partner(rs.getString("NAME_PARTNER"));
                contr.setPartner_id(rs.getInt("PARTNER_ID"));
                list.add(contr);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
            e.printStackTrace();
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return list;
    }

    public static int getMail(int subID, int partnerID) {
        Contract contr = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        int mail = 0;
        try {
            String sql = "select EMAIL_ID "
                    + "from contract C LEFT JOIN subsidiary S ON S.ID = C.SUB_ID "
                    + "LEFT JOIN accounts P on P.ACC_ID = C.PARTNER_ID "
                    + "LEFT JOIN email_manager E on E.ID = C.EMAIL_ID  "
                    + "where C.SUB_ID = ? and C.PARTNER_ID = ?";

            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, subID);
            pstm.setInt(i++, partnerID);
            rs = pstm.executeQuery();
            if (rs.next()) {
                mail = rs.getInt("EMAIL_ID");
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return mail;
    }
}
