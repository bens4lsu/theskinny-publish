    function dpPath() {
        var x = new Date();
        var y = x.getFullYear().toString();
        var m = (x.getMonth() + 1).toString();
        var d = x.getDate().toString();
        d = ('0' + d).substring(d.length - 1);
        m = ('0' + m).substring(m.length - 1);
        var yyyymmdd = y + m + d;
        return yyyymmdd;
    }

    var today = dpPath();
    var latest = "20240830";

    var winner = today < latest ? today : latest;
    var pathPart = "/" + winner.toString().substring(0,4) + "/" + winner;
        
    var dailyphotoImg = "/dailyphotostore" + pathPart + ".jpg";
    console.log(pathPart);
    console.log($('#homeDPImage'));
    $('#homeDPImage').attr(dailyphotoImg);
