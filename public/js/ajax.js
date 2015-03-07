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
    url: '/register',
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
  // need a way to render partials dynamically
  console.log("hid registration");
}

function showLoginForm() {
  $('.login').css('display', "inline");
  console.log("show login");
}

function loginSession(event) {
  event.preventDefault();
  console.log("prevented default, attempting login")

  var request = $.ajax({
    url: '/login',
    type: "POST"
  })

  request.done(function() {
    hideLoginForm();
    console.log("in loginSession callback");
    renderForm();
  });
  console.log("logged in");
}

function hideLoginForm() {
  $('.login').css('display', "none");
}

function renderForm() {
  $('.search-form').css('display', "inline");
}

function logoutSession(event) {
  event.preventDefault();

  var request = $.ajax({
    url: '/logout',
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