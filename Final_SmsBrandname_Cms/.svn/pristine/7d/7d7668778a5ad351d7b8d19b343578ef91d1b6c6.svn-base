/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package gk.myname.vn.entity;

import gk.myname.vn.utils.SMSUtils;
import gk.myname.vn.utils.Tool;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

/**
 *
 * @author TUANPLA
 */
public class RouteTable {

    public static void main(String[] args) {
//        RouteTable tmp = new RouteTable();
//        for (Field field : tmp.getClass().getDeclaredFields()) {
//            Tool.debug(field.getName());
////            field.set(object, jobject.getString(field.getName()));
//        }
//        RouteTable route = new RouteTable();
//        OperProperties vte = route.getVte();
//        vte.setOperCode(SMSUtils.OPER.VIETTEL.val);
//        //--
//        OperProperties mobi = route.getMobi();
//        mobi.setOperCode(SMSUtils.OPER.MOBI.val);
//        //--
//        OperProperties vina = route.getVina();
//        vina.setOperCode(SMSUtils.OPER.VINA.val);
//        //--
//        OperProperties vnm = route.getVnm();
//        vnm.setOperCode(SMSUtils.OPER.VNM.val);
//        //--
//        OperProperties bl = route.getBl();
//        bl.setOperCode(SMSUtils.OPER.BEELINE.val);
//        //--
//
//        String str = toStringJson(route);
//        System.out.println(str);
//        RouteTable result = json2Object(str);
//        System.out.println(result.getVte().operCode);
//        System.out.println(result.getMobi().operCode);
//        System.out.println(result.getVina().operCode);
//        System.out.println(result.getVnm().operCode);
//        System.out.println(result.getBl().operCode);
        String str = "{\"bl\":{\"operCode\":\"BL\",\"route_CSKH\":\"0\",\"route_QC\":\"0\"},\"mobi\":{\"operCode\":\"VMS\",\"route_CSKH\":\"0\",\"route_QC\":\"0\"},\"vina\":{\"operCode\":\"GPC\",\"route_CSKH\":\"XIAOKIN\",\"route_QC\":\"0\"},\"vnm\":{\"operCode\":\"VNM\",\"route_CSKH\":\"0\",\"route_QC\":\"0\"},\"vte\":{\"operCode\":\"VTE\",\"route_CSKH\":\"VAS_VT_WS\",\"route_QC\":\"VAS_VT_WS\"}}";
        //{"bl":{"group":"0","operCode":"BL","route_CSKH":"ANTIT","route_QC":"0"},"mobi":{"group":"UNITEL","operCode":"VMS","route_CSKH":"HTC_SOUTH","route_QC":"0"},"vina":{"group":"N5","operCode":"GPC","route_CSKH":"HTC_SOUTH","route_QC":"0"},"vnm":{"group":"0","operCode":"VNM","route_CSKH":"ANTIT","route_QC":"0"},"vte":{"group":"UNITEL","operCode":"VTE","route_CSKH":"ANTIT","route_QC":"0"}}
        RouteTable tmp = json2Object(str);
        OperProperties mobi = tmp.getMobi();
        System.out.println(mobi.getOperCode());
        System.out.println(mobi.getRoute_CSKH());
        System.out.println(mobi.getRoute_QC());
        System.out.println(mobi.getGroup());
    }

    public static RouteTable json2Object(String str) {
        RouteTable result = new RouteTable();
        if (!Tool.checkNull(str)) {
            try {
                JSONObject obj = (JSONObject) JSONSerializer.toJSON(str);
                
                try {
                    JSONObject vteJson = (JSONObject) obj.get("vte");
                    OperProperties vte = (OperProperties) JSONObject.toBean(vteJson, OperProperties.class);
                    result.setVte(vte);
                } catch (Exception e) {
                    Tool.debug("Route table khong co VIETTEL:");
                }
                try {
                    JSONObject mobiJson = (JSONObject) obj.get("mobi");
                    OperProperties mobi = (OperProperties) JSONObject.toBean(mobiJson, OperProperties.class);
                    result.setMobi(mobi);
                } catch (Exception e) {

                    Tool.debug("Route table khong co MOBI FONE");
                }
                try {
                    JSONObject vinaJson = (JSONObject) obj.get("vina");
                    OperProperties vina = (OperProperties) JSONObject.toBean(vinaJson, OperProperties.class);
                    result.setVina(vina);
                } catch (Exception e) {
                    Tool.debug("Route table khong co VINA PHONE");
                }
                try {
                    JSONObject vnmJson = (JSONObject) obj.get("vnm");
                    OperProperties vnm = (OperProperties) JSONObject.toBean(vnmJson, OperProperties.class);
                    result.setVnm(vnm);
                } catch (Exception e) {
                    Tool.debug("Route table khong co VIETNAM MOBI");
                }
                try {
                    JSONObject blJson = (JSONObject) obj.get("bl");
                    OperProperties bl = (OperProperties) JSONObject.toBean(blJson, OperProperties.class);
                    result.setBl(bl);
                } catch (Exception e) {
                    Tool.debug("Route table khong co BEE LINE");
                }
                try {
                    JSONObject ddgJson = (JSONObject) obj.get("ddg");
                    OperProperties ddg = (OperProperties) JSONObject.toBean(ddgJson, OperProperties.class);
                    result.setDdg(ddg);
                } catch (Exception e) {
                    OperProperties ddg = new OperProperties();
                    ddg.setOperCode("DDG");
                    result.setDdg(ddg);
                    Tool.debug("Route table khong co DONG DUONG");
                }
                ///////////////////////////////
                try {
                    JSONObject lumitelJson = (JSONObject) obj.get("lumitel");
                    OperProperties lumitel = (OperProperties) JSONObject.toBean(lumitelJson, OperProperties.class);
                    result.setLumitel(lumitel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co lumitel");
                }
                
                try {
                    JSONObject africellJson = (JSONObject) obj.get("africell");
                    OperProperties africell = (OperProperties) JSONObject.toBean(africellJson, OperProperties.class);
                    result.setAfricell(africell);
                } catch (Exception e) {
                    Tool.debug("Route table khong co africell");
                }
                
                try {
                    JSONObject lacellsuJson = (JSONObject) obj.get("lacellsu");
                    OperProperties lacellsu = (OperProperties) JSONObject.toBean(lacellsuJson, OperProperties.class);
                    result.setLacellsu(lacellsu);
                } catch (Exception e) {
                    Tool.debug("Route table khong co lacellsu");
                }
                //////////////////////////////////////////
                try {
                    JSONObject nexttelJson = (JSONObject) obj.get("nexttel");
                    OperProperties nexttel = (OperProperties) JSONObject.toBean(nexttelJson, OperProperties.class);
                    result.setNexttel(nexttel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co nexttel");
                }
                
                try {
                    JSONObject mtnJson = (JSONObject) obj.get("mtn");
                    OperProperties mtn = (OperProperties) JSONObject.toBean(mtnJson, OperProperties.class);
                    result.setMtn(mtn);
                } catch (Exception e) {
                    Tool.debug("Route table khong co mtn");
                }
                
                try {
                    JSONObject orangeJson = (JSONObject) obj.get("orange");
                    OperProperties orange = (OperProperties) JSONObject.toBean(orangeJson, OperProperties.class);
                    result.setOrange(orange);
                } catch (Exception e) {
                    Tool.debug("Route table khong co orange");
                }
                /////////////////////////
                try {
                    JSONObject cellcardJson = (JSONObject) obj.get("cellcard");
                    OperProperties cellcard = (OperProperties) JSONObject.toBean(cellcardJson, OperProperties.class);
                    result.setCellcard(cellcard);
                } catch (Exception e) {
                    Tool.debug("Route table khong co cellcard");
                }
                
                try {
                    JSONObject metfoneJson = (JSONObject) obj.get("metfone");
                    OperProperties metfone = (OperProperties) JSONObject.toBean(metfoneJson, OperProperties.class);
                    result.setMetfone(metfone);
                } catch (Exception e) {
                    Tool.debug("Route table khong co metfone");
                }
                
                try {
                    JSONObject beelineCampuchiaJson = (JSONObject) obj.get("beelineCampuchia");
                    OperProperties beelineCampuchia = (OperProperties) JSONObject.toBean(beelineCampuchiaJson, OperProperties.class);
                    result.setBeelineCampuchia(beelineCampuchia);
                } catch (Exception e) {
                    Tool.debug("Route table khong co beelineCampuchia");
                }
                
                try {
                    JSONObject smartJson = (JSONObject) obj.get("smart");
                    OperProperties smart = (OperProperties) JSONObject.toBean(smartJson, OperProperties.class);
                    result.setSmart(smart);
                } catch (Exception e) {
                    Tool.debug("Route table khong co smart");
                }
                
                try {
                    JSONObject qbmoreJson = (JSONObject) obj.get("qbmore");
                    OperProperties qbmore = (OperProperties) JSONObject.toBean(qbmoreJson, OperProperties.class);
                    result.setQbmore(qbmore);
                } catch (Exception e) {
                    Tool.debug("Route table khong co qbmore");
                }
                
                try {
                    JSONObject excellJson = (JSONObject) obj.get("excell");
                    OperProperties excell = (OperProperties) JSONObject.toBean(excellJson, OperProperties.class);
                    result.setExcell(excell);
                } catch (Exception e) {
                    Tool.debug("Route table khong co excell");
                }
                //////////////////////////////////////
                try {
                    JSONObject telemorJson = (JSONObject) obj.get("telemor");
                    OperProperties telemor = (OperProperties) JSONObject.toBean(telemorJson, OperProperties.class);
                    result.setTelemor(telemor);
                } catch (Exception e) {
                    Tool.debug("Route table khong co telemor");
                }
                
                try {
                    JSONObject timortelecomJson = (JSONObject) obj.get("timortelecom");
                    OperProperties timortelecom = (OperProperties) JSONObject.toBean(timortelecomJson, OperProperties.class);
                    result.setTimortelecom(timortelecom);
                } catch (Exception e) {
                    Tool.debug("Route table khong co timortelecom");
                }
                /////////////////////////////////
                try {
                    JSONObject natcomJson = (JSONObject) obj.get("natcom");
                    OperProperties natcom = (OperProperties) JSONObject.toBean(natcomJson, OperProperties.class);
                    result.setNatcom(natcom);
                } catch (Exception e) {
                    Tool.debug("Route table khong co natcom");
                }
                
                try {
                    JSONObject digicelJson = (JSONObject) obj.get("digicel");
                    OperProperties digicel = (OperProperties) JSONObject.toBean(digicelJson, OperProperties.class);
                    result.setDigicel(digicel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co digicel");
                }
                
                try {
                    JSONObject comcelJson = (JSONObject) obj.get("comcel");
                    OperProperties comcel = (OperProperties) JSONObject.toBean(comcelJson, OperProperties.class);
                    result.setComcel(comcel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co comcel");
                }
                //////////////////////
                try {
                    JSONObject unitelJson = (JSONObject) obj.get("unitel");
                    OperProperties unitel = (OperProperties) JSONObject.toBean(unitelJson, OperProperties.class);
                    result.setUnitel(unitel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co UNITEL");
                }
                
                try {
                    JSONObject etlJson = (JSONObject) obj.get("etl");
                    OperProperties etl = (OperProperties) JSONObject.toBean(etlJson, OperProperties.class);
                    result.setEtl(etl);
                } catch (Exception e) {
                    Tool.debug("Route table khong co etl");
                }
                
                try {
                    JSONObject tangoJson = (JSONObject) obj.get("tango");
                    OperProperties tango = (OperProperties) JSONObject.toBean(tangoJson, OperProperties.class);
                    result.setTango(tango);
                } catch (Exception e) {
                    Tool.debug("Route table khong co tango");
                }
                
                try {
                    JSONObject laotelJson = (JSONObject) obj.get("laotel");
                    OperProperties laotel = (OperProperties) JSONObject.toBean(laotelJson, OperProperties.class);
                    result.setLaotel(laotel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co laotel");
                }
                //////////////////////////////
                try {
                    JSONObject mytelJson = (JSONObject) obj.get("mytel");
                    OperProperties mytel = (OperProperties) JSONObject.toBean(mytelJson, OperProperties.class);
                    result.setMytel(mytel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co MYTEL");
                }
                
                try {
                    JSONObject mptJson = (JSONObject) obj.get("mpt");
                    OperProperties mpt = (OperProperties) JSONObject.toBean(mptJson, OperProperties.class);
                    result.setMpt(mpt);
                } catch (Exception e) {
                    Tool.debug("Route table khong co mpt");
                }
                
                try {
                    JSONObject ooredoJson = (JSONObject) obj.get("ooredo");
                    OperProperties ooredo = (OperProperties) JSONObject.toBean(ooredoJson, OperProperties.class);
                    result.setOoredo(ooredo);
                } catch (Exception e) {
                    Tool.debug("Route table khong co ooredo");
                }
                
                try {
                    JSONObject telenorJson = (JSONObject) obj.get("telenor");
                    OperProperties telenor = (OperProperties) JSONObject.toBean(telenorJson, OperProperties.class);
                    result.setTelenor(telenor);
                } catch (Exception e) {
                    Tool.debug("Route table khong co telenor");
                }
                ////////////////////////////////////
                try {
                    JSONObject movitelJson = (JSONObject) obj.get("movitel");
                    OperProperties movitel = (OperProperties) JSONObject.toBean(movitelJson, OperProperties.class);
                    result.setMovitel(movitel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co MOVITEL");
                }
                
                try {
                    JSONObject mcelJson = (JSONObject) obj.get("mcel");
                    OperProperties mcel = (OperProperties) JSONObject.toBean(mcelJson, OperProperties.class);
                    result.setMcel(mcel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co mcel");
                }
                /////////////////////////
                try {
                    JSONObject bitelJson = (JSONObject) obj.get("bitel");
                    OperProperties bitel = (OperProperties) JSONObject.toBean(bitelJson, OperProperties.class);
                    result.setBitel(bitel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co bitel");
                }
                
                try {
                    JSONObject claroJson = (JSONObject) obj.get("claro");
                    OperProperties claro = (OperProperties) JSONObject.toBean(claroJson, OperProperties.class);
                    result.setClaro(claro);
                } catch (Exception e) {
                    Tool.debug("Route table khong co claro");
                }
                
                try {
                    JSONObject telefoniaJson = (JSONObject) obj.get("telefonia");
                    OperProperties telefonia = (OperProperties) JSONObject.toBean(telefoniaJson, OperProperties.class);
                    result.setTelefonia(telefonia);
                } catch (Exception e) {
                    Tool.debug("Route table khong co telefonia");
                }
                //////////////////////////////
                try {
                    JSONObject halotelJson = (JSONObject) obj.get("halotel");
                    OperProperties halotel = (OperProperties) JSONObject.toBean(halotelJson, OperProperties.class);
                    result.setHalotel(halotel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co halotel");
                }
                
                try {
                    JSONObject vodacomJson = (JSONObject) obj.get("vodacom");
                    OperProperties vodacom = (OperProperties) JSONObject.toBean(vodacomJson, OperProperties.class);
                    result.setVodacom(vodacom);
                } catch (Exception e) {
                    Tool.debug("Route table khong co vodacom");
                }
                
                try {
                    JSONObject zantelJson = (JSONObject) obj.get("zantel");
                    OperProperties zantel = (OperProperties) JSONObject.toBean(zantelJson, OperProperties.class);
                    result.setZantel(zantel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co zantel");
                }
                
            } catch (Exception e) {
                Tool.debug("String json Route table not valid");
            }
        }

        return result;
    }

    public static String toStringJson(RouteTable route) {
        if (route != null) {
            JSONObject obj = JSONObject.fromObject(route);
            String str = obj.toString();
            return str;
        } else {
            return "";
        }
    }

    public boolean checkRole(String oper, int type) {
        boolean result = false;

        if (oper.equals(SMSUtils.OPER.VIETTEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!vte.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!vte.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vu khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.MOBI.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!mobi.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!mobi.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.VINA.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!vina.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!vina.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.VNM.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!vnm.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!vnm.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.BEELINE.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!bl.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!bl.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.DONGDUONG.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!ddg.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!ddg.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            ////////////////////
        } else if (oper.equals(SMSUtils.OPER.LUMITEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!lumitel.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!lumitel.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.AFRICELL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!africell.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!africell.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.LACELLSU.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!lacellsu.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!lacellsu.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            ////////////////////////////////
        } else if (oper.equals(SMSUtils.OPER.NEXTTEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!nexttel.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!nexttel.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.MTN.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!mtn.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!mtn.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.ORANGE.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!orange.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!orange.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            /////////////////
        } else if (oper.equals(SMSUtils.OPER.CELLCARD.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!cellcard.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!cellcard.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.METFONE.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!metfone.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!metfone.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.BEELINECAMPUCHIA.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!beelineCampuchia.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!beelineCampuchia.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.SMART.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!smart.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!smart.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.QBMORE.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!qbmore.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!qbmore.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.EXCELL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!excell.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!excell.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            //////////////////////////
        } else if (oper.equals(SMSUtils.OPER.TELEMOR.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!telemor.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!telemor.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.TIMORTELECOM.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!timortelecom.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!timortelecom.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            //////////////////////////
        } else if (oper.equals(SMSUtils.OPER.NATCOM.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!natcom.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!natcom.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.DIGICEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!digicel.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!digicel.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.COMCEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!comcel.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!comcel.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            ////////////////////////////////
        } else if (oper.equals(SMSUtils.OPER.UNITEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!unitel.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!unitel.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.ETL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!etl.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!etl.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.TANGO.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!tango.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!tango.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.LAOTEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!laotel.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!laotel.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            /////////////////////////
        } else if (oper.equals(SMSUtils.OPER.MYTEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!mytel.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!mytel.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.MPT.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!mpt.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!mpt.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.OOREDO.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!ooredo.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!ooredo.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.TELENOR.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!telenor.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!telenor.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            ////////////////////////////////////
        } else if (oper.equals(SMSUtils.OPER.MOVITEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!movitel.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!movitel.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.MCEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!mcel.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!mcel.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            ////////////////////////
        } else if (oper.equals(SMSUtils.OPER.BITEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!bitel.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!bitel.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.CLARO.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!claro.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!claro.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.TELEFONIA.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!telefonia.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!telefonia.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            ///////////////////////
        } else if (oper.equals(SMSUtils.OPER.HALOTEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!halotel.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!halotel.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.VODACOM.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!vodacom.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!vodacom.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.ZANTEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!zantel.getRoute_CSKH().equals("0")) {
                    result = true;
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!zantel.getRoute_QC().equals("0")) {
                    result = true;
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else {
            // Ke no vi no cha thuoc mang nao
        }
        return result;
    }

    public String getSendTo(String oper, int type) {
        String result = "0";

        if (oper.equals(SMSUtils.OPER.VIETTEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!vte.getRoute_CSKH().equals("0")) {
                    result = vte.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!vte.getRoute_QC().equals("0")) {
                    result = vte.getRoute_QC();
                }
            } else {
                // Ke no vu khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.MOBI.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!mobi.getRoute_CSKH().equals("0")) {
                    result = mobi.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!mobi.getRoute_QC().equals("0")) {
                    result = mobi.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.VINA.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!vina.getRoute_CSKH().equals("0")) {
                    result = vina.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!vina.getRoute_QC().equals("0")) {
                    result = vina.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.VNM.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!vnm.getRoute_CSKH().equals("0")) {
                    result = vnm.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!vnm.getRoute_QC().equals("0")) {
                    result = vnm.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.BEELINE.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!bl.getRoute_CSKH().equals("0")) {
                    result = bl.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!bl.getRoute_QC().equals("0")) {
                    result = bl.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.DONGDUONG.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!ddg.getRoute_CSKH().equals("0")) {
                    result = ddg.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!ddg.getRoute_QC().equals("0")) {
                    result = ddg.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            /////////////////
        } else if (oper.equals(SMSUtils.OPER.LUMITEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!lumitel.getRoute_CSKH().equals("0")) {
                    result = lumitel.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!lumitel.getRoute_QC().equals("0")) {
                    result = lumitel.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.AFRICELL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!africell.getRoute_CSKH().equals("0")) {
                    result = africell.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!africell.getRoute_QC().equals("0")) {
                    result = africell.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.LACELLSU.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!lacellsu.getRoute_CSKH().equals("0")) {
                    result = lacellsu.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!lumitel.getRoute_QC().equals("0")) {
                    result = lacellsu.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            //////////////////////
        } else if (oper.equals(SMSUtils.OPER.NEXTTEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!nexttel.getRoute_CSKH().equals("0")) {
                    result = nexttel.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!nexttel.getRoute_QC().equals("0")) {
                    result = nexttel.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.MTN.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!mtn.getRoute_CSKH().equals("0")) {
                    result = mtn.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!mtn.getRoute_QC().equals("0")) {
                    result = mtn.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.ORANGE.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!orange.getRoute_CSKH().equals("0")) {
                    result = orange.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!orange.getRoute_QC().equals("0")) {
                    result = orange.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            ////////////////////////////
        } else if (oper.equals(SMSUtils.OPER.CELLCARD.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!cellcard.getRoute_CSKH().equals("0")) {
                    result = cellcard.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!cellcard.getRoute_QC().equals("0")) {
                    result = cellcard.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.METFONE.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!metfone.getRoute_CSKH().equals("0")) {
                    result = metfone.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!metfone.getRoute_QC().equals("0")) {
                    result = metfone.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.BEELINECAMPUCHIA.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!beelineCampuchia.getRoute_CSKH().equals("0")) {
                    result = beelineCampuchia.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!beelineCampuchia.getRoute_QC().equals("0")) {
                    result = beelineCampuchia.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.SMART.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!smart.getRoute_CSKH().equals("0")) {
                    result = smart.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!smart.getRoute_QC().equals("0")) {
                    result = smart.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.QBMORE.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!qbmore.getRoute_CSKH().equals("0")) {
                    result = qbmore.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!qbmore.getRoute_QC().equals("0")) {
                    result = qbmore.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.EXCELL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!excell.getRoute_CSKH().equals("0")) {
                    result = excell.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!excell.getRoute_QC().equals("0")) {
                    result = excell.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            //////////////////////////////////////
        } else if (oper.equals(SMSUtils.OPER.TELEMOR.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!telemor.getRoute_CSKH().equals("0")) {
                    result = telemor.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!telemor.getRoute_QC().equals("0")) {
                    result = telemor.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.TIMORTELECOM.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!timortelecom.getRoute_CSKH().equals("0")) {
                    result = timortelecom.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!timortelecom.getRoute_QC().equals("0")) {
                    result = timortelecom.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            ////////////////////////////////////////
        } else if (oper.equals(SMSUtils.OPER.NATCOM.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!natcom.getRoute_CSKH().equals("0")) {
                    result = natcom.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!natcom.getRoute_QC().equals("0")) {
                    result = natcom.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.DIGICEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!digicel.getRoute_CSKH().equals("0")) {
                    result = digicel.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!digicel.getRoute_QC().equals("0")) {
                    result = digicel.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.COMCEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!comcel.getRoute_CSKH().equals("0")) {
                    result = comcel.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!comcel.getRoute_QC().equals("0")) {
                    result = comcel.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            /////////////////////////////
        } else if (oper.equals(SMSUtils.OPER.UNITEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!unitel.getRoute_CSKH().equals("0")) {
                    result = unitel.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!unitel.getRoute_QC().equals("0")) {
                    result = unitel.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.ETL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!etl.getRoute_CSKH().equals("0")) {
                    result = etl.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!etl.getRoute_QC().equals("0")) {
                    result = etl.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.TANGO.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!tango.getRoute_CSKH().equals("0")) {
                    result = tango.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!tango.getRoute_QC().equals("0")) {
                    result = tango.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.LAOTEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!laotel.getRoute_CSKH().equals("0")) {
                    result = laotel.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!laotel.getRoute_QC().equals("0")) {
                    result = laotel.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            /////////////////////////////////////
        } else if (oper.equals(SMSUtils.OPER.MYTEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!mytel.getRoute_CSKH().equals("0")) {
                    result = mytel.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!mytel.getRoute_QC().equals("0")) {
                    result = mytel.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.MPT.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!mpt.getRoute_CSKH().equals("0")) {
                    result = mpt.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!mpt.getRoute_QC().equals("0")) {
                    result = mpt.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.OOREDO.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!ooredo.getRoute_CSKH().equals("0")) {
                    result = ooredo.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!ooredo.getRoute_QC().equals("0")) {
                    result = ooredo.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.TELENOR.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!telenor.getRoute_CSKH().equals("0")) {
                    result = telenor.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!telenor.getRoute_QC().equals("0")) {
                    result = telenor.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            //////////////////////
        } else if (oper.equals(SMSUtils.OPER.MOVITEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!movitel.getRoute_CSKH().equals("0")) {
                    result = movitel.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!movitel.getRoute_QC().equals("0")) {
                    result = movitel.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.MCEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!mcel.getRoute_CSKH().equals("0")) {
                    result = mcel.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!mcel.getRoute_QC().equals("0")) {
                    result = mcel.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            ///////////////////////////////////
        } else if (oper.equals(SMSUtils.OPER.BITEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!bitel.getRoute_CSKH().equals("0")) {
                    result = bitel.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!bitel.getRoute_QC().equals("0")) {
                    result = bitel.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.CLARO.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!claro.getRoute_CSKH().equals("0")) {
                    result = claro.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!claro.getRoute_QC().equals("0")) {
                    result = claro.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.TELEFONIA.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!telefonia.getRoute_CSKH().equals("0")) {
                    result = telefonia.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!telefonia.getRoute_QC().equals("0")) {
                    result = telefonia.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
            ////////////////////////////////////////
        } else if (oper.equals(SMSUtils.OPER.HALOTEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!halotel.getRoute_CSKH().equals("0")) {
                    result = halotel.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!halotel.getRoute_QC().equals("0")) {
                    result = halotel.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.VODACOM.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!vodacom.getRoute_CSKH().equals("0")) {
                    result = vodacom.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!vodacom.getRoute_QC().equals("0")) {
                    result = vodacom.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else if (oper.equals(SMSUtils.OPER.ZANTEL.val)) {
            if (type == BrandLabel.TYPE.CSKH.val) {
                if (!zantel.getRoute_CSKH().equals("0")) {
                    result = zantel.getRoute_CSKH();
                }
            } else if (type == BrandLabel.TYPE.QC.val) {
                if (!zantel.getRoute_QC().equals("0")) {
                    result = zantel.getRoute_QC();
                }
            } else {
                // Ke no vi khong dung kieu thi da la khong cap Phep roi
            }
        } else {
            // Ke no vi no cha thuoc mang nao
        }
        return result;
    }
    //****
    private OperProperties vte;
    private OperProperties mobi;
    private OperProperties vina;
    private OperProperties vnm;
    private OperProperties bl;
    private OperProperties ddg;

    public OperProperties getVte() {
        if (vte == null) {
            vte = new OperProperties();
        }
        return vte;
    }

    public void setVte(OperProperties vte) {
        this.vte = vte;
    }

    public OperProperties getMobi() {
        if (mobi == null) {
            mobi = new OperProperties();
        }
        return mobi;
    }

    public void setMobi(OperProperties mobi) {
        this.mobi = mobi;
    }

    public OperProperties getVina() {
        if (vina == null) {
            vina = new OperProperties();
        }
        return vina;
    }

    public void setVina(OperProperties vina) {
        this.vina = vina;
    }

    public OperProperties getVnm() {
        if (vnm == null) {
            vnm = new OperProperties();
        }
        return vnm;
    }

    public void setVnm(OperProperties vnm) {
        this.vnm = vnm;
    }

    public OperProperties getBl() {
        if (bl == null) {
            bl = new OperProperties();
        }
        return bl;
    }

    public void setBl(OperProperties bl) {
        this.bl = bl;
    }

    public OperProperties getDdg() {
        if (ddg == null) {
            ddg = new OperProperties();
        }
        return ddg;
    }

    public void setDdg(OperProperties ddg) {
        this.ddg = ddg;
    }
    ///////////////////////////////////////
    private OperProperties lumitel;
    private OperProperties africell;
    private OperProperties lacellsu;

    public OperProperties getAfricell() {
        if (africell == null) {
            africell = new OperProperties();
        }
        return africell;
    }

    public void setAfricell(OperProperties africell) {
        this.africell = africell;
    }

    public OperProperties getLacellsu() {
        if (lacellsu == null) {
            lacellsu = new OperProperties();
        }
        return lacellsu;
    }

    public void setLacellsu(OperProperties lacellsu) {
        this.lacellsu = lacellsu;
    }
    
    public OperProperties getLumitel() {
        if (lumitel == null) {
            lumitel = new OperProperties();
        }
        return lumitel;
    }

    public void setLumitel(OperProperties lumitel) {
        this.lumitel = lumitel;
    }
    /////////////////////////////////////
    private OperProperties nexttel;
    private OperProperties mtn;
    private OperProperties orange;

    public OperProperties getMtn() {
        if (mtn == null) {
            mtn = new OperProperties();
        }
        return mtn;
    }

    public void setMtn(OperProperties mtn) {
        this.mtn = mtn;
    }

    public OperProperties getOrange() {
        if (orange == null) {
            orange = new OperProperties();
        }
        return orange;
    }

    public void setOrange(OperProperties orange) {
        this.orange = orange;
    }
    
    public OperProperties getNexttel() {
        if (nexttel == null) {
            nexttel = new OperProperties();
        }
        return nexttel;
    }

    public void setNexttel(OperProperties nexttel) {
        this.nexttel = nexttel;
    }
    //////////////////////////////////////
    private OperProperties cellcard;
    private OperProperties metfone;
    private OperProperties beelineCampuchia;
    private OperProperties smart;
    private OperProperties qbmore;
    private OperProperties excell;

    
    public OperProperties getCellcard() {
        if (cellcard == null) {
            cellcard = new OperProperties();
        }
        return cellcard;
    }

    public void setCellcard(OperProperties cellcard) {
        this.cellcard = cellcard;
    }
    
    
    public OperProperties getMetfone() {
        if (metfone == null) {
            metfone = new OperProperties();
        }
        return metfone;
    }

    public void setMetfone(OperProperties metfone) {
        this.metfone = metfone;
    }
        
    public OperProperties getBeelineCampuchia() {
        if (beelineCampuchia == null) {
            beelineCampuchia = new OperProperties();
        }
        return beelineCampuchia;
    }

    public void setBeelineCampuchia(OperProperties beelineCampuchia) {
        this.beelineCampuchia = beelineCampuchia;
    }
    
    
    public OperProperties getSmart() {
        if (smart == null) {
            smart = new OperProperties();
        }
        return smart;
    }

    public void setSmart(OperProperties smart) {
        this.smart = smart;
    }
    
    
    public OperProperties getQbmore() {
        if (qbmore == null) {
            qbmore = new OperProperties();
        }
        return qbmore;
    }

    public void setQbmore(OperProperties qbmore) {
        this.qbmore = qbmore;
    }
    
    
    public OperProperties getExcell() {
        if (excell == null) {
            excell = new OperProperties();
        }
        return excell;
    }

    public void setExcell(OperProperties excell) {
        this.excell = excell;
    }
    ////////////////////////////////////
    private OperProperties telemor;
    private OperProperties timortelecom;    

    public OperProperties getTimortelecom() {
        if (timortelecom == null) {
            timortelecom = new OperProperties();
        }
        return timortelecom;
    }

    public void setTimortelecom(OperProperties timortelecom) {
        this.timortelecom = timortelecom;
    }
    
    public OperProperties getTelemor() {
        if (telemor == null) {
            telemor = new OperProperties();
        }
        return telemor;
    }

    public void setTelemor(OperProperties telemor) {
        this.telemor = telemor;
    }
    //////////////////////////////////////
    private OperProperties natcom;
    private OperProperties mpt;
    private OperProperties ooredo;
    private OperProperties telenor;

    public OperProperties getMpt() {
        if (mpt == null) {
            mpt = new OperProperties();
        }
        return mpt;
    }

    public void setMpt(OperProperties mpt) {
        this.mpt = mpt;
    }

    public OperProperties getOoredo() {
        if (ooredo == null) {
            ooredo = new OperProperties();
        }
        return ooredo;
    }

    public void setOoredo(OperProperties ooredo) {
        this.ooredo = ooredo;
    }

    public OperProperties getTelenor() {
        if (telenor == null) {
            telenor = new OperProperties();
        }
        return telenor;
    }

    public void setTelenor(OperProperties telenor) {
        this.telenor = telenor;
    }
    
    public OperProperties getNatcom() {
        if (natcom == null) {
            natcom = new OperProperties();
        }
        return natcom;
    }

    public void setNatcom(OperProperties natcom) {
        this.natcom = natcom;
    }
    //////////////////////////
    private OperProperties unitel;
    private OperProperties digicel;
    private OperProperties comcel;

    public OperProperties getDigicel() {
        if (digicel == null) {
            digicel = new OperProperties();
        }
        return digicel;
    }

    public void setDigicel(OperProperties digicel) {
        this.digicel = digicel;
    }

    public OperProperties getComcel() {
        if (comcel == null) {
            comcel = new OperProperties();
        }
        return comcel;
    }

    public void setComcel(OperProperties comcel) {
        this.comcel = comcel;
    }
    
    public OperProperties getUnitel() {
        if (unitel == null) {
            unitel = new OperProperties();
        }
        return unitel;
    }

    public void setUnitel(OperProperties unitel) {
        this.unitel = unitel;
    }
    //////////////////////////////////////////////
    private OperProperties mytel;
    private OperProperties etl;
    private OperProperties tango;
    private OperProperties laotel;

    public OperProperties getEtl() {
        if (etl == null) {
            etl = new OperProperties();
        }
        return etl;
    }

    public void setEtl(OperProperties etl) {
        this.etl = etl;
    }

    public OperProperties getTango() {
        if (tango == null) {
            tango = new OperProperties();
        }
        return tango;
    }

    public void setTango(OperProperties tango) {
        this.tango = tango;
    }

    public OperProperties getLaotel() {
        if (laotel == null) {
            laotel = new OperProperties();
        }
        return laotel;
    }

    public void setLaotel(OperProperties laotel) {
        this.laotel = laotel;
    }

    public OperProperties getMytel() {
        if (mytel == null) {
            mytel = new OperProperties();
        }
        return mytel;
    }

    public void setMytel(OperProperties mytel) {
        this.mytel = mytel;
    }
    ////////////////////////////////////////////////////
    private OperProperties movitel;
    private OperProperties mcel;

    public OperProperties getMcel() {
        if (mcel == null) {
            mcel = new OperProperties();
        }
        return mcel;
    }

    public void setMcel(OperProperties mcel) {
        this.mcel = mcel;
    }
    
    public OperProperties getMovitel() {
        if (movitel == null) {
            movitel = new OperProperties();
        }
        return movitel;
    }

    public void setMovitel(OperProperties movitel) {
        this.movitel = movitel;
    }
    /////////////////////////////////////////
    private OperProperties bitel;
    private OperProperties claro;
    private OperProperties telefonia;

    public OperProperties getClaro() {
        if (claro == null) {
            claro = new OperProperties();
        }
        return claro;
    }

    public void setClaro(OperProperties claro) {
        this.claro = claro;
    }

    public OperProperties getTelefonia() {
        if (telefonia == null) {
            telefonia = new OperProperties();
        }
        return telefonia;
    }

    public void setTelefonia(OperProperties telefonia) {
        this.telefonia = telefonia;
    }
    
    public OperProperties getBitel() {
        if (bitel == null) {
            bitel = new OperProperties();
        }
        return bitel;
    }

    public void setBitel(OperProperties bitel) {
        this.bitel = bitel;
    }
    //////////////////////////////////
    private OperProperties halotel;
    private OperProperties vodacom;
    private OperProperties zantel;

    public OperProperties getVodacom() {
        if (vodacom == null) {
            vodacom = new OperProperties();
        }
        return vodacom;
    }

    public void setVodacom(OperProperties vodacom) {
        this.vodacom = vodacom;
    }

    public OperProperties getZantel() {
        if (zantel == null) {
            zantel = new OperProperties();
        }
        return zantel;
    }

    public void setZantel(OperProperties zantel) {
        this.zantel = zantel;
    }
    
    public OperProperties getHalotel() {
        if (halotel == null) {
            halotel = new OperProperties();
        }
        return halotel;
    }

    public void setHalotel(OperProperties halotel) {
        this.halotel = halotel;
    }
}
