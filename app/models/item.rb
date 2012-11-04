class Item < ActiveRecord::Base
  attr_accessible :title, :url, :color, :style, :price, :gender

  belongs_to :user #tastemaker
  has_and_belongs_to_many :wishlists
  has_many :line_items
  has_many :orders, :through => :line_items
  has_many :item_votes

  validates_presence_of :title, :url, :color, :style, :price, :gender,
  :message => "Please make sure to fill in all fields"

  before_destroy :ensure_not_referenced_by_any_line_item

  COLOR_OPTIONS = ["White", "Black", "Red", "Green", "Blue", "Yellow",
                   "Pink", "Grey", "Brown", "Purple", "Orange"]

  STYLE_OPTIONS = ["Elegant", "Casual", "Preppy", "Hipster"]

  PRICE_OPTIONS = ["50", "100", "200"]

  GENDER_OPTIONS = ["Female", "Male"]

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
