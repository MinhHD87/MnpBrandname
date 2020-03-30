
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringEscapeUtils;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Company
 */
public class ExampleJava {

    String urlApi = "http://api.brand1.xyz:8080/service/cp/brand/CSKH";

    String doGetHttp(String username, String password, String msisdn, String brand, String msgbody) {
        String result = "Error";
        try {
            String seqid = brand + "-" + msisdn + "-" + System.nanoTime();
            Map<String, Object> params = new LinkedHashMap<>();
            params.put("user", username);
            params.put("pass", password);
            params.put("phone", msisdn);
            params.put("mess", msgbody);
            params.put("tranId", seqid);
            params.put("brandName", brand);

            StringBuilder getData = new StringBuilder();
            for (Map.Entry<String, Object> param : params.entrySet()) {
                if (getData.length() != 0) {
                    getData.append('&');
                }
                getData.append(URLEncoder.encode(param.getKey(), "UTF-8"));
                getData.append('=');
                getData.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8"));
            }
//                    System.out.println("PostData:" + postData);
            try {
                URL url = new URL(urlApi + "?" + getData);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setConnectTimeout(20000);
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
                Reader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));

                StringBuilder sb = new StringBuilder();
                for (int c; (c = in.read()) >= 0;) {
                    sb.append((char) c);
                }
                String resultPartner = sb.toString();
                System.out.println("resultPartner:" + resultPartner);
                result = resultPartner;
                conn.disconnect();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (Exception ex) {

        }
        return result;
    }

    String doGetXML(String username, String password, String msisdn, String brand, String msgbody) {
        String result = "Error";
        try {
            String seqid = brand + "-" + msisdn + "-" + System.nanoTime();
            StringBuilder getData = new StringBuilder();
            getData.append(URLEncoder.encode("<message>", "UTF-8"));
            getData.append(URLEncoder.encode("<user>", "UTF-8"));
            getData.append(URLEncoder.encode(username, "UTF-8"));
            getData.append(URLEncoder.encode("</user>", "UTF-8"));
            //--
            getData.append(URLEncoder.encode("<pass>", "UTF-8"));
            getData.append(URLEncoder.encode(password, "UTF-8"));
            getData.append(URLEncoder.encode("</pass>", "UTF-8"));
            //--
            getData.append(URLEncoder.encode("<tranId>", "UTF-8"));
            getData.append(URLEncoder.encode(seqid, "UTF-8"));
            getData.append(URLEncoder.encode("</tranId>", "UTF-8"));
            //--
            getData.append(URLEncoder.encode("<brandName>", "UTF-8"));
            getData.append(URLEncoder.encode(brand, "UTF-8"));
            getData.append(URLEncoder.encode("</brandName>", "UTF-8"));
            //--
            getData.append(URLEncoder.encode("<phone>", "UTF-8"));
            getData.append(URLEncoder.encode(msisdn, "UTF-8"));
            getData.append(URLEncoder.encode("</phone>", "UTF-8"));
            //--
            getData.append(URLEncoder.encode("<mess>", "UTF-8"));
            getData.append(URLEncoder.encode(msgbody, "UTF-8"));
            getData.append(URLEncoder.encode("</mess>", "UTF-8"));
            //--
            getData.append(URLEncoder.encode("</message>", "UTF-8"));
            System.out.println("doGetXML:" + getData);
            try {
                URL url = new URL(urlApi + "?data=" + getData);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setConnectTimeout(20000);
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Content-Type", "application/xml");
                Reader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));

                StringBuilder sb = new StringBuilder();
                for (int c; (c = in.read()) >= 0;) {
                    sb.append((char) c);
                }
                String resultPartner = sb.toString();
                System.out.println("resultPartner:" + resultPartner);
                result = resultPartner;
                conn.disconnect();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (Exception ex) {

        }
        return result;
    }

    String doGetJson(String username, String password, String msisdn, String brand, String msgbody) {
        String result = "Error";
        try {
            String seqid = brand + "-" + msisdn + "-" + System.nanoTime();
            Map data = new HashMap();
            data.put("user", username);
            data.put("pass", password);
            data.put("tranId", seqid);
            data.put("brandName", brand);
            data.put("phone", msisdn);
            data.put("mess", msgbody);
            JSONObject jobj = JSONObject.fromObject(data);
            //--
            System.out.println("doGetJson: " + jobj.toString());
            String param = URLEncoder.encode(jobj.toString(), "utf-8");
            System.out.println("doGetJson EndCode:" + jobj.toString());
            try {
                URL url = new URL(urlApi + "?data=" + param);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setConnectTimeout(20000);
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Content-Type", "application/json");
                Reader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));

                StringBuilder sb = new StringBuilder();
                for (int c; (c = in.read()) >= 0;) {
                    sb.append((char) c);
                }
                String resultPartner = sb.toString();
                System.out.println("resultPartner:" + resultPartner);
                result = resultPartner;
                conn.disconnect();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (Exception ex) {

        }
        return result;
    }

    String doPostHttp(String username, String password, String msisdn, String brand, String msgbody) {
        String result = "Error";
        try {
            String seqid = brand + "-" + msisdn + "-" + System.nanoTime();
            Map<String, Object> params = new LinkedHashMap<>();
            params.put("user", username);
            params.put("pass", password);
            params.put("phone", msisdn);
            params.put("mess", msgbody);
            params.put("tranId", seqid);
            params.put("brandName", brand);

            StringBuilder urlParameters = new StringBuilder();
            for (Map.Entry<String, Object> param : params.entrySet()) {
                if (urlParameters.length() != 0) {
                    urlParameters.append('&');
                }
                urlParameters.append(URLEncoder.encode(param.getKey(), "UTF-8"));
                urlParameters.append('=');
                urlParameters.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8"));
            }
            String data = urlParameters.toString();
            System.out.println("PostData:" + data);
            HttpURLConnection conn = null;
            try {
                //Create connection
                URL url = new URL(urlApi);
                conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("POST");
                conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

                conn.setRequestProperty("Content-Length", Integer.toString(data.getBytes().length));
                conn.setRequestProperty("Content-Language", "en-US");
                conn.setUseCaches(false);
                conn.setDoOutput(true);
                //Send request
                DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
                wr.writeBytes(data);
                wr.close();
                //Get Response  
                InputStream is = conn.getInputStream();
                BufferedReader rd = new BufferedReader(new InputStreamReader(is));
                StringBuilder response = new StringBuilder(); // or StringBuffer if not Java 5+ 
                String line;
                while ((line = rd.readLine()) != null) {
                    response.append(line);
                    response.append('\r');
                }
                rd.close();
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

    String doPostXML(String username, String password, String msisdn, String brand, String msgbody) {
        String result = "Error";
        try {
            String seqid = brand + "-" + msisdn + "-" + System.nanoTime();
            StringBuilder postData = new StringBuilder();
            postData.append("<message>");
            postData.append("<user>");
            postData.append(username);
            postData.append("</user>");
            //--
            postData.append("<pass>");
            postData.append(password);
            postData.append("</pass>");
            //--
            postData.append("<tranId>");
            postData.append(seqid);
            postData.append("</tranId>");
            //--
            postData.append("<brandName>");
            postData.append(brand);
            postData.append("</brandName>");
            //--
            postData.append("<phone>");
            postData.append(msisdn);
            postData.append("</phone>");
            //--
            postData.append("<mess>");
            postData.append(StringEscapeUtils.escapeXml(msgbody));
            postData.append("</mess>");
            //--
            postData.append("</message>");
            System.out.println("doPostXML:" + postData);
            String data = postData.toString();
            HttpURLConnection conn = null;
            try {
                //Create connection
                URL url = new URL(urlApi);
                conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("POST");
                conn.setRequestProperty("Content-Type", "application/xml");

                conn.setRequestProperty("Content-Length", Integer.toString(data.getBytes().length));
                conn.setRequestProperty("Content-Language", "en-US");
                conn.setUseCaches(false);
                conn.setDoOutput(true);
                //Send request
                DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
                wr.writeBytes(data);
                wr.close();
                //Get Response  
                InputStream is = conn.getInputStream();
                BufferedReader rd = new BufferedReader(new InputStreamReader(is));
                StringBuilder response = new StringBuilder(); // or StringBuffer if not Java 5+ 
                String line;
                while ((line = rd.readLine()) != null) {
                    response.append(line);
                    response.append('\r');
                }
                rd.close();
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

    String doPostJson(String username, String password, String msisdn, String brand, String msgbody) {
        String result = "Error";
        try {
            String seqid = brand + "-" + msisdn + "-" + System.nanoTime();
            Map data = new HashMap();
            data.put("user", username);
            data.put("pass", password);
            data.put("tranId", seqid);
            data.put("brandName", brand);
            data.put("phone", msisdn);
            data.put("mess", msgbody);
            JSONObject jobj = JSONObject.fromObject(data);
            //--
            System.out.println("doGetJson: " + jobj.toString());
            String param = jobj.toString();
//                    System.out.println("PostData:" + postData);
            HttpURLConnection conn = null;
            try {
                //Create connection
                URL url = new URL(urlApi);
                conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("POST");
                conn.setRequestProperty("Content-Type", "application/json");

                conn.setRequestProperty("Content-Length", Integer.toString(param.getBytes().length));
                conn.setRequestProperty("Content-Language", "en-US");
                conn.setUseCaches(false);
                conn.setDoOutput(true);
                //Send request
                DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
                wr.writeBytes(param);
                wr.close();
                //Get Response  
                InputStream is = conn.getInputStream();
                BufferedReader rd = new BufferedReader(new InputStreamReader(is));
                StringBuilder response = new StringBuilder(); // or StringBuffer if not Java 5+ 
                String line;
                while ((line = rd.readLine()) != null) {
                    response.append(line);
                    response.append('\r');
                }
                rd.close();
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
