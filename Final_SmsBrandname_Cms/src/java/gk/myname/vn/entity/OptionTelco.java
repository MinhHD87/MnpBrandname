/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.utils.Tool;
import java.io.Serializable;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

/**
 *
 * @author tuanp
 */
public class OptionTelco implements Serializable {

    static final Logger logger = Logger.getLogger(OptionTelco.class);
    private OptionVina vinaphone;
    private OptionCheckDuplicate checkDuplicate;

    public OptionTelco() {
        vinaphone = new OptionVina();
        checkDuplicate = new OptionCheckDuplicate();
    }

    public OptionVina getVinaphone() {
        return vinaphone;
    }

    public void setVinaphone(OptionVina vinaphone) {
        this.vinaphone = vinaphone;
    }

    public OptionCheckDuplicate getCheckDuplicate() {
        return checkDuplicate;
    }

    public void setCheckDuplicate(OptionCheckDuplicate checkDuplicate) {
        this.checkDuplicate = checkDuplicate;
    }

    public String toJson() {
        JSONObject obj = JSONObject.fromObject(this);
        String str = obj.toString();
        return str;
    }

    public static OptionTelco json2Objec(String str) {
        OptionTelco result = null;
        try {
            JSONObject inputObj = JSONObject.fromObject(str);
            result = (OptionTelco) JSONObject.toBean(inputObj, OptionTelco.class);
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        }
        return result;
    }
}
