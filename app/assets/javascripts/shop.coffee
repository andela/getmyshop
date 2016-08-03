<<<<<<< 0ec0234f35c580d142d9f97cae20679739972b73
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
=======
>>>>>>> feat(shop dashboard UI): Adds the dashboard UI for new shops that haven't fully setup i.e have not added products. [finishes #126486649]
$ ->
  $(".side-bar-cont").mouseenter ->
    $(".side-bar-menu-text").fadeIn 100

    $(".side-bar-menu a"). animate {
      color: "#ffffff",
      duration: 600,
      easing: "linear"
    }

    $("#hdline").animate {
      color: "#fffff",
      duration: 600,
      easing: "linear"
    }

    $(this).animate {
      width: "150px",
      duration: 600,
      easing: "linear"
    }
  .mouseleave ->
    $(".side-bar-menu-text").fadeOut 100

    $(".side-bar-menu a"). animate {
      color: "#757575",
      duration: 600,
      easing: "linear"
    }

    $('#hdline').animate {
      color: "#ffffff",
      duration: 600,
      easing: "linear"
    }

    $(this).animate {
      width: "64px",
      duration: 600,
      easing: "linear"
    }
<<<<<<< 0ec0234f35c580d142d9f97cae20679739972b73

  $('.modal-trigger').leanModal()
  $('#add-product-btn').leanModal()
  $('input#product_description').characterCounter()

  postData = ->
    name: $('#product_name').val()
    description: $('#product_description').val()
    quantity: $('#product_quantity').val()
    brand: $('#product_brand').val()
    size: $('#product_size').val()
    price: $('#product_price').val()

  $('#create_product').click ->
    event.preventDefault()
    createPath = "/shopowners/shop/product/validate"
    $.ajax
      url: createPath
      beforeSend: (xhr) ->
        xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr 'content'
      data: postData()
      type: "POST"
      success: (data) ->
        $('#new_product').submit()
      error: (data) ->
        outputErrors(data.responseJSON)


outputErrors = (data) ->
  html_string = "<ol>"
  html_string += "<li>#{item}</li>" for item in data
  html_string += "<li>Please select a product image</li>" if $('#product_image').val() is ""
  html_string += "</ol>"
  toastContent = $(html_string)
  Materialize.toast toastContent


window.confirmDeleteProduct = (productIndex) ->
  document.productIndex = productIndex
  $('#confirm-modal').openModal()

window.deleteProduct = ->
  deletePath = "/shopowners/shop/products/#{document.productIndex}"
  $.ajax
    url: deletePath
    beforeSend: (xhr) ->
      xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr 'content'
    type: 'DELETE'
    success: (data) ->
      productString = $('.strike span').text().substr(0, 1)
      products_count = parseInt(productString) - 1
      window.location.reload(true) if products_count < 1

      pluralized_products = if products_count > 1 then "Products" else "Product"
      $('.strike span').html("#{products_count} #{pluralized_products} available in store")
      
      product_id = "#product#{document.productIndex}"
      $(product_id).remove()
      Materialize.toast "Deleted Succesfully!", 4000
    error: (data) ->
      Materialize.toast "Error deleting product", 4000
=======
>>>>>>> feat(shop dashboard UI): Adds the dashboard UI for new shops that haven't fully setup i.e have not added products. [finishes #126486649]
