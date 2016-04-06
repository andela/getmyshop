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
        $("#review").closeModal();
        $("#new-address").closeModal();
    }
    );

    function setStar(id) {
        var rating = id.slice(-1);
        var classToAdd = getStarSelectors(rating);

        clearStars();
        $(classToAdd).addClass("selected-star");
        $("#my-rating").val(rating);
  }

  function getStarSelectors(rating) {
        var stars = ["#star1","#star2","#star3","#star4","#star5"];
        return stars.slice(0, rating).join(",");
  }

    function clearStars() {
        var starSelectors = "#star1, #star2, #star3, #star4, #star5";
        $(starSelectors).removeClass("selected-star");
    }

    $(".star").click(function(){
        var id = $(this).attr("id");
        setStar(id);
    });

    $("#opener").click(
        function(){
            $("#new-address").openModal();
        }
    );
});
