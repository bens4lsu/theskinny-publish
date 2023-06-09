<iframe id="tsob-fullpage-iframe" src="https://dynamic.theskinnyonbenny.com/dp" style="border:none; width: 100%; overflow:hidden;" scrolling="no"></iframe>


<script>

    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
        
    const year = parseInt(urlParams.get('year'));
    const month = parseInt(urlParams.get('month'));
    const day = parseInt(urlParams.get('day')); 
    
    if ( Number.isInteger(year) && 2005 <= year && 2100 >= year &&
         Number.isInteger(month) && 1 <= month && 12 >= month &&
         Number.isInteger(day) && 1<= day && 31 >= day)
    {
        const iframeUrl = "https://dynamic.theskinnyonbenny.com/dp/" + year + "/" + month + "/" + day;
        $('iframe#tsob-fullpage-iframe').attr("src", iframeUrl);
    }
         
</script>