class StoreController < ApplicationController
  def index
    if current_user.nil?
    else
    	@user = current_user
      @channels = @user.channels
      @orders = Order.all.sort_by(&:updated_at) # will want to sort by paid and unpaid
      @confirmations = Confirmation.all

      @channel = Channel.find_by_current_channel(true)

      # Handling orders and confirmations
      unless (@orders.nil? || @orders.empty? || @confirmations.nil? || @confirmations.empty? )
        @confirmation = Confirmation.find_by_user_id_and_status(@user.id, "sent_to_customer")  # might need an index
        @order = @confirmation.order unless @confirmation.nil?
        if params[:confirmation_status]
          @confirmation.status = params[:confirmation_status]
          @confirmation.save
        end
      end 

      # Determines which channel we're on
      if params[:switch_channel] == "true"
        @channel = Channel.find_by_id(params[:channel_id])
        @channel.item_index = 0 #added this because of no method error
        @channels.each do |channel|
          channel.current_channel = false
        end
        @channel.current_channel = true
        @channel.save
      else 
        # Allows us to get the wanted item, thanks to its index
        if params[:index]
          @channel.item_index = params[:index]
        else
          @channel.item_index = 0
        end
          @channel.current_channel = true
          @channel.save
      end

    
      unless @channel.channel_items.empty? 
        @channel_items = @channel.channel_items 
        @current_item = @channel.channel_items[@channel.item_index]
        @item_url = @channel.current_item_url
      end
      @channel.save 
      @user.save
    end
   
  respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @channel }
  end
 end
end
