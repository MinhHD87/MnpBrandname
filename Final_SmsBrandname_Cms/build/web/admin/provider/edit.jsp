<%@page import="gk.myname.vn.utils.RequestTool"%><%@page import="gk.myname.vn.entity.Provider"%><%@page import="gk.myname.vn.utils.Tool"%><%@page import="java.util.Iterator"%><%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><%@page contentType="text/html; charset=utf-8" %>
<html>
    <head><%@include file="/admin/includes/header.jsp" %></head>
    <body>
        <%  //--          
            if (!userlogin.checkAdd(request)) {
                session.setAttribute("mess", "Bạn không có quyền truy cập trang này!");
                response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
                return;
            }
            int id = RequestTool.getInt(request, "id");
            Provider oneProvi = new Provider();
            oneProvi = oneProvi.getbyId(id);
            if (id == 0 || oneProvi == null) {
                session.setAttribute("mess", "Yêu cầu không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/provider/index.jsp");
                return;
            }
            if (request.getParameter("submit") != null) {
                //---------------------------
                String classmap = RequestTool.getString(request, "classmap");
                String name = RequestTool.getString(request, "name");
                String code = RequestTool.getString(request, "code");
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
                if (oneProvi.updateProvider(oneProvi)) {
                    session.setAttribute("mess", "Cập nhật dữ liệu nhà cung cấp thành công!");
                    response.sendRedirect(request.getContextPath() + "/admin/provider/index.jsp");
                    return;
                } else {
                    session.setAttribute("mess", "Cập nhật dữ nhà cung cấp liệu lỗi!");
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
                                        <th style="font-weight: bold" scope="col" class="rounded redBoldUp">Chỉnh sửa nhà cung cấp</th>
                                        <th scope="col" class="rounded-q4"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td align="left">Tên nhà cung cấp: </td>
                                        <td colspan="2"><input value="<%=oneProvi.getName()%>" size="75" type="text" name="name"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Mã nhà cung cấp: </td>
                                        <td colspan="2"><input value="<%=oneProvi.getCode()%>" size="75" type="text" name="code"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Vị trí: </td>
                                        <td colspan="2"><input value="<%=oneProvi.getPos()%>" size="75" type="text" name="pos"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left">Class Map: </td>
                                        <td colspan="2"><input value="<%=oneProvi.getClassSend()%>" size="75" type="text" name="classmap"/></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Cấp hướng nhãn này:</td>
                                        <td>
                                            <span class="redBoldUp">Việt Nam</span><br/>
                                            <input <%=oneProvi.getVte() == 1 ? "checked='checked'" : ""%> onclick="checkBoxClick(this);" type="checkbox" name="viettel" value="<%=oneProvi.getVte() == 1 ? "1" : "0"%>"/> Viettel <br/>
                                            <input <%=oneProvi.getMobi() == 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="mobi" value="<%=oneProvi.getMobi() == 1 ? "1" : "0"%>"/> Mobi<br/>
                                            <input <%=oneProvi.getVina() == 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="vina" value="<%=oneProvi.getVina() == 1 ? "1" : "0"%>"/> Vina<br/>
                                            <input <%=oneProvi.getVnm() == 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="vnm" value="<%=oneProvi.getVnm() == 1 ? "1" : "0"%>"/> Vietnam Mobi <br/>
                                            <input <%=oneProvi.getBl() == 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="bl" value="<%=oneProvi.getBl() == 1 ? "1" : "0"%>"/> Beeline <br/>
                                            <input <%=oneProvi.getDdg()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="ddg" value="<%=oneProvi.getDdg()== 1 ? "1" : "0"%>"/> Dongduong
                                        </td>
                                        <td>
                                            <span class="redBoldUp">Campuchia</span><br/>
                                            <input <%=oneProvi.getCellcard()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="cellcard" value="<%=oneProvi.getCellcard()== 1 ? "1" : "0"%>"/> CellCard<br/>
                                            <input <%=oneProvi.getMetfone()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="metfone" value="<%=oneProvi.getMetfone()== 1 ? "1" : "0"%>"/> Metfone<br/>
                                            <input <%=oneProvi.getBeelineCampuchia()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="beelineCampuchia" value="<%=oneProvi.getBeelineCampuchia()== 1 ? "1" : "0"%>"/> Beeline Campuchia<br/>
                                            <input <%=oneProvi.getSmart() == 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="smart" value="<%=oneProvi.getSmart()== 1 ? "1" : "0"%>"/> Smart<br/>
                                            <input <%=oneProvi.getQbmore()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="qbmore" value="<%=oneProvi.getQbmore()== 1 ? "1" : "0"%>"/> Qbmore <br/>
                                            <input <%=oneProvi.getExcell()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="excell" value="<%=oneProvi.getExcell()== 1 ? "1" : "0"%>"/> Excell <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <span class="redBoldUp">Đông Timor</span><br/>
                                            <input <%=oneProvi.getTelemor()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="telemor" value="<%=oneProvi.getTelemor()== 1 ? "1" : "0"%>"/> Telemor <br/>
                                            <input <%=oneProvi.getTimortelecom()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="timortelecom" value="<%=oneProvi.getTimortelecom()== 1 ? "1" : "0"%>"/> Timor Telecom <br/>
                                        </td>
                                        <td>
                                            <span class="redBoldUp">Mozambique</span><br/>
                                            <input <%=oneProvi.getMovitel()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="movitel" value="<%=oneProvi.getMovitel()== 1 ? "1" : "0"%>"/> Movitel <br/>
                                            <input <%=oneProvi.getMcel()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="mcel" value="<%=oneProvi.getMcel()== 1 ? "1" : "0"%>"/> Mcel <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <span class="redBoldUp">Lào</span><br/>
                                            <input <%=oneProvi.getUnitel()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="unitel" value="<%=oneProvi.getUnitel()== 1 ? "1" : "0"%>"/> Unitel <br/>
                                            <input <%=oneProvi.getEtl()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="etl" value="<%=oneProvi.getEtl()== 1 ? "1" : "0"%>"/> ETL <br/>
                                            <input <%=oneProvi.getTango()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="tango" value="<%=oneProvi.getTango()== 1 ? "1" : "0"%>"/> Tango <br/>
                                            <input <%=oneProvi.getLaotel()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="laotel" value="<%=oneProvi.getLaotel()== 1 ? "1" : "0"%>"/> Lao Tel <br/>
                                        </td>
                                        <td>
                                            <span class="redBoldUp">Myanmar</span><br/>
                                            <input <%=oneProvi.getMytel()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="mytel" value="<%=oneProvi.getMytel()== 1 ? "1" : "0"%>"/> Mytel <br/>
                                            <input <%=oneProvi.getMpt()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="mpt" value="<%=oneProvi.getMpt()== 1 ? "1" : "0"%>"/> MPT <br/>
                                            <input <%=oneProvi.getOoredo()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="ooredo" value="<%=oneProvi.getOoredo()== 1 ? "1" : "0"%>"/> Ooredo <br/>
                                            <input <%=oneProvi.getTelenor()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="telenor" value="<%=oneProvi.getTelenor()== 1 ? "1" : "0"%>"/> Telenor <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <span class="redBoldUp">Haiti</span><br/>
                                            <input <%=oneProvi.getNatcom()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="natcom" value="<%=oneProvi.getNatcom()== 1 ? "1" : "0"%>"/> Natcom <br/>
                                            <input <%=oneProvi.getDigicel()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="digicel" value="<%=oneProvi.getDigicel()== 1 ? "1" : "0"%>"/> Digicel <br/>
                                            <input <%=oneProvi.getComcel()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="comcel" value="<%=oneProvi.getComcel()== 1 ? "1" : "0"%>"/> Comcel <br/>
                                        </td>
                                        <td>
                                            <span class="redBoldUp">Burundi</span><br/>
                                            <input <%=oneProvi.getLumitel()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="lumitel" value="<%=oneProvi.getLumitel()== 1 ? "1" : "0"%>"/> Lumitel <br/>
                                            <input <%=oneProvi.getAfricell()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="africell" value="<%=oneProvi.getAfricell()== 1 ? "1" : "0"%>"/> Africell <br/>
                                            <input <%=oneProvi.getLacellsu()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="lacellsu" value="<%=oneProvi.getLacellsu()== 1 ? "1" : "0"%>"/> Lacellsu <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <span class="redBoldUp">Cameron</span><br/>
                                            <input <%=oneProvi.getNexttel()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="nexttel" value="<%=oneProvi.getNexttel()== 1 ? "1" : "0"%>"/> Nexttel <br/>
                                            <input <%=oneProvi.getMtn()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="mtn" value="<%=oneProvi.getMtn()== 1 ? "1" : "0"%>"/> MTN <br/>
                                            <input <%=oneProvi.getOrange()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="orange" value="<%=oneProvi.getOrange()== 1 ? "1" : "0"%>"/> Orange <br/>
                                        </td>
                                        <td>
                                            <span class="redBoldUp">Tanzania</span><br/>
                                            <input <%=oneProvi.getHalotel()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="halotel" value="<%=oneProvi.getHalotel()== 1 ? "1" : "0"%>"/> Halotel <br/>
                                            <input <%=oneProvi.getVodacom()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="vodacom" value="<%=oneProvi.getVodacom()== 1 ? "1" : "0"%>"/> Vodacom <br/>
                                            <input <%=oneProvi.getZantel()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="zantel" value="<%=oneProvi.getZantel()== 1 ? "1" : "0"%>"/> Zantel <br/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <span class="redBoldUp">Peru</span><br/>
                                            <input <%=oneProvi.getBitel()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="bitel" value="<%=oneProvi.getBitel()== 1 ? "1" : "0"%>"/> Bitel <br/>
                                            <input <%=oneProvi.getClaro()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="claro" value="<%=oneProvi.getClaro()== 1 ? "1" : "0"%>"/> Claro <br/>
                                            <input <%=oneProvi.getTelefonica()== 1 ? "checked='checked'" : ""%>  onclick="checkBoxClick(this);" type="checkbox" name="telefonica" value="<%=oneProvi.getTelefonica()== 1 ? "1" : "0"%>"/> Telefonica <br/>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>Trạng thái</td>
                                        <td>
                                            <select name="status">
                                                <option <%=oneProvi.getStatus() == 1 ? "selected='selected'" : ""%> value="1">Kích hoạt</option>
                                                <option <%=oneProvi.getStatus() == 0 ? "selected='selected'" : ""%> value="0">Khoá</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" align="center">
                                            <input class="button" type="submit" name="submit" value="Cập nhật"/>
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