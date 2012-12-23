class Channel < ActiveRecord::Base
  attr_accessible :color, :gender, :price, :style, :item_index, :current_channel, :name, :user_id
  belongs_to :user # should be unique, even if the mix is the same  ## maybe belong_to as current_channel
  validates_presence_of :name, :apparel, :vibe, :price, :gender

  extend FriendlyId
  friendly_id :name

  # due to votes, and products already seen

  # we'll also sort by best rating

  GENDER_OPTIONS = ["Female", "Male", "All"]

  PRICE_OPTIONS = ["$", "$$", "$$$", "All"]

  VIBE_OPTIONS = ["Elegant", "Casual", "Preppy", "Flashy", "All"]

  FEMALE_APPAREL_OPTIONS = ["Tees, Polos & Shirts",
                            "Pants, Skirts & Shorts",
                            "Sweaters, Jackets & Outerwear",
                            "Dresses & Formalwear",
                            "Shoes, Accessories & Miscellaneous",
                            "All"]

  MALE_APPAREL_OPTIONS = ["Tees, Polos & Shirts",
                          "Sweaters, Jackets & Outerwear",
                          "Pants & Shorts",
                          "Suits & Formalwear",
                          "Shoes, Accessories & Miscellaneous",
                          "All"]
                   
  


  def channel_items
    channel_apparel = self.apparel
    channel_vibe = self.vibe
    channel_price = self.price
    channel_gender = self.gender

    items = []
    Item.all.each do |item|
    	if (item.gender == channel_gender || channel_gender == "All" || channel_gender == "Unisex") &&
         (item.price <= channel_price || channel_price.to_s == "0.0" || channel_price.to_s == "0") &&
         (item.vibe == channel_vibe || channel_vibe == "All") &&
         (item.apparel == channel_apparel || channel_apparel == "All") 
    	      items << item
    	end
    end
    #items = items.shuffle
    items 
  end

  def current_item
    channel_items[self.item_index] unless channel_items[self.item_index].nil?
  end

  def current_item_url
  	channel_items[self.item_index].url unless channel_items[self.item_index].nil?
  end

  def next_item_url
    channel_items[self.item_index+1].url unless channel_items[self.item_index+1].nil?
  end

  def next_next_item_url
    channel_items[self.item_index+2].url unless channel_items[self.item_index+2].nil?
  end


 
end
