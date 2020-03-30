/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.utils;

import gk.myname.vn.entity.AppConfig;
import gk.myname.vn.entity.Money_info;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;

/**
 *
 * @author Cường <duongcuong96 at gmail dot com>
 */
public class ThreadCheckMoney extends Thread {

    static Logger logger = Logger.getLogger(ThreadCheckMoney.class);
    public boolean running = true;
    public int delayTimeInMinute = 1;
    public static final int SLEEP_TIME = 60 * 60 * 1000;// 1h
    public static String MONEY_THRESHOLD_KEY = "MONEY_THRESHOLD";
    public static String MONEY_WARNING_THRESHOLD_KEY = "MONEY_WARNING_THRESHOLD";
    static long lastMoney = new Money_info().getLastMoney();
    AppConfig app = new AppConfig();

    public void alertIfMoneyLargerThanCurrentMoney(long currentMoney, long newMoney, long moneyThreshold) {

        String subject = "__::[TÀI KHOẢN ]::__";
        String content = null;

        if (Math.abs(newMoney - currentMoney) >= moneyThreshold) {
            if (newMoney > currentMoney) {
                subject = " [BLANCER => VAS VT] report [TÀI KHOẢN TĂNG] ";
                content = "Tài khoản thay đổi <b>TĂNG</b> : <b> " + Tool.priceToString(newMoney - currentMoney) + " </b>"
                        + " <br/> Tài khoản cũ : <b> " + Tool.priceToString(currentMoney) + " </b> "
                        + "<br/> Tài khoản mới : <b> " + Tool.priceToString(newMoney) + " </b> ";
            }
            if (newMoney < currentMoney) {
                subject = "[BLANCER => VAS VT] report [TÀI KHOẢN GIẢM] ";
                content = "Tài khoản thay đổi <b>GIẢM</b> : <b> " + Tool.priceToString(currentMoney - newMoney) + " </b>"
                        + " <br/> Tài khoản cũ : <b> " + Tool.priceToString(currentMoney) + " </b> "
                        + "<br/> Tài khoản mới : <b> " + Tool.priceToString(newMoney) + " </b> ";
            }
            if (app.sendAlertMail_Money(subject, content)) {
                logger.log(Level.INFO, "[MAIL SENT] money has changed," + "[OLD] " + Tool.priceToString(currentMoney) + " | [NEW] " + Tool.priceToString(newMoney) + " | [DIFF] " + Tool.priceToString(newMoney - currentMoney));
            } else {
                System.out.println("send mail that bai !! ");
                logger.log(Level.ERROR, "GUI MAIL THAT BAI ");
            }
//            System.out.println("[MAIL SENT] current money has changed," + "[OLD] " + currentMoney + " | [NEW] " + newMoney + " | [DIFF] " + (newMoney - currentMoney));
        } else {
            System.out.println("[NO MAIL WAS SENT] Money : " + "[OLD] =" + Tool.priceToString(currentMoney) + " | [NEW] = " + Tool.priceToString(newMoney) + " | DIFF " + Tool.priceToString(newMoney - currentMoney));
        }
    }

    @Override
    public void run() {
        Money_info mneyDao = new Money_info();
        while (running) {
            try {
                System.out.println("------------------ ThreadCheckMoney is running -----------------");
                long moneyThreshold = Tool.string2Long(AppConfig.getConfigValueCache(MONEY_THRESHOLD_KEY));
                long newMoney = mneyDao.getLastMoney();
                long moneyWarningThreshold = Tool.string2Long(AppConfig.getConfigValueCache(MONEY_WARNING_THRESHOLD_KEY));

                // mỗi 1 tiếng kiểm tra số tiền hiện tại <= mức tiền cảnh báo 1 lần
                long currentMoney = mneyDao.getLastMoney();
                if (currentMoney <= moneyWarningThreshold) {
                    String subject = "[BLANCER- BRAND - VAS VT] Warning " + DateProc.Timestamp2DDMMYYYYHH24MiSS(DateProc.createTimestamp());
                    String content = "Tài khoản giảm xuống dưới: <b style=\"color: blue\">" + Tool.priceToString(moneyWarningThreshold) + "</b>"
                            + "<br/>Số tiền hiện tài còn: <b style=\"color: red\">" + Tool.priceToString(currentMoney) + "</b>";
                    app.sendAlertMail_Money(subject, content);
                    System.out.println("[ Warning ] : Tai khoan : " + Tool.priceToString(currentMoney)
                            + " giam xuong duoi " + Tool.priceToString(moneyWarningThreshold)
                    );

                }

                System.out.println("[last money ] : " + Tool.priceToString(lastMoney) + " | [new money ] : " + Tool.priceToString(newMoney) + " | [ DIFF ]: " + Tool.priceToString(lastMoney - newMoney));
                alertIfMoneyLargerThanCurrentMoney(lastMoney, newMoney, moneyThreshold);
                System.out.println("[ money threshold :  ] " + Tool.priceToString(moneyThreshold));

                if (Math.abs(newMoney - lastMoney) >= moneyThreshold) {
                    lastMoney = newMoney;
                }
                System.out.println("----------------------ThreadCheckMoney---------------------------");
                sleep(SLEEP_TIME);
            } catch (InterruptedException ex) {
                System.out.println("[ERR] ------- ThreadCheckMoney is Interrupted ------------------ ");
                ex.printStackTrace();
            }
        }

    }

    public void stopThread() {
        running = false;
        this.interrupt();
    }

}
