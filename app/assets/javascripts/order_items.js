$(document).ready(function () {
    $(".category-container").on("click", ".add-item-to-order", function (event) {
        $.ajax({
            method: "post",
            url: "/orders/add_item/" + $(event.target).attr("data-id"),
            beforeSend: function (xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
            },
            success: function (responseHtml) {
                $(".order-container").html(responseHtml);
            },
            error: function (error) {
                alert(error);
            }
        });
    });
});