$(document).ready(function () {
    $(".menu").on("click", ".item-name", function (event) {
        var element = $(event.target);
        $.get("/menu_items/" + element.attr("data-id"), function (responseHtml) {
            var container = element.parents(".category-container");
            $(".detail-view", container).html(responseHtml);
        });
    });
});