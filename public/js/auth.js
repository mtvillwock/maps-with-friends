$(document).ready(function() {
  addFacebookLoginListener();
});

function addFacebookLoginListener() {
  $('.container').on('click', '#facebook_button', loginWithFacebook)
  console.log("listener attached")
}

function loginWithFacebook() {
  console.log("click listener works")
  event.preventDefault();

  var request = $.ajax({
    url: '/auth/facebook/'
  })

  request.done(function() {
    console.log("login done function")
  })

  request.fail(function() {
    console.log("login fail function")
  })

  request.always(function() {
    console.log("login always function");
  });

}