$(document).ready(function() {
  addFacebookLoginListener();
});

function addFacebookLoginListener() {
  $('.container').on('click', '#facebook_button', loginWithFacebook())
}

function loginWithFacebook() {

}