class Channel < ActiveRecord::Base
  attr_accessible :gender, :price, :vibe, :apparel, :item_index, :current_channel, :user_id
  belongs_to :user # should be unique, even if the mix is the same  ## maybe belong_to as current_channel
  validates_presence_of :gender, :price, :vibe, :apparel
  
  # due to votes, and products already seen

  # we'll also sort by best rating

  GENDER_OPTIONS = ["Female", "Male", "All"]

  PRICE_OPTIONS = ["$", "$$", "$$$", "All"]

  VIBE_OPTIONS = ["Elegant", "Casual", "Preppy", "Flashy", "All"]

  APPAREL_OPTIONS = ["Tops","Bottoms", "All"]

  def gender_match(item_gender, channel_gender)
    item_gender == channel_gender || channel_gender == "All" || channel_gender == "Unisex"
  end

  def price_match(item_price, channel_price)
    (item_price < 51.0 && channel_price == "$") || 
    (item_price < 101.0 && channel_price == "$$") ||
    channel_price == "$$$" ||
    channel_price == "All" 
  end

  def vibe_match(item_vibe, channel_vibe)
    item_vibe == channel_vibe || channel_vibe == "All"
  end

  def apparel_match(item_apparel, channel_apparel)
    item_apparel == channel_apparel || channel_apparel == "All"
  end
                   
  
  def channel_items
    channel_gender = self.gender
    channel_price = self.price
    channel_vibe = self.vibe
    channel_apparel = self.apparel
    
    items = []

    Item.all.each do |item|
      if gender_match(item.gender, channel_gender) && 
         price_match(item.price, channel_price) &&
         vibe_match(item.vibe, channel_vibe) &&
         apparel_match(item.apparel, channel_apparel)
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

  def next_item_url
    channel_items[self.item_index+1].url unless channel_items[self.item_index+1].nil?
  end

  def next_next_item_url
    channel_items[self.item_index+2].url unless channel_items[self.item_index+2].nil?
  end


 
end
