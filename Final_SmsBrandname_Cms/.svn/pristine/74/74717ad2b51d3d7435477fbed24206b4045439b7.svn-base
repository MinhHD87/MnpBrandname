/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.service;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.ObjectMapper;
import gk.myname.vn.entity.JSONUtil;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author Company
 */
public class TestUnicode {
    static final ObjectMapper mapper = new ObjectMapper();
    public static void main(String[] args) {

    }

    public static String doSendTestJson(String username, String password, String msisdn, String brand, String msgbody, int sendType, String node_test, int dataEncode) {
        String result = "Error";
        System.out.println("doSendTestJson =========>");
        try {
            String seqid = brand + "-" + msisdn + "-" + System.nanoTime();
            Map dataMap = new HashMap();
            dataMap.put("user", username);
            dataMap.put("pass", password);
            dataMap.put("tranId", seqid);
            dataMap.put("brandName", brand);
            dataMap.put("phone", msisdn);
            dataMap.put("mess", msgbody);
            dataMap.put("dataEncode", dataEncode);
            dataMap.put("sendTime", "");
            mapper.getFactory().configure(JsonGenerator.Feature.ESCAPE_NON_ASCII, true);
            String strJson = mapper.writeValueAsString(dataMap);
            //--
            //            System.out.println("doGetJson: " + jobj.toString());
            String data = strJson;
            //            data = JSONUtil.escape(data);
            System.out.println("escape param:" + data);
            System.out.println("unescape param:" + JSONUtil.unescape(data));
            HttpURLConnection conn = null;
            try {
                //Create connection
                URL url = new URL(node_test);
                conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("POST");
                conn.setRequestProperty("accept", MediaType.APPLICATION_JSON);
                conn.setRequestProperty("Content-Type", MediaType.APPLICATION_JSON);
                conn.setUseCaches(false);
                conn.setDoOutput(true);
                try ( //Send request
                        DataOutputStream wr = new DataOutputStream(conn.getOutputStream())) {
                    wr.writeBytes(data);
                }
                //Get Response  
                InputStream is = conn.getInputStream();
                StringBuilder response;
                try (BufferedReader rd = new BufferedReader(new InputStreamReader(is))) {
                    response = new StringBuilder(); // or StringBuffer if not Java 5+
                    String line;
                    while ((line = rd.readLine()) != null) {
                        response.append(line);
                        response.append('\r');
                    }
                } // or StringBuffer if not Java 5+
                result = response.toString();
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            } finally {
                if (conn != null) {
                    conn.disconnect();
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return result;
    }
}
