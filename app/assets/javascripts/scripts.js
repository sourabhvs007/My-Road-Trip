
/* Portfolio */
$(window).load(function() {
  var $cont = $('.portfolio-group');


  $cont.isotope({
    itemSelector: '.portfolio-group .portfolio-item',
    masonry: {columnWidth: $('.isotope-item:first').width(), gutterWidth: -20, isFitWidth: true},
    filter: '*',
  });

  $('.portfolio-filter-container a').click(function() {
    $cont.isotope({
      filter: this.getAttribute('data-filter')
    });

    return false;
  });

  var lastClickFilter = null;
  $('.portfolio-filter a').click(function() {

        //first clicked we don't know which element is selected last time
        if (lastClickFilter === null) {
          $('.portfolio-filter a').removeClass('portfolio-selected');
        }
        else {
          $(lastClickFilter).removeClass('portfolio-selected');
        }

        lastClickFilter = this;
        $(this).addClass('portfolio-selected');
      });

});

/* Image Hover  - Add hover class on hover */
$(document).ready(function(){
  if (Modernizr.touch) {
        // show the close overlay button
        $(".close-overlay").removeClass("hidden");
        // handle the adding of hover class when clicked
        $(".image-hover figure").click(function(e){
          if (!$(this).hasClass("hover")) {
            $(this).addClass("hover");
          }
        });
        // handle the closing of the overlay
        $(".close-overlay").click(function(e){
          e.preventDefault();
          e.stopPropagation();
          if ($(this).closest(".image-hover figure").hasClass("hover")) {
            $(this).closest(".image-hover figure").removeClass("hover");
          }
        });
      } else {
        // handle the mouseenter functionality
        $(".image-hover figure").mouseenter(function(){
          $(this).addClass("hover");
        })
        // handle the mouseleave functionality
        .mouseleave(function(){
          $(this).removeClass("hover");
        });
      }
    });

// thumbs animations
$(function () {

  $(".thumbs-gallery i").animate({
   opacity: 0

 }, {
   duration: 300,
   queue: false
 });

  $(".thumbs-gallery").parent().hover(
   function () {},
   function () {
    $(".thumbs-gallery i").animate({
     opacity: 0
   }, {
     duration: 300,
     queue: false
   });
  });

  $(".thumbs-gallery i").hover(
    function () {
      $(this).animate({
       opacity: 0

     }, {
       duration: 300,
       queue: false
     });

      $(".thumbs-gallery i").not( $(this) ).animate({
       opacity: 0.4         }, {
         duration: 300,
         queue: false
       });
    }, function () {
    }
    );

});

// Mobile Menu
$(function(){
  $('#hornavmenu').slicknav();
});

$(window).load(function(){
  $("#hornavmain").sticky({ topSpacing: 120 });
});

$(window).load(function(){
  $("#header").sticky({ topSpacing: 0 });
});

// maps and facebook share

window.fbAsyncInit = function() {
  FB.init({
      appId      : '1569067850011644', // App ID
      status     : false, 
      version:  'v2.0',
      cookie     : true, 
      xfbml      : false  // parse XFBML
    });
  $(document).trigger('fbload');
};

function initMap() {
  var directionsService = new google.maps.DirectionsService;
  var directionsDisplay = new google.maps.DirectionsRenderer;
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 7,
    center: {lat: 20.5937, lng: 78.9629}
  });
  directionsDisplay.setMap(map);
  calculateAndDisplayRoute(directionsService, directionsDisplay);
}

function fbShare() {
 console.log('<%=@trip.title.titleize%>');
 console.log('<%=@trip.description%>');
 console.log('<%=@trip.main_image.url%>');
 FB.ui(
 {
  method: 'share',
  href: 'https://www.youtube.com',
  caption: '<%= @trip.title.titleize%>',
  description: '<%= @trip.description%>',
  picture: 'https://www.girlsgonestrong.com/wp-content/uploads/2016/02/NaturalMovement-AbbyClark-1200x630.png',
},
  // callback
  function(response) {
    if (response && !response.error_message) {
      alert('Posting completed.');
    } else {
      alert('Error while posting.');
    }
  }
  );
}

function calculateAndDisplayRoute(directionsService, directionsDisplay) {
  directionsService.route({
    origin: '<%=@trip.from_address%>',
    destination: '  <%=@trip.to_address%>',
    travelMode: google.maps.TravelMode.DRIVING
  }, function(response, status) {
    if (status === google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    } else {
      window.alert('Directions request failed due to ' + status);
    }
  });
  console.log("origin:",origin);
}

function calculateRoute(from, to) {
  debugger;
        // Center initialized to Naples, Italy
        var myOptions = {
          zoom: 10,
          center: new google.maps.LatLng(20.5937, 78.9629),
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        // Draw the map
        var mapObject = new google.maps.Map(document.getElementById("createRoute"), myOptions);

        var directionsService = new google.maps.DirectionsService();
        var directionsRequest = {
          origin: from,
          destination: to,
          waypoints: [{ location: "Coimbatore, Tamil Nadu, India" }],
          travelMode: google.maps.DirectionsTravelMode.DRIVING,
          unitSystem: google.maps.UnitSystem.METRIC
        };
        directionsService.route(
          directionsRequest,
          function(response, status)
          {
            if (status == google.maps.DirectionsStatus.OK)
            {
              new google.maps.DirectionsRenderer({
                map: mapObject,
                directions: response
              });
            }
            else
              $("#error").append("Unable to retrieve your route<br />");
          }
          );
      }

