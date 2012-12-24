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

  def gender_match(item, channel_gender)
    item.gender == channel_gender || channel_gender == "All" || channel_gender == "Unisex"
  end

  def price_match(item, channel_price)
    (item.price <= channel_price || channel_price.to_s == "0.0" || channel_price.to_s == "0") ||
    (item.price < 51 && channel.price == "$") || 
    (item.price < 101 && channel.price == "$$") ||
    channel.price == "$$$" ||
    channel.price == "All" 
  end

  def vibe_match(item, channel_vibe)
    item.vibe == channel_vibe || channel_vibe == "All"
  end

  def apparel_match(item, channel_apparel)
    item.apparel == channel_apparel || channel_apparel == "All"
  end
                   
  
  def channel_items
    channel_gender = self.gender
    channel_price = self.price
    channel_vibe = self.vibe
    channel_apparel = self.apparel
    
  
    items = []

    Item.all.each do |item|
      if gender_match(item, channel_gender) && 
         price_match(item, channel_price) &&
         vibe_match(item, channel_vibe) &&
         apparel_match(item, channel_apparel)
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
