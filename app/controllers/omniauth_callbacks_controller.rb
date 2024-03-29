class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def all
	    user = User.from_omniauth(request.env["omniauth.auth"])
	   
        # not making duplicates
	    if user.channels.empty? && user.cart.nil? && user.wishlist.nil?
		    user.role = "standard"
		    user.cart = Cart.new(:user_id => user.id)
		    user.wishlist = Wishlist.new(:user_id => user.id)
		    
		    # Initial channel for the user
		    @channel = Channel.new(:gender => "All",
							       :price => "All",
							       :apparel => "All",
		    	                   :vibe => "All",
							       :user_id => user.id,
							       :item_index => 0)
		    @channel.current_channel = true
		    @channel.save
	    end

	    if user.persisted?
	      sign_in_and_redirect user
	    else
	      session["devise.user_attributes"] = user.attributes
	      redirect_to new_user_registration_url
	    end
	  end
	alias_method :twitter, :all #add other providers after
	alias_method :facebook, :all 
end
