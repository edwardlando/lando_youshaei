class RegistrationsController < Devise::RegistrationsController
	
	def after_sign_in_path_for(resource)
        root_path
    end

	def new
	    super
    end

	def create
		super
        
        # If the guest user has decided to make an account
		if guest_user
			@channels = Channel.find_all_by_guest_user_id(guest_user.lazy_id)
			@channels.each do |c|
				c.user_id = resource.id
				c.item_index = 0
				c.save
			end
        else
		    @channel = Channel.new(:gender => "All",
							       :price => "All",
							       :vibe => "All",
							       :apparel => "All",
							       :user_id => resource.id,
							       :item_index => 0)

		    @channel.current_channel = true
		    @channel.save
        end  
	    resource.role = "standard"
	    resource.cart = Cart.new(:user_id => resource.id)
	    resource.wishlist = Wishlist.new(:user_id => resource.id)
	    resource.save
    end

    def destroy
    	super
    end
end

