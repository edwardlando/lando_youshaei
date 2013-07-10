class StoreController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index

    p "params are #{params}"


    if current_or_guest_user #should check if a current or guest user exists
      if current_user
        @user = current_user
        cookies[:aveece_user_id] = current_user.id
      end

      @index = params["index"].to_i ||= 0

      if @user
        if params[:current_channel] && params[:switch]
           @old_channel = @user.current_channel
           @old_channel.current_channel = false
           @old_channel.save
           @channels = @user.channels
           @channel = @channels.find(params[:current_channel])
           @channel.current_channel = true
           @channel.item_index = 0
           @channel.save
        else 
           @channel = @user.current_channel 
        end
      end
    
      if @channel 
        @items = @channel.channel_items # send index in json too let's see if just sending the url works
        @items = @channel.get_next_items(@items) # machine learning
        @items = @items[@index..@index+2] 

        puts "old items were #{@items}"

         if params[:id].to_i > 0
          puts "got param id!"
          id_no = params[:id].to_i
          request = Item.find(id_no)
          if request
            @items[0] = request
          end
        else
          puts "culdnt find param id"
        end
        puts "new urls are #{@items}"

        @items.each { |ite| @channel.seen+=(ite.id.to_s+",")}
        @channel.item_index = @index unless @channel.channel_items[@index.to_i].nil?
        @channel.save unless @channel.channel_items[@index.to_i].nil?
      end

  #    render :json => @items
       
    end
    respond_to do |format|
        format.html 
        format.json { render :json => @items, :params => { :id => params[:id]} }#@item_urls } # send index too
    end
  end

  def make_first_channel
    @user = current_user
  end
end

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
