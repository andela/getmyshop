$(document).on('ready page:load page:change', function() {
  var firstNameState = false,
      lastNameState = false,
      emailState = false,
      passwordState = false;

  function emailChecker() {
    var pattern = /^([a-z\d_\.\-])+\@(([a-z\d\-])+\.)+([a-z]{2,4})+$/i;
    if (!pattern.test($(this).val())) {
      $(this).addClass("invalid");
      $(this).prev(".field-error").text("Email is invalid");
      emailState = false;
    } else {
      $(this).removeClass("invalid");
      $(this).prev(".field-error").text("");
      emailState = true;
    }
    changeButton();
  }

  function passwordChecker() {
    if ($(this).val().length < 7) {
      $(this).addClass("invalid");
      $(this).prev(".field-error").text("Password " +
        "must be more than 6 characters");
      passwordState = false;
    } else {
      $(this).removeClass("invalid");
      $(this).prev(".field-error").text("");
      passwordState = true;
    }
    changeButton();
  }

  function nameChecker() {
    var id = $(this).prop("id");
    if ( $(this).val() === "") {
      $(this).addClass("invalid");
      changeField(id, false);
    } else {
      $(this).removeClass("invalid");
      $(this).prev(".field-error").text("");
      changeField(id, true);
    }
    changeButton();
  }

  function changeField(id, value) {
    switch(id) {
      case "user_first_name":
        if (!value) {
          $("#"+id).prev(".field-error").text("First name required");
        }
        firstNameState = value;
        break;
      case "user_last_name":
        if (!value) {
          $("#"+id).prev(".field-error").text("Last name required");
        }
        lastNameState = value;
        break;
      default:
        break;
    }
  }

  function changeButton() {
    if (passwordState && emailState && firstNameState && lastNameState) {
      $("#submit-signup").prop("disabled", false);
    } else if (passwordState && emailState) {
      $("#submit-signin").prop("disabled", false);
    } else if (passwordState) {
      $("#submit-signup").prop("disabled", false);
      $("#submit_reset").prop("disabled", false);
    } else {
      $("#submit-signin").attr("disabled", "disabled");
      $("#submit-signup").attr("disabled", "disabled");
      $("#submit_reset").prop("disabled", true);
    }
  }




  $("#session_email").on("focusout keyup change", emailChecker);
  $("#session_password").on("focusout keyup change", passwordChecker);
  $("#user_first_name").on("focusout keyup change", nameChecker);
  $("#user_last_name").on("focusout keyup change", nameChecker);
  $("#user_email").on("focusout keyup change", emailChecker);
  $("#user_password").on("focusout keyup change", passwordChecker);

  $("#show-password").change(function() {
    if ($(this).is(":checked")) {
      $(".pword").attr("type","text");
    } else {
      $(".pword").attr("type","password");
    }
  });

  $("#reset_password").on("keyup keydown", passwordChecker);
  $('.modal-trigger').leanModal();
});
