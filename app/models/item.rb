class Item < ActiveRecord::Base
  attr_accessible :title, :url, :gender, :price, :vibe, :apparel

  belongs_to :user #tastemaker
  has_and_belongs_to_many :wishlists
  has_many :line_items
  has_many :orders, :through => :line_items
  has_many :item_votes

  validates_presence_of :title, :url, :apparel, :vibe, :price, :gender,
  :message => "Please make sure to fill in all fields"

  before_destroy :ensure_not_referenced_by_any_line_item

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

  SIZE_OPTIONS = ["Extra Small", "Small", "Medium", "Large", "Extra Large"]

  def self.by_votes
    select('items.*, coalesce(value, 0) as votes').
    joins('left join item_votes on item_id=item.id').
    order('votes desc')
  end

  def votes
    read_attribute(:votes) || item_votes.sum(:value)
  end

  private

	  def ensure_not_referenced_by_any_line_item
	  	if line_items.empty?
	  		return true
	  	else
	  		errors.add(:base, "Line Items present")
	  		return false
	  	end
	  end
  
end
