

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

    jQuery.ajaxSetup({ 
		'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")} 
	})

    // CHANNELS

    // Allows us to make top disappear
	var wantToCreate = false;
	$("#path").on("click", function(event) {
		wantToCreate = !wantToCreate;
		if (wantToCreate == true) {
			$(".inner").slideDown(200);
		} else {
			$(".inner").slideUp(200);
		};
	})

 
    // Highlighting selected option

    var apparelOptions = ["ApparelTops", "ApparelBottoms", "ApparelAll"]

    var vibeOptions = ["VibeElegant", "VibeCasual", "VibePreppy", "VibeFlashy", "VibeAll"]

    var priceOptions = ["$", "$$", "$$$", "All"]

    var genderOptions = ["Female", "Male", "All"]


    // Highlight options in the selected element
    var lightSwitch = function(element_name, border) {
    	border = typeof border !== undefined ? border : false;
    	var selected = null;
	    options = $(element_name + " + .picker > .option");
		options.on("click", function(event) {
			if (selected !== null) {
				if (border) {
					selected.style.border = "";
				} else {
					selected.style.color = '#FFFFFF';
				}
			}
			selected = this;
			if (border) {
				this.style.border = "2px solid #11A1F4";
			} else {
				this.style.color = '#11A1F4';
			}
		});
    }

    lightSwitch("#channel_apparel"); // used to be true
    lightSwitch("#channel_vibe");
    lightSwitch("#channel_price");
    lightSwitch("#channel_gender");

    lightSwitch("#item_apparel");
    lightSwitch("#item_vibe");
    lightSwitch("#item_gender");
   

	// USER PROFILE

    var wantToSeeProfile = false;
	$("#profile").on("click", function(event) {
		wantToSeeProfile = !wantToSeeProfile;
		if (wantToSeeProfile == true) {
			$(".inner_user").slideDown(200);
		} else {
			$(".inner_user").slideUp(200);
		};
	})

	var more = false;
	$("#more").on("click", function(event) {
		more = !more;
		if (more == true) {
			$(".more").slideDown(200);
		} else {
			$(".more").slideUp(200);
		};
	})

	// ITEMS


    var makeItem = false;
    $("#item").on("click", function(event) {
    	if (AVDATA.user.role === "standard") {
    		humane.log("Email hello@aveece.com to become an official tastemaker");
    	} else {
    		makeItem = !makeItem;
    		if (makeItem == true) {
				$(".inner_item").slideDown(200);
			} else {
				$(".inner_item").slideUp(200);
			};
    	}
    });

	
	// CART

	/*
	var wantToSeeCart = false;
	$("#my_cart").on("click", function(event) {
		wantToSeeCart = !wantToSeeCart;
		if (wantToSeeCart == true) {
			$(".inner_cart").slideDown(500);
		} else {
			$(".inner_cart").slideUp(500);
		};
	})
    */


    $("#my_cart").on("click", function(event) {
		$("#coming_soon").show(400);
    	$("#coming_soon").delay(1200).hide(400);
    })


    // CREATING A LINE ITEM
    /*
    var wantToAddToCart = false;
	$("#add_to_cart_link").on("click", function(event) {
		wantToAddToCart = !wantToAddToCart;
		if (wantToAddToCart  == true) {
			$(".inner_add_to_cart").slideDown(500);
		} else {
			$(".inner_add_to_cart").slideUp(500);
		};
    */



  
    function closeComingSoonDiv(){
		document.getElementById("coming_soon").style.visibility="hidden";
    }

    $("#add_to_cart_link").on("click", function(event) {
    	$("#coming_soon").show(400);
    	$("#coming_soon").delay(1200).hide(400);
    })

   
	// LANDING PAGE
	var wantToSignIn = false;
	$("#landing_sign_in").on("click", function(event) {
		wantToSignIn = !wantToSignIn;
		if (wantToSignIn == true) {
			$(".sign_in_partial").slideDown(200);
		} else {
			$(".sign_in_partial").slideUp(200);
		};
	});

	// SOCIAL SHARING

    $("#share").click(function () {
    	$("#social_icons").show(400);
    	$("#social_icons").delay(4500).hide(400);
    });
  


    if ($("#facebook_share").length>0) {
		//Facebook
		var facebook_url_to_share = window.location.href;
		var facebook_text = "OMG found this on Aveece";
		var facebook = "https://www.facebook.com/sharer.php?u="+facebook_url_to_share+"&t="+facebook_text;
		document.getElementById("facebook_share").setAttribute("href", facebook);
		

		//Twitter   
		var twitter_data_url = window.location.href;
		var twitter_data_text = "OMG! Look at what I found on Aveece"
		document.getElementById("twitter_share").setAttribute("href",
			"https://twitter.com/intent/tweet?url="+twitter_data_url);
		//Pinterest
		var pinterest_url = "http://pinterest.com/pin/create/button/?url=" + window.location.href
		document.getElementById("pinterest_share").setAttribute("href", pinterest_url);
	 
	    // Google Plus
		var google_plus_url = "https://plus.google.com/share?url=" + window.location.href; 
		document.getElementById("googleplus_share").setAttribute("href", google_plus_url);
	}

	// window.location.href does not seem to work

// https://www.facebook.com/sharer.php?u=[URL]&t=[TEXT]
// http://twitter.com/intent/tweet?source=sharethiscom&text=[TEXT]&url=[URL]

//https://plus.google.com/share?url=http%3A%2F%2Fexample.com


    // Tastemaker page




	// Paginating

	var index = 0; 
	var counter = 0;
	var items = new Array(3);

	window.onload = getNextItem();
	
	function getNextItem() {
		var data = {
			"index": index,
		};
		$.ajax({
			type: 'GET',
			url: "/store/index.json",
			data: data,
			dataType: "json",
			success: function(data) {
				items = data;
				setNextIFrame();
			}
		});
	}

	function setNextIFrame() {
		if (counter == 0) {
			var url1 = items[0].url;
	        var id1 = items[0].id;
		    $("#main_iframe").attr({"src": url1, "item-id": id1});
		} else {
			var url2 = items[1].url;
			var id2 = items[1].id;
			$("#next_main_iframe").attr({"src": url2, "item-id": id2}); 
		}
	}

	 function processAjaxData(response, urlPath){
	     document.getElementById("main_iframe").innerHTML = response.html;
	     document.title = response.pageTitle;
	     window.history.pushState({"html":response.html,"pageTitle":response.pageTitle},"", urlPath);
 	}

	function iframeTransition() {
		var main = $("#main_iframe");
		var next = $("#next_main_iframe");
		$("#next_main_iframe").animate({"left": "-100"}, 1000);
		$("#main_iframe").animate({"left": "0"}, 1000);
		$("#main_iframe").css({"visibility": "hidden"});
		$("#main_iframe").css({"left": "100"});
		main.attr({"id": "next_main_iframe"}); 
		next.attr({"id": "main_iframe"});	

	}

	function next() {
		iframeTransition();
		setNextIframe();
 	}








 	function downVote() {
 		var item_id = $("#main_iframe").attr("item-id");
        var data = {
        	"id": item_id,
			"value": "-1",
		};
		$.ajax({
			type: 'POST',
			url: "/items/"+item_id+"/vote.json", 
			data: data,
			dataType: "json",
			success: function(data) {
				humane.log("Thanks for your feedback! We're improving your experience.", {timeout: 1000 });
				console.log(data);
				next();
			}
		});
 	}

 	/* index is also different from item id */

 	function upVote() {
 		var item_id = $("#main_iframe").attr("item-id");
        var data = {
        	"id": item_id,
			"value": "1",
		};
		$.ajax({
			type: 'POST',
			url: "/items/"+item_id+"/vote.json",   /******* FOR SOME REASON NEVER REACH THE SUCCESS FUNCTION ******/
			data: data,
			dataType: "json",
			success: function(data) {
				humane.log("Glad you liked this! Your feedback helps us improve your experience.", {timeout: 1000 });
				console.log(data);
			}
		});
 	}


	$("#next").on("click", function(event) {
		next();
	});

 	key('right', function() {
		next();
	});

	$("#upvote").on("click", function(event) {
		upVote();
	});

	$("#downvote").on("click", function(event) {
		downVote();
	});

	/* Notifications based on sign in count */
	/*

	window.onload = greetNewUser();

    
    function greetNewUser() {
    // Need to access signin count in some way
    	if (AVDATA.user.sign_in_count === 1) {
			humane.log("Welcome. Use the right arrow key to move forward.");
		} else {
			humane.log("Welcome back.");
		}
    }
	*/




    $("#edwardlando").hover(
      function() {
       $("#edward_info").css({"visibility":"visible"});
       $("#edward_pic").css({"opacity":"0.2"});
      }, 
      function() {
       $("#edward_info").css({"visibility":"hidden"});
       $("#edward_pic").css({"opacity":"1"});
      }
    );

    $("#jonathonyoushaei").hover(
      function() {
       $("#jon_info").css({"visibility":"visible"});
       $("#jon_pic").css({"opacity":"0.2"});
      }, 
      function() {
       $("#jon_info").css({"visibility":"hidden"});
       $("#jon_pic").css({"opacity":"1"});
      }
    );

    $("#first").hover(
      function() {
       $("#first_info").css({"visibility":"visible"});
       $("#first_pic").css({"opacity":"0.2"});
      }, 
      function() {
       $("#first_info").css({"visibility":"hidden"});
       $("#first_pic").css({"opacity":"1"});
      }
    );

    $("#second").hover(
      function() {
       $("#second_info").css({"visibility":"visible"});
       $("#second_pic").css({"opacity":"0.2"});
      }, 
      function() {
       $("#second_info").css({"visibility":"hidden"});
       $("#second_pic").css({"opacity":"1"});
      }
    );

    $("#third").hover(
      function() {
       $("#third_info").css({"visibility":"visible"});
       $("#third_pic").css({"opacity":"0.2"});
      }, 
      function() {
       $("#third_info").css({"visibility":"hidden"});
       $("#third_pic").css({"opacity":"1"});
      }
    );


   
   
});
