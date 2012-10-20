class StoreController < ApplicationController
  def index
    if current_user.nil?
    else
    	@user = current_user
      @channels = @user.channels
      if @user.role == "admin"
        @orders = Order.all.sort_by(&:updated_at) # will want to sort by paid and unpaid
      end

      # When a user stays on the same channel
      @channel = @user.current_channel

      # Handling orders and confirmations
      @confirmation = Confirmation.find_by_user_id_and_status(@user.id, "not_payed")  # might need an index
      @order = @confirmation.order

      # Determines which channel we're on
      if params[:switch_channel] == "true"
        @channel = Channel.find_by_id(params[:channel_id])
        @channels.each do |channel|
          channel.update_attributes(:current_channel => false)
        end
      @channel.current_channel = true
      end

      # Allows us to get the wanted item, thanks to its index
      if params[:index]
      @channel.item_index = params[:index]
      else
      @channel.item_index = 0
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
