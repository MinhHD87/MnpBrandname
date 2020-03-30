<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><%@page contentType="text/html; charset=utf-8" %>
<html>
    <head><%@include file="/admin/includes/header.jsp" %></head>
    <body>
        <%            //--
            if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập trang này!");
                response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
                return;
            }
            Provider oneProvi = null;
            if (request.getParameter("submit") != null) {
                //---------------------------
                String name = RequestTool.getString(request, "name");
                String code = RequestTool.getString(request, "code");
                String classmap = RequestTool.getString(request, "classmap");                
                int pos = RequestTool.getInt(request, "pos");
                
                int vte = RequestTool.getInt(request, "viettel");
                int vina = RequestTool.getInt(request, "vina");
                int mobi = RequestTool.getInt(request, "mobi");
                int vnm = RequestTool.getInt(request, "vnm");
                int bl = RequestTool.getInt(request, "bl");
                int ddg = RequestTool.getInt(request, "ddg");
                
                int cellcard = RequestTool.getInt(request, "cellcard");
                int metfone = RequestTool.getInt(request, "metfone");
                int beelineCampuchia = RequestTool.getInt(request, "beelineCampuchia");
                int smart = RequestTool.getInt(request, "smart");
                int qbmore = RequestTool.getInt(request, "qbmore");
                int excell = RequestTool.getInt(request, "excell");
                
                int telemor = RequestTool.getInt(request, "telemor");
                int timortelecom = RequestTool.getInt(request, "timortelecom");
                
                int movitel = RequestTool.getInt(request, "movitel");
                int mcel = RequestTool.getInt(request, "mcel");
                
                int unitel = RequestTool.getInt(request, "unitel");
                int etl = RequestTool.getInt(request, "etl");
                int tango = RequestTool.getInt(request, "tango");
                int laotel = RequestTool.getInt(request, "laotel");
                
                int mytel = RequestTool.getInt(request, "mytel");
                int mpt = RequestTool.getInt(request, "mpt");
                int ooredo = RequestTool.getInt(request, "ooredo");
                int telenor = RequestTool.getInt(request, "telenor");
                
                int natcom = RequestTool.getInt(request, "natcom");
                int digicel = RequestTool.getInt(request, "digicel");
                int comcel = RequestTool.getInt(request, "comcel");
                
                int lumitel = RequestTool.getInt(request, "lumitel");
                int africell = RequestTool.getInt(request, "africell");
                int lacellsu = RequestTool.getInt(request, "lacellsu");
                
                int nexttel = RequestTool.getInt(request, "nexttel");
                int mtn = RequestTool.getInt(request, "mtn");
                int orange = RequestTool.getInt(request, "orange");
                
                int halotel = RequestTool.getInt(request, "halotel");
                int vodacom = RequestTool.getInt(request, "vodacom");
                int zantel = RequestTool.getInt(request, "zantel");
                
                int bitel = RequestTool.getInt(request, "bitel");
                int claro = RequestTool.getInt(request, "claro");
                int telefonica = RequestTool.getInt(request, "telefonica");
                
                int status = RequestTool.getInt(request, "status", 0);
                //---
                oneProvi = new Provider();
                oneProvi.setClassSend(classmap);
                oneProvi.setName(name);
                oneProvi.setCode(code);
                oneProvi.setPos(pos);
                
                oneProvi.setVte(vte);
                oneProvi.setMobi(mobi);
                oneProvi.setVina(vina);
                oneProvi.setVnm(vnm);
                oneProvi.setBl(bl);
                oneProvi.setDdg(ddg);
                
                oneProvi.setCellcard(cellcard);
                oneProvi.setMetfone(metfone);
                oneProvi.setBeelineCampuchia(beelineCampuchia);
                oneProvi.setSmart(smart);
                oneProvi.setQbmore(qbmore);
                oneProvi.setExcell(excell);
                
                oneProvi.setTelemor(telemor);
                oneProvi.setTimortelecom(timortelecom);
                
                oneProvi.setMovitel(movitel);
                oneProvi.setMcel(mcel);
                
                oneProvi.setUnitel(unitel);
                oneProvi.setEtl(etl);
                oneProvi.setTango(tango);
                oneProvi.setLaotel(laotel);
                
                oneProvi.setMytel(mytel);
                oneProvi.setMpt(mpt);
                oneProvi.setOoredo(ooredo);
                oneProvi.setTelenor(telenor);
                
                oneProvi.setNatcom(natcom);
                oneProvi.setDigicel(digicel);
                oneProvi.setComcel(comcel);
                
                oneProvi.setLumitel(lumitel);
                oneProvi.setAfricell(africell);
                oneProvi.setLacellsu(lacellsu);
                
                oneProvi.setNexttel(nexttel);
                oneProvi.setMtn(mtn);
                oneProvi.setOrange(orange);
                
                oneProvi.setHalotel(halotel);
                oneProvi.setVodacom(vodacom);
                oneProvi.setZantel(zantel);
                
                oneProvi.setBitel(bitel);
                oneProvi.setClaro(claro);
                oneProvi.setTelefonica(telefonica);
                
                oneProvi.setStatus(status);
                //------------
                if (oneProvi.addProvider(oneProvi)) {
                    session.setAttribute("mess", "Thêm mới nhà cung cấp dữ liệu thành công!");
                    response.sendRedirect(request.getContextPath() + "/admin/provider/index.jsp");
                    return;
                } else {
                    session.setAttribute("mess", "Thêm mới nhà cung cấp dữ liệu lỗi!");
                }
            }
        %>
        <div id="main_container">
            <%@include file="/admin/includes/checkLogin.jsp" %>
            <div class="main_content">
                <%@include file="/admin/includes/menu.jsp" %>
                <div class="center_content">
                    <div class="right_content">
                        <div align="center" style="height: 20px;margin-bottom: 2px; color: red;font-weight: bold">
                            <%                                if (session.getAttribute("mess") != null) {
                                    out.print(session.getAttribute("mess"));
                                    session.removeAttribute("mess");
                                }
                            %>
                        </div>
                        <form action="" method="post">
                            <table  align="center" id="rounded-corner">
                                <thead>
                                    <tr>
                                        <th scope="col" class="rounded-company"></th>
                                        <th scope="col" class="rounded"></th>
                                        <th style="font-weight: bold" scope="col" class="rounded redBoldUp">Thêm mới Nhà cung cấp</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tên nhà cung cấp: </td>
                                        <td colspan="2"><input size="75" type="text" name="name"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mã nhà cung cấp: </td>
                                        <td colspan="2"><input size="75" type="text" name="code"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Vị trí: </td>
                                        <td colspan="2"><input size="75" type="text" name="pos"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Class Map: </td>
                                        <td colspan="2"><input size="75" type="text" name="classmap"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Hướng cho phép:</td>
                                        <td>
                                            <span class="redBoldUp">Việt Nam</span><br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="viettel" value="0"/> Viettel<br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="vina" value="0"/> Vina<br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="mobi" value="0"/> Mobi<br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="vnm" value="0"/> Vietnam Mobi <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="bl" value="0"/> Beeline <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="ddg" value="0"/> Dongduong <br/>
                                        </td>
                                        <td>
                                            <span class="redBoldUp">Campuchia</span><br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="cellcard" value="0"/> CellCard<br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="metfone" value="0"/> Metfone<br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="beelineCampuchia" value="0"/> Beeline Campuchia<br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="smart" value="0"/> Smart<br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="qbmore" value="0"/> Qbmore <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="excell" value="0"/> Excell <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <span class="redBoldUp">Đông Timor</span><br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="telemor" value="0"/> Telemor <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="timortelecom" value="0"/> Timor Telecom <br/>
                                        </td>
                                        <td>
                                            <span class="redBoldUp">Mozambique</span><br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="movitel" value="0"/> Movitel <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="mcel" value="0"/> Mcel <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <span class="redBoldUp">Lào</span><br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="unitel" value="0"/> Unitel <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="etl" value="0"/> ETL <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="tango" value="0"/> Tango <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="laotel" value="0"/> Lao Tel <br/>
                                        </td>
                                        <td>
                                            <span class="redBoldUp">Myanmar</span><br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="mytel" value="0"/> Mytel <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="mpt" value="0"/> MPT <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="ooredo" value="0"/> Ooredo <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="telenor" value="0"/> Telenor <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <span class="redBoldUp">Haiti</span><br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="natcom" value="0"/> Natcom <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="digicel" value="0"/> Digicel <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="comcel" value="0"/> Comcel <br/>
                                        </td>
                                        <td>
                                            <span class="redBoldUp">Burundi</span><br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="lumitel" value="0"/> Lumitel <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="africell" value="0"/> Africell <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="lacellsu" value="0"/> Lacellsu <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <span class="redBoldUp">Cameron</span><br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="nexttel" value="0"/> Nexttel <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="mtn" value="0"/> MTN <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="orange" value="0"/> Orange <br/>
                                        </td>
                                        <td>
                                            <span class="redBoldUp">Tanzania</span><br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="halotel" value="0"/> Halotel <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="vodacom" value="0"/> Vodacom <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="zantel" value="0"/> Zantel <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <span class="redBoldUp">Peru</span><br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="bitel" value="0"/> Bitel <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="claro" value="0"/> Claro <br/>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="telefonica" value="0"/> Telefonica <br/>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <input onclick="checkBoxClick(this);" type="checkbox" name="skeep" value="0"/>
                                            <span class="redBoldUp">Keep Tin khi cần</span>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Trạng thái</td>
                                        <td>
                                            <select name="status">
                                                <option value="1">Kích hoạt</option>
                                                <option value="0">Khoá</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <input class="button" type="submit" name="submit" value="Thêm mới"/>
                                            <input class="button" onclick="window.location.href = '/admin/provider/index.jsp'" type="reset" name="reset" value="Hủy"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div><!-- end of right content-->
                </div>   <!--end of center content -->
                <div class="clear"></div>
            </div> <!--end of main content-->
            <%@include file="/admin/includes/footer.jsp" %>
        </div>
    </body>
</html>