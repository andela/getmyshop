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

    function setOneStar() {
      $("#star1").addClass("selected-star");
      $("#star2").removeClass("selected-star");
      $("#star3").removeClass("selected-star");
      $("#star4").removeClass("selected-star");
      $("#star5").removeClass("selected-star");
      $("#my-rating").val(1);
    };

    function setTwoStar() {
      $("#star1").addClass("selected-star");
      $("#star2").addClass("selected-star");
      $("#star3").removeClass("selected-star");
      $("#star4").removeClass("selected-star");
      $("#star5").removeClass("selected-star");
      $("#my-rating").val(2);
    };

    function setThreeStar() {
      $("#star1").addClass("selected-star");
      $("#star2").addClass("selected-star");
      $("#star3").addClass("selected-star");
      $("#star4").removeClass("selected-star");
      $("#star5").removeClass("selected-star");
      $("#my-rating").val(3);
    };

    function setFourStar() {
      $("#star1").addClass("selected-star");
      $("#star2").addClass("selected-star");
      $("#star3").addClass("selected-star");
      $("#star4").addClass("selected-star");
      $("#star5").removeClass("selected-star");
      $("#my-rating").val(4);
    };

    function setFiveStar() {
      $("#star1").addClass("selected-star");
      $("#star2").addClass("selected-star");
      $("#star3").addClass("selected-star");
      $("#star4").addClass("selected-star");
      $("#star5").addClass("selected-star");
      $("#my-rating").val(5);
    };



    $("#star1").click(function(){
         setOneStar();
      }
    );

    $("#star2").click(function(){
         setTwoStar();
      }
    );

    $("#star3").click(function(){
         setThreeStar();
      }
    );

    $("#star4").click(function(){
         setFourStar();
      }
    );

    $("#star5").click(function(){
         setFiveStar();
      }
    );
});
