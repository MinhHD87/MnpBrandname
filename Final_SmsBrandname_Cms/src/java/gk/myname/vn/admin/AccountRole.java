/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.admin;

import gk.myname.vn.entity.OptionTelco;
import gk.myname.vn.utils.Tool;
import java.io.Serializable;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

/**
 *
 * @author NGOC LONG
 */
public class AccountRole implements Serializable {

    static final Logger logger = Logger.getLogger(OptionTelco.class);
    boolean createAgentcy;
    boolean createSubAcc;
    boolean confirmOTP;
    String phoneOtp;
    boolean lockLogin;

    public boolean isCreateAgentcy() {
        return createAgentcy;
    }

    public void setCreateAgentcy(boolean createAgentcy) {
        this.createAgentcy = createAgentcy;
    }

    public boolean isCreateSubAcc() {
        return createSubAcc;
    }

    public void setCreateSubAcc(boolean createSubAcc) {
        this.createSubAcc = createSubAcc;
    }

    public String toJson() {
        JSONObject obj = JSONObject.fromObject(this);
        String str = obj.toString();
        return str;
    }

    public static AccountRole json2Objec(String str) {
        AccountRole result = null;
        try {
            JSONObject inputObj = JSONObject.fromObject(str);
            result = (AccountRole) JSONObject.toBean(inputObj, AccountRole.class);
            if (result == null) {
                result = new AccountRole();
            }
        } catch (Exception e) {
            result = new AccountRole();
            logger.error(Tool.getLogMessage(e));
        }
        return result;
    }

    public boolean isConfirmOTP() {
        return confirmOTP;
    }

    public void setConfirmOTP(boolean confirmOTP) {
        this.confirmOTP = confirmOTP;
    }

    public String getPhoneOtp() {
        return phoneOtp;
    }

    public void setPhoneOtp(String phoneOtp) {
        this.phoneOtp = phoneOtp;
    }

    public boolean isLockLogin() {
        return lockLogin;
    }

    public void setLockLogin(boolean lockLogin) {
        this.lockLogin = lockLogin;
    }

}
