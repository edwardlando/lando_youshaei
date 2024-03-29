class OrdersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :user_is_admin, :only => [:index]
  
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    @confirmation = Confirmation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @confirmation = Confirmation.find_by_order_id(@order.id)
  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @cart = current_user.cart
  
    if @cart.line_items.empty?
      redirect_to root_path, :notice => "Oh no! Your shopping bag is empty."
      return
    end

    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    p "****************************************"
    p params
    @order = Order.new(params[:order])
    @user = current_user
    @user.username = params[:order][:name]
    @user.address = params[:order][:address]
    @user.shipping_address = params[:order][:shipping_address]
    @user.save
    @order.user_id = @user.id
    @order.add_line_items_from_cart(current_user.cart)
    
    if @user.stripe_customer_token.nil?
      @customer = @order.create_customer 
    else
      @customer = @order.retrieve_customer 
    end

    respond_to do |format|
      if @order.save
        current_user.cart.empty_cart
        format.html { redirect_to root_path,
          :notice => "Yipee! Request placed! We'll soon get back to you to confirm
          your items and complete the order so you can have your nice clothes :-)" }
        format.json { }#render :json => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.json { render :json => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, :notice => 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private 

  def user_is_admin
    unless current_user.role == "admin"
      redirect_to :controller => "store", :action => "index"
    end
  end

end
