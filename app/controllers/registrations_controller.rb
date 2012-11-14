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
			@channel = Channel.find_by_guest_user_id(guest_user.lazy_id)
			@channel.user_id = resource.id
			@channel.item_index = 0
			@channel.save
			guest_user.destroy
	        cookies.delete :uuid 
        # User is registering without having been a guest user
        else
	        # Initial channel for the user
		    @channel = Channel.new(
		    :color => "All", :style => "All",
		    :price => "All", :gender => "Unisex",
	        :user_id => resource.id, :item_index => 0,
	        :name => "My first channel")
		    @channel.current_channel = true
		    @channel.save
        end  
	    resource.role = "standard"
	    resource.cart = Cart.new(:user_id => resource.id)
	    resource.wishlist = Wishlist.new(:user_id => resource.id)
	    resource.save
	    flash[:notice] = "Welcome to Aveece!"
    end
end

