class Channel < ActiveRecord::Base
  attr_accessible :color, :gender, :price, :style
  belongs_to :user # should be unique, even if the mix is the same
  # due to votes, and products already seen


  # we'll also sort by best rating
  def channel_items
  	Item.find_all { |item|
  		item.color = channel.color,
  		item.style = channel.style,
        item.price <= channel.price,
        item.gender = channel.gender }
  end

 
end
