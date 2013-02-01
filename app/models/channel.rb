class Channel < ActiveRecord::Base
  attr_accessible :gender, :price, :vibe, :apparel, :item_index, :current_channel, :user_id, :guest_user_id,
                  :genes, :seen, :mean_gene_distance 

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


  def calculate_mean_gene_distance(items)
    mean_dist = 0
    num_items = items.size
    items.each do |item|
      mean_dist+=item.gene_distance(self)/num_items
    end
    return mean_dist
  end

  def seen?(item)
    seen = self.seen.split(",")
    seen.each do |val|
      if item.id.to_s == val
        return true
      end
    end
    return false
  end



  def get_next_items(items)
    basket = []
    items.each do |item| # arbitrary and should be changed later
      if item.gene_distance(self) < self.mean_gene_distance/1.25 && !seen?(item)
#        self.seen+=(item.id.to_s+",")
        basket << item
      end
    end
    self.save
    return basket
  end

 
end
