package gk.myname.vn.utils;

import gk.myname.vn.entity.AppConfig;
import gk.myname.vn.entity.CDRSubmit;
import gk.myname.vn.entity.CdrStatisEntityTmp;
import java.util.HashMap;
import java.util.Set;
import org.apache.log4j.Logger;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Cường <duongcuong96 at gmail dot com>
 */
public class ThreadCheckErrors extends Thread {

    static final Logger logger = Logger.getLogger(ThreadCheckErrors.class);
    private static final int MINUTES = 60 * 1000;  //1 phut 
    private static final String KEYSLEEP_TIME_ERROR = "ALERT_SLEEP_TIME_ERROR";
    private static final String KEY_ERRORS_THRESHOLD = "MESSAGE_ERROR_THRESHOLD";
    //--
    public static boolean running = true;
    public static int SLEEP_TIME = AppConfig.getConfigValueInt(KEYSLEEP_TIME_ERROR, MINUTES) * MINUTES;      // MAC DINH 10'
    public static int ERRORS_THRESHOLD = AppConfig.getConfigValueInt(KEY_ERRORS_THRESHOLD, 10);  //Số tin vượt quá

//    chon tat ca  thong bao loi cua ngay hom nay
    public static HashMap<String, CdrStatisEntityTmp> currentErrorsList = new HashMap<>();
    public static HashMap newErrorsList = new HashMap();
    public static HashMap errorsQueueList = new HashMap();
    public static boolean isFirstRun = true;

    public static HashMap getDiff(HashMap<String, CdrStatisEntityTmp> newHash) {
//        tra ve 1 hashtable cua gia tri moi cua newHash + nap gia tri vao errorsQueueList 
        HashMap ht = new HashMap();
        Set<String> newHashKey = newHash.keySet();
        if (!newHashKey.isEmpty()) {
            for (String k : newHashKey) {
                CdrStatisEntityTmp newCdr = newHash.get(k);
                CdrStatisEntityTmp currentCdr = currentErrorsList.get(k);
                if (newCdr == null) {
                    newCdr = new CdrStatisEntityTmp();
                }
                if (currentCdr == null) {
                    currentCdr = new CdrStatisEntityTmp();
                }

                if (newCdr.total_count < currentCdr.total_count) {
                    //nếu currentHash > newHash -> đây là ngày mới, vì mỗi ngày error log bị reset về 0 -> reset currentHash
                    currentErrorsList.put(k, (new CdrStatisEntityTmp()));
                    Tool.debug("have a nice day ! ");
                }

                if (currentErrorsList.containsKey(k)) {
                    //neu currentHash chua gia tri key cua newHash thi so sanh , neu ko thi cho key moi vao ht 
                    if ((newCdr.total_count - currentCdr.total_count) >= ERRORS_THRESHOLD) {
                        errorsQueueList.put(k, newCdr);
                    }
                    ht.put(k, newCdr);
                } else {
                    if (newCdr.total_count >= ERRORS_THRESHOLD) {
                        //neu gia tri moi >= ERROR_THRESHOLD thi cung cho vao errorsQueueList 
                        errorsQueueList.put(k, newCdr);
                    }
                    ht.put(k, newCdr);
                }
            }
        } else {
            ht = null;
        }
        return ht;
    }//getDiff  

    public void resetVars() {
        errorsQueueList = null;
    }

    public boolean sendMail() {
        String subject = "_.::ERROR SEND BRAND IDC-SV::.__ ";
        String content = " ";
        Set<String> kHash = errorsQueueList.keySet();
        if (!kHash.isEmpty()) {
            for (String k : kHash) {
                if (!currentErrorsList.containsKey(k)) {
                    CdrStatisEntityTmp cdr = (CdrStatisEntityTmp) errorsQueueList.get(k);
                    content += "[new] : " + k + " : " + cdr.total_count + "<br/>";
                } else {
                    CdrStatisEntityTmp currentCdr = (CdrStatisEntityTmp) currentErrorsList.get(k);
                    CdrStatisEntityTmp newCdr = (CdrStatisEntityTmp) errorsQueueList.get(k);
                    content += "[old] : " + k + " : " + currentCdr.total_count + " | [new] : " + k + " : " + newCdr.total_count + "<br/>";
                }
            }
            AppConfig app = new AppConfig();
            return app.sendAlertMail_Error(subject, content);
        } else {
            Tool.debug("Khong gui tin bao loi vi khong co thay doi ");
            return false;
        }
    }

    @Override
    public void run() {
        CDRSubmit cdrDao = new CDRSubmit();
        while (running) {
            try {
                Tool.debug(" ThreadCheckErrors : sleep_Time : " + SLEEP_TIME + " millisecond " + " | errorsThreshold : " + ERRORS_THRESHOLD);
                // Load Lai Config DB
                SLEEP_TIME = AppConfig.getConfigValueInt(KEYSLEEP_TIME_ERROR, MINUTES) * MINUTES;
                ERRORS_THRESHOLD = AppConfig.getConfigValueInt(KEY_ERRORS_THRESHOLD, 10);  //Số tin vượt quá
                //-- Chay Lan Sau
                if (isFirstRun == false) {
                    if (currentErrorsList == null) {
                        Tool.debug("---- [ThreadCheckErrors : ERR] KHONG THE LAY ERRORS LIST TU DB -------");
                    }
                    newErrorsList = getDiff(cdrDao.getErrorsList());
                    if (newErrorsList != null) {
                        if (sendMail()) {
                            Tool.debug(" -------- [ThreadCheckErrors ] GUI MAIL THONG BAO THANH CONG -------- ");
                        } else {
                            Tool.debug(" -------- [ThreadCheckErrors : ERR] GUI MAIL THAT BAI -------- ");
                        }
                        currentErrorsList = (HashMap) newErrorsList.clone();
                    } else {
                        Tool.debug("------ [ThreadCheckErrors] : Khong co tin nhan bi loi nao, Khong gui mail ---------");
                    }
                    //xóa mảng errorsQueueList 
                    errorsQueueList = new HashMap();
                } else {
                    currentErrorsList = cdrDao.getErrorsList();
                    isFirstRun = false;
                    Tool.debug("---------------- ThreadCheckErrors:first run ,initialize currentErrorsList ------------------");
                }
                sleep(SLEEP_TIME);
            } catch (InterruptedException ex) {
                Tool.debug("[ERR] ------- ThreadCheckErrors is Interrupted ------------------ ");
            }
        }
    }

    public void stopThread() {
        this.interrupt();
    }
}
