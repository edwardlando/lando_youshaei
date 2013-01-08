class StoreController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    if current_or_guest_user #should check if a current or guest user exists
    	@user = current_user
      @guest_user = guest_user
      @channels = @user.channels unless @user.nil?
      #@items = Item.page(params[:page]).per(5)   ##### starting kaminari change here
      @index = params["index"].to_i ||= 0
      ### need to add params page
=begin
      @orders = Order.all.sort_by(&:updated_at) # will want to sort by paid and unpaid
      @confirmations = Confirmation.all

      # Handling orders and confirmations
      unless (@user.nil? || @orders.nil? || @orders.empty? || @confirmations.nil? || @confirmations.empty? )
        @confirmation = Confirmation.find_by_user_id_and_status(@user.id, "sent_to_customer")  # might need an index
        @order = @confirmation.order unless @confirmation.nil?
        if params[:confirmation_status]
          @confirmation.status = params[:confirmation_status]
          @confirmation.save
        end
      end 
=end
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
        @channel = @user.current_channel
      elsif @guest_user
        @guest_channel = @guest_user.current_channel
      end

     
    
      if @channel 
        @items = @channel.channel_items # send index in json too let's see if just sending the url works
        @items = @items[@index..@index+2]
        @channel.item_index = @index unless @channel.channel_items[@index.to_i].nil?
        @channel.save unless @channel.channel_items[@index.to_i].nil?
      elsif @guest_channel 
        @items = @guest_channel.channel_items
        @items = @items[@index..index+2]
        @guest_channel.item_index = @index unless @guest_channel.channel_items[@index.to_i].nil?
        @guest_channel.save
      end

      @item_urls = []
        unless @items.nil?
        @items.each do |item|
          @item_urls << item.url
        end
      end

      
    end
    respond_to do |format|
        format.html { } # index.html.erb
        #format.js 
        format.json { render :json => @item_urls } # send index too

        #somewhere else, call items.paginate (will only give you a certain amount of items, say 5)
        #render json items
        #allows you to request the next page


    end
  end
end
