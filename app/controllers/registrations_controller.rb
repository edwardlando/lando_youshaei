class RegistrationsController < Devise::RegistrationsController
	
	def after_sign_in_path_for(resource)
        root_path
    end

	def new
	    super
    end

	def create
		super
		
	    resource.role = "standard"
	    resource.cart = Cart.new(:user_id => resource.id)
	    resource.wishlist = Wishlist.new(:user_id => resource.id)
	    
	    # Initial channel for the user
	    @channel = Channel.new(:color => "All_colors", :style => "All_styles", :price => "All_prices", :gender => "Unisex",
    :user_id => resource.id, :item_index => 0, :name => "My first channel")
	    @channel.current_channel = true
	    @channel.save
	    resource.save
    end
end

