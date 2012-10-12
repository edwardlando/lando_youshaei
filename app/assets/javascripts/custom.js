

$(document).ready(function() {
	// The actual form
	$(".picker .option").on("click", function(event){
		// this = option clicked
		// index of item relative to other children
		
		var $input = $(this).parent().parent().children("select");
		var i = $(this).index();
		// sets the actual form value
		// $input[0] -- we need the [0] to actual the element (not the jQuery) (there should only be one)
		$input[0].options[i].selected = true;
		// set id of selected element to match option (to be same color)
		//var selected = $(this).parent().parent(); // visible selected elemented
		//selected.attr("id", $(this).attr("id")); // here we set the id of the selected element to the id of the clicked element
	});


    // Stops Devise from signing out user when Ajax POST request is made
    $.ajaxSetup({
	    beforeSend: function(xhr) {
	        xhr.setRequestHeader('X-CSRF-Token',
	        $('meta[name="csrf-token"]').attr('content'));
	    }
    });

    // CHANNELS

    // Allows us to make top disappear
	var wantToCreate = false;
	$("#new_channel_button").on("click", function(event) {
		wantToCreate = !wantToCreate;
		if (wantToCreate == true) {
			$(".inner").show(500);
		} else {
			$(".inner").hide(500);
		};
	})

	$("#create_channel").on("click", function(event) {
		var data = {
		"name": $("#channel_name").val(),
		"color": $("#channel_color").val(),
		"style": $("#channel_style").val(),
		"price": $("#channel_price").val(),
		"gender": $("#channel_gender").val(),
		};
		console.log(data);
		$.ajax({
			type: 'POST',
			url: "http://localhost:3000/channels.json",
			data: data,
			dataType: "json",
			success: function(data) {
				console.log(data);
				$(".inner").hide(500);
			}
		});
	})
     
    // Highlighting selected option
	$(".option").on("click", function(event) {
		this.style.border = '1px solid lightblue';
	});

	// USER PROFILE

    var wantToSeeProfile = false;
	$("#my_profile").on("click", function(event) {
		wantToSeeProfile = !wantToSeeProfile;
		if (wantToSeeProfile == true) {
			$(".inner_user").show(500);
		} else {
			$(".inner_user").hide(500);
		};
	})

	// ITEMS

	var wantToCreateItem = false;
	$("#new_item_button").on("click", function(event) {
		wantToCreateItem = !wantToCreateItem;
		if (wantToCreateItem == true) {
			$(".inner_item").show(500);
		} else {
			$(".inner_item").hide(500);
		};
	})

	$("#create_item").on("click", function(event) {
		var data = {
		"title": $("#item_title").val(),
		"url": $("#item_url").val(),
		"color": $("#item_color").val(),
		"style": $("#item_style").val(),
		"price": $("#item_price").val(),
		"gender": $("#item_gender").val(),
		};
		$.ajax({
			type: 'POST',
			url: "http://localhost:3000/items.json",
			data: data,
			dataType: "json",
			success: function(data) {
				$(".inner_item").hide(500);
			}
		});
	})

	// CART

	var wantToSeeCart = false;
	$("#my_cart").on("click", function(event) {
		wantToSeeCart = !wantToSeeCart;
		if (wantToSeeCart == true) {
			$(".inner_cart").show(500);
		} else {
			$(".inner_cart").hide(500);
		};
	})


	// LANDING PAGE 

    $("#want_to_join").on("click", function(event) {
    	$(".sign_in_partial").hide(200);
    	$("#want_to_join").hide();
    	$(".sign_up_partial").show(200);
    });

    // GET CURRENT URL

    function getCurrentUrl() {
    	var current_url = document.getElementById("main_iframe").src;
    	return current_url;
    };

    $("#add_to_cart_link").on("click", function(event) {
    	var data = {
		"current_url": getCurrentUrl(),
		};
		$.ajax({
			type: 'POST',
			url: "http://localhost:3000/users/add_to_cart.json",
			data: data,
			dataType: "json",
			success: function(data) {
				$(".inner_item").show(500);
			}
		});
    });

  

});
