class ItemsController < ApplicationController

  layout "no_header_footer", :only => :index
  # GET /items
  # GET /items.json
  before_filter :authenticate_user!, :except => [:new, :create]
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

    if params["title"]

      @item = Item.new(:title => params["title"],
                       :url => params["url"],
                       :gender => params["gender"],
                       :price => params["price"],
                       :vibe => params["vibe"],
                       :apparel => params["apparel"])
      @item.user_id = params["user_id"]
      @item.save

    else

      @item = Item.new

    end

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
    @item = Item.new(:title => params[:item][:title],
                     :url => params[:item][:url],
                     :gender => params[:item][:gender],
                     :price => params[:item][:price],
                     :vibe => params[:item][:vibe],
                     :apparel => params[:item][:apparel])
                        
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

  def vote # in the route, give item id
    vote = current_user.item_votes.new(value: params["value"], item_id: params["id"])
    @user = current_or_guest_user
    @channel = @user.current_channel
    @item = @channel.current_item
    @tastemaker = @item.user unless @item.user.nil?
    @index = @channel.item_index

    # adding to wishlist or skipping to next item
    if params["value"] == '1'
      @user.add_to_wishlist(@item)
      @tastemaker.rating += 1 unless @tastemaker.nil?
      @user.save
    elsif params["value"] == '-1'
      @index+=1
      @tastemaker.rating -= 1 unless @tastemaker.nil?
      # maybe can't redirect to back then
    end

    @tastemaker.save unless @tastemaker.nil?

    vote.save

    respond_to do |format|
      format.json { render :json => @item } #I'm sending back the item for now
    end
  end

  private 

  def user_is_admin
    unless current_user.role == "admin"
      redirect_to :controller => "store", :action => "index"
    end
  end

end
