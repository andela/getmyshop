$(window).scroll(function(){
	var scroll = $(window).scrollTop();
    if (scroll > 0) {
        $("#top-fixed").addClass("shadow-active");
    }
    else {
        $("#top-fixed").removeClass("shadow-active");
    }
});
