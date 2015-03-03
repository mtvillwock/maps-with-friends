$(document).ready(function() {

  navigator.geolocation.getCurrentPosition(initialize);

  $('.search-form').on('submit', function(e){
    e.preventDefault();

    var data = $(e.target).serialize();

    var request = $.ajax({
      type: 'POST',
      url: '/',
      data: data,
      dataType: 'json'
    });

    request.done(function(data){
        console.log("in ajax success. data = " + data);
        navigator.geolocation.getCurrentPosition(codeAddress);
    });

  })

});

function initialize(location) {

  var currentLocation = new google.maps.LatLng(location.coords.latitude, location.coords.longitude)

  var mapCanvas = document.getElementById('map-canvas');

  var mapOptions = {
    center: currentLocation,
    zoom: 5,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }

  var map = new google.maps.Map(mapCanvas, mapOptions);

  var marker = new google.maps.Marker({
    position: currentLocation,
    map: map
  });

  var defaultBounds = new google.maps.LatLngBounds(
    new google.maps.LatLng(33.695441, -117.805632),
    new google.maps.LatLng(45.250434, -69.377900));

  var options = {
    bounds: defaultBounds,
    types: ['(cities)']
  };


// Search Form
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

};


// Converts human-readable address into Geolocation ?? and makes marker??
var codeAddress = function(location) {
    var address = document.getElementById("address").value;
    console.log("in codeAddress, address = " + address, " and location is: " + location);
    var geocoder = new google.maps.Geocoder();

    var currentLocation = new google.maps.LatLng(location.coords.latitude, location.coords.longitude)

    var mapCanvas = document.getElementById('map-canvas');

    var mapOptions = {
      center: currentLocation,
      zoom: 5,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    var map = new google.maps.Map(mapCanvas, mapOptions);

    geocoder.geocode( { 'address': address}, function(results, status) {
      debugger;
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
        var marker = new google.maps.Marker({
            map: map,
            position: results[0].geometry.location
            // I think I need to reference location.D and location.k for Lat/Long respectively
        });
        marker.setMap(map);
      } else {
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
  }