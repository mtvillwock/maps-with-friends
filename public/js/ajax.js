$(document).ready(function() {

  // register listener
  $('.container').on("submit", '.register', registerUser);
  // login listener
  $('.container').on("submit", '.login', loginSession);
  // logout listener
  $('.container').on("submit", '.logout', logoutSession);


});

function registerUser(event) {
  event.preventDefault();

  var request = $.ajax({
    url: '/login',
    type: "POST"
  })

  request.done(function(){
    hideRegisterForm();
    showLoginForm();
  });
  console.log("registered");
}

function hideRegisterForm() {
  $('.register').css('display', "none");
  // Display none is no good
  // need a way to render partials dynamically
  console.log("hid registration");
}

function showLoginForm() {
  $('.login').css('display', "inline");
  debugger
  console.log("show login");
}

function loginSession(event) {
  event.preventDefault();

  var request = $.ajax({
    url: url,
    type: "POST"
  })

  request.done(function() {
    hideLoginForm();
  })
  console.log("logged in");
}

function hideLoginForm() {
  $('.login').css('display', "none");
}

function renderMapAndForm() {
  // render map and form partial
}

function logoutSession(event) {
  event.preventDefault();

  var request = $.ajax({
    url: url,
    type: "DELETE"
  })

  request.done(function() {
    hideLogoutLink();
    showRegisterForm();
  })
  console.log("logged out");
}

function hideLogoutLink() {
  $('.logout').css('display', "none");
}

function showRegisterForm() {
  $('.register').css('display', "inline");
}