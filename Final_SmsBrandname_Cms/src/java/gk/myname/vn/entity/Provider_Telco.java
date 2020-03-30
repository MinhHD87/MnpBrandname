package gk.myname.vn.entity;

import gk.myname.vn.admin.PriceTelco;
import gk.myname.vn.utils.Tool;
import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;

public class Provider_Telco {

    public static void main(String[] args) {

        String str = "{\"bl\":{\"group0Price\":\"0\",\"group1Price\":\"0\",\"group2Price\":\"0\",\"group3Price\":\"0\",\"group4Price\":\"0\",\"group5Price\":\"0\",\"group6Price\":\"0\",\"group7Price\":\"0\",\"group8Price\":\"0\",\"group9Price\":\"0\",\"group10Price\":\"0\",\"group11Price\":\"0\",\"group12Price\":\"0\",\"group13Price\":\"0\",\"group14Price\":\"0\",\"group15Price\":\"0\",\"groupLCPrice\":\"0\"}"
                + ",\"mobi\":{\"group0Price\":\"0\",\"group1Price\":\"0\",\"group2Price\":\"0\",\"group3Price\":\"0\",\"group4Price\":\"0\",\"group5Price\":\"0\",\"group6Price\":\"0\",\"group7Price\":\"0\",\"group8Price\":\"0\",\"group9Price\":\"0\",\"group10Price\":\"0\",\"group11Price\":\"0\",\"group12Price\":\"0\",\"group13Price\":\"0\",\"group14Price\":\"0\",\"group15Price\":\"0\",\"groupLCPrice\":\"0\"}"
                + "\"vina\":{\"group0Price\":\"0\",\"group1Price\":\"0\",\"group2Price\":\"0\",\"group3Price\":\"0\",\"group4Price\":\"0\",\"group5Price\":\"0\",\"group6Price\":\"0\",\"group7Price\":\"0\",\"group8Price\":\"0\",\"group9Price\":\"0\",\"group10Price\":\"0\",\"group11Price\":\"0\",\"group12Price\":\"0\",\"group13Price\":\"0\",\"group14Price\":\"0\",\"group15Price\":\"0\",\"groupLCPrice\":\"0\"}"
                + "\"vnm\":{\"group0Price\":\"0\",\"group1Price\":\"0\",\"group2Price\":\"0\",\"group3Price\":\"0\",\"group4Price\":\"0\",\"group5Price\":\"0\",\"group6Price\":\"0\",\"group7Price\":\"0\",\"group8Price\":\"0\",\"group9Price\":\"0\",\"group10Price\":\"0\",\"group11Price\":\"0\",\"group12Price\":\"0\",\"group13Price\":\"0\",\"group14Price\":\"0\",\"group15Price\":\"0\",\"groupLCPrice\":\"0\"}"
                + "\"ddg\":{\"group0Price\":\"0\",\"group1Price\":\"0\",\"group2Price\":\"0\",\"group3Price\":\"0\",\"group4Price\":\"0\",\"group5Price\":\"0\",\"group6Price\":\"0\",\"group7Price\":\"0\",\"group8Price\":\"0\",\"group9Price\":\"0\",\"group10Price\":\"0\",\"group11Price\":\"0\",\"group12Price\":\"0\",\"group13Price\":\"0\",\"group14Price\":\"0\",\"group15Price\":\"0\",\"groupLCPrice\":\"0\"}"
                + "\"vte\":{\"group0Price\":\"0\",\"group1Price\":\"0\",\"group2Price\":\"0\",\"group3Price\":\"0\",\"group4Price\":\"0\",\"group5Price\":\"0\",\"group6Price\":\"0\",\"group7Price\":\"0\",\"group8Price\":\"0\",\"group9Price\":\"0\",\"group10Price\":\"0\",\"group11Price\":\"0\",\"group12Price\":\"0\",\"group13Price\":\"0\",\"group14Price\":\"0\",\"group15Price\":\"0\",\"groupLCPrice\":\"0\"}}";
        Provider_Telco tmp = json2Object(str);
        PriceTelco mobi = tmp.getMobi();
    }

    public static Provider_Telco json2Object(String str) {
        Provider_Telco result = new Provider_Telco();
        if (!Tool.checkNull(str)) {
            try {
                JSONObject obj = (JSONObject) JSONSerializer.toJSON(str);

                try {
                    JSONObject vteJson = (JSONObject) obj.get("vte");
                    PriceTelco vte = (PriceTelco) JSONObject.toBean(vteJson, PriceTelco.class);
                    result.setVte(vte);
                } catch (Exception e) {
                    Tool.debug("Route table khong co VIETTEL:");
                }

                try {
                    JSONObject mobiJson = (JSONObject) obj.get("mobi");
                    PriceTelco mobi = (PriceTelco) JSONObject.toBean(mobiJson, PriceTelco.class);
                    result.setMobi(mobi);
                } catch (Exception e) {
                    Tool.debug("Route table khong co MOBI FONE");
                }

                try {
                    JSONObject vinaJson = (JSONObject) obj.get("vina");
                    PriceTelco vina = (PriceTelco) JSONObject.toBean(vinaJson, PriceTelco.class);
                    result.setVina(vina);
                } catch (Exception e) {
                    Tool.debug("Route table khong co VINA PHONE");
                }

                try {
                    JSONObject vnmJson = (JSONObject) obj.get("vnm");
                    PriceTelco vnm = (PriceTelco) JSONObject.toBean(vnmJson, PriceTelco.class);
                    result.setVnm(vnm);
                } catch (Exception e) {
                    Tool.debug("Route table khong co VIETNAM MOBI");
                }

                try {
                    JSONObject blJson = (JSONObject) obj.get("bl");
                    PriceTelco bl = (PriceTelco) JSONObject.toBean(blJson, PriceTelco.class);
                    result.setBl(bl);
                } catch (Exception e) {
                    Tool.debug("Route table khong co BEE LINE");
                }

                try {
                    JSONObject ddgJson = (JSONObject) obj.get("ddg");
                    PriceTelco ddg = (PriceTelco) JSONObject.toBean(ddgJson, PriceTelco.class);
                    result.setDdg(ddg);
                } catch (Exception e) {
                    Tool.debug("Route table khong co DONG DUONG");
                }

                try {
                    JSONObject lumitelJson = (JSONObject) obj.get("lumitel");
                    PriceTelco lumitel = (PriceTelco) JSONObject.toBean(lumitelJson, PriceTelco.class);
                    result.setLumitel(lumitel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co lumitel");
                }

                try {
                    JSONObject nexttelJson = (JSONObject) obj.get("nexttel");
                    PriceTelco nexttel = (PriceTelco) JSONObject.toBean(nexttelJson, PriceTelco.class);
                    result.setNexttel(nexttel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co nexttel");
                }

                try {
                    JSONObject cellcardJson = (JSONObject) obj.get("cellcard");
                    PriceTelco cellcard = (PriceTelco) JSONObject.toBean(cellcardJson, PriceTelco.class);
                    result.setCellcard(cellcard);
                } catch (Exception e) {
                    Tool.debug("Route table khong co cellcard");
                }

                try {
                    JSONObject metfoneJson = (JSONObject) obj.get("metfone");
                    PriceTelco metfone = (PriceTelco) JSONObject.toBean(metfoneJson, PriceTelco.class);
                    result.setMetfone(metfone);
                } catch (Exception e) {
                    Tool.debug("Route table khong co metfone");
                }

                try {
                    JSONObject beelineCampuchiaJson = (JSONObject) obj.get("beelineCampuchia");
                    PriceTelco beelineCampuchia = (PriceTelco) JSONObject.toBean(beelineCampuchiaJson, PriceTelco.class);
                    result.setBeelineCampuchia(beelineCampuchia);
                } catch (Exception e) {
                    Tool.debug("Route table khong co beelineCampuchia");
                }

                try {
                    JSONObject smartJson = (JSONObject) obj.get("smart");
                    PriceTelco smart = (PriceTelco) JSONObject.toBean(smartJson, PriceTelco.class);
                    result.setSmart(smart);
                } catch (Exception e) {
                    Tool.debug("Route table khong co smart");
                }

                try {
                    JSONObject qbmoreJson = (JSONObject) obj.get("qbmore");
                    PriceTelco qbmore = (PriceTelco) JSONObject.toBean(qbmoreJson, PriceTelco.class);
                    result.setQbmore(qbmore);
                } catch (Exception e) {
                    Tool.debug("Route table khong co qbmore");
                }

                try {
                    JSONObject excellJson = (JSONObject) obj.get("excell");
                    PriceTelco excell = (PriceTelco) JSONObject.toBean(excellJson, PriceTelco.class);
                    result.setExcell(excell);
                } catch (Exception e) {
                    Tool.debug("Route table khong co excell");
                }

                try {
                    JSONObject telemorJson = (JSONObject) obj.get("telemor");
                    PriceTelco telemor = (PriceTelco) JSONObject.toBean(telemorJson, PriceTelco.class);
                    result.setTelemor(telemor);
                } catch (Exception e) {
                    Tool.debug("Route table khong co telemor");
                }

                try {
                    JSONObject natcomJson = (JSONObject) obj.get("natcom");
                    PriceTelco natcom = (PriceTelco) JSONObject.toBean(natcomJson, PriceTelco.class);
                    result.setNatcom(natcom);
                } catch (Exception e) {
                    Tool.debug("Route table khong co natcom");
                }

                try {
                    JSONObject unitelJson = (JSONObject) obj.get("unitel");
                    PriceTelco unitel = (PriceTelco) JSONObject.toBean(unitelJson, PriceTelco.class);
                    result.setUnitel(unitel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co UNITEL");
                }

                try {
                    JSONObject mytelJson = (JSONObject) obj.get("mytel");
                    PriceTelco mytel = (PriceTelco) JSONObject.toBean(mytelJson, PriceTelco.class);
                    result.setMytel(mytel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co MYTEL");
                }

                try {
                    JSONObject movitelJson = (JSONObject) obj.get("movitel");
                    PriceTelco movitel = (PriceTelco) JSONObject.toBean(movitelJson, PriceTelco.class);
                    result.setMovitel(movitel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co MOVITEL");
                }

                try {
                    JSONObject bitelJson = (JSONObject) obj.get("bitel");
                    PriceTelco bitel = (PriceTelco) JSONObject.toBean(bitelJson, PriceTelco.class);
                    result.setBitel(bitel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co bitel");
                }

                try {
                    JSONObject halotelJson = (JSONObject) obj.get("halotel");
                    PriceTelco halotel = (PriceTelco) JSONObject.toBean(halotelJson, PriceTelco.class);
                    result.setHalotel(halotel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co halotel");
                }
                try {
                    JSONObject timortelecomJson = (JSONObject) obj.get("timortelecom");
                    PriceTelco timortelecom = (PriceTelco) JSONObject.toBean(timortelecomJson, PriceTelco.class);
                    result.setTimortelecom(timortelecom);
                } catch (Exception e) {
                    Tool.debug("Route table khong co timortelecom");
                }
                try {
                    JSONObject mcelJson = (JSONObject) obj.get("mcel");
                    PriceTelco mcel = (PriceTelco) JSONObject.toBean(mcelJson, PriceTelco.class);
                    result.setMcel(mcel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co mcel");
                }
                try {
                    JSONObject etlJson = (JSONObject) obj.get("etl");
                    PriceTelco etl = (PriceTelco) JSONObject.toBean(etlJson, PriceTelco.class);
                    result.setEtl(etl);
                } catch (Exception e) {
                    Tool.debug("Route table khong co etl");
                }
                try {
                    JSONObject tangoJson = (JSONObject) obj.get("tango");
                    PriceTelco tango = (PriceTelco) JSONObject.toBean(tangoJson, PriceTelco.class);
                    result.setTango(tango);
                } catch (Exception e) {
                    Tool.debug("Route table khong co tango");
                }
                try {
                    JSONObject laotelJson = (JSONObject) obj.get("laotel");
                    PriceTelco laotel = (PriceTelco) JSONObject.toBean(laotelJson, PriceTelco.class);
                    result.setLaotel(laotel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co laotel");
                }
                try {
                    JSONObject mptJson = (JSONObject) obj.get("mpt");
                    PriceTelco mpt = (PriceTelco) JSONObject.toBean(mptJson, PriceTelco.class);
                    result.setMpt(mpt);
                } catch (Exception e) {
                    Tool.debug("Route table khong co mpt");
                }
                try {
                    JSONObject ooredoJson = (JSONObject) obj.get("ooredo");
                    PriceTelco ooredo = (PriceTelco) JSONObject.toBean(ooredoJson, PriceTelco.class);
                    result.setOoredo(ooredo);
                } catch (Exception e) {
                    Tool.debug("Route table khong co ooredo");
                }
                try {
                    JSONObject telenorJson = (JSONObject) obj.get("telenor");
                    PriceTelco telenor = (PriceTelco) JSONObject.toBean(telenorJson, PriceTelco.class);
                    result.setTelenor(telenor);
                } catch (Exception e) {
                    Tool.debug("Route table khong co telenor");
                }
                try {
                    JSONObject digicelJson = (JSONObject) obj.get("digicel");
                    PriceTelco digicel = (PriceTelco) JSONObject.toBean(digicelJson, PriceTelco.class);
                    result.setDigicel(digicel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co digicel");
                }
                try {
                    JSONObject comcelJson = (JSONObject) obj.get("comcel");
                    PriceTelco comcel = (PriceTelco) JSONObject.toBean(comcelJson, PriceTelco.class);
                    result.setComcel(comcel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co comcel");
                }
                try {
                    JSONObject africellJson = (JSONObject) obj.get("africell");
                    PriceTelco africell = (PriceTelco) JSONObject.toBean(africellJson, PriceTelco.class);
                    result.setAfricell(africell);
                } catch (Exception e) {
                    Tool.debug("Route table khong co africell");
                }
                try {
                    JSONObject lacellsuJson = (JSONObject) obj.get("lacellsu");
                    PriceTelco lacellsu = (PriceTelco) JSONObject.toBean(lacellsuJson, PriceTelco.class);
                    result.setLacellsu(lacellsu);
                } catch (Exception e) {
                    Tool.debug("Route table khong co lacellsu");
                }
                try {
                    JSONObject mtnJson = (JSONObject) obj.get("mtn");
                    PriceTelco mtn = (PriceTelco) JSONObject.toBean(mtnJson, PriceTelco.class);
                    result.setMtn(mtn);
                } catch (Exception e) {
                    Tool.debug("Route table khong co mtn");
                }
                try {
                    JSONObject orangeJson = (JSONObject) obj.get("orange");
                    PriceTelco orange = (PriceTelco) JSONObject.toBean(orangeJson, PriceTelco.class);
                    result.setOrange(orange);
                } catch (Exception e) {
                    Tool.debug("Route table khong co orange");
                }
                try {
                    JSONObject vodacomJson = (JSONObject) obj.get("vodacom");
                    PriceTelco vodacom = (PriceTelco) JSONObject.toBean(vodacomJson, PriceTelco.class);
                    result.setVodacom(vodacom);
                } catch (Exception e) {
                    Tool.debug("Route table khong co vodacom");
                }
                try {
                    JSONObject zantelJson = (JSONObject) obj.get("zantel");
                    PriceTelco zantel = (PriceTelco) JSONObject.toBean(zantelJson, PriceTelco.class);
                    result.setZantel(zantel);
                } catch (Exception e) {
                    Tool.debug("Route table khong co zantel");
                }
                try {
                    JSONObject claroJson = (JSONObject) obj.get("claro");
                    PriceTelco claro = (PriceTelco) JSONObject.toBean(claroJson, PriceTelco.class);
                    result.setClaro(claro);
                } catch (Exception e) {
                    Tool.debug("Route table khong co claro");
                }
                try {
                    JSONObject telefonicaJson = (JSONObject) obj.get("telefonica");
                    PriceTelco telefonica = (PriceTelco) JSONObject.toBean(telefonicaJson, PriceTelco.class);
                    result.setTelefonica(telefonica);
                } catch (Exception e) {
                    Tool.debug("Route table khong co telefonica");
                }

            } catch (Exception e) {
                Tool.debug("String json Route table not valid");
            }
        }

        return result;
    }

    public static String toStringJson(Provider_Telco telco) {
        if (telco != null) {
            JSONObject obj = JSONObject.fromObject(telco);
            String str = obj.toString();
            return str;
        } else {
            return "";
        }
    }

    //****
    private PriceTelco vte;
    private PriceTelco mobi;
    private PriceTelco vina;
    private PriceTelco vnm;
    private PriceTelco bl;
    private PriceTelco ddg;
    // mạng CAMPUCHIA
    private PriceTelco cellcard;
    private PriceTelco metfone;
    private PriceTelco beelineCampuchia;
    private PriceTelco smart;
    private PriceTelco qbmore;
    private PriceTelco excell;
    //mạng  ĐÔNG TIMOR
    private PriceTelco telemor;
    private PriceTelco timortelecom;
    // mạng MOZAMBIQUE
    private PriceTelco movitel;
    private PriceTelco mcel;
    // mạng LÀO 
    private PriceTelco unitel;
    private PriceTelco etl;
    private PriceTelco tango;
    private PriceTelco laotel;
    //mạng MIANMA
    private PriceTelco mytel;
    private PriceTelco mpt;
    private PriceTelco ooredo;
    private PriceTelco telenor;
    //mạng HAITI
    private PriceTelco natcom;
    private PriceTelco digicel;
    private PriceTelco comcel;
    // mạng BURUNDI
    private PriceTelco lumitel;
    private PriceTelco africell;
    private PriceTelco lacellsu;
    // mạng CAMEROON
    private PriceTelco nexttel;
    private PriceTelco mtn;
    private PriceTelco orange;
    // mạng TANZANIA
    private PriceTelco halotel;
    private PriceTelco vodacom;
    private PriceTelco zantel;
    // mạng TANZANIA
    private PriceTelco bitel;
    private PriceTelco claro;
    private PriceTelco telefonica;

    public PriceTelco getVte() {
        if (vte == null) {
            vte = new PriceTelco();
        }
        return vte;
    }

    public void setVte(PriceTelco vte) {
        this.vte = vte;
    }

    public String toJson() {
        JSONObject obj = JSONObject.fromObject(this);
        String str = obj.toString();
        return str;
    }

    public PriceTelco getMobi() {
        if (mobi == null) {
            mobi = new PriceTelco();
        }
        return mobi;
    }

    public void setMobi(PriceTelco mobi) {
        this.mobi = mobi;
    }

    public PriceTelco getVina() {
        if (vina == null) {
            vina = new PriceTelco();
        }
        return vina;
    }

    public void setVina(PriceTelco vina) {
        this.vina = vina;
    }

    public PriceTelco getVnm() {
        if (vnm == null) {
            vnm = new PriceTelco();
        }
        return vnm;
    }

    public void setVnm(PriceTelco vnm) {
        this.vnm = vnm;
    }

    public PriceTelco getBl() {
        if (bl == null) {
            bl = new PriceTelco();
        }
        return bl;
    }

    public void setBl(PriceTelco bl) {
        this.bl = bl;
    }

    public PriceTelco getDdg() {
        if (ddg == null) {
            ddg = new PriceTelco();
        }
        return ddg;
    }

    public void setDdg(PriceTelco ddg) {
        this.ddg = ddg;
    }

    public PriceTelco getLumitel() {
        if (lumitel == null) {
            lumitel = new PriceTelco();
        }
        return lumitel;
    }

    public void setLumitel(PriceTelco lumitel) {
        this.lumitel = lumitel;
    }

    public PriceTelco getNexttel() {
        if (nexttel == null) {
            nexttel = new PriceTelco();
        }
        return nexttel;
    }

    public void setNexttel(PriceTelco nexttel) {
        this.nexttel = nexttel;
    }

    public PriceTelco getCellcard() {
        if (cellcard == null) {
            cellcard = new PriceTelco();
        }
        return cellcard;
    }

    public void setCellcard(PriceTelco cellcard) {
        this.cellcard = cellcard;
    }

    public PriceTelco getMetfone() {
        if (metfone == null) {
            metfone = new PriceTelco();
        }
        return metfone;
    }

    public void setMetfone(PriceTelco metfone) {
        this.metfone = metfone;
    }

    public PriceTelco getBeelineCampuchia() {
        if (beelineCampuchia == null) {
            beelineCampuchia = new PriceTelco();
        }
        return beelineCampuchia;
    }

    public void setBeelineCampuchia(PriceTelco beelineCampuchia) {
        this.beelineCampuchia = beelineCampuchia;
    }

    public PriceTelco getSmart() {
        if (smart == null) {
            smart = new PriceTelco();
        }
        return smart;
    }

    public void setSmart(PriceTelco smart) {
        this.smart = smart;
    }

    public PriceTelco getQbmore() {
        if (qbmore == null) {
            qbmore = new PriceTelco();
        }
        return qbmore;
    }

    public void setQbmore(PriceTelco qbmore) {
        this.qbmore = qbmore;
    }

    public PriceTelco getExcell() {
        if (excell == null) {
            excell = new PriceTelco();
        }
        return excell;
    }

    public void setExcell(PriceTelco excell) {
        this.excell = excell;
    }

    public PriceTelco getTelemor() {
        if (telemor == null) {
            telemor = new PriceTelco();
        }
        return telemor;
    }

    public void setTelemor(PriceTelco telemor) {
        this.telemor = telemor;
    }

    public PriceTelco getNatcom() {
        if (natcom == null) {
            natcom = new PriceTelco();
        }
        return natcom;
    }

    public void setNatcom(PriceTelco natcom) {
        this.natcom = natcom;
    }

    public PriceTelco getUnitel() {
        if (unitel == null) {
            unitel = new PriceTelco();
        }
        return unitel;
    }

    public void setUnitel(PriceTelco unitel) {
        this.unitel = unitel;
    }

    public PriceTelco getMytel() {
        if (mytel == null) {
            mytel = new PriceTelco();
        }
        return mytel;
    }

    public void setMytel(PriceTelco mytel) {
        this.mytel = mytel;
    }

    public PriceTelco getMovitel() {
        if (movitel == null) {
            movitel = new PriceTelco();
        }
        return movitel;
    }

    public void setMovitel(PriceTelco movitel) {
        this.movitel = movitel;
    }

    public PriceTelco getBitel() {
        if (bitel == null) {
            bitel = new PriceTelco();
        }
        return bitel;
    }

    public void setBitel(PriceTelco bitel) {
        this.bitel = bitel;
    }

    public PriceTelco getHalotel() {
        if (halotel == null) {
            halotel = new PriceTelco();
        }
        return halotel;
    }

    public void setHalotel(PriceTelco halotel) {
        this.halotel = halotel;
    }

    public PriceTelco getTimortelecom() {
        if (timortelecom == null) {
            timortelecom = new PriceTelco();
        }
        return timortelecom;
    }

    public void setTimortelecom(PriceTelco timortelecom) {
        this.timortelecom = timortelecom;
    }

    public PriceTelco getMcel() {
        if (mcel == null) {
            mcel = new PriceTelco();
        }
        return mcel;
    }

    public void setMcel(PriceTelco mcel) {
        this.mcel = mcel;
    }

    public PriceTelco getEtl() {
        if (etl == null) {
            etl = new PriceTelco();
        }
        return etl;
    }

    public void setEtl(PriceTelco etl) {
        this.etl = etl;
    }

    public PriceTelco getTango() {
        if (tango == null) {
            tango = new PriceTelco();
        }
        return tango;
    }

    public void setTango(PriceTelco tango) {
        this.tango = tango;
    }

    public PriceTelco getLaotel() {
        if (laotel == null) {
            laotel = new PriceTelco();
        }
        return laotel;
    }

    public void setLaotel(PriceTelco laotel) {
        this.laotel = laotel;
    }

    public PriceTelco getMpt() {
        if (mpt == null) {
            mpt = new PriceTelco();
        }
        return mpt;
    }

    public void setMpt(PriceTelco mpt) {
        this.mpt = mpt;
    }

    public PriceTelco getOoredo() {
        if (ooredo == null) {
            ooredo = new PriceTelco();
        }
        return ooredo;
    }

    public void setOoredo(PriceTelco ooredo) {
        this.ooredo = ooredo;
    }

    public PriceTelco getTelenor() {
        if (telenor == null) {
            telenor = new PriceTelco();
        }
        return telenor;
    }

    public void setTelenor(PriceTelco telenor) {
        this.telenor = telenor;
    }

    public PriceTelco getDigicel() {
        if (digicel == null) {
            digicel = new PriceTelco();
        }
        return digicel;
    }

    public void setDigicel(PriceTelco digicel) {
        this.digicel = digicel;
    }

    public PriceTelco getComcel() {
        if (comcel == null) {
            comcel = new PriceTelco();
        }
        return comcel;
    }

    public void setComcel(PriceTelco comcel) {
        this.comcel = comcel;
    }

    public PriceTelco getAfricell() {
        if (africell == null) {
            africell = new PriceTelco();
        }
        return africell;
    }

    public void setAfricell(PriceTelco africell) {
        this.africell = africell;
    }

    public PriceTelco getLacellsu() {
        if (lacellsu == null) {
            lacellsu = new PriceTelco();
        }
        return lacellsu;
    }

    public void setLacellsu(PriceTelco lacellsu) {
        this.lacellsu = lacellsu;
    }

    public PriceTelco getMtn() {
        if (mtn == null) {
            mtn = new PriceTelco();
        }
        return mtn;
    }

    public void setMtn(PriceTelco mtn) {
        this.mtn = mtn;
    }

    public PriceTelco getOrange() {
        if (orange == null) {
            orange = new PriceTelco();
        }
        return orange;
    }

    public void setOrange(PriceTelco orange) {
        this.orange = orange;
    }

    public PriceTelco getVodacom() {
        if (vodacom == null) {
            vodacom = new PriceTelco();
        }
        return vodacom;
    }

    public void setVodacom(PriceTelco vodacom) {
        this.vodacom = vodacom;
    }

    public PriceTelco getZantel() {
        if (zantel == null) {
            zantel = new PriceTelco();
        }
        return zantel;
    }

    public void setZantel(PriceTelco zantel) {
        this.zantel = zantel;
    }

    public PriceTelco getClaro() {
        if (claro == null) {
            claro = new PriceTelco();
        }
        return claro;
    }

    public void setClaro(PriceTelco claro) {
        this.claro = claro;
    }

    public PriceTelco getTelefonica() {
        if (telefonica == null) {
            telefonica = new PriceTelco();
        }
        return telefonica;
    }

    public void setTelefonica(PriceTelco telefonica) {
        this.telefonica = telefonica;
    }

}
