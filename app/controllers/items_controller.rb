class ItemsController < ApplicationController
  # GET /items
  # GET /items.json
  before_filter :authenticate_user!, :except => [:index]
  before_filter :user_is_admin, :only => [:index]

  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])
    @item_url = @item.url

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(:title => params["item"]["title"], :url => params["item"][:url], :color => params["item"]["color"], 
      :style => params["item"]["style"], :price => params["item"]["price"], :gender => params["item"]["gender"])

    @item.user_id = current_user.id

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, :notice => 'Item was successfully created.' }
        format.js
        format.json { render :json => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, :notice => 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  def vote
    p params
    p "************************************"
    vote = current_user.item_votes.new(value: params[:value], item_id: params[:id])
    @user = current_or_guest_user
    @channel = @user.current_channel
    @item = @channel.current_item
    @index = @channel.item_index

    # adding to wishlist or skipping to next item
    if params[:value] == 1
      @user.add_to_wishlist(@item)
      
    elsif params[:value] == -1
      @index+=1
      # maybe can't redirect to back then
    end
  
    if vote.save
      redirect_to :controller => "store", :action => "index", :index => @index
      flash[:notice] =  "Thanks for voting. Your feedback allows us to show you things you'll love."
    else
      redirect_to :controller => "store", :action => "index"
      flash[:notice] =  "Unable to vote, perhaps you already did."
    end
  end

  private 

  def user_is_admin
    unless current_user.role == "admin"
      redirect_to :controller => "store", :action => "index"
    end
  end

end
