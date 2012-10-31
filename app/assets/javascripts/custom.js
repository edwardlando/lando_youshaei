

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
			$(".inner").slideDown(500);
		} else {
			$(".inner").slideUp(500);
		};
	})

 
    // Highlighting selected option

    var colorOptions = ["ColorWhite", "ColorGrey", "ColorBlack", "ColorRed", "ColorGreen", "ColorBlue",
    "ColorPink", "ColorBrown", "ColorYellow", "ColorOrange", "ColorPurple", "ColorAll"]

    var styleOptions = ["StyleElegant", "StyleCasual", "StylePreppy", "StyleHipster", "StyleAll"]

    var priceOptions = ["Under50", "Under100", "Under200", "UnderAll"]

    var genderOptions = ["Female", "Male", "Unisex"]


    // Highlight options in the selected element
    var lightSwitch = function(element_name, border) {
    	border = typeof border !== undefined ? border : false;
    	var selected = null;
	    options = $(element_name + " + .picker > .option");
		options.on("click", function(event) {
			if (selected !== null) {
				if (border) {
					selected.style.border = "";
				}
				selected.style.color = '#FFFFFF';
			}
			selected = this;
			if (border) {
				this.style.border = "1px solid #59B4AE";
			}
			this.style.color = '#59B4AE';
		});
    }

    // TODO: Fix blocking div
    lightSwitch("#channel_color", true);
    lightSwitch("#channel_style");
    lightSwitch("#channel_price");
    lightSwitch("#channel_gender");
   

	// USER PROFILE

    var wantToSeeProfile = false;
	$("#my_profile").on("click", function(event) {
		wantToSeeProfile = !wantToSeeProfile;
		if (wantToSeeProfile == true) {
			$(".inner_user").slideDown(500);
		} else {
			$(".inner_user").slideUp(500);
		};
	})

	// ITEMS

	var wantToCreateItem = false;
	$("#new_item_button").on("click", function(event) {
		wantToCreateItem = !wantToCreateItem;
		if (wantToCreateItem == true) {
			$(".inner_item").slideDown(500);
		} else {
			$(".inner_item").slideUp(500);
		};
	})

	
	// CART

	var wantToSeeCart = false;
	$("#my_cart").on("click", function(event) {
		wantToSeeCart = !wantToSeeCart;
		if (wantToSeeCart == true) {
			$(".inner_cart").slideDown(500);
		} else {
			$(".inner_cart").slideUp(500);
		};
	})


    // CREATING A LINE ITEM

    var wantToAddToCart = false;
	$("#add_to_cart_link").on("click", function(event) {
		wantToAddToCart = !wantToAddToCart ;
		if (wantToAddToCart  == true) {
			$(".inner_add_to_cart").slideDown(500);
		} else {
			$(".inner_add_to_cart").slideUp(500);
		};
	})

   
});
