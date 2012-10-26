class LineItemsController < ApplicationController
  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.json

  def create
    @user = current_user
    @channel = current_user.current_channel
    @item = @channel.current_item
    @cart = @user.cart
    @existing_line_item = LineItem.find_by_item_id_and_cart_id(@item.id, @cart.id) # have to identify line_items in other ways now
    @current_url = @item.url

    if @cart.line_items.include?(@existing_line_item)
      @line_item = @existing_line_item
      @line_item.quantity += 1
    else 
      @line_item = LineItem.new(:item_id => @item.id, :cart_id => @cart.id,
        :current_url => @item.url, :name => params[:name], :size => params[:size])
      @line_item.quantity = 1
    end
    
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to root_path, :notice => 'Item successfully added to cart' }
        format.json { }#render :json => @channel }
      else
        format.html { redirect_to :controller => "store", :action => "index", :notice => "There was an error adding the item to your cart" }
        format.json { }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, :notice => 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to line_items_url }
      format.json { head :no_content }
    end
  end
end
