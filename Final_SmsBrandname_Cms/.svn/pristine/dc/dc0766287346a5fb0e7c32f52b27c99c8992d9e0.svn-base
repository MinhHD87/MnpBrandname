function GetXmlHttpObject() {
    var objXMLHttp = null;
    if (window.XMLHttpRequest) {
        objXMLHttp = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        objXMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return objXMLHttp;
}

function AjaxAction(where, url) {
    var xmlHttp = new GetXmlHttpObject();
    if (xmlHttp == null) {
        return;
    }
    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4 || xmlHttp.readyState == 200) {
            document.getElementById(where).innerHTML = xmlHttp.responseText;
            alert('vao day 2');
        }
    }
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
}
function setTipMsg(adsid) {
    document.getElementById('dhtmltooltip').innerHTML = '<div style="margin:8px;color: #0066CC;"><b> + name + </b></div>'
            + '<div style="margin:8px;">Ca sỹ :  singer  </div>'
            + '<div style="margin:8px;">Để cài đặt bài này làm nhạc chờ, soạn: <br/>'
            + '<b><span style=\"color: red\"> + commandcode +  </span>'
            + '</b> gửi <b class="tip"><span style=\"color: red\"> + serviceid + </span></b></div>';
//    var bar = '<img src="/resource/images/processing_wheel.gif" align="absmiddle" height="20px" width="20px" title="&#272;ang t&#7843;i d&#7919; li&#7879;u"/> Đang tải dữ liệu';
//    document.getElementById('dhtmltooltip').innerHTML = bar;
////    setTimeout(function() {
//        AjaxAction('dhtmltooltip', '/advertise/view/advHtml.jsp?id=' + adsid);
////    }, 2000);
    return;
}
var showTipInterval = null;
var offsetxpoint = -20
var offsetypoint = 20
var ie = document.all
var ns6 = document.getElementById && !document.all
var enabletip = false
if (ie || ns6)
    var tipobj = document.all ? document.all["dhtmltooltip"] : document.getElementById ? document.getElementById("dhtmltooltip") : ""

function ietruebody() {
    return (document.compatMode && document.compatMode != "BackCompat") ? document.documentElement : document.body
}
var mouseE;
function ddrivetip(thecolor, thewidth) {
    if (ns6 || ie) {
        if (typeof thewidth != "undefined")
            tipobj.style.width = thewidth + "px"
        if (typeof thecolor != "undefined" && thecolor != "")
            tipobj.style.backgroundColor = thecolor
        showTipInterval = setInterval('enableTip()', 50)
    }
}

function enableTip() {
    enabletip = true
}

function cancel() {
    clearInterval(showTipInterval);
    var tipobj = document.getElementById('dhtmltooltip');
    if (null != tipobj) {
        tipobj.style.visibility = 'hidden';
        tipobj.style.left = '-1000px';
        tipobj.innerHTML = '';
    }
    enabletip = false;
}
function positiontip(e) {
    if (enabletip) {
        if (tipobj.innerHTML == '') {
            enabletip = false;
            return;
        }
        var curX = (ns6) ? e.pageX : event.x + ietruebody().scrollLeft;
        var curY = (ns6) ? e.pageY : event.y + ietruebody().scrollTop;
        var rightedge = ie && !window.opera ? ietruebody().clientWidth - event.clientX - offsetxpoint : window.innerWidth - e.clientX - offsetxpoint - 20
        var bottomedge = ie && !window.opera ? ietruebody().clientHeight - event.clientY - offsetypoint : window.innerHeight - e.clientY - offsetypoint - 20

        var leftedge = (offsetxpoint < 0) ? offsetxpoint * (-1) : -1000
        if (rightedge < tipobj.offsetWidth)
            tipobj.style.left = ie ? ietruebody().scrollLeft + event.clientX - tipobj.offsetWidth + "px" : window.pageXOffset + e.clientX - tipobj.offsetWidth + "px"
        else if (curX < leftedge)
            tipobj.style.left = "5px"
        else
            tipobj.style.left = curX + offsetxpoint + "px"
        if (bottomedge < tipobj.offsetHeight)
            tipobj.style.top = ie ? ietruebody().scrollTop + event.clientY - tipobj.offsetHeight - offsetypoint + "px" : window.pageYOffset + e.clientY - tipobj.offsetHeight - offsetypoint + "px"
        else
            tipobj.style.top = curY + offsetypoint + "px"
        tipobj.style.visibility = "visible"
    }
}

function hideddrivetip() {
    enabletip = false
    tipobj.style.visibility = "hidden"
    tipobj.style.left = "-1000px"
    tipobj.style.backgroundColor = ''
    tipobj.style.width = ''
}

document.onmousemove = positiontip