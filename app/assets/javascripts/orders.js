$(document).ready(function(){
    $("ul.tabs").tabs();

    $(".expand-order").click(function(){
        var nextOrder = $(this).parents("div.order-group").
          find("div.order-details");
        if (nextOrder.css("display") == "none") {
            nextOrder.css("display", "block");
        } else if (nextOrder.css("display") == "block") {
            nextOrder.css("display", "none");
        }
    });

    $(".full-profile").hover(
        function(){
            $(".user-profile").css("display", "block");
        },
        function(){
            $(".user-profile").css("display", "none");
        }
    );

    $(".close-review").click(
      function(){
        $(".review").css("display", "none");
        $('#review').closeModal();
      }
    );
});
