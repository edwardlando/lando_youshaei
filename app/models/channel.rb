class Channel < ActiveRecord::Base
  attr_accessible :color, :gender, :price, :style, :item_index
  belongs_to :user # should be unique, even if the mix is the same  ## maybe belong_to as current_channel
  # due to votes, and products already seen

  # we'll also sort by best rating

  COLOR_OPTIONS = ["ALL", "Blue", "Green", "Red", "Yellow",
                   "Pink", "White", "Black", "Grey",
                   "Brown"]

  STYLE_OPTIONS = ["ALL", "Elegant", "Casual", "Preppy", "Hipster"]

  PRICE_OPTIONS = ["ALL", "Under $50", "Under $70", "Under $100", "Under $200"]

  GENDER_OPTIONS = ["BOTH", "Male", "Female"]


  def channel_items
    channel_color = self.color
    channel_style = self.style
    channel_price = self.price
    channel_gender = self.gender

    channel_items = []
    Item.all.each do |item|
    	if (item.color == channel_color &&
    	   item.style == channel_style &&
    	   item.price <= channel_price &&
    	   item.gender == channel_gender) 
    	      channel_items << item
    	end
    end
    channel_items
  end

  def current_item_url
	channel_items[self.item_index].url
  end


 
end
