class Channel < ActiveRecord::Base
  attr_accessible :color, :gender, :price, :style, :item_index
  belongs_to :user # should be unique, even if the mix is the same
  # due to votes, and products already seen


  # we'll also sort by best rating
  def channel_items(user)
  	unless user.channel.nil?
	    channel_color = user.channel.color
	    channel_style = user.channel.style
	    channel_price = user.channel.price
	    channel_gender = user.channel.gender

	  	Item.where(
	  		:color == channel_color,
	  		:style == channel_style,
	        "price < ?", channel_price,
	        :gender == channel_gender
	        ) 
    end
  end

 
end
