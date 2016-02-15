function shoppingCart(cartName) {
    this.cartName = cartName;
    this.items = [];
    this.clearCart = false;

    this.loadItems();
    var self = this;
    $(window).unload(function () {
        if (self.clearCart) {
            self.clearItems();
        }
        // self.saveItems();
        self.clearCart = false;
    });
}

shoppingCart.prototype.loadItems = function () {
    var items = localStorage !== null ? localStorage[this.cartName + "_items"] : null;
    if (items !== null && JSON !== null) {
        try {
            items = JSON.parse(items);
            for (var i = 0; i < items.length; i++) {
                var item = items[i];
                if (!item.empty) {
                    this.items.push(item);
                }
            }
        }
        catch (err) {
            // ignore errors while loading...
        }
    }
};

shoppingCart.prototype.saveItems = function () {
    if (localStorage !== null && JSON !== null) {
        localStorage[this.cartName + "_items"] = JSON.stringify(this.items);
    }
};

// adds an item to the cart
shoppingCart.prototype.addItem = function (itemInCart) {
    var quantity = this.toNumber(itemInCart.quantity);
    if (quantity !== 0) {

        // update quantity for existing item
        var found = false,
            item;
        for (var i = 0; i < this.items.length && !found; i++) {
            
            item = this.items[i];
            if (item.code == itemInCart.code) {
                found = true;
                item.quantity = this.toNumber(item.quantity + quantity);
                if (item.quantity <= 0) {
                    this.items.splice(i, 1);
                }
            }
        }

        // new item, add now
        if (!found) {
            this.items.push(itemInCart);
        }

        // save changes.
        this.saveItems();
    }
};

// get the total price for all items currently in the cart
shoppingCart.prototype.getTotalPrice = function (code) {
    var total = 0;
    for (var i = 0; i < this.items.length; i++) {
        var item = this.items[i];
        if (code !== null || item.code == code) {
            total += this.toNumber(item.quantity * item.price);
        }
    }
    return total;
};

// get the total count for all items currently in the cart
shoppingCart.prototype.getTotalCount = function () {
    var count = 0;
    for (var i = 0; i < this.items.length; i++) {
        count = i + 1;
    }
    return count;
};

// clear the cart
shoppingCart.prototype.clearItems = function () {
    this.items = [];
    this.saveItems();
};

//utility methods
shoppingCart.prototype.toNumber = function (value) {
    value = value * 1;
    return isNaN(value) ? 0 : value;
};

$(document).ready(function() {
    var shopping = new shoppingCart("getmyshop_shoppping_cart"),
        totalPrice,
        totalItem;
    updateCart();
    $("#cart_form").submit(function(e) {
        e.preventDefault();
        var cartData = $(this).serializeArray(),
            cartItems = {};
            Materialize.toast("Item added to cart!", 1500);

        for(var i in cartData) {
            if(cartData.hasOwnProperty(i) && i >= 2) {
                if(cartData[i].name === "quantity" ||
                    cartData[i].name === "price") {
                    cartData[i].value = parseInt(cartData[i].value);
                }
                cartItems[cartData[i].name] = cartData[i].value;
            }
        }

        shopping.addItem(cartItems);
        updateCart();
    });

    $(".cart-span").on("click", ".del", function() {
        var items = JSON.parse(localStorage.getmyshop_shoppping_cart_items),
            element_id = $(this).attr("id"),
            cost = 0;
        if (items.length == 1) {
            items[0] = undefined;
            location.reload();
            Materialize.toast("Your cart has been emptied!", 3000);
        } else {
            for (var i = 0; i < items.length; i++) {
                    if (items.hasOwnProperty(i)) {
                    cost += (parseInt(items[i].quantity)) *
                        (parseInt(items[i].price));
                    if (parseInt(element_id) == items[i].product_id) {
                        var parent =
                            document.getElementById("updated_product"),
                            stringProductId = "" + items[i].product_id + "",
                            child = document.getElementById(stringProductId);
                            parent.removeChild(child);
                            cost -= (parseInt(items[i].quantity)) *
                                (parseInt(items[i].price));
                        Materialize.toast("Item removed successfully!", 1500);
                        items.splice(i--, 1);
                    }
                }
            }

            $("#total_price").html(cost);
            $("#total_item").html(items.length);
        }
        localStorage.getmyshop_shoppping_cart_items = JSON.stringify(items);
    });



    function updateCart(){
        var cartHtml = "";
        totalPrice = shopping.getTotalPrice(),
        totalItem = shopping.getTotalCount();

        shopping.items.forEach(function(item){
            cartHtml += "<div id=" + item.product_id + "><div class=";
            cartHtml += "'col l2' id='cart-image'><img src=";
            cartHtml += item.image + " height='42' width='42'></div>";
            cartHtml += "<div class='col l5' id='cart-name'>" + item.name;
            cartHtml += "</div><div class='col l1' id='cart-qty'>";
            cartHtml += item.quantity +"</div><div class='col l3' ";
            cartHtml += "id='cart-price'>" + item.price + "</div>";
            cartHtml += "<div class='col l1 del' id=" + item.product_id;
            cartHtml += "><a href='#'>";
            cartHtml += "<i class='fa fa-times red-text'></i></a></div></div>";
        });
        $("#updated_product").html(cartHtml);
        $("#total_price").html(totalPrice);
        if(totalItem >= 1) {
            $(".total-item").css("background-color", "#f00");
            $("#total_item").html(totalItem);
            if(totalItem <= 9) {
                $(".total-item").css("padding-left", "5.5px");
            } else {
                $(".total-item").css("padding-left", "2px");
            }
            
            $(".cart-span").mouseenter(function() {
                $("#cart-dropdown").css("display", "block");
                $("#no-cart-dropdown").css("display", "none");
            }).mouseleave(function() {
                $("#cart-dropdown").css("display", "none");
            });
         } else {
            $(".total-item").css("background-color", "#fff");
            $(".cart-span").mouseenter(function() {
                $("#cart-dropdown").css("display", "none");
                $("#no-cart-dropdown").css("display", "block");
            }).mouseleave(function() {
                $("#no-cart-dropdown").css("display", "none");
            });
        }
    }
});
