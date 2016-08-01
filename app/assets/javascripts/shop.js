$(document).ready(function(){
  $('.modal-trigger').leanModal();
  $('#add-product-btn').leanModal();
  $('input#product_description').characterCounter();

  $('#create_product').click(function(){
    event.preventDefault();
    var createPath = "/shopowners/shop/product/validate"
    $.ajax({
      url: createPath,
      beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      },
      data: postData(),
      type: "POST",
      success: function(data){
        $('#new_product').submit();
      },
      error: function(data){
        outputErrors(data.responseJSON);
      }
    })
  })

});

function outputErrors(data){
  html_string = "<ol>";
  data.forEach(function(item){
    html_string += "<li>"+item+"</li>";
  })
  if ($('#product_image').val()===""){
    html_string += "<li>Please select a product image</li>";
  }
  html_string += "</ol>";
  var $toastContent = $(html_string);
  Materialize.toast($toastContent);
}

function postData(){
  data = {};
  data['name'] = $('#product_name').val();
  data['description'] = $('#product_description').val();
  data['quantity'] = $('#product_quantity').val();
  data['brand'] = $('#product_brand').val();
  data['size'] = $('#product_size').val();
  data['price'] = $('#product_price').val();
  return data;
}

