$(document).ready(function(){
   // Activate the side menu 
   $(".button-collapse").sideNav();
   
   $('.dropdown-button').dropdown({
      inDuration: 300,
      outDuration: 225,
      constrain_width: false, // Does not change width of dropdown to that of the activator
      hover: true, // Activate on hover
       // Spacing from edge
      belowOrigin: true, // Displays dropdown below the button
      alignment: "left" // Displays dropdown with edge aligned to the left of button
    });
});

$(window).scroll(function(){
	var scroll = $(window).scrollTop();
    if (scroll > 0) {
        $("#top-fixed").addClass("shadow-active");
    }
    else {
        $("#top-fixed").removeClass("shadow-active");
    }
});
