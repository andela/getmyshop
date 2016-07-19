$(document).ready(function(){
  $('.modal-trigger').leanModal();

  $('#new_product').fileupload({
    dataType: "script",
    add: function(e, data){
      console.log("Error: "+e);
      console.log(data);
    },
    progress: function(e, data){
      console.log(data)
    }
  })
});