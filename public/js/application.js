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
      };

// google.maps.event.addDomListener(window, 'load', initialize);