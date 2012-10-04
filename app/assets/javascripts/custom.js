

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
		"channel_name": $("#channel_name").val(),
		"channel_color": $("#channel_color").val(),
		"channel_style": $("#channel_style").val(),
		"channel_price": $("#channel_price").val(),
		"channel_gender": $("#channel_gender").val(),
		};
		console.log(data);
		$.ajax({
			type: 'POST',
			url: "http://localhost:3000/channels.json",
			data: data,
			dataType: "json",
			success: function(data) {
				onsole.log(data);
				$(".inner").hide(500);
			}
		});
	})

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
	






});
