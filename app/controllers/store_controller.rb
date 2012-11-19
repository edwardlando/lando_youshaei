class StoreController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    if current_or_guest_user #should check if a current or guest user exists
    	@user = current_user
      @guest_user = guest_user
      @channels = @user.channels unless @user.nil?
      @orders = Order.all.sort_by(&:updated_at) # will want to sort by paid and unpaid
      @confirmations = Confirmation.all

       # Handling orders and confirmations
      unless (@orders.nil? || @orders.empty? || @confirmations.nil? || @confirmations.empty? )
        @confirmation = Confirmation.find_by_user_id_and_status(@user.id, "sent_to_customer")  # might need an index
        @order = @confirmation.order unless @confirmation.nil?
        if params[:confirmation_status]
          @confirmation.status = params[:confirmation_status]
          @confirmation.save
        end
      end 

      if @user
        if params[:current_channel] && params[:switch]
           @old_channel = @user.current_channel
           @old_channel.current_channel = false
           @old_channel.save
           @channel = @channels.find(params[:current_channel])
           @channel.current_channel = true
           @channel.item_index = 0
           @channel.save
        else 
           @channel = @user.current_channel 
        end
      end

      if @guest_user
        @guest_channel = @guest_user.current_channel
      end
          
      # Allows us to get the wanted item, thanks to its index
      if @channel && params[:index]
        @index = params[:index]
        unless @channel.channel_items[@index.to_i].nil?
          @channel.item_index = params[:index]
        end
      end

      if @guest_channel && params[:index]
        @index = params[:index]
        unless @guest_channel.channel_items[@index.to_i].nil?
          @guest_channel.item_index = params[:index]
        end
      end

      unless @channel.nil? || @channel.channel_items.empty? 
        @channel_items = @channel.channel_items 
        @current_item = @channel.channel_items[@channel.item_index]
        @item_url = @channel.current_item_url
      end

      unless @guest_channel.nil? || @guest_channel.channel_items.empty? 
        @guest_channel_items = @guest_channel.channel_items 
        @guest_current_item = @guest_channel.channel_items[@guest_channel.item_index]
        @guest_item_url = @guest_channel.current_item_url
      end

      @guest_channel.save unless @guest_channel.nil?
      @channel.save unless @channel.nil?
      
    end
    respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @channel } # or guest channel?
    end
  end
end
