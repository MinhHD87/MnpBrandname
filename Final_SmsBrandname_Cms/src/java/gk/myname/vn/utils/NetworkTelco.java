/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.gk.htc.ahp.brand.common;

/**
 *
 * @author @author LienHoa(CongNX)
 */
public class NetworkTelco {
    //For Vietnam telco
    public static enum VIETNAM {
        VIETTEL("VTE"),
        VINAPHONE("GPC"),
        MOBIFONE("VMS"),
        VIETNAMMOBILE("VNM"),
        GMOBILE("BL"),
        ITELECOM("DDG");
        
        public String val;

        public String getVal() {
            return val;
        }

        private VIETNAM(String val) {
            this.val = val;
        }
    }
    
    //For CAMBODIA telco
    public static enum CAMBODIA {
        CELLCARD("CCD"),
        METFONE("MFE"),
        BEELINE("VLE"),
        SMART("SMA"),
        QBMORE("QME"),
        EXCELL("ECL");
        
        public String val;

        public String getVal() {
            return val;
        }

        private CAMBODIA(String val) {
            this.val = val;
        }
    }
    
    //For DONGTIMOR telco
    public static enum DONGTIMOR {
        TELEMOR("TMR"),
        TIMORTELECOM("TTM");
        
        public String val;

        public String getVal() {
            return val;
        }

        private DONGTIMOR(String val) {
            this.val = val;
        }
    }
    
    //For MOZAMBIQUE telco
    public static enum MOZAMBIQUE {
        MOVITEL("MTL"),
        MCEL("MEL");
        
        public String val;

        public String getVal() {
            return val;
        }

        private MOZAMBIQUE(String val) {
            this.val = val;
        }
    }
    
    //For LAOS telco
    public static enum LAOS {
        UNITEL("UTL"),
        ETL("ETL"),
        TANGO("TGO"),
        LAOTEL("LEL");
        
        public String val;

        public String getVal() {
            return val;
        }

        private LAOS(String val) {
            this.val = val;
        }
    }
    
    //For MYANMA telco
    public static enum MYANMA {
        MYTEL("MYL"),
        MPT("MPT"),
        OOREDO("RED"),
        TELENOR("TER");
        
        public String val;

        public String getVal() {
            return val;
        }

        private MYANMA(String val) {
            this.val = val;
        }
    }
    
    //For HAITI telco
    public static enum HAITI {
        NATCOM("NAT"),
        DIGICEL("DIG"),
        COMCEL("CCE");
        
        public String val;

        public String getVal() {
            return val;
        }

        private HAITI(String val) {
            this.val = val;
        }
    }
    
    //For BURUNDI telco
    public static enum BURUNDI {
        LUMITEL("LUM"),
        AFRICELL("AFR"),
        LACELLSU("LAU");
        
        public String val;

        public String getVal() {
            return val;
        }

        private BURUNDI(String val) {
            this.val = val;
        }
    }
    
    //For CAMEROON telco
    public static enum CAMEROON {
        NEXTTEL("NEL"),
        MTN("MTN"),
        ORANGE("ORE");
        
        public String val;

        public String getVal() {
            return val;
        }

        private CAMEROON(String val) {
            this.val = val;
        }
    }
    
    //For TANZANIA telco
    public static enum TANZANIA {
        HALOTEL("HEL"),
        VODACOM("VOM"),
        ZANTEL("ZTL");
        
        public String val;

        public String getVal() {
            return val;
        }

        private TANZANIA(String val) {
            this.val = val;
        }
    }
    
    //For PERU telco
    public static enum PERU {
        BITEL("BIT"),
        CLARO("CLO"),
        TELEFONICA("TFA");
        
        public String val;

        public String getVal() {
            return val;
        }

        private PERU(String val) {
            this.val = val;
        }
    }
    
}
