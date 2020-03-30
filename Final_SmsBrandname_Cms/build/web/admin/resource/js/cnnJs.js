$(document).ready(function () {
    var pattern = /[a-zA-Z@]/g;

    var numberFormatArr = $(".cnnNumberFormat");

    for (var i = 0; i < numberFormatArr.length; i++) {
        var $n = $(numberFormatArr[i]);
        if (pattern.test($n.text()) === false) {
            var num = (parseInt($n.text()));
            $n.text(num.toLocaleString());
        }
    }

});