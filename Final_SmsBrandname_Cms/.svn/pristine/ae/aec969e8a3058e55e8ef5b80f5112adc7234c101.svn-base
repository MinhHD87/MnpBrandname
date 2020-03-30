package gk.myname.vn.utils;

import com.gk.htc.ahp.brand.common.NetworkTelco;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;
import java.util.TimeZone;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.log4j.Logger;

public class SMSUtils {

    static Logger logger = Logger.getLogger(SMSUtils.class);
    private static final String HEXINDEX = "0123456789abcdef          ABCDEF";
    public static String CHAR_PARSE_MT = "###";
    public static String[] SO_NGIEP_VU = {};
    //-------------------------------------
    public static final String VIETTEL_OPERATOR = NetworkTelco.VIETNAM.VIETTEL.getVal();
    public static String VINA_OPERATOR = NetworkTelco.VIETNAM.VINAPHONE.getVal();
    public static String MOBI_OPERATOR = NetworkTelco.VIETNAM.MOBIFONE.getVal();
    public static String VNM_OPERATOR = NetworkTelco.VIETNAM.VIETNAMMOBILE.getVal();
    public static String BEELINE_OPERATOR = NetworkTelco.VIETNAM.GMOBILE.getVal();
    public static String DONGDUONG_OPERATOR = NetworkTelco.VIETNAM.ITELECOM.getVal();
    
    public static String CELLCARD_OPERATOR = NetworkTelco.CAMBODIA.CELLCARD.getVal();
    public static String METFONE_OPERATOR = NetworkTelco.CAMBODIA.METFONE.getVal();
    public static String BEELINECAMPUCHIA_OPERATOR = NetworkTelco.CAMBODIA.BEELINE.getVal();
    public static String SMART_OPERATOR = NetworkTelco.CAMBODIA.SMART.getVal();
    public static String QBMORE_OPERATOR = NetworkTelco.CAMBODIA.QBMORE.getVal();
    public static String EXCELL_OPERATOR = NetworkTelco.CAMBODIA.EXCELL.getVal();
    
    public static String TELEMOR_OPERATOR = NetworkTelco.DONGTIMOR.TELEMOR.getVal();
    public static String TIMOTELECOM_OPERATOR = NetworkTelco.DONGTIMOR.TIMORTELECOM.getVal();
    
    public static String MOVITEL_OPERATOR = NetworkTelco.MOZAMBIQUE.MOVITEL.getVal();
    public static String MCEL_OPERATOR = NetworkTelco.MOZAMBIQUE.MCEL.getVal();
    
    public static String UNITEL_OPERATOR = NetworkTelco.LAOS.UNITEL.getVal();
    public static String ETL_OPERATOR = NetworkTelco.LAOS.ETL.getVal();
    public static String TANGO_OPERATOR = NetworkTelco.LAOS.TANGO.getVal();
    public static String LAOTEL_OPERATOR = NetworkTelco.LAOS.LAOTEL.getVal();
    
    public static String MYTEL_OPERATOR = NetworkTelco.MYANMA.MYTEL.getVal();
    public static String MPT_OPERATOR = NetworkTelco.MYANMA.MPT.getVal();
    public static String OOREDO_OPERATOR = NetworkTelco.MYANMA.OOREDO.getVal();
    public static String TELENOR_OPERATOR = NetworkTelco.MYANMA.TELENOR.getVal();
    
    public static String NATCOM_OPERATOR = NetworkTelco.HAITI.NATCOM.getVal();
    public static String DIGICEL_OPERATOR = NetworkTelco.HAITI.DIGICEL.getVal();
    public static String COMCEL_OPERATOR = NetworkTelco.HAITI.COMCEL.getVal();
    
    public static String LUMITEL_OPERATOR = NetworkTelco.BURUNDI.LUMITEL.getVal();
    public static String AFRICELL_OPERATOR = NetworkTelco.BURUNDI.AFRICELL.getVal();
    public static String LACELLSU_OPERATOR = NetworkTelco.BURUNDI.LACELLSU.getVal();
    
    public static String NEXTTEL_OPERATOR = NetworkTelco.CAMEROON.NEXTTEL.getVal();
    public static String MTN_OPERATOR = NetworkTelco.CAMEROON.MTN.getVal();
    public static String ORANGE_OPERATOR = NetworkTelco.CAMEROON.ORANGE.getVal();
    
    public static String HALOTEL_OPERATOR = NetworkTelco.TANZANIA.HALOTEL.getVal();
    public static String VODACOM_OPERATOR = NetworkTelco.TANZANIA.VODACOM.getVal();
    public static String ZANTEL_OPERATOR = NetworkTelco.TANZANIA.ZANTEL.getVal();
    
    public static String BITEL_OPERATOR = NetworkTelco.PERU.BITEL.getVal();
    public static String CLARO_OPERATOR = NetworkTelco.PERU.CLARO.getVal();
    public static String TELEFONIA_OPERATOR = NetworkTelco.PERU.TELEFONICA.getVal();;
    
    public static int REJECT_MSG_LENG = -1;

    public static enum OPER {

        VIETTEL(NetworkTelco.VIETNAM.VIETTEL.getVal()),
        VINA(NetworkTelco.VIETNAM.VINAPHONE.getVal()),
        MOBI(NetworkTelco.VIETNAM.MOBIFONE.getVal()),
        VNM(NetworkTelco.VIETNAM.VIETNAMMOBILE.getVal()),
        BEELINE(NetworkTelco.VIETNAM.GMOBILE.getVal()),
        DONGDUONG(NetworkTelco.VIETNAM.ITELECOM.getVal()),
        CELLCARD(NetworkTelco.CAMBODIA.CELLCARD.getVal()),
        METFONE(NetworkTelco.CAMBODIA.METFONE.getVal()),
        BEELINECAMPUCHIA(NetworkTelco.CAMBODIA.BEELINE.getVal()),
        SMART(NetworkTelco.CAMBODIA.SMART.getVal()),
        QBMORE(NetworkTelco.CAMBODIA.QBMORE.getVal()),
        EXCELL(NetworkTelco.CAMBODIA.EXCELL.getVal()),
        TELEMOR(NetworkTelco.DONGTIMOR.TELEMOR.getVal()),//
        TIMORTELECOM(NetworkTelco.DONGTIMOR.TIMORTELECOM.getVal()),
        MOVITEL(NetworkTelco.MOZAMBIQUE.MOVITEL.getVal()),//
        MCEL(NetworkTelco.MOZAMBIQUE.MCEL.getVal()),
        UNITEL(NetworkTelco.LAOS.UNITEL.getVal()),//
        ETL(NetworkTelco.LAOS.ETL.getVal()),
        TANGO(NetworkTelco.LAOS.TANGO.getVal()),
        LAOTEL(NetworkTelco.LAOS.LAOTEL.getVal()),
        MYTEL(NetworkTelco.MYANMA.MYTEL.getVal()),//
        MPT(NetworkTelco.MYANMA.MPT.getVal()),
        OOREDO(NetworkTelco.MYANMA.OOREDO.getVal()),
        TELENOR(NetworkTelco.MYANMA.TELENOR.getVal()),
        NATCOM(NetworkTelco.HAITI.NATCOM.getVal()),//
        DIGICEL(NetworkTelco.HAITI.DIGICEL.getVal()),
        COMCEL(NetworkTelco.HAITI.COMCEL.getVal()),
        LUMITEL(NetworkTelco.BURUNDI.LUMITEL.getVal()),//
        AFRICELL(NetworkTelco.BURUNDI.AFRICELL.getVal()),
        LACELLSU(NetworkTelco.BURUNDI.LACELLSU.getVal()),
        NEXTTEL(NetworkTelco.CAMEROON.NEXTTEL.getVal()),//
        MTN(NetworkTelco.CAMEROON.MTN.getVal()),
        ORANGE(NetworkTelco.CAMEROON.ORANGE.getVal()),
        HALOTEL(NetworkTelco.TANZANIA.HALOTEL.getVal()),//
        VODACOM(NetworkTelco.TANZANIA.VODACOM.getVal()),
        ZANTEL(NetworkTelco.TANZANIA.ZANTEL.getVal()),
        BITEL(NetworkTelco.PERU.BITEL.getVal()),//
        CLARO(NetworkTelco.PERU.CLARO.getVal()),
        TELEFONIA(NetworkTelco.PERU.TELEFONICA.getVal());
        
        public String val;

        public String getVal() {
            return val;
        }

        private OPER(String val) {
            this.val = val;
        }
    }

    public static enum CODE {

        EXCEPTION(-1, "Unknow Exception Service"),
        //        ERROR(0, "Sending Fail"),
        SUCCESS(1, "Success"), // Tra ve ket qua cho KH khong duoc thay doi
        REJECT(-2, "REJECT"),
        IP_SER_NOT_ALLOW(2, "Authentication IP failure"), // Sai IP
        UNKNOW_SERVICE(3, "UnknowService"), // Sai user
        ERROR_SERVICE_HTC(4, "Service Send SMS Error"),
        SENDPHONE_INVALID(5, "Send Phone Invalid"),
        LOGIN_FAIL(6, "Authentication login failure"),
        BRAND_NOT_AVTIVE(7, "Brand not Active"),
        SMS_TELCO_NOT_ALLOW(8, "Send SMS to Telco Not Allow"),
        TEMP_NOT_VALID(9, "Template not valid"),
        MSG_LENGTH_NOT_VALID(10, "Message Length invalid"),
        UNICODE_MESSAGE(11, "Message Has Unicode Charactor"),
        MESSAGE_NULL_OR_EMPTY(12, "Message null or Empty"),
        ACC_LOCKED(13, "Account is locked"),
        SAME_CONTENT_SHORT_TIME(15, "The Same Content Short Time"),
        DUPLICATE_TRANS_ID(16, "The Same Trans_id on 5 Minus"),
        INVALID_XML_DATA(17, "Invalid XML Data"),
        INVALID_JSON_DATA(18, "Invalid Json Data"),
        OVER_TPS(19, "Over TPS"),
        CONTENT_BLACK(20, "Content Black List"),
        //--Advertise
        DATE_ADS_NOT_SET(21, "Time advertise not set"),
        DATE_ADS_BEFORE_NOW(22, "Date advertise is Before current Date"),
        TIME_ADS_NOT_ALLOW(23, "Wrong time advertise from 8:AM to 20:PM"),
        WRONG_TIME_ADS_SET(24, "Need to set advertising time after the current time 3h"),
        CAMPAIGN_ID_NOT_SET(25, "Campaign ID Confirm is not set"),
        CAMPAIGN_NOT_FOUND_BYID(26, "Campaign was not found by CampaignID"),
        CAMPAIGN_STATUS_NOT_WAIT(27, "The current status of the campaign is not WAIT"),
        CREATE_CAMPAIGN_ERROR(28, "Create Campaign Error"),
        USER_CANCEL_DEL(29, "User Delete Campaign"),
        //--
        SYS_MAINTAIN(98, "System Maintain"),
        RECEIVED(99, "RECEIVED") //--
        ;
        public int val;
        public String mess;
        private String result;

        public String getResult() {
            return result;
        }

        private void setResult(int val, String mess) {
            result = val + "." + mess;
        }

        private CODE(int val, String mess) {
            this.val = val;
            this.mess = mess;
            setResult(val, mess);
        }
    }

    public static String removePassLog(String input) {
        if (Tool.checkNull(input)) {
            return "";
        }
        String[] arr = input.split("\\|");
        String tmp = "";
        for (String one : arr) {
            if (!Tool.checkNull(one)) {
                one = one.trim();
            }
            if (!one.startsWith("pass")) {
                tmp += one + " |";
            }
        }
        if (!Tool.checkNull(tmp) && tmp.endsWith("|")) {
            tmp = tmp.substring(0, (tmp.length() - 1));
            tmp = tmp.trim();
        }
        return tmp;
    }

    //VIETTEL 016x -> 03x
    //MOBI 0120 -> 070,0121 ->079, 0122->077,0126->076,0128->078
    //VINA 0123 -> 083,0124 ->084, 0125->085,0127->081,0129->082
    //VNM 18x -> 0186 ->056, 0188->058
    public static boolean validPhoneVN(String phone) {
        phone = phoneTo84(phone);
        String regex = ""
                + "^"
                + "((843|845|847|848|849)\\d{8})|(841\\d{9})"
                + "$";
        // Create a Pattern object
        Pattern pattern = Pattern.compile(regex);
        // Now create matcher object.
        Matcher matcher = pattern.matcher(phone);
        return matcher.matches();
    }

    public static boolean isSoNghiepVu(String snumber) {
        boolean flag = false;
        for (String arr1 : SO_NGIEP_VU) {
            if (arr1.endsWith(snumber)) {
                flag = true;
                break;
            }
        }
        return flag;
    }

    public static int countNomalSMS(String msg) {
        int result = 0;
        if (!Tool.checkNull(msg)) {
            if (msg.length() <= 160) {
                result = 1;
            } else {
                result = msg.length() / 153;
                if (msg.length() % 153 != 0) {
                    result = result + 1;
                }
            }
        }
        return result;
    }

    public static int countSmsBrandQC(String mess, String oper) {
        int count = 1;
        if (!Tool.checkNull(mess)) {
            int length = mess.length();
            if (oper.equals(VIETTEL_OPERATOR)) {
                if (length <= 123) {
                    count = 1;
                } else if (length > 123 && length <= 268) {
                    count = 2;
                } else if (length > 268 && length <= 421) {
                    count = 3;
                } else if (length > 421 && length <= 574) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(VINA_OPERATOR)) {
                if (length <= 123) {
                    count = 1;
                } else if (length > 123 && length <= 268) {
                    count = 2;
                } else if (length > 268 && length <= 421) {
                    count = 3;
                } else if (length > 421 && length <= 574) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(MOBI_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(VNM_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(BEELINE_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(DONGDUONG_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(CELLCARD_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(METFONE_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(BEELINECAMPUCHIA_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(SMART_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(QBMORE_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(EXCELL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                //////////////
            } else if (oper.equals(TELEMOR_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(TIMOTELECOM_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                ///////////////////////////////
            }else if (oper.equals(MOVITEL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(MCEL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                //////////////////////////////////
            }else if (oper.equals(UNITEL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(ETL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(TANGO_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(LAOTEL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                /////////////////////////////////
            }else if (oper.equals(MYTEL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(MPT_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(OOREDO_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(TELENOR_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                ////////////////////////////
            }else if (oper.equals(NATCOM_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(DIGICEL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(COMCEL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                ////////////////////////
            }else if (oper.equals(LUMITEL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(AFRICELL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(LACELLSU_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                ///////////////////////////
            }else if (oper.equals(NEXTTEL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(MTN_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(ORANGE_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                /////////////
            }else if (oper.equals(HALOTEL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(VODACOM_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(ZANTEL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                ////////////////////
            }else if (oper.equals(BITEL_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }                
            }else if (oper.equals(CLARO_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(TELEFONIA_OPERATOR)) {
                if (length <= 127) {
                    count = 1;
                } else if (length > 127 && length <= 273) {
                    count = 2;
                } else if (length > 273 && length <= 426) {
                    count = 3;
                } else if (length > 426 && length <= 579) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                ////////////////////
            }else if (length <= 160) {
                count = 1;
            } else if (length > 160 && length <= 306) {
                count = 2;
            } else if (length > 306 && length <= 459) {
                count = 3;
            } else if (length > 459 && length <= 612) {
                count = 4;
            } else {
                count = REJECT_MSG_LENG;
            }
        } else {
            count = 0;
        }
        return count;
    }

    public static int countSmsBrandCSKH(String mess, String oper) {
        int count = 1;
        if (!Tool.checkNull(mess)) {
            int length = mess.length();
            if (oper.equals(VIETTEL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(VINA_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(MOBI_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(VNM_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(BEELINE_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(DONGDUONG_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            }else if (oper.equals(CELLCARD_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(METFONE_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(BEELINECAMPUCHIA_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(SMART_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(QBMORE_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(EXCELL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                ///////////////////////
            } else if (oper.equals(TELEMOR_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(TIMOTELECOM_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                /////////////////////////
            }else if (oper.equals(MOVITEL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(MCEL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                ////////////////////////////////
            }else if (oper.equals(UNITEL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(ETL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(TANGO_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(LAOTEL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                ///////////////////////////////////////
            }else if (oper.equals(MYTEL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(MPT_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(OOREDO_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(TELENOR_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                ////////////////////////
            } else if (oper.equals(NATCOM_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(DIGICEL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(COMCEL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                ////////////////////////////////////
            } else if (oper.equals(LUMITEL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(AFRICELL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(LACELLSU_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                ////////////////////////////
            } else if (oper.equals(NEXTTEL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(MTN_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(ORANGE_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                ////////////////////////
            }else if (oper.equals(HALOTEL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(VODACOM_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(ZANTEL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                //////////////////////////////
            }else if (oper.equals(BITEL_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(CLARO_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
            } else if (oper.equals(TELEFONIA_OPERATOR)) {
                if (length <= 160) {
                    count = 1;
                } else if (length > 160 && length <= 306) {
                    count = 2;
                } else if (length > 306 && length <= 459) {
                    count = 3;
                } else if (length > 459 && length <= 612) {
                    count = 4;
                } else {
                    count = REJECT_MSG_LENG;
                }
                ////////////////////////////////
            } else if (length <= 160) {
                count = 1;
            } else if (length > 160 && length <= 306) {
                count = 2;
            } else if (length > 306 && length <= 459) {
                count = 3;
            } else if (length > 459 && length <= 612) {
                count = 4;
            } else {
                count = REJECT_MSG_LENG;
            }
        } else {
            count = 0;
        }
        return count;
    }

    public static String[] arrangeCommandCode(String[] allCommandCode) {
        try {
            for (int i = 0; i < allCommandCode.length; i++) {
                for (int j = i + 1; j < allCommandCode.length; j++) {
                    String stem = "";
                    if (allCommandCode[j].length() > allCommandCode[i].length()) {
                        stem = allCommandCode[i].toUpperCase();
                        allCommandCode[i] = allCommandCode[j].toUpperCase();
                        allCommandCode[j] = stem;
                    }
                }
            }
        } catch (Exception e) {
            return allCommandCode;
        }
        return allCommandCode;
    }

    public static ArrayList validList(String listPhone) {
        ArrayList list = new ArrayList();
        if (listPhone != null) {
            String[] arrPhone = listPhone.split("[,;: ]");
            if (arrPhone != null && arrPhone.length > 0) {
                for (String onePhone : arrPhone) {
                    // Valid 1 Phone
                    if (onePhone == null) {
                        continue;
                    }
                    if (validPhoneVN(onePhone)) {
                        // So dien thoai hop le
                        onePhone = SMSUtils.phoneTo84(onePhone);
                        list.add(onePhone);
                    }
                }
            }
        }
        return list;
    }

    public static ArrayList listPhone(String listPhone) {
        ArrayList list = new ArrayList();
        if (listPhone != null) {
            String[] arrPhone = listPhone.split("[,;: ]");
            if (arrPhone != null && arrPhone.length > 0) {
                for (String onePhone : arrPhone) {
                    // Valid 1 Phone
                    if (onePhone == null) {
                        continue;
                    }
                    list.add(onePhone);
                }
            }
        }
        return list;
    }

    public static ArrayList validList(ArrayList<String> listPhone) {
        ArrayList list = new ArrayList();
        // VIETTEL AND OTHER
        if (listPhone != null) {
            for (String onePhone : listPhone) {
                // Valid 1 Phone
                if (validPhoneVN(onePhone)) {
                    list.add(onePhone);
                }
            }
        }
        return list;
    }

    public static String phoneTo84(String number) {
        if (number == null) {
            number = "";
            return number;
        }
        number = number.replaceAll("o", "0");
        if (number.startsWith("84")) {
            return number;
        } else if (number.startsWith("0")) {
            number = "84" + number.substring(1);
        } else if (number.startsWith("+84")) {
            number = number.substring(1);
        } else {
            number = "84" + number;
        }
        return number;
    }

    /**
     * PLA TUAN Loai Bo Cac Ky Tu Dac biet trong Msg
     *
     * @param msg
     * @return
     */
    public static String validMessage(String msg) {
        msg = msg.replace('.', ' ');
        msg = msg.replace('!', ' ');
        msg = msg.replace('$', ' ');
        msg = msg.replace('#', ' ');
        msg = msg.replace('[', ' ');
        msg = msg.replace(']', ' ');
        msg = msg.replace('(', ' ');
        msg = msg.replace(')', ' ');
        msg = msg.replace(',', ' ');
        msg = msg.replace(';', ' ');
        msg = msg.replace('"', ' ');
        msg = msg.replace('\'', ' ');
        msg = msg.replace('\\', ' ');
        msg = msg.replace('/', ' ');
        msg = msg.replace('%', ' ');
        msg = msg.replace('<', ' ');
        msg = msg.replace('>', ' ');
        msg = msg.replace('@', ' ');
        msg = msg.replace(':', ' ');
        msg = msg.replace('=', ' ');
        msg = msg.replace('?', ' ');
        msg = msg.replace('-', ' ');
        msg = msg.replace('_', ' ');
        msg = msg.trim();
        StringTokenizer tk = new StringTokenizer(msg, " ");
        msg = "";
        while (tk.hasMoreTokens()) {
            String sTmp = (String) tk.nextToken();
            if (!msg.equals("")) {
                msg += " " + sTmp;
            } else {
                msg += sTmp;
            }
        }
        msg = Tool.convert2NoSign(msg);
        return msg;
    }

    public static String sumNick(String nick) {
        if (nick == null || "".equals(nick)) {
            return null;
        }
        nick = nick.trim();
        int sum = 0;
        if (nick.length() < 2 && isNumberic(nick)) {
            return nick;
        }
        nick = nick.toUpperCase();
        for (int i = 0; i < nick.length(); i++) {
            char ch = nick.charAt(i);
            if (ch == 'A' || ch == 'J' || ch == 'S') {
                sum++;
                continue;
            }
            if (ch == 'B' || ch == 'K' || ch == 'T') {
                sum += 2;
                continue;
            }
            if (ch == 'C' || ch == 'L' || ch == 'U') {
                sum += 3;
                continue;
            }
            if (ch == 'D' || ch == 'M' || ch == 'V') {
                sum += 4;
                continue;
            }
            if (ch == 'E' || ch == 'N' || ch == 'W') {
                sum += 5;
                continue;
            }
            if (ch == 'F' || ch == 'O' || ch == 'X') {
                sum += 6;
                continue;
            }
            if (ch == 'G' || ch == 'P' || ch == 'Y') {
                sum += 7;
                continue;
            }
            if (ch == 'H' || ch == 'Q' || ch == 'Z') {
                sum += 8;
                continue;
            }
            if (ch == 'I' || ch == 'R') {
                sum += 9;
            }
        }

        String sTmp = (new StringBuilder()).append("").append(sum).toString();
        sum = 0;
        int iTmp;
        for (; sTmp.length() != 1; sTmp = String.valueOf(iTmp)) {
            iTmp = 0;
            for (int i = 0; i < sTmp.length(); i++) {
                char temp = sTmp.charAt(i);
                if (Character.isDigit(temp)) {
                    iTmp += Integer.parseInt(String.valueOf(temp));
                }
            }

        }

        return sTmp;
    }

    public static String buildMobileOperator(String phone) {
        String mobileOperator = "OTHER";
        phone = phoneTo84(phone);                   // Chuyen ve 1 dinh dang cho chuan
        boolean isPhoneVn = validPhoneVN(phone);    // Fix loi So dien thoai dai hon 10 hoac 11 so
        if (!isPhoneVn) {
            return mobileOperator;
        }
        if (//-
                phone.startsWith("8491")
                || phone.startsWith("8494")
                || phone.startsWith("84123") 
                || phone.startsWith("84124") 
                || phone.startsWith("84125") 
                || phone.startsWith("84127") 
                || phone.startsWith("84129")
                || phone.startsWith("8488") // NEW
                || phone.startsWith("8481") 
                || phone.startsWith("8482") 
                || phone.startsWith("8483") 
                || phone.startsWith("8484") 
                || phone.startsWith("8485")// NEW
                ) {
            //VINA
            mobileOperator = OPER.VINA.val;
        } else if (//--
                phone.startsWith("8490")
                || phone.startsWith("8493")
                || phone.startsWith("84120") 
                || phone.startsWith("84121") 
                || phone.startsWith("84122") 
                || phone.startsWith("84126") 
                || phone.startsWith("84128")
                || phone.startsWith("8489")
                || phone.startsWith("8470") 
                || phone.startsWith("8476") 
                || phone.startsWith("8477") 
                || phone.startsWith("8478") 
                || phone.startsWith("8479") // NEW
                ) {
            // MOBILE
            mobileOperator = OPER.MOBI.val;
        } else if (//--
                phone.startsWith("8498")
                || phone.startsWith("8497")
                || phone.startsWith("8496") // EVN Cu
//                || phone.startsWith("8416")
                || phone.startsWith("8486") // NEW
                || phone.startsWith("8432") // Chuyen Mang Moi 016 -> 03x
                || phone.startsWith("8433") // Chuyen Mang Moi 016 -> 03x
                || phone.startsWith("8434") // Chuyen Mang Moi 016 -> 03x
                || phone.startsWith("8435") // Chuyen Mang Moi 016 -> 03x
                || phone.startsWith("8436") // Chuyen Mang Moi 016 -> 03x
                || phone.startsWith("8437") // Chuyen Mang Moi 016 -> 03x
                || phone.startsWith("8438") // Chuyen Mang Moi 016 -> 03x
                || phone.startsWith("8439") // Chuyen Mang Moi 016 -> 03x
                ) {
            mobileOperator = OPER.VIETTEL.val;
        } else if (phone.startsWith("8492")
                || phone.startsWith("84188")
                // || phone.startsWith("84187") 
                || phone.startsWith("84186")
                // || phone.startsWith("84184") 
                || phone.startsWith("8452")
                || phone.startsWith("8456")
                || phone.startsWith("8458")) {
            // VIET NAM MOBILE
            mobileOperator = OPER.VNM.val;
        } else if (phone.startsWith("099") 
                || phone.startsWith("8499") 
                || phone.startsWith("+8499")
                || phone.startsWith("0199") 
                || phone.startsWith("84199") 
                || phone.startsWith("8459")
                || phone.startsWith("+84199")) {
            mobileOperator = OPER.BEELINE.val;
            //GMOBILE
        } else if (phone.startsWith("8487")) {
            mobileOperator = OPER.DONGDUONG.val;
            //DONG DUONG MOBILE
        } else {
            mobileOperator = "OTHER";
        }
        return mobileOperator;
    }

    public static String getTimeString() {
        Calendar cal = Calendar.getInstance(TimeZone.getDefault());
        String DATE_FORMAT = "HH:mm:ss";
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
                DATE_FORMAT);
        sdf.setTimeZone(TimeZone.getDefault());
        return sdf.format(cal.getTime());
    }

    public static byte[] hexToByte(String s) {
        int l = s.length() / 2;
        byte data[] = new byte[l];
        int j = 0;
        for (int i = 0; i < l; i++) {
            char c = s.charAt(j++);
            int n, b;
            n = HEXINDEX.indexOf(c);
            b = (n & 0xf) << 4;
            c = s.charAt(j++);
            n = HEXINDEX.indexOf(c);
            b += (n & 0xf);
            data[i] = (byte) b;
        }
        return data;
    }

    public static String stringToHexString(String str) {
        byte[] bytes = null;
        String temp = "";
        try {
            bytes = str.getBytes("US-ASCII");
        } catch (Exception ex) {
            return null;
        }
        for (int i = 0; i < bytes.length; i++) {
            temp = temp + Integer.toHexString(bytes[i]);
        }
        return temp;
    }

    public static String stringToHex(String str) {
        char[] chars = str.toCharArray();
        StringBuilder strBuffer = new StringBuilder();
        for (int i = 0; i < chars.length; i++) {
            strBuffer.append(Integer.toHexString((int) chars[i]));
        }
        return strBuffer.toString();
    }

    public static boolean isNumberic(String sNumber) {
        if (sNumber == null || "".equals(sNumber)) {
            return false;
        }
        for (int i = 0; i < sNumber.length(); i++) {
            char ch = sNumber.charAt(i);
            char ch_max = '9';
            char ch_min = '0';
            if (ch < ch_min || ch > ch_max) {
                return false;
            }
        }

        return true;
    }

    public static boolean checkEVN(String userId) {
        String region[] = {
            "18", "19", "20", "210", "211", "22", "23", "240", "241", "25",
            "26", "27", "280", "281", "29", "30", "31", "320", "321", "33",
            "34", "350", "351", "36", "37", "38", "39", "4", "50", "510",
            "511", "52", "53", "54", "55", "56", "57", "58", "59", "60",
            "61", "62", "63", "64", "650", "651", "66", "67", "68", "70",
            "71", "72", "73", "74", "75", "76", "77", "780", "781", "79",
            "8"
        };
        boolean valid = false;
        if (!userId.startsWith("0") || !userId.startsWith("84")) {
            return false;
        }
        String isRegion = "";
        if (userId.startsWith("84")) {
            userId = userId.substring(2);
        } else {
            userId = userId.substring(1);
        }
        int i = 0;
        do {
            if (i >= region.length - 1) {
                break;
            }
            if (userId.startsWith(region[i])) {
                int len = region[i].length();
                String sTmp = userId.substring(len, len + 1);
                if (sTmp.equals("2")) {
                    valid = true;
                } else {
                    valid = false;
                }
                isRegion = region[i];
                break;
            }
            i++;
        } while (true);
        if (valid) {
            if ((userId.startsWith("4") || userId.startsWith("8")) && userId.length() != 8) {
                return false;
            }
            if (!userId.startsWith("4") && !userId.startsWith("8") && userId.length() != 6 + isRegion.length()) {
                return false;
            }
        }
        return valid;
    }

    public static List splitLongMsg(String arg) {
        String result[] = new String[3];
        List v = new ArrayList();
        int segment = 0;
        if (arg.length() <= 160) {
            result[0] = arg;
            v.add(result[0]);
            return v;
        }
        segment = 160;
        StringTokenizer tk = new StringTokenizer(arg, " ");
        String temp = "";
        int j = 0;
        do {
            if (!tk.hasMoreElements()) {
                break;
            }
            String token = (String) tk.nextElement();
            if (temp.equals("")) {
                temp += token;
            } else {
                temp += " " + token;
            }
            if (temp.length() > segment) {
                temp = token;
                j++;
            } else {
                result[j] = temp;
            }
        } while (j != 3);
        for (int i = 0; i < result.length; i++) {
            if (result[i] != null) {
                v.add(result[i]);
            }
        }
        return v;
    }
}
