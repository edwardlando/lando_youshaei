class StoreController < ApplicationController
  def index
    if current_user.nil?
    else
    	@user = current_user

      # Determines which channel we're on
      if params[:switch_channel] == "true"
        @channel = Channel.find_by_id(params[:channel_id])
      else
         @channel = @user.current_channel
      end
       
      # Allows us to get the wanted item, thanks to its index
      @channel_items = @channel.channel_items 
      @channel.item_index = params[:index]
      unless @channel.channel_items.empty?
        @current_item = @channel.channel_items[@channel.item_index]
        @item_url = @channel.current_item_url
      end
      @channel.save 
    end
   

  respond_to do |format|
      format.html # index.html.erb
      format.json {}
  end
 end
end
