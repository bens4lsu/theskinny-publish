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

        function pathPart() {
            var today = dpPath();
            var latest = "20241027";

            var winner = today < latest ? today : latest;
            var pathPart = "/" + winner.toString().substring(0,4) + "/" + winner;
            return pathPart
        }

        $(document).ready(function(){

            var today = dpPath();
            var latest = "20241027";

            var winner = today < latest ? today : latest;
            var pathPart = "/" + winner.toString().substring(0,4) + "/" + winner;
            
            var dailyphotoImg = "/dailyphotostore" + pathPart + ".jpg";
            $('#homeDPImage').attr('src', dailyphotoImg);
    });
    
    $(document).ready(function(){
        var dailyphotoImg = "/dailyphotostore" + pathPart() + ".jpg";
        $('#homeDPImage').attr('src', dailyphotoImg);
    });
