$(document).ready(function() {
  var map; // declaring map globally for later
  var infowindow; // declaring globally for later
  var marker; // declaring globally for later
  navigator.geolocation.getCurrentPosition(initialize);
  // finds user's current position and creates map and marker showing them
  $('.search-form').on('submit', function(e){
    addNewMarker(e);
  })

  // click listener for info window
});

function initialize(location) {
  // Create the map
  createMapWithUserMarker(location);
  // Initialize autocomplete form
  setUpAutocompleteForm();
  // Add database locations to map
  populateLocations();
};

// Adds marker to map
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
    navigator.geolocation.getCurrentPosition(codeAddress);
    // Makes the new marker based on address in form submission
    $("#friend-list").append("<p>" + "<span class='friend-name'>" + data.name + "</span>" + " in " + "<span class='friend-location'>" + data.location + "</span>" + "</p>");
  });
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
    map: map
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

var codeAddress = function(location) {
  var address = document.getElementById("address").value;
  geoCode(address);
}

var addMarkerFromDatabase = function(location) {
  return geoCode(location);
}

// Finds LatLong of provided address and makes a marker at that location
var geoCode = function(location, infowindow) {
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode( { 'address': location}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
        map: map,
        position: results[0].geometry.location,
        title: "This is where you are"
      });
    } else {
      alert("Geocode was not successful for the following reason: " + status);
    }
  return marker
  });
  clearFriendForm();
}

// gets all locations from server
function populateLocations() {
  var request = $.ajax({
    type: 'GET',
    url: '/locations'
  });

  request.done(function(data){
      console.log("we in the for loop populateLocations")
      console.log(data)
    for (var i = 0; i < data.length; i++) {
      console.log("in da for loop")
      var marker = addMarkerFromDatabase(data[i].location);
      console.log(marker); //
      $("#friend-list").append("<p>" + "<span class='friend-name'>" + data[i].name + "</span>" + " in " + "<span class='friend-location'>" + data[i].location + "</span>" + "</p>");

      addInfoWindowListener(marker, createInfoWindow(data));

    };
  });

  request.error(function(){
    console.log("errors retrieving or processing data from server");
  });
}

function createInfoWindow(data) {
  var infoToDisplay = data.name + " in " + data.location
  infoWindowOptions = {
    content: infoToDisplay
  }
  var infowindow = new google.maps.InfoWindow(infoWindowOptions)
  console.log("in createInfoWindow, infowindow = " + infowindow)
  console.log(infowindow); //
  return infowindow
}

function addInfoWindowListener(marker, infowindow) {
  console.log("in addInfoWindowListener, infowindow = " + infowindow)
  var marker = marker
  console.log(marker); // undefined
  google.maps.event.addListener(marker, 'click', showInfoWindow(infowindow, marker));
}

function showInfoWindow(infowindow, marker) {
  console.log("in showInfoWindow, infowindow = " + infowindow)
  infowindow.open(map,marker);
}