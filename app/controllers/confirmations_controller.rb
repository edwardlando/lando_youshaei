class ConfirmationsController < ApplicationController
  # GET /confirmations
  # GET /confirmations.json
  def index
    @confirmations = Confirmation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @confirmations }
    end
  end

  # GET /confirmations/1
  # GET /confirmations/1.json
  def show
    @confirmation = Confirmation.find(params[:id])
    @order = @confirmation.order


    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @confirmation }
    end
  end

  # GET /confirmations/new
  # GET /confirmations/new.json
  def new
    @order = Order.find(params[:id])
    @user = @order.user
    @confirmation = @order.confirmation

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @confirmation }
    end
  end

  # GET /confirmations/1/edit
  def edit
    @confirmation = Confirmation.find(params[:id])
  end

  # POST /confirmations
  # POST /confirmations.json
  def create
    @user = current_user
    @order = Order.find(params[:id])
    @confirmation = @order.confirmation
    @confirmation.order_id = @order.id
    @confirmation.add_line_items_from_order(@order)

    @customer = @order.retrieve_customer 

    respond_to do |format|
      if @confirmation.save
        format.html { redirect_to @confirmation, :notice => 'Confirmation was successfully created.' }
        format.json { render :json => @confirmation, :status => :created, :location => @confirmation, :id => @confirmation.id }
      else
        format.html { render :action => "new" }
        format.json { render :json => @confirmation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /confirmations/1
  # PUT /confirmations/1.json
  def update
    @confirmation = Confirmation.find(params[:id])

    respond_to do |format|
      if @confirmation.update_attributes(params[:confirmation])
        format.html { redirect_to @confirmation, :notice => 'Confirmation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @confirmation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /confirmations/1
  # DELETE /confirmations/1.json
  def destroy
    @confirmation = Confirmation.find(params[:id])
    @confirmation.destroy

    respond_to do |format|
      format.html { redirect_to confirmations_url }
      format.json { head :no_content }
    end
  end

  #################################################################################
  #################################################################################

  def accept_to_pay
    @user = current_user
    @order = Order.find(params[:id])
    @confirmation = @order.confirmation

    @customer = @order.retrieve_customer 
    @confirmation.save_and_make_payment  # payment is made here
    @confirmation.status = "payed"

    respond_to do |format|
      if @confirmation.save
        format.html { redirect_to @confirmation, :notice => 'Yay! Your order was placed. Your clothes will be shipped shortly' }
        format.json { render :json => @confirmation, :id => @confirmation.id }
      else
        format.html { render :action => "new" }
        format.json { render :json => @confirmation.errors, :status => :unprocessable_entity }
      end
    end

  end



end
