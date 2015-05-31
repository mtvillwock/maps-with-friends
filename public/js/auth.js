// $(document).ready(function() {
//   addFacebookLoginListener();
// });

// function addFacebookLoginListener() {
//   $('.container').on('click', '#facebook_button', loginWithFacebook)
//   console.log("listener attached")
// }

// function loginWithFacebook() {
//   console.log("click listener works")
//   // event.preventDefault();

//   var request = $.ajax({
//     url: '/login-via-facebook',
//     type: 'get'
//   })

//   request.done(function(response) {
//     console.log("login done function, response is: ", response);
//   })

//   request.fail(function(response) {
//     console.log("login fail function: ", response);
//   })

//   request.always(function() {
//     console.log("login always function");
//   });

// }