class UsersController < Devise::RegistrationsController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @channels = @user.channels

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    super
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  
  # This is not being used because of devise so the logic is the same in store#index
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

    respond_to do |format|
      if @user.save
        format.html { }#redirect_to root_path, :notice => 'User was successfully created.' }
        format.json { }#render :json => @user, :status => :created, :location => @user }
      else
        format.html { }#render :action => "new" }
        format.json { }#render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    super
=begin
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
=end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  ########################################################################################
  ########################################################################################

  def add_to_wishlist
    @user = current_user
    @channel = current_user.current_channel
    @item = @channel.current_item

    @user.add_to_wishlist(@item)

    @user.save
  
    respond_to do |format|
      format.html 
      format.json {render :json => @user }
    end
  end

end
