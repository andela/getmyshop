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

    $("#cart_form").submit(formSubmission);

    $(".cart-span").on("click", ".del", deleteFromLocalStorage);

    function formSubmission(e) {
        e.preventDefault();
        var cartData = $(this).serializeArray();
        Materialize.toast("Item added to cart!", 1500);

        var parsedInfo = parseData(cartData);

        shopping.addItem(parsedInfo);
        updateCart();
    }

    function deleteFromLocalStorage() {
        var items = JSON.parse(localStorage.getmyshop_shoppping_cart_items),
            element_id = $(this).attr("id"),
            cost = 0;
        if (items.length == 1) {
            items[0] = undefined;
            location.reload();
            Materialize.toast("Your cart has been emptied!", 3000);
        } else {
            expungeItem(items, cost, element_id);   
        }
        
        shopping.items = items;
        localStorage.getmyshop_shoppping_cart_items = JSON.stringify(items);
    }

    function expungeItem(items, cost, element_id) {
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
        costWithItems(cost, items);
    }

    function costWithItems(cost, items) {
        $("#total_price").html(cost);
        $("#total_item").html(items.length);
    }

    function parseData(data) {
        var cartItems = {};
        for(var i in data) {
            if(data.hasOwnProperty(i) && i >= 2) {
                if(data[i].name === "quantity" ||
                    data[i].name === "price") {
                    data[i].value = parseInt(data[i].value);
                }
                cartItems[data[i].name] = data[i].value;
            }
        }
        return cartItems;
    }


    function updateCart(){
        var totalPrice = shopping.getTotalPrice(),
            totalItem = shopping.getTotalCount();

        $("#updated_product").html(cartHtmlBuider());
        $("#total_price").html(totalPrice);
        if(totalItem >= 1) {
            cartItemsDisplay(totalItem);
         } else {
            noItem();
        }
    }

    function cartHtmlBuider(){
        var cartHtml = "";
        shopping.items.forEach(function(item) {
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
        return cartHtml;
    }

    function cartItemsDisplay(totalItem) {
        $(".total-item").css("background-color", "#f00");
        $("#total_item").html(totalItem);
        if(totalItem <= 9) {
            $(".total-item").css("padding-left", "5.5px");
        } else {
            $(".total-item").css("padding-left", "2px");
        }
        
        cartHover();
    }

    function cartHover() {
        $(".cart-span").mouseenter(function() {
            $("#cart-dropdown").css("display", "block");
            $("#no-cart-dropdown").css("display", "none");
        }).mouseleave(function() {
            $("#cart-dropdown").css("display", "none");
        });
    }

    function noItem() {
        $(".total-item").css("background-color", "#fff");
        $(".cart-span").mouseenter(function() {
            $("#cart-dropdown").css("display", "none");
            $("#no-cart-dropdown").css("display", "block");
        }).mouseleave(function() {
            $("#no-cart-dropdown").css("display", "none");
        });
    }

});
