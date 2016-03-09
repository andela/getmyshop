$(document).ready(function(){
  $(".slider").slider({full_width: false});
  $("select").material_select();

  var currentElement = null,
      wishlist_url = location.origin + "/wishlist";

  $(".add-to-wishlist").click(function() {
    currentElement = $(this);
    if (currentElement.attr("href") != "#") {
      window.location = currentElement.attr("href");
    } else {
      process_add_wishlist_ajax_call(currentElement);
    }
  });

  $(".delete-from-wishlist").click(function() {
    currentElement = $(this);
    process_delete_wishlist_ajax_call(currentElement);
  });

  function process_add_wishlist_ajax_call(currentElement) {
    currentElement.hide();
      $.ajax({
        url: wishlist_url,
        type: "POST",
        data: {
          edit_action: "add",
          product_id: currentElement.data("product-id")
        },
        success: ajax_success_for_add,
        error: function() {
          currentElement.fadeIn("slow");
          Materialize.toast("Problem encountered. Please try again", 3000);
        }
      });
  }

  function process_delete_wishlist_ajax_call(currentElement) {
    $.ajax({
      url: wishlist_url,
      type: "POST",
      data: {
        edit_action: "delete",
        wishlist_id: currentElement.data("wishlist-id")
      },
      success: function(result) {
         Materialize.toast(result, 3000);
         currentElement.parent().parent().remove();
      },
      error: function() {
        Materialize.toast("Problem encountered. Please try again", 3000);
      }
    });
  }

  function ajax_success_for_add(result) {
    var initialHtml = currentElement.html(),
        newHtml = initialHtml.replace("fa-heart-o", "fa-heart");

    newHtml = newHtml.replace("Add to Wishlist", "Browse Wishlist");
    currentElement.html(newHtml);
    currentElement.addClass("dark-cyan-text");
    Materialize.toast(result, 3000);
    currentElement.fadeIn("slow");
    currentElement.attr("href", wishlist_url);
  }

});
