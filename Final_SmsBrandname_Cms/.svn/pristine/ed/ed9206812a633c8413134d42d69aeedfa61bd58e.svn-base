/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.admin;

import gk.myname.vn.utils.Tool;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;

/**
 *
 * @author @author LienHoa(CongNX)
 */
public class PriceTelco {
    static final Logger logger = Logger.getLogger(PriceTelco.class);
    
    private int group0Price;
    private int group1Price;
    private int group2Price;
    private int group3Price;
    private int group4Price;
    private int group5Price;
    private int group6Price;
    private int group7Price;
    private int group8Price;
    private int group9Price;
    private int group10Price;
    private int group11Price;
    private int group12Price;
    private int group13Price;
    private int group14Price;
    private int group15Price;
    private int groupLCPrice;
    public PriceTelco(){
        group0Price = 0;
        group1Price = 0;
        group2Price = 0;
        group3Price = 0;
        group4Price = 0;
        group5Price = 0;
        group6Price = 0;
        group7Price = 0;
        group8Price = 0;
        group9Price = 0;
        group10Price = 0;
        group11Price = 0;
        group12Price = 0;
        group13Price = 0;
        group14Price = 0;
        group15Price = 0;
        groupLCPrice = 0;
    }
    
    public static PriceTelco json2Objec(String str) {
        PriceTelco result = null;
        try {
            JSONObject inputObj = JSONObject.fromObject(str);
            result = (PriceTelco) JSONObject.toBean(inputObj, PriceTelco.class);
            if (result == null) {
                result = new PriceTelco();
            }
        } catch (Exception e) {
            result = new PriceTelco();
            logger.error(Tool.getLogMessage(e));
        }
        return result;
    }
    
    public String toJson() {
        JSONObject obj = JSONObject.fromObject(this);
        String str = obj.toString();
        return str;
    }

    public int getGroup0Price() {
        return group0Price;
    }

    public void setGroup0Price(int group0Price) {
        this.group0Price = group0Price;
    }

    public int getGroup1Price() {
        return group1Price;
    }

    public void setGroup1Price(int group1Price) {
        this.group1Price = group1Price;
    }

    public int getGroup2Price() {
        return group2Price;
    }

    public void setGroup2Price(int group2Price) {
        this.group2Price = group2Price;
    }

    public int getGroup3Price() {
        return group3Price;
    }

    public void setGroup3Price(int group3Price) {
        this.group3Price = group3Price;
    }

    public int getGroup4Price() {
        return group4Price;
    }

    public void setGroup4Price(int group4Price) {
        this.group4Price = group4Price;
    }

    public int getGroup5Price() {
        return group5Price;
    }

    public void setGroup5Price(int group5Price) {
        this.group5Price = group5Price;
    }

    public int getGroup6Price() {
        return group6Price;
    }

    public void setGroup6Price(int group6Price) {
        this.group6Price = group6Price;
    }

    public int getGroup7Price() {
        return group7Price;
    }

    public void setGroup7Price(int group7Price) {
        this.group7Price = group7Price;
    }

    public int getGroup8Price() {
        return group8Price;
    }

    public void setGroup8Price(int group8Price) {
        this.group8Price = group8Price;
    }

    public int getGroup9Price() {
        return group9Price;
    }

    public void setGroup9Price(int group9Price) {
        this.group9Price = group9Price;
    }

    public int getGroup10Price() {
        return group10Price;
    }

    public void setGroup10Price(int group10Price) {
        this.group10Price = group10Price;
    }

    public int getGroup11Price() {
        return group11Price;
    }

    public void setGroup11Price(int group11Price) {
        this.group11Price = group11Price;
    }

    public int getGroup12Price() {
        return group12Price;
    }

    public void setGroup12Price(int group12Price) {
        this.group12Price = group12Price;
    }

    public int getGroup13Price() {
        return group13Price;
    }

    public void setGroup13Price(int group13Price) {
        this.group13Price = group13Price;
    }

    public int getGroup14Price() {
        return group14Price;
    }

    public void setGroup14Price(int group14Price) {
        this.group14Price = group14Price;
    }

    public int getGroup15Price() {
        return group15Price;
    }

    public void setGroup15Price(int group15Price) {
        this.group15Price = group15Price;
    }

    public int getGroupLCPrice() {
        return groupLCPrice;
    }

    public void setGroupLCPrice(int groupLCPrice) {
        this.groupLCPrice = groupLCPrice;
    }
    
    
}
