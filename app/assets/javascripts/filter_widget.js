$(document).ready(function(){
  function setMinimum() {
    var minVal = Number($("#lower-value").val()) + 1;
    $("#upper-value").attr("min", minVal);
    $("#upper-value").attr("value", minVal);
  }
    $("#lower-value").on("focusout keyup change", setMinimum);
    $("#upper-value").on("focusout keyup change", setMinimum);

});
