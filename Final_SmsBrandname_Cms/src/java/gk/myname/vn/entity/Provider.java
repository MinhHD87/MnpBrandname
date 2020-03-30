package gk.myname.vn.entity;

import gk.myname.vn.db.DBPool;
import gk.myname.vn.utils.Tool;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.apache.log4j.Logger;

public class Provider {

    static final Logger logger = Logger.getLogger(Provider.class);
    public static ArrayList<Provider> CACHE = new ArrayList<>();

    static {
        CACHE = getALL();
    }

    private void reload() {
        CACHE.clear();
        CACHE = getALL();
    }

    public static int getPrividerID(String code) {
        int result = 0;
        for (Provider one : CACHE) {
            if (one.getCode().equalsIgnoreCase(code)) {
                result = one.getId();
            }
        }
        return result;
    }

    public ArrayList<Provider> getProvider(int page, int limit, String code, String name) {
        ArrayList<Provider> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM PROVIDER A WHERE 1=1 ";
        try {
            if (!Tool.checkNull(code)) {
                sql += " AND CODE = ?";
            }
            if (!Tool.checkNull(name)) {
                sql += " AND NAME like ?";
            }
            sql += " ORDER BY A.CODE ASC LIMIT ?,?";
            int start = (page - 1) * limit;
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(code)) {
                pstm.setString(i++, code);
            }
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, "%" + name + "%");
            }
            pstm.setInt(i++, start);
            pstm.setInt(i++, limit);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Provider one = new Provider();
                one.setId(rs.getInt("ID"));
                one.setPos(rs.getInt("POS"));
                one.setCode(rs.getString("CODE"));
                one.setName(rs.getString("NAME"));
                one.setClassSend(rs.getString("CLASS_SEND"));
                one.setVte(rs.getInt("VTE"));
                one.setMobi(rs.getInt("MOBI"));
                one.setVina(rs.getInt("VINA"));
                one.setVnm(rs.getInt("VNM"));
                one.setBl(rs.getInt("BL"));
                one.setDdg(rs.getInt("DDG"));
                one.setStatus(rs.getInt("STATUS"));
                one.setTelemor(rs.getInt("TELEMOR"));
                one.setMovitel(rs.getInt("MOVITEL"));
                one.setUnitel(rs.getInt("UNITEL"));
                one.setMytel(rs.getInt("MYTEL"));
                one.setNatcom(rs.getInt("NATCOM"));
                one.setLumitel(rs.getInt("LUMITEL"));
                one.setHalotel(rs.getInt("NEXTTEL"));
                one.setNexttel(rs.getInt("HALOTEL"));
                one.setBitel(rs.getInt("BITEL"));
                one.setCellcard(rs.getInt("CELLCARD"));
                one.setMetfone(rs.getInt("METFONE"));
                one.setBeelineCampuchia(rs.getInt("BELINECAMPUCHIA"));
                one.setSmart(rs.getInt("SMART"));
                one.setQbmore(rs.getInt("QBMORE"));
                one.setExcell(rs.getInt("EXCELL"));
                one.setTimortelecom(rs.getInt("TIMORTELECOM"));
                one.setMcel(rs.getInt("MCEL"));
                one.setEtl(rs.getInt("ETL"));
                one.setTango(rs.getInt("TANGO"));
                one.setLaotel(rs.getInt("LAOTEL"));
                one.setMpt(rs.getInt("MPT"));
                one.setOoredo(rs.getInt("OOREDO"));
                one.setTelenor(rs.getInt("TELENOR"));
                one.setDigicel(rs.getInt("DIGICEL"));
                one.setComcel(rs.getInt("COMCEL"));
                one.setAfricell(rs.getInt("AFRICELL"));
                one.setLacellsu(rs.getInt("LACELLSU"));
                one.setMtn(rs.getInt("MTN"));
                one.setOrange(rs.getInt("ORANGE"));
                one.setVodacom(rs.getInt("VODACOM"));
                one.setZantel(rs.getInt("ZANTEL"));
                one.setClaro(rs.getInt("CLARO"));
                one.setTelefonica(rs.getInt("TELEFONICA"));
                one.setBuy_price(rs.getString("BUY_PRICE"));
                if (one.getBuy_price() == null) {
                    one.setBuy_price(new Provider_Telco());
                }
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public int countProvider(String code, String name) {
        int result = 0;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT count(*) FROM PROVIDER A WHERE 1=1 ";
        try {
            if (!Tool.checkNull(code)) {
                sql += " AND CODE = ?";
            }
            if (!Tool.checkNull(name)) {
                sql += " AND NAME = ?";
            }
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            if (!Tool.checkNull(code)) {
                pstm.setString(i++, code);
            }
            if (!Tool.checkNull(name)) {
                pstm.setString(i++, name);
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

    public static ArrayList<Provider> getALL() {
        ArrayList<Provider> result = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM PROVIDER A ORDER BY POS";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            rs = pstm.executeQuery();
            while (rs.next()) {
                Provider one = new Provider();
                one.setId(rs.getInt("ID"));
                one.setPos(rs.getInt("POS"));
                one.setCode(rs.getString("CODE"));
                one.setName(rs.getString("NAME"));
                one.setClassSend(rs.getString("CLASS_SEND"));
                one.setVte(rs.getInt("VTE"));
                one.setMobi(rs.getInt("MOBI"));
                one.setVina(rs.getInt("VINA"));
                one.setVnm(rs.getInt("VNM"));
                one.setBl(rs.getInt("BL"));
                one.setDdg(rs.getInt("DDG"));
                one.setStatus(rs.getInt("STATUS"));
                one.setTelemor(rs.getInt("TELEMOR"));
                one.setMovitel(rs.getInt("MOVITEL"));
                one.setUnitel(rs.getInt("UNITEL"));
                one.setMytel(rs.getInt("MYTEL"));
                one.setNatcom(rs.getInt("NATCOM"));
                one.setLumitel(rs.getInt("LUMITEL"));
                one.setHalotel(rs.getInt("NEXTTEL"));
                one.setNexttel(rs.getInt("HALOTEL"));
                one.setBitel(rs.getInt("BITEL"));
                one.setCellcard(rs.getInt("CELLCARD"));
                one.setMetfone(rs.getInt("METFONE"));
                one.setBeelineCampuchia(rs.getInt("BELINECAMPUCHIA"));
                one.setSmart(rs.getInt("SMART"));
                one.setQbmore(rs.getInt("QBMORE"));
                one.setExcell(rs.getInt("EXCELL"));
                one.setTimortelecom(rs.getInt("TIMORTELECOM"));
                one.setMcel(rs.getInt("MCEL"));
                one.setEtl(rs.getInt("ETL"));
                one.setTango(rs.getInt("TANGO"));
                one.setLaotel(rs.getInt("LAOTEL"));
                one.setMpt(rs.getInt("MPT"));
                one.setOoredo(rs.getInt("OOREDO"));
                one.setTelenor(rs.getInt("TELENOR"));
                one.setDigicel(rs.getInt("DIGICEL"));
                one.setComcel(rs.getInt("COMCEL"));
                one.setAfricell(rs.getInt("AFRICELL"));
                one.setLacellsu(rs.getInt("LACELLSU"));
                one.setMtn(rs.getInt("MTN"));
                one.setOrange(rs.getInt("ORANGE"));
                one.setVodacom(rs.getInt("VODACOM"));
                one.setZantel(rs.getInt("ZANTEL"));
                one.setClaro(rs.getInt("CLARO"));
                one.setTelefonica(rs.getInt("TELEFONICA"));
                result.add(one);
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public static Provider getbyId(int id) {
        Provider result = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT A.* FROM PROVIDER A WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                result = new Provider();
                result.setId(rs.getInt("ID"));
                result.setPos(rs.getInt("POS"));
                result.setCode(rs.getString("CODE"));
                result.setName(rs.getString("NAME"));
                result.setClassSend(rs.getString("CLASS_SEND"));
                result.setVte(rs.getInt("VTE"));
                result.setMobi(rs.getInt("MOBI"));
                result.setVina(rs.getInt("VINA"));
                result.setVnm(rs.getInt("VNM"));
                result.setBl(rs.getInt("BL"));
                result.setDdg(rs.getInt("DDG"));
                result.setStatus(rs.getInt("STATUS"));
                result.setTelemor(rs.getInt("TELEMOR"));
                result.setMovitel(rs.getInt("MOVITEL"));
                result.setUnitel(rs.getInt("UNITEL"));
                result.setMytel(rs.getInt("MYTEL"));
                result.setNatcom(rs.getInt("NATCOM"));
                result.setLumitel(rs.getInt("LUMITEL"));
                result.setHalotel(rs.getInt("NEXTTEL"));
                result.setNexttel(rs.getInt("HALOTEL"));
                result.setBitel(rs.getInt("BITEL"));
                result.setCellcard(rs.getInt("CELLCARD"));
                result.setMetfone(rs.getInt("METFONE"));
                result.setBeelineCampuchia(rs.getInt("BELINECAMPUCHIA"));
                result.setSmart(rs.getInt("SMART"));
                result.setQbmore(rs.getInt("QBMORE"));
                result.setExcell(rs.getInt("EXCELL"));
                result.setTimortelecom(rs.getInt("TIMORTELECOM"));
                result.setMcel(rs.getInt("MCEL"));
                result.setEtl(rs.getInt("ETL"));
                result.setTango(rs.getInt("TANGO"));
                result.setLaotel(rs.getInt("LAOTEL"));
                result.setMpt(rs.getInt("MPT"));
                result.setOoredo(rs.getInt("OOREDO"));
                result.setTelenor(rs.getInt("TELENOR"));
                result.setDigicel(rs.getInt("DIGICEL"));
                result.setComcel(rs.getInt("COMCEL"));
                result.setAfricell(rs.getInt("AFRICELL"));
                result.setLacellsu(rs.getInt("LACELLSU"));
                result.setMtn(rs.getInt("MTN"));
                result.setOrange(rs.getInt("ORANGE"));
                result.setVodacom(rs.getInt("VODACOM"));
                result.setZantel(rs.getInt("ZANTEL"));
                result.setClaro(rs.getInt("CLARO"));
                result.setTelefonica(rs.getInt("TELEFONICA"));
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
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
        String sql = "UPDATE PROVIDER SET STATUS = ? WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, Tool.STATUS.DEL.val);
            pstm.setInt(2, id);
            if (pstm.executeUpdate() > 0) {
                reload();
            }
            result = true;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean del_ever(int id) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "DELETE FROM PROVIDER WHERE ID = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);
            if (pstm.executeUpdate() > 0) {
                reload();
            }
            result = true;
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean addProvider(Provider one) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "INSERT INTO PROVIDER(POS,CODE,NAME,CLASS_SEND,VTE,MOBI,VINA,VNM,BL,DDG,STATUS,TELEMOR,MOVITEL,UNITEL,MYTEL,NATCOM,LUMITEL,NEXTTEL,HALOTEL,BITEL,CELLCARD,METFONE,BELINECAMPUCHIA,SMART,QBMORE,EXCELL,TIMORTELECOM,MCEL,ETL,TANGO,LAOTEL,MPT,OOREDO,TELENOR,DIGICEL,AFRICELL,LACELLSU,MTN,ORANGE,VODACOM,ZANTEL,CLARO,TELEFONICA,COMCEL) "
                + "              VALUES( ? , ?  , ?  ,    ?     , ? , ?  ,  ? , ? , ?,  ?  , ?  ,?      ,?      ,?     ,?    ,?     ,?      ,?      ,?      ,?    ,?       ,?      ,?              ,?    ,?     ,?     ,?           ,?   ,?  ,?    ,?     ,?  ,?     ,?      ,?      ,?       ,?       ,?  ,?     ,?      ,?     ,?    ,?         ,?     ) ";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, one.getPos());
            pstm.setString(i++, one.getCode());
            pstm.setString(i++, one.getName());
            pstm.setString(i++, one.getClassSend());
            pstm.setInt(i++, one.getVte());
            pstm.setInt(i++, one.getMobi());
            pstm.setInt(i++, one.getVina());
            pstm.setInt(i++, one.getVnm());
            pstm.setInt(i++, one.getBl());
            pstm.setInt(i++, one.getDdg());
            pstm.setInt(i++, one.getStatus());
            pstm.setInt(i++, one.getTelemor());
            pstm.setInt(i++, one.getMovitel());
            pstm.setInt(i++, one.getUnitel());
            pstm.setInt(i++, one.getMytel());
            pstm.setInt(i++, one.getNatcom());
            pstm.setInt(i++, one.getLumitel());
            pstm.setInt(i++, one.getHalotel());
            pstm.setInt(i++, one.getNexttel());
            pstm.setInt(i++, one.getBitel());
            pstm.setInt(i++, one.getCellcard());
            pstm.setInt(i++, one.getMetfone());
            pstm.setInt(i++, one.getBeelineCampuchia());
            pstm.setInt(i++, one.getSmart());
            pstm.setInt(i++, one.getQbmore());
            pstm.setInt(i++, one.getExcell());
            pstm.setInt(i++, one.getTimortelecom());
            pstm.setInt(i++, one.getMcel());
            pstm.setInt(i++, one.getEtl());
            pstm.setInt(i++, one.getTango());
            pstm.setInt(i++, one.getLaotel());
            pstm.setInt(i++, one.getMpt());
            pstm.setInt(i++, one.getOoredo());
            pstm.setInt(i++, one.getTelenor());
            pstm.setInt(i++, one.getDigicel());
            pstm.setInt(i++, one.getAfricell());
            pstm.setInt(i++, one.getLacellsu());
            pstm.setInt(i++, one.getMtn());
            pstm.setInt(i++, one.getOrange());
            pstm.setInt(i++, one.getVodacom());
            pstm.setInt(i++, one.getZantel());
            pstm.setInt(i++, one.getClaro());
            pstm.setInt(i++, one.getTelefonica());
            pstm.setInt(i++, one.getComcel());
            if (pstm.executeUpdate() == 1) {
                result = true;
                reload();
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public boolean updateProvider(Provider one) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE PROVIDER SET POS = ?,CODE = ?,NAME = ?,CLASS_SEND = ?,"
                + " VTE = ?,MOBI = ?,VINA = ?,VNM = ?,BL = ?,DDG = ?,STATUS = ?,"
                + " TELEMOR = ?,MOVITEL = ?,UNITEL = ?,MYTEL = ?,NATCOM = ?,LUMITEL = ?,"
                + " NEXTTEL = ?,HALOTEL =?,BITEL =?, "
                + " CELLCARD = ?, METFONE = ?, BELINECAMPUCHIA = ?, SMART = ?, QBMORE = ?, EXCELL = ?, "
                + " TIMORTELECOM = ?, MCEL = ?, ETL = ?, TANGO = ?, LAOTEL = ? , MPT = ?, "
                + " OOREDO = ?, TELENOR = ?, DIGICEL = ?, AFRICELL = ?, LACELLSU = ?, "
                + " MTN = ?, ORANGE = ?, VODACOM = ?, ZANTEL = ?, CLARO = ?, TELEFONICA = ?, COMCEL = ? "
                + " WHERE ID = ? ";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, one.getPos());
            pstm.setString(i++, one.getCode());
            pstm.setString(i++, one.getName());
            pstm.setString(i++, one.getClassSend());
            pstm.setInt(i++, one.getVte());
            pstm.setInt(i++, one.getMobi());
            pstm.setInt(i++, one.getVina());
            pstm.setInt(i++, one.getVnm());
            pstm.setInt(i++, one.getBl());
            pstm.setInt(i++, one.getDdg());
            
            pstm.setInt(i++, one.getStatus());
            
            pstm.setInt(i++, one.getTelemor());
            pstm.setInt(i++, one.getMovitel());
            pstm.setInt(i++, one.getUnitel());
            pstm.setInt(i++, one.getMytel());
            pstm.setInt(i++, one.getNatcom());
            pstm.setInt(i++, one.getLumitel());
            
            pstm.setInt(i++, one.getNexttel());
            pstm.setInt(i++, one.getHalotel());
            pstm.setInt(i++, one.getBitel());
            
            pstm.setInt(i++, one.getCellcard());
            pstm.setInt(i++, one.getMetfone());
            pstm.setInt(i++, one.getBeelineCampuchia());
            pstm.setInt(i++, one.getSmart());
            pstm.setInt(i++, one.getQbmore());
            pstm.setInt(i++, one.getExcell());
            
            pstm.setInt(i++, one.getTimortelecom());
            pstm.setInt(i++, one.getMcel());
            pstm.setInt(i++, one.getEtl());
            pstm.setInt(i++, one.getTango());
            pstm.setInt(i++, one.getLaotel());
            pstm.setInt(i++, one.getMpt());
            
            pstm.setInt(i++, one.getOoredo());
            pstm.setInt(i++, one.getTelenor());
            pstm.setInt(i++, one.getDigicel());
            pstm.setInt(i++, one.getAfricell());
            pstm.setInt(i++, one.getLacellsu());
            
            pstm.setInt(i++, one.getMtn());
            pstm.setInt(i++, one.getOrange());
            pstm.setInt(i++, one.getVodacom());
            pstm.setInt(i++, one.getZantel());
            pstm.setInt(i++, one.getClaro());
            pstm.setInt(i++, one.getTelefonica());
            pstm.setInt(i++, one.getComcel());
            
            pstm.setInt(i++, one.getId());
            result = pstm.executeUpdate() == 1;
            if (result) {
                reload();
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    public Provider getByCode(String code) {
        Provider pro = null;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM PROVIDER  WHERE CODE = ?";
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            pstm.setString(1, code);
            rs = pstm.executeQuery();
            if (rs.next()) {
                pro = new Provider();
                pro.setId(rs.getInt("ID"));
                pro.setPos(rs.getInt("POS"));
                pro.setCode(rs.getString("CODE"));
                pro.setName(rs.getString("NAME"));
                pro.setClassSend(rs.getString("CLASS_SEND"));
                pro.setVte(rs.getInt("VTE"));
                pro.setMobi(rs.getInt("MOBI"));
                pro.setVina(rs.getInt("VINA"));
                pro.setVnm(rs.getInt("VNM"));
                pro.setBl(rs.getInt("BL"));
                pro.setDdg(rs.getInt("DDG"));
                pro.setStatus(rs.getInt("STATUS"));
                pro.setTelemor(rs.getInt("TELEMOR"));
                pro.setMovitel(rs.getInt("MOVITEL"));
                pro.setUnitel(rs.getInt("UNITEL"));
                pro.setMytel(rs.getInt("MYTEL"));
                pro.setNatcom(rs.getInt("NATCOM"));
                pro.setLumitel(rs.getInt("LUMITEL"));
                pro.setHalotel(rs.getInt("NEXTTEL"));
                pro.setNexttel(rs.getInt("HALOTEL"));
                pro.setBitel(rs.getInt("BITEL"));
                pro.setCellcard(rs.getInt("CELLCARD"));
                pro.setMetfone(rs.getInt("METFONE"));
                pro.setBeelineCampuchia(rs.getInt("BELINECAMPUCHIA"));
                pro.setSmart(rs.getInt("SMART"));
                pro.setQbmore(rs.getInt("QBMORE"));
                pro.setExcell(rs.getInt("EXCELL"));
                pro.setTimortelecom(rs.getInt("TIMORTELECOM"));
                pro.setMcel(rs.getInt("MCEL"));
                pro.setEtl(rs.getInt("ETL"));
                pro.setTango(rs.getInt("TANGO"));
                pro.setLaotel(rs.getInt("LAOTEL"));
                pro.setMpt(rs.getInt("MPT"));
                pro.setOoredo(rs.getInt("OOREDO"));
                pro.setTelenor(rs.getInt("TELENOR"));
                pro.setDigicel(rs.getInt("DIGICEL"));
                pro.setComcel(rs.getInt("COMCEL"));
                pro.setAfricell(rs.getInt("AFRICELL"));
                pro.setLacellsu(rs.getInt("LACELLSU"));
                pro.setMtn(rs.getInt("MTN"));
                pro.setOrange(rs.getInt("ORANGE"));
                pro.setVodacom(rs.getInt("VODACOM"));
                pro.setZantel(rs.getInt("ZANTEL"));
                pro.setClaro(rs.getInt("CLARO"));
                pro.setTelefonica(rs.getInt("TELEFONICA"));
                pro.setBuy_price(rs.getString("BUY_PRICE"));
                if (pro.getBuy_price() == null) {
                    pro.setBuy_price(new Provider_Telco());
                }
            }
        } catch (SQLException ex) {
            logger.error(Tool.getLogMessage(ex));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return pro;
    }

    public boolean addPrice(Provider one) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        String sql = "UPDATE PROVIDER SET BUY_PRICE = ? WHERE CODE = ? ";
        String Buy_price = Provider_Telco.toStringJson(one.getBuy_price());
        try {
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setString(i++, Buy_price);
            pstm.setString(i++, one.getCode());
            result = pstm.executeUpdate() == 1;
            if (result) {
                reload();
            }
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        return result;
    }

    private int id;
    private int pos;
    private String code;
    private String name;
    private String classSend;
    private int vte;
    private int mobi;
    private int vina;
    private int vnm;
    private int bl;
    private int ddg;

    private int cellcard;
    private int metfone;
    private int beelineCampuchia;
    private int smart;
    private int qbmore;
    private int excell;

    private int telemor;
    private int timortelecom;

    private int movitel;
    private int mcel;

    private int unitel;
    private int etl;
    private int tango;
    private int laotel;

    private int mytel;
    private int mpt;
    private int ooredo;
    private int telenor;

    private int natcom;
    private int digicel;
    private int comcel;

    private int lumitel;
    private int africell;
    private int lacellsu;

    private int nexttel;
    private int mtn;
    private int orange;

    private int halotel;
    private int vodacom;
    private int zantel;

    private int bitel;
    private int claro;
    private int telefonica;

    int status;
    
    Provider_Telco telco;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPos() {
        return pos;
    }

    public void setPos(int pos) {
        this.pos = pos;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getClassSend() {
        return classSend;
    }

    public void setClassSend(String classSend) {
        this.classSend = classSend;
    }

    public static ArrayList<Provider> getCACHE() {
        return CACHE;
    }

    public static void setCACHE(ArrayList<Provider> CACHE) {
        Provider.CACHE = CACHE;
    }

    public int getVte() {
        return vte;
    }

    public void setVte(int vte) {
        this.vte = vte;
    }

    public int getMobi() {
        return mobi;
    }

    public void setMobi(int mobi) {
        this.mobi = mobi;
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

    public int getStatus() {
        return status;
    }

    public int getDdg() {
        return ddg;
    }

    public void setDdg(int ddg) {
        this.ddg = ddg;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getCellcard() {
        return cellcard;
    }

    public void setCellcard(int cellcard) {
        this.cellcard = cellcard;
    }

    public int getMetfone() {
        return metfone;
    }

    public void setMetfone(int metfone) {
        this.metfone = metfone;
    }

    public int getBeelineCampuchia() {
        return beelineCampuchia;
    }

    public void setBeelineCampuchia(int beelineCampuchia) {
        this.beelineCampuchia = beelineCampuchia;
    }

    public int getSmart() {
        return smart;
    }

    public void setSmart(int smart) {
        this.smart = smart;
    }

    public int getQbmore() {
        return qbmore;
    }

    public void setQbmore(int qbmore) {
        this.qbmore = qbmore;
    }

    public int getExcell() {
        return excell;
    }

    public void setExcell(int excell) {
        this.excell = excell;
    }

    public int getTelemor() {
        return telemor;
    }

    public void setTelemor(int telemor) {
        this.telemor = telemor;
    }

    public int getMovitel() {
        return movitel;
    }

    public void setMovitel(int movitel) {
        this.movitel = movitel;
    }

    public int getUnitel() {
        return unitel;
    }

    public void setUnitel(int unitel) {
        this.unitel = unitel;
    }

    public int getMytel() {
        return mytel;
    }

    public void setMytel(int mytel) {
        this.mytel = mytel;
    }

    public int getNatcom() {
        return natcom;
    }

    public void setNatcom(int natcom) {
        this.natcom = natcom;
    }

    public int getLumitel() {
        return lumitel;
    }

    public void setLumitel(int lumitel) {
        this.lumitel = lumitel;
    }

    public int getHalotel() {
        return halotel;
    }

    public void setHalotel(int halotel) {
        this.halotel = halotel;
    }

    public int getNexttel() {
        return nexttel;
    }

    public void setNexttel(int nexttel) {
        this.nexttel = nexttel;
    }

    public int getBitel() {
        return bitel;
    }

    public void setBitel(int bitel) {
        this.bitel = bitel;
    }

    public int getTimortelecom() {
        return timortelecom;
    }

    public void setTimortelecom(int timortelecom) {
        this.timortelecom = timortelecom;
    }

    public int getMcel() {
        return mcel;
    }

    public void setMcel(int mcel) {
        this.mcel = mcel;
    }

    public int getEtl() {
        return etl;
    }

    public void setEtl(int etl) {
        this.etl = etl;
    }

    public int getTango() {
        return tango;
    }

    public void setTango(int tango) {
        this.tango = tango;
    }

    public int getLaotel() {
        return laotel;
    }

    public void setLaotel(int laotel) {
        this.laotel = laotel;
    }

    public int getMpt() {
        return mpt;
    }

    public void setMpt(int mpt) {
        this.mpt = mpt;
    }

    public int getOoredo() {
        return ooredo;
    }

    public void setOoredo(int ooredo) {
        this.ooredo = ooredo;
    }

    public int getTelenor() {
        return telenor;
    }

    public void setTelenor(int telenor) {
        this.telenor = telenor;
    }

    public int getDigicel() {
        return digicel;
    }

    public void setDigicel(int digicel) {
        this.digicel = digicel;
    }

    public int getComcel() {
        return comcel;
    }

    public void setComcel(int comcel) {
        this.comcel = comcel;
    }

    public int getAfricell() {
        return africell;
    }

    public void setAfricell(int africell) {
        this.africell = africell;
    }

    public int getLacellsu() {
        return lacellsu;
    }

    public void setLacellsu(int lacellsu) {
        this.lacellsu = lacellsu;
    }

    public int getMtn() {
        return mtn;
    }

    public void setMtn(int mtn) {
        this.mtn = mtn;
    }

    public int getOrange() {
        return orange;
    }

    public void setOrange(int orange) {
        this.orange = orange;
    }

    public int getVodacom() {
        return vodacom;
    }

    public void setVodacom(int vodacom) {
        this.vodacom = vodacom;
    }

    public int getZantel() {
        return zantel;
    }

    public void setZantel(int zantel) {
        this.zantel = zantel;
    }

    public int getClaro() {
        return claro;
    }

    public void setClaro(int claro) {
        this.claro = claro;
    }

    public int getTelefonica() {
        return telefonica;
    }

    public void setTelefonica(int telefonica) {
        this.telefonica = telefonica;
    }

    @Override
    public String toString() {
        return "Provider{" + "id=" + id + ", pos=" + pos + ", code=" + code + ", name=" + name + ", classSend=" + classSend + ", vte=" + vte + ", mobi=" + mobi + ", vina=" + vina + ", vnm=" + vnm + ", bl=" + bl + ", ddg=" + ddg + ", cellcard=" + cellcard + ", metfone=" + metfone + ", beelineCampuchia=" + beelineCampuchia + ", smart=" + smart + ", qbmore=" + qbmore + ", excell=" + excell + ", telemor=" + telemor + ", timortelecom=" + timortelecom + ", movitel=" + movitel + ", mcel=" + mcel + ", unitel=" + unitel + ", etl=" + etl + ", tango=" + tango + ", laotel=" + laotel + ", mytel=" + mytel + ", mpt=" + mpt + ", ooredo=" + ooredo + ", telenor=" + telenor + ", natcom=" + natcom + ", digicel=" + digicel + ", comcel=" + comcel + ", lumitel=" + lumitel + ", africell=" + africell + ", lacellsu=" + lacellsu + ", nexttel=" + nexttel + ", mtn=" + mtn + ", orange=" + orange + ", halotel=" + halotel + ", vodacom=" + vodacom + ", zantel=" + zantel + ", bitel=" + bitel + ", claro=" + claro + ", telefonica=" + telefonica + ", status=" + status + '}';
    }

    public Provider_Telco getBuy_price() {
        return telco;
    }

    public void setBuy_price(Provider_Telco telco) {
        this.telco = telco;
    }

    public void setBuy_price(String strJson) {
        this.telco = Provider_Telco.json2Object(strJson);
    }
}
