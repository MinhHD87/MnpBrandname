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

function checkAll() {
    var chk = document.getElementById("checkall");
    if (chk.checked) {
        var chkmove = document.getElementsByName("chkmove");
        for (var i = 0; i < chkmove.length; i++)
            chkmove[i].checked = true;
    } else {
        var chkmove = document.getElementsByName("chkmove");
        for (var i = 0; i < chkmove.length; i++)
            chkmove[i].checked = false;
    }
}
function CheckMove() {
    var chkmove = document.getElementsByName("chkmove");
    for (var i = 0; i < chkmove.length; i++) {
        if (chkmove[i].checked) {
            return true;
        }
    }
    alert("Bạn cần chọn ít nhất một nội dung để chuyển chuyên mục");
    return false;
}
function isBlank(str) {
    return (!str || /^\s*$/.test(str));
}
$(document).ready(function () {
    $("#_label").select2({
        formatResult: function (item) {
            var valOpt = $(item.element).attr('img-data');
            if (!valOpt) {
                return ('<div><b>' + item.text + '</b></div>');
            } else {
                return ('<div><span><b style="color: red">' + item.text + '<b> <img src="' + valOpt + '" class="img-flag" /></span></div>');
            }
        },
        formatSelection: function (item) {
            //  load page or selected
            var opt = $("#_label option:selected");
            var valOpt = opt.attr("img-data");
            if (!valOpt) {
                return ('<b>' + item.text + '</b>');
            } else {
                return ('<div><span><b style="color: red">' + item.text + '</b> <img src="' + valOpt + '" class="img-flag" /></span></div>');
            }
        },
        dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
        escapeMarkup: function (m) {
            return m;
        }
    });
});
$(document).ready(function () {
    $("#_agentcy_id").select2({
        formatResult: function (item) {
            var valOpt = $(item.element).attr('img-data');
            if (!valOpt) {
                return ('<div><b>' + item.text + '</b></div>');
            } else {
                return ('<div><span><b style="color: red">' + item.text + '<b> <img src="' + valOpt + '" class="img-flag" /></span></div>');
            }
        },
        formatSelection: function (item) {
            //  load page or selected
            var opt = $("#_agentcy_id option:selected");
            var valOpt = opt.attr("img-data");
            if (!valOpt) {
                return ('<b>' + item.text + '</b>');
            } else {
                return ('<div><span><b style="color: red">' + item.text + '</b> <img src="' + valOpt + '" class="img-flag" /></span></div>');
            }
        },
        dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
        escapeMarkup: function (m) {
            return m;
        }
    });
});
$(document).ready(function () {
    $("#_userSender").select2({
        formatResult: function (item) {
            var valOpt = $(item.element).attr('img-data');
            if (!valOpt) {
                return ('<div><b>' + item.text + '</b></div>');
            } else {
                return ('<div><span><b style="color: red">' + item.text + '<b> <img src="' + valOpt + '" class="img-flag" /></span></div>');
            }
        },
        formatSelection: function (item) {
            //  load page or selected
            var opt = $("#_userSender option:selected");
            var valOpt = opt.attr("img-data");
            if (!valOpt) {
                return ('<b>' + item.text + '</b>');
            } else {
                return ('<div><span><b style="color: red">' + item.text + '</b> <img src="' + valOpt + '" class="img-flag" /></span></div>');
            }
        },
        dropdownCssClass: "bigdrop", // apply css that makes the dropdown taller
        escapeMarkup: function (m) {
            return m;
        }
    });
});