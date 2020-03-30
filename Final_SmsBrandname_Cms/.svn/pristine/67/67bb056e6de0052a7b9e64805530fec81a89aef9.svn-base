/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * ===========================================
 *      readyState
 *	0 (Uninitialized): Đối tượng mới đựơc tạo nhưng hàm open chưa được gọi.
 *	1 (Loading): Hàm open  mới được gọi nhưng request chưa được gởi
 *	2 (Loaded): Request vừa mới được gởi
 *	3 (Interactive): Client đã nhận được một phần response từ server
 *	4 (Complete): Tất cả dữ liệu đã được server gởi về client và kết nối đã đóng lại.
 *
 */
var context = "";
function urlEncode(str) {
    str = escape(str);
    str = str.replace(new RegExp('\\+', 'g'), '%2B');
    return str.replace(new RegExp('%20', 'g'), '+');
}
function GetXmlHttpObject() {
    var objXMLHttp = null;
    if (window.XMLHttpRequest) {
        objXMLHttp = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        objXMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return objXMLHttp;
}
function AjaxAction(url, where) {
    var xmlHttp = new GetXmlHttpObject();
    if (xmlHttp === null) {
        return;
    }
    xmlHttp.onreadystatechange = function () {
        if (xmlHttp.readyState === 4 || xmlHttp.readyState === 200) {
            document.getElementById(where).innerHTML = xmlHttp.responseText;
        }
    };
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
}
function AjaxStr(url) {
    var xmlHttp = new GetXmlHttpObject();
    if (xmlHttp == null) {
        return "";
    }
    xmlHttp.open("GET", url, false);
    xmlHttp.send();
    return xmlHttp.responseText;
}
function submitForm(form) {
    /*
     "submit is not a function" means that you named your submit button or some other element submit. Rename the button to btnSubmit and your call will magically work.
     When you name the button submit, you override the submit() function on the form.
     */
    document.getElementById(form).submit();
}
function showLoading(where) {
    var bar = '<img src="/admin/res/images/loading.gif" align="absmiddle" height="20px" width="20px" title="Đang xử lý dữ liệu"/> Đang xử lý';
    document.getElementById(where).innerHTML = bar;
}
function hidenLoading(where) {
    document.getElementById(where).innerHTML = '';
}
function closePopup(id) {
    $("#lean_overlay").fadeOut(200);
    $("#" + id).css({display: "none"});
}
function ajaxLoad(url, divid) {
    if (url.length === 0) {
        return;
    }
    $.get(url, divid, function success(responseText) {
        if (responseText !== "error" && responseText !== "") {
            document.getElementById(divid).innerHTML = responseText;
        } else {
            alert("Xử lý thất bại!");
        }
    });
}
function checkBoxClick(obj) {
    if (obj.value === 1) {
        obj.value = 0;
    } else {
        obj.value = 1;
    }
}
function isNumeric(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
}
function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}
function listCustumer(pg, rid, key, gid) {
    $.ajax({
        url: context + "/cus-cms/ds_khach_hang/ajax_cus-list.jsp?rid=" + rid + "&page=" + pg + "&key=" + key + "&gid=" + gid + "&r=" + Math.floor(Math.random() * 10000),
        type: 'post',
        success: function (data) {
            if (data != null && data != '' && data != 'undefined') {
                $("#list-customer-tbody").html(data);
                $("#groupChoice").find("option[value='" + gid + "']").attr('selected', 'selected');
                return;
            } else {
                return false;
            }
        }
    });
    return false;
}
function ChangeChoiceType(val) {
    if (val == 'f') {
        $("#div_fileInputSend").show();
        $("#phoneInputSend").hide();
        $("#listInputSend").hide();
    } else if (val == 'l') {
        $("#listInputSend").show();
        $("#div_fileInputSend").hide();
        $("#phoneInputSend").hide();
    } else {
        $("#phoneInputSend").show();
        $("#div_fileInputSend").hide();
        $("#listInputSend").hide();
    }
}
function isBlank(str) {
    return (!str || /^\s*$/.test(str));
}
//Ham chuyen chu co dau sang khong dau
function locdau(str) {
    str = str.toLowerCase();
    str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
    str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
    str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
    str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
    str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
    str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
    str = str.replace(/đ/g, "d");
    return str;
}
function isGSMAlphabet(text) {
    var regexp = new RegExp("^[A-Za-z0-9 \\r\\n@£$¥èéùìòÇØøÅå\u0394_\u03A6\u0393\u039B\u03A9\u03A0\u03A8\u03A3\u0398\u039EÆæßÉ!\"#$%&'()*+,\\-./:;<=>?¡ÄÖÑÜ§¿äöñüà^{}\\\\\\[~\\]|\u20AC]*$");
    return regexp.test(text);
}
var regexPhone = /(\+849\d{8})|(849\d{8})|(09\d{8})|(9\d{8})|(\+841\d{9})|(841\d{9})|(01\d{9})|(1\d{9})|(\+848\\d{8})|(848\d{8})|(08\d{8})|(8\d{8})|(3\d{8})|(5\d{8})|(7\d{8})|(03\d{8})|(05\d{8})|(07\d{8})|(843\d{8})|(845\d{8})|(847\d{8})|(\+843\d{8})|(\+845\d{8})|(\+847\d{8})/;
function checkPhone(listPhone) {
//    console.log("-------------");
    var arrData = listPhone.split(/[, ;:]/);
//    console.log("arrData length:" + arrData.length)
    var arrValid = [7]; // 
    for (var k = 0; k < 7; k++) {
        arrValid[k] = 0;
    }
    if (arrData != null && arrData.length > 0) {
        for (var i = 0; i < arrData.length; i++) {
//            console.log('regexPhone.test(arrData[' + i + ']):' + regexPhone.test(arrData[i]));
            if (!isBlank(arrData[i])) {
                if (regexPhone.test(arrData[i])) {
                    var oper = buildOper(arrData[i]);
                    switch (oper) {
                        case 1:
                            arrValid[1] = arrValid[1] + 1;
                            break;
                        case 2:
                            arrValid[2] = arrValid[2] + 1;
                            break;
                        case 3:
                            arrValid[3] = arrValid[3] + 1;
                            break;
                        case 4:
                            arrValid[4] = arrValid[4] + 1;
                            break;
                        case 5:
                            arrValid[5] = arrValid[5] + 1;
                            break;
                        case 6:
                            arrValid[6] = arrValid[6] + 1;
                            break;
                        default :
                            arrValid[0] = arrValid[0] + 1;
                            break;
                    }
                } else {
                    arrValid[0] = arrValid[0] + 1;
                }
            }
        }
    }
    $("#phone_error").html(arrValid[0]);
    $("#phone_vte").html(arrValid[1]);
    $("#phone_vms").html(arrValid[2]);
    $("#phone_gpc").html(arrValid[3]);
    $("#phone_vnm").html(arrValid[4]);
    $("#phone_gtel").html(arrValid[5]);
    $("#phone_ddg").html(arrValid[6]);
//    for (var k = 0; k < 6; k++) {
//        console.log("arrValid[" + k + "]: " + arrValid[k]);
//    }
}

function  buildOper(phone) {
    console.log("CO phone:" + phone);
    var oper = 0;
    if (phone.startsWith("+8498") || phone.startsWith("8498") || phone.startsWith("098")
            || phone.startsWith("+8497") || phone.startsWith("8497") || phone.startsWith("097")
            || phone.startsWith("+84160") || phone.startsWith("84160") || phone.startsWith("0160")
            || phone.startsWith("+84161") || phone.startsWith("84161") || phone.startsWith("0161")
            || phone.startsWith("+84162") || phone.startsWith("84162") || phone.startsWith("0162")
            || phone.startsWith("+84163") || phone.startsWith("84163") || phone.startsWith("0163")
            || phone.startsWith("+84164") || phone.startsWith("84164") || phone.startsWith("0164")
            || phone.startsWith("+84165") || phone.startsWith("84165") || phone.startsWith("0165")
            || phone.startsWith("+84166") || phone.startsWith("84166") || phone.startsWith("0166")
            || phone.startsWith("+84167") || phone.startsWith("84167") || phone.startsWith("0167")
            || phone.startsWith("+84168") || phone.startsWith("84168") || phone.startsWith("0168")
            || phone.startsWith("+84169") || phone.startsWith("84169") || phone.startsWith("0169")
            || phone.startsWith("+8486") || phone.startsWith("8486") || phone.startsWith("086") // NEW
            || phone.startsWith("+843") || phone.startsWith("843") || phone.startsWith("03") // NEW
            // EVN Cu
            || phone.startsWith("096") || phone.startsWith("8496") || phone.startsWith("+8496")) {
        oper = 1;
    } else if (phone.startsWith("+8490") || phone.startsWith("8490") || phone.startsWith("090")
            || phone.startsWith("+8493") || phone.startsWith("8493") || phone.startsWith("093")
            || phone.startsWith("+84120") || phone.startsWith("84120") || phone.startsWith("0120")
            || phone.startsWith("+84121") || phone.startsWith("84121") || phone.startsWith("0121")
            || phone.startsWith("+84122") || phone.startsWith("84122") || phone.startsWith("0122")
            || phone.startsWith("+84126") || phone.startsWith("84126") || phone.startsWith("0126")
            || phone.startsWith("+84128") || phone.startsWith("84128") || phone.startsWith("0128")
            || phone.startsWith("+8489") || phone.startsWith("8489") || phone.startsWith("089") // NEW
            || phone.startsWith("+8470") || phone.startsWith("8470") || phone.startsWith("070") // NEW
            || phone.startsWith("+8476") || phone.startsWith("8476") || phone.startsWith("076") // NEW
            || phone.startsWith("+8477") || phone.startsWith("8477") || phone.startsWith("077") // NEW
            || phone.startsWith("+8478") || phone.startsWith("8478") || phone.startsWith("078") // NEW
            || phone.startsWith("+8479") || phone.startsWith("8479") || phone.startsWith("079") // NEW
            ) {
// MOBILE
        oper = 2;
    } else if (//-
            phone.startsWith("+8491") || phone.startsWith("8491") || phone.startsWith("091")
            || phone.startsWith("+8494") || phone.startsWith("8494") || phone.startsWith("094")
            || phone.startsWith("+84123") || phone.startsWith("84123") || phone.startsWith("0123")
            || phone.startsWith("+84124") || phone.startsWith("84124") || phone.startsWith("0124")
            || phone.startsWith("+84125") || phone.startsWith("84125") || phone.startsWith("0125")
            || phone.startsWith("+84127") || phone.startsWith("84127") || phone.startsWith("0127")
            || phone.startsWith("+84129") || phone.startsWith("84129") || phone.startsWith("0129")
            || phone.startsWith("+8488") || phone.startsWith("8488") || phone.startsWith("088") // NEW
            || phone.startsWith("+8481") || phone.startsWith("8481") || phone.startsWith("081") // NEW
            || phone.startsWith("+8482") || phone.startsWith("8482") || phone.startsWith("082") // NEW
            || phone.startsWith("+8483") || phone.startsWith("8483") || phone.startsWith("083") // NEW
            || phone.startsWith("+8484") || phone.startsWith("8484") || phone.startsWith("084") // NEW
            || phone.startsWith("+8485") || phone.startsWith("8485") || phone.startsWith("085") // NEW
            ) {
//VINA
        oper = 3;
    } else if (phone.startsWith("092") || phone.startsWith("8492") || phone.startsWith("+8492")
            || phone.startsWith("0188") || phone.startsWith("84188") || phone.startsWith("+84188")
            || phone.startsWith("056") || phone.startsWith("8456") || phone.startsWith("+8456")
            || phone.startsWith("052") || phone.startsWith("8452") || phone.startsWith("+8452")
            || phone.startsWith("058") || phone.startsWith("8458") || phone.startsWith("+8458")) {
// VIET NAM MOBILE
        oper = 4;
    } else if (phone.startsWith("099") || phone.startsWith("8499") || phone.startsWith("+8499")
            || phone.startsWith("0199") || phone.startsWith("84199") || phone.startsWith("+84199")
            || phone.startsWith("059") || phone.startsWith("8459") || phone.startsWith("+8459")) {
        oper = 5;
        //GMOBILE
    } else if (phone.startsWith("087") || phone.startsWith("8487") || phone.startsWith("+8487")) {
        oper = 6;
        //DONGDUONG
    } else {
        oper = 0;
    }
    console.log(oper);
    return oper;
}
function blink_text(id) {
    for (var i = 1; i < 5; i++) {
        $('#' + id).fadeOut(500);
        $('#' + id).fadeIn(500);
        setTimeout(function () {
            //do what you need here
        }, 2000);
    }
}
function randomString(length) {
    var result = '';
    for (var i = length; i > 0; --i)
        result += rString[Math.floor(Math.random() * rString.length)];
    return result;
}
var rString = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
Date.prototype.hhmiss = function () {
    var yy = this.getFullYear();
    var mon = this.getMonth();
    var dd = this.getDaysInMonth();
    var hh = this.getHours();
    var mi = this.getMinutes();
    var ss = this.getSeconds();
    return [
        yy,
        (mon < 10 ? "0" : "") + mon,
        (dd < 10 ? "0" : "") + dd,
        (hh < 10 ? "0" : "") + hh,
        (mi < 10 ? "0" : "") + mi,
        (ss < 10 ? "0" : "") + ss
    ].join('');
};