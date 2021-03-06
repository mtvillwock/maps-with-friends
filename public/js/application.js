$(document).ready(function() {
  var map; // declaring map globally for later
  var infowindow; // declaring globally for later
  var marker; // declaring globally for later
  // JS object to hold references to future markers that are generated
  var markers;
  navigator.geolocation.getCurrentPosition(initialize);
  // finds user's current position and creates map and marker showing them
  $('.search-form').on('submit', function(e){
    addNewMarker(e);
  });

  $('#friend-list').on('click', ".delete", function(e) {
    deleteFriend(e);
  });
});

function initialize(location) {
  markers = {};
  // Create the map
  createMapWithUserMarker(location);
  // Initialize autocomplete form
  setUpAutocompleteForm();
  // Add database locations to map
  populateLocations();
};

// Adds marker to map (and saves friend to database) via AJAX form
function addNewMarker(e){
  e.preventDefault();

  var data = $(e.target).serialize();

  var request = $.ajax({
    type: 'POST',
    url: '/',
    data: data,
    dataType: 'json'
  });

  request.done(function(data){
    // Makes the new marker based on address in form submission
    codeAddress(data);
    $("#friend-list").append("<li id=" + data.id +"><p>" + "<span class='friend-name'>" + data.name + "</span>" + " in " + "<span class='friend-location'>" + data.location + "</span>" + "</p>"
      + "<button><a class='delete' href=" + "/friend/" + data.id + " /delete>Delete</a></button></li>");
    console.log("form should clear");
    clearFriendForm();
  });
}

function deleteFriend(e) {
  e.preventDefault();

  var id = e.target.closest('li').id;
  var friend = e.target.closest('li');

  var request = $.ajax({
    type: 'delete',
    url: '/friends/' + id + "/delete"
  });

  request.done(function(data) {
    // find marker in dictionary of markers and object data
    marker = markers[Number(data.id)]["marker"];
    // remove the marker from the map
    marker.setMap(null);
    // delete the marker from the dictionary
    delete markers[data.id];
    // remove the friend from the DOM
    friend.remove();
  })
}



function clearFriendForm() {
  $('.search-form .friend').val("");
  $('.search-form #address').val("");
}

// Creates a initial map with marker location of current user
function createMapWithUserMarker(location){
  var currentLocation = new google.maps.LatLng(location.coords.latitude, location.coords.longitude)

  var mapCanvas = document.getElementById('map-canvas');

  var mapOptions = {
    center: currentLocation,
    zoom: 3,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }

  map = new google.maps.Map(mapCanvas, mapOptions);

  var marker = new google.maps.Marker({
    position: currentLocation,
    map: map,
    title: "You are here"
  });

  var infowindow = new google.maps.InfoWindow({
    content: "You are here!"
  });

  google.maps.event.addListener(marker, 'click', function() {
    infowindow.open(map, marker);
    setTimeout(function() {
        infowindow.close();
      }, 3000)
  });
}

// Defines search form based on Places library, biases LatLong bounds
function setUpAutocompleteForm(){
  var defaultBounds = new google.maps.LatLngBounds(
    new google.maps.LatLng(33.695441, -117.805632),
    new google.maps.LatLng(45.250434, -69.377900));

  var options = {
    bounds: defaultBounds,
    types: ['(cities)']
  };

  var input = document.getElementById('address');

  var autocomplete = new google.maps.places.Autocomplete(input, options);

  function fillInAddress() {
  // Get the place details from the autocomplete object.
  var place = autocomplete.getPlace();

  for (var component in componentForm) {
    document.getElementById(component).value = '';
    document.getElementById(component).disabled = false;
  }

    // Get each component of the address from the place details
    // and fill the corresponding field on the form.
    for (var i = 0; i < place.address_components.length; i++) {
      var addressType = place.address_components[i].types[0];
      if (componentForm[addressType]) {
        var val = place.address_components[i][componentForm[addressType]];
        document.getElementById(addressType).value = val;
      }
    }
  }
}

// Used in addNewMarker AJAX call
var codeAddress = function(data) {
  geoCode(data);
}

// Used in populateLocations AJAX call
var addMarkerFromDatabase = function(data) {
  geoCode(data);
}

// Finds LatLong of provided address and makes a marker at that location
var geoCode = function(data) {
  console.log("in geocode, data is:");
  console.log(data);
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode( { 'address': data.location }, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
        map: map,
        position: results[0].geometry.location,
        title: data.name
      });
    } else {
      console.log("Geocode was not successful for the following reason: " + status);
    }

    markers[data.id] = { "marker": marker, "data": data };
    console.log(markers);

// future iterations plan to include more user info from user profile page
    var content = "<div class='infowindow'><img src='../placeholder.png'><p>" + data.name +"</p></div>"
    var infowindow = new google.maps.InfoWindow({
      content: content
    });
// Adds listener to open the marker's info window
    google.maps.event.addListener(marker, 'click', function() {
      infowindow.open(map,marker);
      setTimeout(function() {
        infowindow.close();
      }, 3000)
    });
  });
}

// gets all locations from server
function populateLocations() {
  var request = $.ajax({
    type: 'GET',
    url: '/locations'
  });

  request.done(function(data){
    for (var i = 0; i < data.length; i++) {
      console.log(data);
      addMarkerFromDatabase(data[i]);
    };
  });

  request.error(function(response){
    console.log("errors retrieving or processing data from server", response);
  });
}