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

function eventAction(url, divid) {
    if (url.length == 0) {
        return;
    }
    $.get(url, divid, function AllStateChanged(responseText) {
        if (responseText != "error" && responseText != "") {
            document.getElementById(divid).innerHTML = responseText;
        } else {
            alert("Cập nhật thất bại!");
        }
    });
}
function insertTags(url, divid) {
    if (url.length == 0) {
        return;
    }
    $.get(url, divid, function resultAddTag(responseText) {
        if (responseText != "error" && responseText != "")
        {
            alert("Thêm mới thành công!");
            document.getElementById(divid).style.display = 'none';
        }
        else
        {
            alert("Cập nhật thất bại!");
        }
    });
}

