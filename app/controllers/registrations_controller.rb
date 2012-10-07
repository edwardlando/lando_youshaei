class RegistrationsController < Devise::RegistrationsController
	def new
		super
	end

	def create
		super
		# @user = User.new(params[:user])
	    # @user.role = "standard"
	    resource.role = "standard"
	    resource.cart = Cart.new(:user_id => resource.id)
	    resource.wishlist = Wishlist.new(:user_id => resource.id)
	    resource.save

	    # Create wishlist when create user
	    # @user.wishlist = Wishlist.new(:user_id => @user.id)
	    # @user.save
	    # Initial chanel for the user
	    @channel = Channel.new(:color => "All_colors", :style => "All_styles", :price => "All_prices", :gender => "Unisex",
    :user_id => resource.id, :item_index => 0, :name => "My first channel")
	    @channel.current_channel = true
	    @channel.save
	
		respond_to do |format|
	      if @user.save
	        format.html { }#redirect_to root_path, :notice => 'User was successfully created.' }
	        format.json { }#render :json => resource } #render :json => @user, :status => :created, :location => @user }
	      else
	        format.html { render :action => "new" }
	        format.json { }#render :json => @user.errors, :status => :unprocessable_entity }
	      end
	    end
	end

end
