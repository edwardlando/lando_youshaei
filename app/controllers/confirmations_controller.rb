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
    @confirmation.total = @confirmation.calculate_total
    @order = @confirmation.order

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @confirmation, :id => @confirmation.id }
    end
  end

  # GET /confirmations/new
  # GET /confirmations/new.json
  def new
    @order = Order.find(params[:order_id])
    @confirmation = Confirmation.new()
    @confirmation.order_id = @order.id
    @line_items = @confirmation.line_items
    @confirmation.add_line_items_from_order(@order) # adding line items here
    @user = @order.user
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @confirmation }
    end
  end

  # GET /confirmations/1/edit
  def edit
    @confirmation = Confirmation.find(params[:confirmation_id])
  end

  # POST /confirmations
  # POST /confirmations.json
  def create
    @user = current_user
    @confirmation = Confirmation.new(params[:confirmation])
    @confirmation.status = "sent_to_customer"
    @order = @confirmation.order

    @confirmation.order_id = @order.id
    @order.confirmation_id = @confirmation.id
    @order.save
    
    @confirmation.total = @confirmation.calculate_total

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
    @confirmation.update_attributes(params[:confirmation])

    @confirmation.status = "sent_to_customer"
    @order = @confirmation.order

    @confirmation.order_id = @order.id
    @order.confirmation_id = @confirmation.id
    
    @confirmation.total = @confirmation.calculate_total

    @customer = @order.retrieve_customer 

    respond_to do |format|
    @confirmation.save
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
    @confirmation = Confirmation.find(params[:id])
    @order = @confirmation.order
    @customer = @order.retrieve_customer 
    p @customer
    p "CASHED OUT *******************************************"
    # @confirmation.save_and_make_payment(@customer)  # payment is made here
    # @confirmation.status = "payed"
    @confirmation.save_and_make_payment(@customer)
   
    respond_to do |format|
        format.html { redirect_to root_path, :notice => "Yay! Thanks for your order! We hope you'll love your new
          clothes. You will shortly receive a confirmation email :)" }
        format.json { }#}render :json => @confirmation, :id => @confirmation.id }
    end

  end



end
