
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
    $("li.menu-collapser:first-child a").click(function() {
        var collapser = $(this).parent();
        collapser.children("ul").toggleVisibility();
        if (collapser.children(".li-pagelink:visible").length > 0) {
            $(this).children(".span-collapser").text(" ▼︎");
            $(this).css("text-decoration", "underline");
        } else {
            $(this).children(".span-collapser").text(" ▶");
            $(this).css("text-decoration", "none");
        }
    }); 
    
    
})
