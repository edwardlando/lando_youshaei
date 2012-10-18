class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

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
      redirect_to root_path, :notice => "You cart is empty"
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
    @order = Order.new(params[:order])
    @user = current_user
    @order.user_id = @user.id
    @order.add_line_items_from_cart(current_user.cart)
    @confirmation = Confirmation.new(params[:order]) # confirmation gets created here
    @confirmation.order_id = @order.id
    @confirmation.save

    if @user.stripe_customer_token.nil?
      @customer = @order.create_customer 
    else
      @customer = @order.retrieve_customer 
    end

    respond_to do |format|
      if @order.save_with_payment_info(@customer)
        current_user.cart.empty_cart
        format.html { redirect_to @confirmation, :notice => "Thank you for placing this request! We'll soon get back to you to confirm
          your items and complete the order" }
        format.json { render :json => @confirmation, :status => :created, :location => @confirmation }
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
  
 
end
