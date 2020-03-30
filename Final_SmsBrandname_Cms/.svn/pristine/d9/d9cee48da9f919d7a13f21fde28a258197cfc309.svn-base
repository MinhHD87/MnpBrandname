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
 * @author Admin
 */
public class CalculatedByRequest {
    static final Logger logger = Logger.getLogger(OptionTelco.class);
   
    private OptionCheckDuplicate calculatedByRequest;

    public CalculatedByRequest() {
       calculatedByRequest = new OptionCheckDuplicate();
    }

    

    public OptionCheckDuplicate getCalculatedByRequest() {
        return calculatedByRequest;
    }

    public void setCalculatedByRequest(OptionCheckDuplicate calculatedByRequest) {
        this.calculatedByRequest = calculatedByRequest;
    }
   
   
    public String toJson() {
        JSONObject obj = JSONObject.fromObject(this);
        String str = obj.toString();
        return str;
    }

    public static CalculatedByRequest json2Objec(String str) {
        CalculatedByRequest result = null;
        try {
            JSONObject inputObj = JSONObject.fromObject(str);
            result = (CalculatedByRequest) JSONObject.toBean(inputObj, CalculatedByRequest.class);
        } catch (Exception e) {
            logger.error(Tool.getLogMessage(e));
        }
        return result;
    }
    
            
}
