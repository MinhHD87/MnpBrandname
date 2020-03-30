/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.config;

import gk.myname.vn.admin.Account;
import gk.myname.vn.entity.AppConfig;
import gk.myname.vn.entity.CDRSubmit;
import gk.myname.vn.utils.DateProc;
import gk.myname.vn.utils.SendMail;
import gk.myname.vn.utils.Tool;
import java.util.ArrayList;
import org.apache.log4j.Logger;

/**
 *
 * @author TUANPLA
 */
public class Monitor extends Thread {

    static final Logger logger = Logger.getLogger(Monitor.class);
    private static boolean NOFIRY = false;

    @Override
    public void run() {
        System.out.println("=====> Send Notify Statistic SMS BRAND HTC Starting");
        double hm = 0;
        CDRSubmit cdrDao = new CDRSubmit();
        while (MyContext.running) {
            String mailList = AppConfig.getConfigValueCache("LIST_MAIL_STATISTIC");
            ArrayList<String> toEmail = SendMail.parseListMail(mailList);
            hm = DateProc.getTimer();
            try {
                if (hm < 8) {
                    NOFIRY = false;
                }
                if (hm > 8 && !NOFIRY && hm < 8.5) {
                    String subject = "![SMS BRAND HTC REPORT " + DateProc.createDDMMYYYY() + "]";
                    String conntent = cdrDao.buildContentCDR();
                    SendMail.sendMail(subject, conntent, toEmail, "[HTC BRAND] REPORT");
                    NOFIRY = true;
                }
                Thread.sleep(10 * 60 * 1000);
                Account.outerReload();
                Tool.debug("Report SMS BRAND HTC is live...NOFIRY:[" + NOFIRY + "]");
            } catch (Exception e) {
                logger.error(Tool.getLogMessage(e));
            }
        }
    }

    public void stopThread() {
        this.interrupt();
    }
}
