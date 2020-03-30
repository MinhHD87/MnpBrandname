/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.utils;

import gk.myname.vn.config.MyContext;
import gk.myname.vn.entity.Money_info;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.StringWriter;
import java.io.Writer;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.StringTokenizer;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

/**
 *
 * @author PLATUAN
 */
public class Tool {

    static Logger logger = Logger.getLogger(Tool.class);
    private static final HashMap<Long, Money_info> CACHE_MONEY = new HashMap<>();
    public static long keyMoney = 0L;

    public static Money_info getMoney() {
        if (CACHE_MONEY.get(keyMoney) == null) {
            Money_info moneyInfo = new Money_info();
            moneyInfo = moneyInfo.getBlanceNew();
            keyMoney = moneyInfo.getLasTime().getTime();
            CACHE_MONEY.clear();
            CACHE_MONEY.put(keyMoney, moneyInfo);
            return moneyInfo;
        } else {
            return CACHE_MONEY.get(keyMoney);
        }
    }

    public static boolean oVer10M() {
        return System.currentTimeMillis() - keyMoney > 10 * 60 * 1000;
    }

    public static boolean existsFileUrl(String URLName) {
        try {
            HttpURLConnection.setFollowRedirects(false);
            // note : you may also need
//            HttpURLConnection.setInstanceFollowRedirects(false);
            HttpURLConnection con = (HttpURLConnection) new URL(URLName).openConnection();
            con.setInstanceFollowRedirects(false);
            con.setRequestMethod("HEAD");
            return (con.getResponseCode() == HttpURLConnection.HTTP_OK);
        } catch (Exception e) {
//            e.printStackTrace();
            return false;
        }
    }

    /**
     * Neu thoi gian hien tai <= thoi gian timeout => false else => true
     *
     * @param lastTime
     * @param secondTimeOut
     * @return
     */
    public static boolean timeOut(long lastTime, int secondTimeOut) {
        long current = System.currentTimeMillis();
        boolean result = lastTime + (secondTimeOut * 1000) < current;
        System.out.println("timeOut.result: " + result);
        return result;
    }

    public static Double longToDouble(Long number) {
        return Double.longBitsToDouble(number);
    }

    public enum STATUS {

        ACTIVE(1),
        LOCK(0),
        DEL(404);
        public int val;

        private STATUS(int val) {
            this.val = val;
        }
    }

    public static void reload(String funtion, String action, HashMap<String, String> optionParam) {
        System.out.println("Vao Reload--->");
        String[] listUrl = null;
        if (!Tool.checkNull(MyContext.URL_RELOAD)) {
            listUrl = MyContext.URL_RELOAD.split(",");
        }
        if (listUrl != null) {
            for (String oneUrl : listUrl) {
                String url = "http://" + oneUrl + "/service/private/" + funtion;
                System.out.println("URL:" + url);
                if (optionParam != null) {
                    url += "?action=" + action;
                    Set set = optionParam.entrySet();
                    Iterator it = set.iterator();
                    while (it.hasNext()) {
                        Map.Entry entry = (Map.Entry) it.next();
                        try {
                            url += "&" + entry.getKey() + "=" + URLEncoder.encode((String) entry.getValue(), "UTF-8");
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    Tool.debug(url);
                    Tool.loadUrl(url);
                }
            }
        } else {
            System.out.println("URL_RELOAD is null: " + MyContext.URL_RELOAD);
        }
    }

    public static void synFirewall(String funtion, String action, HashMap<String, String> optionParam) {
        System.out.println("Vao synFirewall--->");
        String[] listUrl = null;
        if (!Tool.checkNull(MyContext.URL_FIREWALL)) {
            listUrl = MyContext.URL_FIREWALL.split(",");
        }
        if (listUrl != null) {
            for (String oneUrl : listUrl) {
                String url = "http://" + oneUrl + "/service/private/" + funtion;
                System.out.println("URL:" + url);
                if (optionParam != null) {
                    url += "?action=" + action;
                    Set set = optionParam.entrySet();
                    Iterator it = set.iterator();
                    while (it.hasNext()) {
                        Map.Entry entry = (Map.Entry) it.next();
                        try {
                            url += "&" + entry.getKey() + "=" + URLEncoder.encode((String) entry.getValue(), "UTF-8");
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    Tool.debug(url);
                    Tool.loadUrl(url);
                }
            }
        } else {
            System.out.println("URL_RELOAD is null: " + MyContext.URL_RELOAD);
        }
    }

    public static String loadUrl(String urlStr) {
        String t = "";
        try {
            URL url = new URL(urlStr);
            HttpURLConnection http = (HttpURLConnection) url.openConnection();
            http.setConnectTimeout(20000);
            try (InputStream in = http.getInputStream()) {
                t = convertStreamToString(in);
            }
            http.disconnect();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return t;
    }

    public static String convertStreamToString(InputStream is) throws IOException {
        /*
         * To convert the InputStream to String we use the
         * Reader.read(char[] buffer) method. We iterate until the
         * Reader return -1 which means there's no more data to
         * read. We use the StringWriter class to produce the string.
         */
        if (is != null) {
            Writer writer = new StringWriter();
            char[] buffer = new char[1024];
            try {
                Reader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
                int n;
                while ((n = reader.read(buffer)) != -1) {
                    writer.write(buffer, 0, n);
                }
            } finally {
                is.close();
            }
            return writer.toString();
        } else {
            return "";
        }
    }

    public String getCookie(HttpServletRequest request, String c_name) {
        String value = "";
        try {
            Cookie[] cookies = request.getCookies();

            for (Cookie cookie : cookies) {
                String name = cookie.getName();
                if (name.equals(c_name)) {
                    value = cookie.getValue();
                    break;
                }
            }
        } catch (Exception e) {
            System.out.println("Unable to get cookie using");
            e.printStackTrace();
        }
        return value;
    }

    public static String StringOneLine(String input) {
        if (input == null) {
            return "";
        } else {
            input = input.trim();
            String NL = System.getProperty("line.separator");
            input = input.replaceAll("\n", "");
            input = input.replaceAll("\r", "");
            input = input.replaceAll(NL, "");
            return input;
        }
    }

    public static String validStringJs(String input) {
        if (input == null) {
            return "";
        } else {
            input = input.replaceAll("/", "\\\\/");
            input = input.replaceAll("\"", "\\\\\"");
            input = input.replaceAll("\n", "");
            input = input.replaceAll("\r", "");
            return input;
        }
    }

    public static String getClientIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    public static String getDomainName(String url) throws MalformedURLException {
        String host = "";
        try {
            if (!url.startsWith("http") && !url.startsWith("https")) {
                url = "http://" + url;
            }
            URL netUrl = new URL(url);
            host = netUrl.getHost();

            if (host.startsWith("www")) {
                host = host.substring("www".length() + 1);
            }
        } catch (MalformedURLException e) {
            logger.error("[ERROR getDomainName] ==> " + url);
        }
        return host;
    }

    public static void debug(String input) {
        String fullClassName = Thread.currentThread().getStackTrace()[2].getClassName();
        String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
        int lineNumber = Thread.currentThread().getStackTrace()[2].getLineNumber();
        if (MyContext.DE_BUG) {
            System.out.println("Tool.debug: " + className + ".class:[d" + lineNumber + "] " + input);
        }
    }

    public static void debug(int input) {
        String fullClassName = Thread.currentThread().getStackTrace()[2].getClassName();
        String className = fullClassName.substring(fullClassName.lastIndexOf(".") + 1);
        int lineNumber = Thread.currentThread().getStackTrace()[2].getLineNumber();
        if (MyContext.DE_BUG) {
            System.out.println("Tool.debug: " + className + ".class:[d" + lineNumber + "] " + input);
        }
    }

    public static void sleepSecond(int second) {
        long start = System.currentTimeMillis();
        while (true) {
            long runTime = System.currentTimeMillis();
            long distance = runTime - start;
            if (distance > second * 1000) {
                break;
            }
        }
    }
    private static final Random RANDOM = new SecureRandom();
    // Get Random String

    public static String getRandomString(int length) {
        // Pick from some letters that won't be easily mistaken for each
        // other. So, for example, omit o O and 0, 1 l and L.
        String letters = "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789";

        String pw = "";
        for (int i = 0; i < length; i++) {
            int index = (int) (RANDOM.nextDouble() * letters.length());
            pw += letters.substring(index, index + 1);
        }
        String str = "<input class=\"button\" type=\"button\" onclick=\"location.href = '<%=request.getContextPath() + \"/admin/partner-manager/add.jsp\"%>'\" value=\"Thêm mới\"/>";
        return pw;
    }

    public static String getURI(HttpServletRequest request) {
        String currentURL = null;
        if (request.getAttribute("javax.servlet.forward.request_uri") != null) {
            currentURL = (String) request.getAttribute("javax.servlet.forward.request_uri");
        } else {
            currentURL = request.getRequestURI();
        }
        if (currentURL != null && request.getAttribute("javax.servlet.include.query_string") != null) {
            currentURL += "?" + request.getQueryString();
        }
        return currentURL;
    }

    public static String getFullURL(HttpServletRequest request) {
        String currentURL = null;
        String domain = request.getScheme() + "://" + request.getHeader("host");
        if (request.getAttribute("javax.servlet.forward.request_uri") != null) {
            currentURL = (String) request.getAttribute("javax.servlet.forward.request_uri");
        } else {
            currentURL = request.getRequestURI();
        }
        if (currentURL != null && request.getAttribute("javax.servlet.include.query_string") != null) {
            currentURL += "?" + request.getQueryString();
        }
        return domain + currentURL;
    }

    public static String getLogMessage(Exception ex) {
        StackTraceElement[] trace = ex.getStackTrace();
        String str = DateProc.createTimestamp() + "||" + ex.getMessage() + "||";
        for (StackTraceElement trace1 : trace) {
            str += trace1 + "\t\n";
        }
        return str;
    }

    public static boolean checkNull(String input) {
        return input == null || input.equalsIgnoreCase("null") || input.equalsIgnoreCase("");
    }

    //em Minh thêm
    public static boolean checkNullTimestamp(Timestamp input) {
        return input == null || input.equals("null") || input.equals("0000/00/00");
    }

    //em Minh thêm
    public static String checkNullDate(String input) {
        if (input == null || input.equalsIgnoreCase("null") || input.equalsIgnoreCase("")) {
            input = "0000/00/00";
        }
        return input;
    }

    public static boolean checkNull(Object input) {
        return input == null;
    }

    public static String convert2NoSign(String org) {
        if (org == null) {
            org = "";
            return org;
        }
        char arrChar[] = org.toCharArray();
        char result[] = new char[arrChar.length];
        for (int i = 0; i < arrChar.length; i++) {
            switch (arrChar[i]) {
                case '\u00E1':
                case '\u00E0':
                case '\u1EA3':
                case '\u00E3':
                case '\u1EA1':
                case '\u0103':
                case '\u1EAF':
                case '\u1EB1':
                case '\u1EB3':
                case '\u1EB5':
                case '\u1EB7':
                case '\u00E2':
                case '\u1EA5':
                case '\u1EA7':
                case '\u1EA9':
                case '\u1EAB':
                case '\u1EAD':
                case '\u0203':
                case '\u01CE': {
                    result[i] = 'a';
                    break;
                }
                case '\u00E9':
                case '\u00E8':
                case '\u1EBB':
                case '\u1EBD':
                case '\u1EB9':
                case '\u00EA':
                case '\u1EBF':
                case '\u1EC1':
                case '\u1EC3':
                case '\u1EC5':
                case '\u1EC7':
                case '\u0207': {
                    result[i] = 'e';
                    break;
                }
                case '\u00ED':
                case '\u00EC':
                case '\u1EC9':
                case '\u0129':
                case '\u1ECB': {
                    result[i] = 'i';
                    break;
                }
                case '\u00F3':
                case '\u00F2':
                case '\u1ECF':
                case '\u00F5':
                case '\u1ECD':
                case '\u00F4':
                case '\u1ED1':
                case '\u1ED3':
                case '\u1ED5':
                case '\u1ED7':
                case '\u1ED9':
                case '\u01A1':
                case '\u1EDB':
                case '\u1EDD':
                case '\u1EDF':
                case '\u1EE1':
                case '\u1EE3':
                case '\u020F': {
                    result[i] = 'o';
                    break;
                }
                case '\u00FA':
                case '\u00F9':
                case '\u1EE7':
                case '\u0169':
                case '\u1EE5':
                case '\u01B0':
                case '\u1EE9':
                case '\u1EEB':
                case '\u1EED':
                case '\u1EEF':
                case '\u1EF1': {
                    result[i] = 'u';
                    break;
                }
                case '\u00FD':
                case '\u1EF3':
                case '\u1EF7':
                case '\u1EF9':
                case '\u1EF5': {
                    result[i] = 'y';
                    break;
                }
                case '\u0111': {
                    result[i] = 'd';
                    break;
                }
                case '\u00C1':
                case '\u00C0':
                case '\u1EA2':
                case '\u00C3':
                case '\u1EA0':
                case '\u0102':
                case '\u1EAE':
                case '\u1EB0':
                case '\u1EB2':
                case '\u1EB4':
                case '\u1EB6':
                case '\u00C2':
                case '\u1EA4':
                case '\u1EA6':
                case '\u1EA8':
                case '\u1EAA':
                case '\u1EAC':
                case '\u0202':
                case '\u01CD': {
                    result[i] = 'A';
                    break;
                }
                case '\u00C9':
                case '\u00C8':
                case '\u1EBA':
                case '\u1EBC':
                case '\u1EB8':
                case '\u00CA':
                case '\u1EBE':
                case '\u1EC0':
                case '\u1EC2':
                case '\u1EC4':
                case '\u1EC6':
                case '\u0206': {
                    result[i] = 'E';
                    break;
                }
                case '\u00CD':
                case '\u00CC':
                case '\u1EC8':
                case '\u0128':
                case '\u1ECA': {
                    result[i] = 'I';
                    break;
                }
                case '\u00D3':
                case '\u00D2':
                case '\u1ECE':
                case '\u00D5':
                case '\u1ECC':
                case '\u00D4':
                case '\u1ED0':
                case '\u1ED2':
                case '\u1ED4':
                case '\u1ED6':
                case '\u1ED8':
                case '\u01A0':
                case '\u1EDA':
                case '\u1EDC':
                case '\u1EDE':
                case '\u1EE0':
                case '\u1EE2':
                case '\u020E': {
                    result[i] = 'O';
                    break;
                }
                case '\u00DA':
                case '\u00D9':
                case '\u1EE6':
                case '\u0168':
                case '\u1EE4':
                case '\u01AF':
                case '\u1EE8':
                case '\u1EEA':
                case '\u1EEC':
                case '\u1EEE':
                case '\u1EF0': {
                    result[i] = 'U';
                    break;
                }

                case '\u00DD':
                case '\u1EF2':
                case '\u1EF6':
                case '\u1EF8':
                case '\u1EF4': {
                    result[i] = 'Y';
                    break;
                }
                case '\u0110':
                case '\u00D0':
                case '\u0089': {
                    result[i] = 'D';
                    break;
                }
                case (char) 160: {
                    result[i] = ' ';
                    break;
                }
                default:
                    result[i] = arrChar[i];
            }
        }
        String tem = new String(result);
        char[] charArray = tem.toCharArray();
        String output = "";
        for (int i = 0; i < charArray.length; ++i) {
            char a = charArray[i];
            if ((int) a > 255) {
//                    output += "&#" + (int) a + ";";
            } else {
                output += a;
            }
        }
        return output;
    }

    public static String convertTitle(String input) {
        if (input == null) {
            return null;
        }
        input = Tool.convert2NoSign(input);
        StringBuilder buffer = new StringBuilder();
        for (int i = 0; i < input.length(); i++) {
            char ch = input.charAt(i);
            if ((ch >= '0' && ch <= '9') || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z')) {
                buffer.append(ch);
            }
        }
        return buffer.toString();
    }

    public static String getNumber(String input) {
        if (input == null) {
            return null;
        }
        input = Tool.convert2NoSign(input);
        StringBuilder buffer = new StringBuilder();
        for (int i = 0; i < input.length(); i++) {
            char ch = input.charAt(i);
            if ((ch >= '0' && ch <= '9')) {
                buffer.append(ch);
            }
        }
        return buffer.toString();
    }

    public static String[] tag2Nosign(String[] tag) {
        if (tag == null || tag.length == 0) {
            return null;
        } else {
            for (int i = 0; i < tag.length; i++) {
                tag[i] = convertTitle(tag[i]);
            }
        }
        return tag;
    }

    public static String tag2String(String[] tag) {
        String tem = "";
        for (String one : tag) {
            tem += one + ",";
        }
        if (tem.endsWith(",")) {
            tem = tem.substring(0, tem.length() - 1);
        }
        return tem;
    }

    public static boolean getBoolean(String status) {
        return status != null && (status.equals("1") || status.equals("true"));
    }

    public static boolean getBoolean(int aInt) {
        boolean val;
        val = aInt != 0;
        return val;
    }

    public static String validStringRequest(String input) {
        if (input != null) {
            input = input.trim();
        } else {
            input = "";
        }
        return input;
    }

    public static int string2Integer(String input) {
        int tem = 0;
        try {
            tem = Integer.parseInt(input.trim());
        } catch (Exception e) {
            tem = 0;
        }
        return tem;
    }
    
    public static String dinhDangTienTe(String tienTe) {
        String str = null;
        Locale localeVN = new Locale("vi", "VN");
        NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);
        String str1 = currencyVN.format(Long.parseLong(tienTe));
        str = str1;
        return str1;
    } 

    public static int string2Integer(String input, int defaultVal) {
        int tem = 0;
        try {
            String tem2 = input.replace(",", "");
            String tem3 = tem2.replace(".", "");
            String tem4 = tem3.replace("đ", "");
//            System.out.println("--"+tem2+"--");
            tem = Integer.parseInt(tem4.trim());
        } catch (Exception e) {
            tem = defaultVal;
        }
        return tem;
    }

    public static long string2Long(String input) {
        long tem = 0;
        try {
            tem = Long.parseLong(input);
        } catch (Exception e) {
            tem = 0;
        }
        return tem;
    }

    public static long string2Long(String input, long defaultVal) {
        long tem = 0;
        try {
            tem = Long.parseLong(input);
        } catch (Exception e) {
            tem = defaultVal;
        }
        return tem;
    }

    public static double string2Double(String input) {
        double tem = 0;
        try {
            tem = Double.parseDouble(input);
        } catch (Exception e) {
            tem = 0;
        }
        return tem;
    }

    public static String stringToHTMLString(String string) {
        StringBuilder sb = new StringBuilder(string.length());
        // true if last char was blank
        boolean lastWasBlankChar = false;
        int len = string.length();
        char c;

        for (int i = 0; i < len; i++) {
            c = string.charAt(i);
            if (c == ' ') {
                // blank gets extra work,
                // this solves the problem you get if you replace all
                // blanks with &nbsp;, if you do that you loss
                // word breaking
                if (lastWasBlankChar) {
                    lastWasBlankChar = false;
                    sb.append("&nbsp;");
                } else {
                    lastWasBlankChar = true;
                    sb.append(' ');
                }
            } else {
                lastWasBlankChar = false;
                //
                // HTML Special Chars
                if (c == '"') {
                    sb.append("&quot;");
                } else if (c == '&') {
                    sb.append("&amp;");
                } else if (c == '<') {
                    sb.append("&lt;");
                } else if (c == '>') {
                    sb.append("&gt;");
                } else if (c == '\n') // Handle Newline
                {
                    sb.append("&lt;br/&gt;");
                } else {
                    int ci = 0xffff & c;
                    if (ci < 160) // nothing special only 7 Bit
                    {
                        sb.append(c);
                    } else {
                        // Not 7 Bit use the unicode system
                        sb.append("&#");
                        sb.append(new Integer(ci).toString());
                        sb.append(';');
                    }
                }
            }
        }
        return sb.toString();
    }

    public static String replaceString(String sStr, String oldStr, String newStr) {
        sStr = (sStr == null ? "" : sStr);
        String strVar = sStr;
        String tmpStr = "";
        String finalStr = "";
        int stpos = 0, endpos = 0, strLen = 0;
        while (true) {
            strLen = strVar.length();
            stpos = 0;
            endpos = strVar.indexOf(oldStr, stpos);
            if (endpos == -1) {
                break;
            }
            tmpStr = strVar.substring(stpos, endpos);
            tmpStr = tmpStr.concat(newStr);
            strVar = strVar.substring(endpos + oldStr.length() > sStr.length() ? endpos : endpos + oldStr.length(), strLen);
            finalStr = finalStr.concat(tmpStr);
            stpos = endpos;
        }
        finalStr = finalStr.concat(strVar);
        return finalStr;
    }

    public static String validStringUserInput(String sStr) {

        if (sStr == null) {
            sStr = "";
        }
        sStr = sStr.replaceAll("&", "&amp;");
        sStr = sStr.replaceAll("\"", "&quot;");
        sStr = sStr.replaceAll("'", "&apos;");
        sStr = sStr.replaceAll("<", "&lt;");
        sStr = sStr.replaceAll(">", "&gt;");
        sStr = sStr.replaceAll("&lt;br&gt;", "<br/>");
        sStr = sStr.replaceAll("&lt;br/&gt;", "<br/>");
        sStr = sStr.replaceAll("&lt;p&gt;", "<p>");
        sStr = sStr.replaceAll("&lt;/p&gt;", "</p>");
        sStr = sStr.replaceAll("&lt;hr&gt;", "<hr/>");
        sStr = sStr.replaceAll("&lt;hr/&gt;", "<hr/>");
        sStr = sStr.replaceAll("\n", "<br/>");
        return sStr;
    }

    public static String validTitle(String str) {
        if (str == null) {
            str = "";
        }
        str = str.replaceAll("&", "&amp;");
        str = str.replaceAll("\"", "&quot;");
        str = str.replaceAll("'", "&apos;");
        str = str.replaceAll("<", "&lt;");
        str = str.replaceAll(">", "&gt;");
        return str.trim();
    }

    public static String trimString(String input, int lenght) {
        String SPECIAL_CHARACTOR = "[ .-/]";
        String str = "";
        if (input == null) {
            return str;
        } else {
            StringTokenizer tokenSpace = new StringTokenizer(input, SPECIAL_CHARACTOR);
            while (tokenSpace.hasMoreTokens()) {
                String tempStr = tokenSpace.nextToken();
                if ((str + tempStr).length() < lenght) {
                    str += tempStr + " ";
                } else {
                    str += "...";
                    break;
                }
            }

            return str.trim();
        }
    }

    private static String getUrlFromImageTag(String imageTag) {
        try {
            imageTag = imageTag.replaceAll(" ", "");
            imageTag = imageTag.substring(imageTag.indexOf("src=\"") + 5);
            imageTag = imageTag.substring(0, imageTag.indexOf("\""));
        } catch (Exception e) {
        }
        return imageTag;
    }

    public static String getLongTimeString() {
        String str = "";
        long time = new Date().getTime();
        str += time;
        return str;
    }

    public static String getStringURL(String input) {
        if (input == null || input.equals("")) {
            return "";
        }
        input = input.trim();
        input = convert2NoSign(input);
        input = input.replaceAll("&amp;", "");
        input = input.replaceAll("amp;", "");
        input = input.replaceAll("&quot;", "");
        input = input.replaceAll("quot;", "");
        input = input.replaceAll("&apos;", "");
        input = input.replaceAll("apos;", "");
        input = input.replaceAll("&lt;", "");
        input = input.replaceAll("lt;", "");
        input = input.replaceAll("&gt;", "");
        input = input.replaceAll("gt;", "");
        input = input.replaceAll("&amp;", "");
        input = input.replaceAll("&AMP;", "");
        input = input.replaceAll("'", "");
        input = input.replaceAll(":", "");
        input = input.replaceAll(",", "");
        input = input.replaceAll("\\.", "");
        input = input.replaceAll("‘", "");
        input = input.replaceAll("“", "");
        input = input.replaceAll("”", "");
        input = input.replaceAll("\\?", "");
        input = input.replaceAll("~", "");
        input = input.replaceAll("!", "");
        input = input.replaceAll("@", "");
        input = input.replaceAll("#", "");
        input = input.replaceAll("$", "");
        input = input.replaceAll("%", "");
        input = input.replaceAll("^", "");
        input = input.replaceAll("&", "");
        input = input.replaceAll("…", "");
        input = input.replaceAll("\\*", "");
        input = input.replaceAll("\\(", "");
        input = input.replaceAll("\\)", "");
        input = input.replaceAll("\"", "");
        input = input.replaceAll("\'", "");
        input = input.replaceAll(" ", "-");
        input = input.replaceAll("/", "-");
        while (input.indexOf("--") > -1) {
            input = input.replaceAll("--", "-");
        }
        input = input.toLowerCase();
        return input;
    }

    public static String arrTagAscii(String input) {
        if (input == null || input.equals("")) {
            return "";
        }
        input = input.trim();
        input = convert2NoSign(input);
        input = input.replaceAll("&amp;", "");
        input = input.replaceAll("amp;", "");
        input = input.replaceAll("&quot;", "");
        input = input.replaceAll("quot;", "");
        input = input.replaceAll("&apos;", "");
        input = input.replaceAll("apos;", "");
        input = input.replaceAll("&lt;", "");
        input = input.replaceAll("lt;", "");
        input = input.replaceAll("&gt;", "");
        input = input.replaceAll("gt;", "");
        input = input.replaceAll("&amp;", "");
        input = input.replaceAll("&AMP;", "");
        input = input.replaceAll("'", "");
        input = input.replaceAll(":", "");
//        input = input.replaceAll(",", "");
        input = input.replaceAll("\\.", "");
        input = input.replaceAll("‘", "");
        input = input.replaceAll("“", "");
        input = input.replaceAll("”", "");
        input = input.replaceAll("\\?", "");
        input = input.replaceAll("~", "");
        input = input.replaceAll("!", "");
        input = input.replaceAll("@", "");
        input = input.replaceAll("#", "");
        input = input.replaceAll("$", "");
        input = input.replaceAll("%", "");
        input = input.replaceAll("^", "");
        input = input.replaceAll("&", "");
        input = input.replaceAll("…", "");
        input = input.replaceAll("\\*", "");
        input = input.replaceAll("\\(", "");
        input = input.replaceAll("\\)", "");
        input = input.replaceAll("\"", "");
        input = input.replaceAll("\'", "");
        input = input.replaceAll(" ", "-");
        input = input.replaceAll("/", "-");
        while (input.indexOf("--") > -1) {
            input = input.replaceAll("--", "-");
        }
        input = replaceString(input, ",-", ",");
//        String[] tags = input.split(",");
//        if (tags != null && tags.length > 0) {
//            int i = 1;
//            input = "";
//            for (String oneTag : tags) {
//                if (oneTag.startsWith("-")) {
//                    oneTag = oneTag.substring(1);
//                }
//                input += oneTag;
//                if (i != tags.length) {
//                    input += ",";
//                }
//            }
//        }
        input = input.toLowerCase();
        return input;
    }

    public static String getStringAlt(String input) {
        if (input == null || input.equals("")) {
            return "";
        }
        input = input.trim();
        input = input.replaceAll("&amp;", "");
        input = input.replaceAll("'", "");
        input = input.replaceAll(":", "");
        input = input.replaceAll(",", "");
        input = input.replaceAll("\\.", "");
        input = input.replaceAll("‘", "");
        input = input.replaceAll("“", "");
        input = input.replaceAll("”", "");
        input = input.replaceAll("\\?", "");
        input = input.replaceAll("~", "");
        input = input.replaceAll("!", "");
        input = input.replaceAll("@", "");
        input = input.replaceAll("#", "");
        input = input.replaceAll("$", "");
        input = input.replaceAll("%", "");
        input = input.replaceAll("^", "");
        input = input.replaceAll("&", "");
        input = input.replaceAll("\\*", "");
        input = input.replaceAll("\\(", "");
        input = input.replaceAll("\\)", "");
        input = input.replaceAll("\"", "");
        input = input.replaceAll(" ", "-");
        while (input.indexOf("--") > -1) {
            input = input.replaceAll("--", "-");
        }
        return input;
    }

    public static String readFileText(String path) {
        String Content = "";
        String sContent = "";
        try {
            FileInputStream fstream = new FileInputStream(path);
            try (DataInputStream in = new DataInputStream(fstream)) {
                BufferedReader br = new BufferedReader(new InputStreamReader(in, "UTF-8"));
                while ((Content = br.readLine()) != null) {
                    sContent += Content + "\n";
                }
            }
        } catch (IOException e) {
            System.err.println("Tool : Error: ReadFile >> " + e.getMessage());
        }
        return sContent;
    }

    public static boolean writeFileText(String content, String path) {
        boolean flag = false;
        try {
            try (Writer outw2 = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path), "UTF-8"))) {
                outw2.write(content);
                flag = true;
            } catch (Exception e) {
                flag = false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            flag = false;
        }
        return flag;
    }

    public static String validStringFCK(String content, String title_url) {
        if (content != null) {
            content = content.trim();
        } else {
            content = "";
        }
        // Xu lai Title cho ImageName
        title_url = getStringURL(title_url);
        content = FCKProcessImage(content, title_url);
        return content;
    }

    public static String FCKProcessImage(String content, String title_url) {
        if (content == null || content.equals("")) {
            return content;
        }
        String strFirst;
        String strLast;
        ArrayList<String> listImgTag = new ArrayList<>();
        int posImg = 0;
        try {
            int index = -1;
            while ((index = content.indexOf("<img")) > 0) {
                int lastIndex = -1;
                String striamge = "";
                // Phan truoc the <img
                strFirst = content.substring(0, index);
                // Phan tu the <img tro di
                strLast = content.substring(index);
//                System.out.println("phan con lai= "+strLast);
                lastIndex = strLast.indexOf(">");
                striamge = strLast.substring(0, lastIndex + 1);
//                System.out.println(striamge);
                // Phan con lai sau khi da loai the <img...>
                strLast = strLast.substring(striamge.length());
//                System.out.println(strLast);
                // Duong dan anh lay ra de xu ly
                listImgTag.add(striamge);
                // Tra lai str da lay duoc link anh
                content = strFirst + "##" + posImg + "##" + strLast;
//                System.out.println("str="+str);
//                System.out.println("--------------------------------");
                posImg++;
                index = -1;
            }
            /**
             * < XU LY CAC LINK ANH
             */
            int indexTem = 0;
            ArrayList<String> contentLink = ImageProcessCache(listImgTag, title_url);
            for (String oneLink : contentLink) {
                String imgStr = "<img alt='" + title_url + "' title ='" + title_url + "' class=\"photo\" src=\"" + oneLink + "\" />";
                content = replaceString(content, "##" + indexTem + "##", imgStr);
                indexTem++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return content;
    }

    public static String FCKProcessImageDisplay(String content, String title_url) {
        if (content == null || content.equals("")) {
            return content;
        }
        String strFirst;
        String strLast;
        ArrayList<String> listImgTag = new ArrayList<>();
        int posImg = 0;
        try {
            int index = -1;
            while ((index = content.indexOf("<img")) > 0) {
                int lastIndex = -1;
                String striamge = "";
                // Phan truoc the <img
                strFirst = content.substring(0, index);
                // Phan tu the <img tro di
                strLast = content.substring(index);
//                System.out.println("phan con lai= "+strLast);
                lastIndex = strLast.indexOf(">");
                striamge = strLast.substring(0, lastIndex + 1);
//                System.out.println(striamge);
                // Phan con lai sau khi da loai the <img...>
                strLast = strLast.substring(striamge.length());
//                System.out.println(strLast);
                // Duong dan anh lay ra de xu ly
                listImgTag.add(striamge);
                // Tra lai str da lay duoc link anh
                content = strFirst + "##" + posImg + "##" + strLast;
//                System.out.println("str="+str);
//                System.out.println("--------------------------------");
                posImg++;
                index = -1;
            }
            int indexTem = 0;
            for (String urlImage : listImgTag) {
                urlImage = getUrlFromImageTag(urlImage);
                String realLink = "";
                if (urlImage.contains("myname.vn")) {
                    realLink = urlImage;
                } else {
                    realLink = "http://myname.vn" + urlImage;
                }
                String imgStr = "<img alt='" + title_url + "' title ='" + title_url + "' class=\"photo\" src=\"" + realLink + "\" />";
                content = replaceString(content, "##" + indexTem + "##", imgStr);
                indexTem++;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return content;
    }

    /**
     * Xu ly lay anh ve Cache va tra lai List duong dan thuc theo Host cua Image
     *
     * @param listImgTag
     * @param title_url
     * @return
     */
    public static ArrayList<String> ImageProcessCache(ArrayList<String> listImgTag, String title_url) {
        ArrayList<String> allRealLink = new ArrayList<>();
        try {
            int i = 1;
            for (String urlImage : listImgTag) {
                // Duong dan anh trong the
                urlImage = getUrlFromImageTag(urlImage);
                if (urlImage.indexOf(MyContext.ARTICLES_IMG_CACHE_ALIAS) >= 0) {
                    allRealLink.add(urlImage);
                } else {
                    String _alias = MyContext.ARTICLES_IMG_CACHE_ALIAS + "/" + title_url + "_" + i + "." + getExtentionImageRequest(urlImage);
                    // Duong dan that
                    String real_path = MyContext.MYNAME_DIR + MyContext.ARTICLES_IMG_CACHE_ALIAS + "/" + title_url + "_" + i + "." + getExtentionImageRequest(urlImage);
//                    System.out.println("REAL PATH:" + real_path);
                    cacheImageRequest(urlImage, real_path, true, MyContext.WIDTH_IMAGE_IN_CONTENT);
                    //--------- Cho nay vi insert vao trong Web server nen ko con cai URL host nua
//                    String url_by_host = MyContext.URL_HOST_ALIAS_IMAGE + pathSave;
                    allRealLink.add(_alias);
                }
                i++;
            }
        } catch (Exception e) {
        }
        return allRealLink;
    }

    private static String getExtentionImageRequest(String urlImage) {
        String ext = "jpg";
        if (urlImage == null) {
            return ext;
        }
        int index = urlImage.lastIndexOf(".");
        if (index != -1) {
            ext = urlImage.substring(index + 1);
        } else {
            return ext;
        }
        return ext;
    }

    public static boolean cacheImageRequest(String urlImage, String realPath, boolean resize, int width_max) {
        boolean flag = false;
        try {
            URL urlimg = new URL(urlImage);
            URLConnection ucconnimg = urlimg.openConnection();
            InputStream ipstimg = ucconnimg.getInputStream();
            if (resize) {
                // Thay doi Kich Thuoc Anh Lay Ve                
                //TODO
                FileUtils.resizeMaxWithWriteImg(ipstimg, width_max, realPath, "jpg");
            } else {
                byte[] imgCache = DataConvert.InputStream2Bytes(ipstimg);
                if (imgCache != null && imgCache.length > 0) {
                    try (FileOutputStream file = new FileOutputStream(realPath)) {
                        file.write(imgCache);
                        file.flush();
                    }
                    flag = true;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return flag;
    }

    public static String priceWithDecimal(Double price) {
        DecimalFormat formatter = new DecimalFormat("###,###,###.00");
        return formatter.format(price);
    }

    public static String priceWithDecimal(Long price) {
        DecimalFormat formatter = new DecimalFormat("###,###,###.00");
        return formatter.format(price);
    }

    public static String priceWithoutDecimal(Double price) {
        DecimalFormat formatter = new DecimalFormat("###,###,###.##");
        return formatter.format(price);
    }

    public static String priceWithoutDecimal(Long price) {
        DecimalFormat formatter = new DecimalFormat("###,###,###.##");
        return formatter.format(price);
    }

    public static String priceWithoutDecimal(String price) {
        DecimalFormat formatter = new DecimalFormat("###,###,###.##");
        return formatter.format(price);
    }

    public static String priceToString(Double price) {
        String toShow = priceWithoutDecimal(price);
        if (toShow.indexOf(".") > 0) {
            return priceWithDecimal(price);
        } else {
            return priceWithoutDecimal(price);
        }
    }

    public static String priceToString(Long price) {
        String toShow = priceWithoutDecimal(price);
        if (toShow.indexOf(".") > 0) {
            return priceWithDecimal(price);
        } else {
            return priceWithoutDecimal(price);
        }
    }

    //em Minh thêm hàm này
    public static Timestamp convertDateToTimestamp(String date) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date dateFormat = null;
        try {
            dateFormat = formatter.parse(date);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        long timestamp = dateFormat.getTime();
        return new Timestamp(timestamp);
    }

    //em MInh thêm hàm này
    public static String convertTimestampToDate(Timestamp timestamp) {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        // Có thể thay đổi định dạng dd-MM-yyyy theo dạng khác tùy ý.
        String dateString = formatter.format(new Date(Long.parseLong(timestamp.toString())));
        return dateString;
    }

    //em Minh thêm
    public static Date convertStringToDate(String input) {
        Date d = null;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            d = dateFormat.parse(input);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return d;
    }
}
