class Channel < ActiveRecord::Base
  attr_accessible :color, :gender, :price, :style, :item_index, :current_channel, :name, :user_id
  belongs_to :user # should be unique, even if the mix is the same  ## maybe belong_to as current_channel
  validates_presence_of :name, :color, :style, :price, :gender

  # due to votes, and products already seen

  # we'll also sort by best rating

  COLOR_OPTIONS = ["White", "Grey", "Black", "Red", "Green", "Blue", "Pink", "Brown", "Yellow", "Orange",
                   "Purple", "All"]

  STYLE_OPTIONS = ["Elegant", "Casual", "Preppy", "Hipster", "All"]

  PRICE_OPTIONS = ["50", "100", "200", "All"]

  GENDER_OPTIONS = ["Female", "Male", "Unisex"]


  def channel_items
    channel_color = self.color
    channel_style = self.style
    channel_price = self.price
    channel_gender = self.gender

    items = []
    Item.all.each do |item|
    	if  (channel_color == item.color || channel_color == "All") &&
    	    (item.style == channel_style || channel_style == "All") &&
    	    (item.price <= channel_price || channel_price.to_s == "0.0" || channel_price.to_s == "0") &&
    	    (item.gender == channel_gender || channel_gender == "Unisex")
    	      items << item
    	end
    end
    items 
  end

  def current_item
  channel_items[self.item_index] unless channel_items[self.item_index].nil?
  end

  def current_item_url
	channel_items[self.item_index].url unless channel_items[self.item_index].nil?
  end


 
end
