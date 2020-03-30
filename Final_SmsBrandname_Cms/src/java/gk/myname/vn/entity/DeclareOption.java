/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.utils.Tool;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

/**
 *
 * @author tuanp
 */
public class DeclareOption {

    static final Logger logger = Logger.getLogger(DeclareOption.class);

    public DeclareOption() {
        this.vte = false;
        this.vms = false;
        this.gpc = false;
        this.vnm = false;
        this.gtel = false;
        this.vte_qc = false;
        this.vms_qc = false;
        this.gpc_qc = false;
        this.vnm_qc = false;
        this.gtel_qc = false;
    }

    public DeclareOption(boolean vte, boolean vms, boolean gpc, boolean vnm, boolean gtel,
            boolean vte_qc, boolean vms_qc, boolean gpc_qc, boolean vnm_qc, boolean gtel_qc) {
        this.vte = vte;
        this.vms = vms;
        this.gpc = gpc;
        this.vnm = vnm;
        this.gtel = gtel;
        this.vte_qc = vte;
        this.vms_qc = vms;
        this.gpc_qc = gpc;
        this.vnm_qc = vnm;
        this.gtel_qc = gtel;
    }

    public String toStringJson() {
        if (this != null) {
            JSONObject obj = JSONObject.fromObject(this);
            String str = obj.toString();
            return str;
        } else {
            return "";
        }
    }

    public static DeclareOption json2Objec(String str) {
        DeclareOption result = null;
        try {
            JSONObject inputObj = JSONObject.fromObject(str);
            result = (DeclareOption) JSONObject.toBean(inputObj, DeclareOption.class);
            if (result == null) {
                result = new DeclareOption(false, false, false, false, false, false, false, false, false, false);
            }
        } catch (Exception e) {
            result = new DeclareOption(false, false, false, false, false, false, false, false, false, false);
            logger.error(Tool.getLogMessage(e));
        }
        return result;
    }
    boolean vte;
    boolean vms;
    boolean gpc;
    boolean vnm;
    boolean gtel;
    boolean vte_qc;
    boolean vms_qc;
    boolean gpc_qc;
    boolean vnm_qc;
    boolean gtel_qc;

    public boolean isVte() {
        return vte;
    }

    public void setVte(boolean vte) {
        this.vte = vte;
    }

    public boolean isVms() {
        return vms;
    }

    public void setVms(boolean vms) {
        this.vms = vms;
    }

    public boolean isGpc() {
        return gpc;
    }

    public void setGpc(boolean gpc) {
        this.gpc = gpc;
    }

    public boolean isVnm() {
        return vnm;
    }

    public void setVnm(boolean vnm) {
        this.vnm = vnm;
    }

    public boolean isGtel() {
        return gtel;
    }

    public void setGtel(boolean gtel) {
        this.gtel = gtel;
    }

    public boolean isVte_qc() {
        return vte_qc;
    }

    public void setVte_qc(boolean vte_qc) {
        this.vte_qc = vte_qc;
    }

    public boolean isVms_qc() {
        return vms_qc;
    }

    public void setVms_qc(boolean vms_qc) {
        this.vms_qc = vms_qc;
    }

    public boolean isGpc_qc() {
        return gpc_qc;
    }

    public void setGpc_qc(boolean gpc_qc) {
        this.gpc_qc = gpc_qc;
    }

    public boolean isVnm_qc() {
        return vnm_qc;
    }

    public void setVnm_qc(boolean vnm_qc) {
        this.vnm_qc = vnm_qc;
    }

    public boolean isGtel_qc() {
        return gtel_qc;
    }

    public void setGtel_qc(boolean gtel_qc) {
        this.gtel_qc = gtel_qc;
    }

}
