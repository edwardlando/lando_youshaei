

$(document).ready(function() {
	// The actual form
	// The [0] is only needed because a bunch of elements match
	var colorInput = $(".field select")[0];

	$("#picker .option").on("click", function(event){
		// this = option clicked
		// index of item relative to other children
		var i = $(this).index();
		// sets the actual form value
		colorInput.options[i].selected = true;
		// set id of selected element to match option (to be same color)
		var selected = $(this).parent().parent(); // visible selected elemented
		selected.attr("id", $(this).attr("id")); // here we set the id of the selected element to the id of the clicked element
	});

	$("#new_channel").on("click", function(event) {
		$(".inner").show(500);
	})
});