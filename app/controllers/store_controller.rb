class StoreController < ApplicationController
  def index
  	@user = current_user
  	if params[:switch_channel] == "true"
  		@channel = Channel.find_by_id(:channel_id)
  	else
       @channel = @user.current_channel
  	end
  	@item_url = @channel.current_item_url
  end

  @channel.save

  respond_to do |format|
      format.html # index.html.erb
      format.json {}
    end
end
