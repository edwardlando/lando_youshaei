

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

	$(".make_channel").on("click", function(event) {
		var data = {
		"name": $("#channel_name").val(),
		"color": $("#channel_color").val(),
		"style": $("#channel_style").val(),
		"price": $("#channel_price").val(),
		"gender": $("#channel_gender").val(),
		};
		$.ajax({
			type: 'POST',
			url: "/channels.json",
			data: data,
			dataType: "json",
			success: function(data) {
				$(".inner").hide(500);
			}
		});
	})
     
    // Highlighting selected option
	$(".option").on("click", function(event) {
		this.style.border = '1px solid black';
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

	$("#make_item").on("click", function(event) {
		var data = {
		"title": $("#item_title").val(),
		"url": $("#item_url").val(),
		"color": $("#item_color").val(),
		"style": $("#item_style").val(),
		"price": $("#item_price").val(),
		"gender": $("#item_gender").val(),
		};
		console.log("click");
		
		$.ajax({
			type: 'POST',
			url: "/items.json",
			data: data,
			dataType: "json",
			success: function(data) {
				console.log("success");
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


    // CREATING A LINE ITEM

    var wantToAddToCart = false;
	$("#add_to_cart_link").on("click", function(event) {
		wantToAddToCart = !wantToAddToCart ;
		if (wantToAddToCart  == true) {
			$(".inner_add_to_cart").show(500);
		} else {
			$(".inner_add_to_cart").hide(500);
		};
	})

    /*
	$(".make_line_item").on("click", function(event) {
		var data = {
		"name": $("#line_item_name").val(),
		"size": $("#line_item_size").val()
		};
		$.ajax({
			type: 'POST',
			url: "http://localhost:3000/line_items.json",
			data: data,
			dataType: "json",
			success: function(data) {
				$(".inner_add_to_cart").hide(500);
				console.log(data);
			}
		});
	
	})
    */
});
