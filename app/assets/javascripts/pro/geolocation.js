$(function(){
  if(window.geolocation_url != undefined) {

    function geo_success(position) {
      var valuesToSubmit = {
        'user': {
          'address_attributes': {
            'latitude': position.coords.latitude,
            'longitude': position.coords.longitude
          }
        }
      }
      $.ajax({
        type: "PUT",
        url: window.geolocation_url, //sumbits it to the given url of the form
        data: valuesToSubmit,
        dataType: "JSON", // you want a difference between normal and ajax-calls, and json is standard
        success: function(data, textStatus, jqXHR ) {
          var a = data.address.address1 + ', ' + data.address.zipcode + ' ' + data.address.city
          $('.js-pro-town').html('<b>Vous êtes à proximité de:</b><br>' + a)
        }
      });
    }

    function geo_error() {
      alert("Désolé, le service de géolocalisation est indisponible.");
    }

    var geo_options = {
      enableHighAccuracy: true,
      maximumAge        : 30000,
      timeout           : 27000
    };

    var wpid = navigator.geolocation.watchPosition(geo_success, geo_error, geo_options);

    $('.js-geolocate-me').on('click', function(e) {
      e.preventDefault();
      navigator.geolocation.getCurrentPosition(geo_success, geo_error, geo_options);
    });
  }
});
