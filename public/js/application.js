$(document).ready(function() {
  navigator.geolocation.getCurrentPosition(initialize);


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
    bounds: defaultBounds
  };

  var input = document.getElementById('search');
  // map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

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

// google.maps.event.addDomListener(window, 'load', initialize);

