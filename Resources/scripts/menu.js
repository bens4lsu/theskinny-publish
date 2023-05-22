
$.fn.extend({
    toggleVisibility: function() {
        if (this.css('display') == "none") {
            this.css('display', "block");
        } else {
            this.css('display', 'none');
        }
    }
});

$(document).ready(function() {
    $(".menu-collapser li:first-child a").click(function() {
        var collapser = $(this).parent().parent();
        collapser.children(".li-pagelink").toggleVisibility();
        if (collapser.children(".li-pagelink:visible").length > 0) {
            $(this).children(".span-collapser").text(" ▼︎");
            $(this).css("text-decoration", "underline");
        } else {
            $(this).children(".span-collapser").text(" ▶");
            $(this).css("text-decoration", "none");
        }
    }); 
    
    
})

function receiveMessage(event) {
    if (! isNaN(event.data)) {
        var iframe = document.getElementById('tsob-fullpage-iframe');
        iframe.style.height = iframe.height = event.data + "px";
    }
    document.body.scrollTop = document.documentElement.scrollTop = 0;
}
    
if(typeof window.addEventListener != 'undefined'){
    window.addEventListener('message', receiveMessage, false);
} else if(typeof window.attachEvent != 'undefined') {
    window.attachEvent('onmessage', receiveMessage);
}
