class Channel < ActiveRecord::Base
  attr_accessible :color, :gender, :price, :style, :item_index, :current_channel
  belongs_to :user # should be unique, even if the mix is the same  ## maybe belong_to as current_channel
  # due to votes, and products already seen

  # we'll also sort by best rating

  COLOR_OPTIONS = ["ALL", "Blue", "Green", "Red", "Yellow",
                   "Pink", "White", "Black", "Grey", "Brown", "Purple"]

  STYLE_OPTIONS = ["ALL", "Elegant", "Casual", "Preppy", "Hipster"]

  PRICE_OPTIONS = ["ALL", "Under $50", "Under $70", "Under $100", "Under $200"]

  GENDER_OPTIONS = ["BOTH", "Male", "Female"]


  def channel_items
    channel_color = self.color
    channel_style = self.style
    channel_price = self.price
    channel_gender = self.gender

    items = []
    Item.all.each do |item|
    	if  (channel_color == item.color || channel_color == "ALL") &&
    	    (item.style == channel_style || channel_style == "ALL") &&
    	    (item.price <= channel_price || channel_price == "$0.00") &&
    	    (item.gender == channel_gender || channel_gender == "BOTH")
    	      items << item
    	end
    end
    items
  end

  def current_item_url
	channel_items[self.item_index].url unless channel_items[self.item_index].nil?
  end


 
end
