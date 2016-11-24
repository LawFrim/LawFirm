$(function() {

    "use strict";

	// Clients Carousel
	$("#clients-carousel").owlCarousel({
		autoPlay: true, //Set AutoPlay to 3 seconds
		items : 6,
		stopOnHover : true,
		navigation : false, // Show next and prev buttons
		pagination : false,
		navigationText : ["<span class='fa fa-angle-left'></span>","<span class='fa fa-angle-right'></span>"]
	});

	// Team  Carousel
	$("#team-carousel").owlCarousel({
		autoPlay: true, //Set AutoPlay to 3 seconds
		items : 4,
		stopOnHover : true,
		navigation : true, // Show next and prev buttons
		pagination : false,
		navigationText : ["<span class='fa fa-angle-left'></span>","<span class='fa fa-angle-right'></span>"]
	});

	// COUNTER
	function count($this){
		var current = parseInt($this.html(), 10);
		$this.html(++current);
		if(current !== $this.data('count')){
			setTimeout(function(){count($this)}, 50);
		}
	}
	$(".badges-counter").each(function() {
	  $(this).data('count', parseInt($(this).html(), 1000));
	  $(this).html('0');
	  count($(this));
	});

	//AJAX CONTACT FORM
	$(".contact-form").submit(function() {
		var rd = this;
		var url = "sendemail.php"; // the script where you handle the form input.
		$.ajax({
			type: "POST",
			url: url,
			data: $(".contact-form").serialize(), // serializes the form's elements.
			success: function(data) {
				$(rd).prev().text(data.message).fadeIn().delay(3000).fadeOut();
			}
		});
		return false; // avoid to execute the actual submit of the form.
	});

	// GOOGLE MAP
	function initialize($) {
		var mapOptions = {
			zoom: 8,
			center: new google.maps.LatLng(17.421306, 78.457553),
			disableDefaultUI: true
		};
		var map = new google.maps.Map(document.querySelector('.map'), mapOptions);
	}
	// google.maps.event.addDomListener(window, 'load', initialize);

});
