class Channel < ActiveRecord::Base
  attr_accessible :color, :gender, :price, :style, :item_index
  belongs_to :user # should be unique, even if the mix is the same  ## maybe belong_to as current_channel
  # due to votes, and products already seen

  # we'll also sort by best rating


  def channel_items
    channel_color = self.color
    channel_style = self.style
    channel_price = self.price
    channel_gender = self.gender

  	Item.where(
  		:color == channel_color,
  		:style == channel_style,
        "price < ?", channel_price,
        :gender == channel_gender
        ) 
  end

  def current_item_url
	channel_items[self.item_index]
  end


 
end
