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
import java.sql.SQLException;
import java.util.ArrayList;
import org.apache.log4j.Logger;

/**
 *
 * @author HTC-PC
 */
public class ProviderLabelChange {
    
    static final Logger logger = Logger.getLogger(ProviderLabelChange.class);
    
    private int providerId;
    private int labelError;
    private int labelActive;
    private BrandLabel brandLabelError;
    private BrandLabel brandLabelActive;

    public ProviderLabelChange() {
    }

    public ProviderLabelChange(int providerId, int labelError, int labelActive) {
        this.providerId = providerId;
        this.labelError = labelError;
        this.labelActive = labelActive;
    }

    public BrandLabel getBrandLabelError() {
        return brandLabelError;
    }

    public void setBrandLabelError(BrandLabel brandLabelError) {
        this.brandLabelError = brandLabelError;
    }

    public BrandLabel getBrandLabelActive() {
        return brandLabelActive;
    }

    public void setBrandLabelActive(BrandLabel brandLabelActive) {
        this.brandLabelActive = brandLabelActive;
    }

    public int getProviderId() {
        return providerId;
    }

    public void setProviderId(int providerId) {
        this.providerId = providerId;
    }

    public int getLabelError() {
        return labelError;
    }

    public void setLabelError(int labelError) {
        this.labelError = labelError;
    }

    public int getLabelActive() {
        return labelActive;
    }

    public void setLabelActive(int labelActive) {
        this.labelActive = labelActive;
    }
    
    public ArrayList<ProviderLabelChange> findAllByProviderId(int id) {
        ArrayList<ProviderLabelChange> plcs = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstm = null;
        ResultSet rs = null;
        try {
            String sql = "select * from provider_label_edit where 1 = 1 ";
            sql += " AND PROVIDER_ID = ? ";
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            pstm.setInt(i++, id);
            rs = pstm.executeQuery();
            while (rs.next()) {
                ProviderLabelChange plc = new ProviderLabelChange();
                plc.setProviderId(rs.getInt("PROVIDER_ID"));
                plc.setLabelError(rs.getInt("LABEL_ERROR"));
                plc.setLabelActive(rs.getInt("LABEL_ACTIVE"));
                plcs.add(plc);
            }
        } catch (SQLException e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(rs, pstm, conn);
        }
        
        plcs.forEach((plc) -> {
            plc.setBrandLabelError(BrandLabel.getById(plc.getLabelError()));
            plc.setBrandLabelActive(BrandLabel.getById(plc.getLabelActive()));
        });
        
        return plcs;
    }
    
    public boolean add(ProviderLabelChange plc) {
        boolean result = false;
        Connection conn = null;
        PreparedStatement pstm = null;
        try {
            String sql = " INSERT INTO provider_label_edit( PROVIDER_ID, LABEL_ERROR, LABEL_ACTIVE ) "
                       + " VALUES(                                    ?,           ?,            ? ) ";
            
            conn = DBPool.getConnection();
            pstm = conn.prepareStatement(sql);
            int i = 1;
            
            pstm.setInt(i++, plc.getProviderId());
            pstm.setInt(i++, plc.getLabelError());
            pstm.setInt(i++, plc.getLabelActive());
            
            result = pstm.executeUpdate() == 1;
        } catch (SQLException e) {
            logger.error(Tool.getLogMessage(e));
        } finally {
            DBPool.freeConn(pstm, conn);
        }
        return result;
    }
    
    
    public boolean delete(int providerId, int label) {
        String sql = "DELETE FROM provider_label_edit WHERE PROVIDER_ID = ? AND LABEL_ERROR = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBPool.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, providerId);
            pstmt.setInt(2, label);
            int tm = pstmt.executeUpdate();
            if (tm == 1) {
                return true;
            }
        } catch (SQLException e) {
        } finally {
            DBPool.freeConn(pstmt, conn);
        }
        return false;
    }
}
