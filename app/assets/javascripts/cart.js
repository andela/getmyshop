$(document).ready(function() {
    $("a.update-quantity-link").click(function(ex) {
        ex.preventDefault();
        var product_id = $(this).data("product-id"),
            url = location.origin + "/cart/update/" + product_id,
            parent_div = $(this).parents("div.quantity-div"),
            quantity = parent_div.find("input.quantity-field").val(),
            data = { quantity: quantity };

        $.post(url, data, function() {
            location.reload();
        });
    });
});
