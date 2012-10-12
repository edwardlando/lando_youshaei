class UsersController < ApplicationController
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
  # USER CREATED IN REGISTRATIONS CONTROLLER
  def create
    super
    @user = User.new(params[:user])
    @user.role = "standard"
    # Create wishlist when create user
    @user.wishlist = Wishlist.new(:user_id => @user.id)
    
    # Initial chanel for the user
    @channel = Channel.new(:color => "All_colors", :style => "All_prices", :price => "All_prices", :gender => "Unisex",
    :user_id => @user.id, :item_index => 0)
    @channel.current_channel = true
    @channel.save

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path }#redirect_to root_path, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
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
      format.html { redirect_to root_path } 
      format.json {}
    end
  end

  def add_to_cart
    @user = current_user
    @channel = current_user.current_channel
    @item = @channel.current_item
    @cart = @user.cart
    @existing_line_item = LineItem.find_by_item_id_and_cart_id(@item.id, @cart.id)
    @current_item_url = params["current_url"] # getting it from Ajax post
    
    if @cart.line_items.include?(@existing_line_item)
      @existing_line_item.quantity += 1
      @existing_line_item.save
      @cart.save
    else 
      @line_item = LineItem.new(:item_id => @item.id, :cart_id => @cart.id,
        :current_url => @current_item_url)
      @cart.line_items << @line_item 
    end
    
    @user.save
  
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json {}
    end
  end

end
