

$(document).ready(function() {
	// The actual form
	// The [0] is only needed because a bunch of elements match
	var colorInput = $(".field select")[0];

	$(".picker .option").on("click", function(event){
		// this = option clicked
		// index of item relative to other children
		var i = $(this).index();
		// sets the actual form value
		colorInput.options[i].selected = true;
		// set id of selected element to match option (to be same color)
		//var selected = $(this).parent().parent(); // visible selected elemented
		//selected.attr("id", $(this).attr("id")); // here we set the id of the selected element to the id of the clicked element
	});

    // Allows us to make top disappeat
	var wantToCreate = false;

	$("#new_channel").on("click", function(event) {
		wantToCreate = !wantToCreate;
		if (wantToCreate == true) {
			$(".inner").show(500);
		} else {
			$(".inner").hide(500);
		};
	})

	$("#create_channel").on("click", function(event) {
		data = {
		"channel_name": $("#channel_name").val(),
		"channel_color": $("#channel_color").val(),
		"channel_style": $("#channel_style").val(),
		"channel_price": $("#channel_price").val(),
		"channel_gender": $("#channel_gender").val(),
		};
		$.ajax({
			type: 'POST',
			url: "http://localhost:3000/channels",
			data: data,
			success: function(data) {
				$(".inner").hide(500);
			},
			dataType: "html"
		});
	})


});