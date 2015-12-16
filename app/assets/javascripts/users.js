$(document).ready(function() {
	var firstNameState = false;
	if ($("#user_first_name").val() !== "") {
		firstNameState = true;
	}
	
	var lastNameState = false;
	if ($("#user_last_name").val() !== "") {
		lastNameState = true;
	}

	var emailState = false;
	if ($("#user_email").val() !== "") {
		emailState = true;
	}
	var passwordState = false;

	$("#show_password").change(function() {
		if ($(this).is(":checked"))
		{
			$(".pword").attr("type","text");
		}
		else
		{
			$(".pword").attr("type","password");
		}
	});

	$("#user_first_name").on("focusout keyup", function() {
		if ( $(this).val() === "")
		{
			$(this).addClass("invalid");
			$(this).prev(".field-error").text("Field is required");
			firstNameState = false;
		}
		else{
			$(this).removeClass("invalid");
			$(this).prev(".field-error").text("");
			firstNameState = true;
		}
			changeButton();
	});

	$("#user_last_name").on("focusout keyup", function() {
		if ( $(this).val() === "")
		{
			$(this).addClass("invalid");
			$(this).prev(".field-error").text("Field is required");
			lastNameState = false;
		}
		else{
			$(this).removeClass("invalid");
			$(this).prev(".field-error").text("");
			lastNameState = true;
		}
			changeButton();
	});

	$("#user_email").on("focusout keyup", function() {
		var pattern = /^([a-z\d_\.\-])+\@(([a-z\d\-])+\.)+([a-z]{2,4})+$/i;
		var email = $(this).val();
		if (!pattern.test(email)) {
			$(this).addClass("invalid");
			$(this).prev(".field-error").text("Email is invalid");
			emailState = false;
		}
		else{
			$(this).removeClass("invalid");
			$(this).prev(".field-error").text("");
			emailState = true;
		}
		changeButton();
	});

	$("#user_password").on("focusout keyup", function() {
		var password = $(this).val();
		if (password.length < 7){
			$(this).addClass("invalid");
			$(this).prev(".field-error").text("Password " +
				"must be more than 6 characters");
			passwordState = false;
		}

		else{
			$(this).removeClass("invalid");
			$(this).prev(".field-error").text("");
			passwordState = true;
		}
		changeButton();
	});

	function changeButton () {
		if (passwordState && emailState && firstNameState && lastNameState)
		{
			$("#submit-signup").prop("disabled", false);
		}
		else
		{
			$("#submit-signup").prop("disabled", true);
		}
	}
});
