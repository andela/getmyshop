$ ->
  $('a.update-btn').click ->
    json_array = []
    $('tr').each ->
      id = $(this).attr('id')
      json_object = {}
      json_object["id"] = id
      json_object["status"] = $(this).find('select').val()
      if id? then json_array.push(json_object) 

    orders_status = { orders_attributes: json_array }
    updateOrderStatus({ shop: orders_status })
    
@setOrderStatus = (status, element) ->
  json_array = []
  $('tr').each ->
    id = $(this).attr('id')
    json_object = {}
    json_object["id"] = id
    json_object["status"] = status
    if $(this).find("input[type='checkbox']").is(':checked')
      json_array.push(json_object) 

  orders_status = { orders_attributes: json_array }
  updateOrderStatus({ shop: orders_status })

updateOrderStatus = (status) ->
  $.ajax
    type: "PUT"
    url: "/shopowners/shop/orders"
    beforeSend: (xhr) ->
      xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr 'content'
    contentType: "application/json"
    data: JSON.stringify(status)
    success: (data) ->
      window.location.reload(true)
    error: (data) ->
      Materialize.toast "Update Failed, Please Try again later", 4000
