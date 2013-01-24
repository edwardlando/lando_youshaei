class UsersController < ApplicationController


  before_filter :authenticate_user!
  before_filter :user_is_admin, :only => [:index]

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

  def add_to_wishlist
    @user = current_user
    @channel = current_user.current_channel
    @item = @channel.current_item

    @user.add_to_wishlist(@item)

    @user.save
  
    respond_to do |format|
      format.html { redirect_to root_path, :notice => "Item successfully added to your wishlist" } 
      format.json {}
    end
  end

  def user_is_admin
    unless current_user.role == "admin"
      redirect_to :controller => "store", :action => "index"
    end
  end

end
