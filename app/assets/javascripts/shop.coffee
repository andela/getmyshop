# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  initializeOrderPage()

  $(".side-bar-cont").mouseenter ->
    $(".side-bar-menu a"). animate {
      duration: 600,
      easing: "linear"
    }

    $("#hdline").animate {
      duration: 600,
      easing: "linear"
    }

    $(this).animate {
      width: "150px",
      duration: 600,
      easing: "linear"
    }
  .mouseleave ->
    $(".side-bar-menu a"). animate {
      duration: 600,
      easing: "linear"
    }

    $('#hdline').animate {
      duration: 600,
      easing: "linear"
    }

    $(this).animate {
      width: "64px",
      duration: 600,
      easing: "linear"
    }

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

  $('#session_password').trigger('focus')

outputErrors = (data) ->
  html_string = "<ol>"
  html_string += "<li>#{item}</li>" for item in data
  html_string += "<li>Please select a product image</li>" if $('#product_image').val() is ""
  html_string += "</ol>"
  toastContent = $(html_string)
  Materialize.toast toastContent


@confirmDeleteProduct = (productIndex) ->
  document.productIndex = productIndex
  $('#confirm-modal').openModal()

@deleteProduct = ->
  deletePath = "/shopowners/shop/products/#{document.productIndex}"
  $.ajax
    url: deletePath
    beforeSend: (xhr) ->
      xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr 'content'
    type: 'DELETE'
    success: (data) ->
      products_count = $('.products-card').length
      product_id = "#product#{document.productIndex}"
      $(product_id).remove()
      if (products_count - 1) < 1 then window.location.reload(true)
      $('.edit-form-heading').html("SHOP PRODUCTS(#{products_count - 1})")
      Materialize.toast "Deleted Succesfully!", 4000
    error: (data) ->
      Materialize.toast "Error deleting product", 4000

initializeOrderPage = ->
  $('.pagination-holder ul li a').each ->
      if $(this).attr('href') is window.location.search
        $('.pagination-holder ul li a').removeClass("active")
        $(this).addClass("active")

  $('select.status').each ->
    optionValue = $(this).attr("value")
    $(this).find("option[value='#{optionValue}']").attr("selected", true)
    $(this).material_select()

  $('input[type="checkbox"]').change ->
    if $('input[type="checkbox"]').is(':checked')
      $(".action-container").show("slow")
    else
      $(".action-container").hide("slow")

  $('.pagination-holder ul li').click ->
    window.location = $(this).find('a').attr('href')
    if $(this).find('a').attr('href') is ""
      window.location = "/shopowners/admin/shop/orders"
