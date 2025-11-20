
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
        console.log(collapser.find(".li-pagelink:visible").length);
        if (collapser.find(".li-pagelink:visible").length > 0) {
            $(this).find(".span-collapser").text(" ▼︎");
            $(this).css("text-decoration", "underline");
        } else {
            $(this).find(".span-collapser").text(" ▶");
            $(this).css("text-decoration", "none");
        }
    }); 
    
    
})
