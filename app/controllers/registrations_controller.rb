class RegistrationsController < Devise::RegistrationsController
	def new
		super
	end

	def create
		@user = User.new(params[:user])
	    @user.role = "standard"
	    # Create wishlist when create user
	    @user.wishlist = Wishlist.new(:user_id => @user.id)
	    @user.save
	    # Initial chanel for the user
	    @channel = Channel.new(:color => "ALL", :style => "ALL", :price => "ALL", :gender => "BOTH",
	    :user_id => @user.id, :item_index => 0)
	    @channel.current_channel = true
	    @channel.save
	end

	respond_to do |format|
      if @user.save
        format.html { redirect_to root_path }#redirect_to root_path, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { }#render :action => "new" }
        format.json { }#render :json => @user.errors, :status => :unprocessable_entity }
      end
    end

end
