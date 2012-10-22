class Item < ActiveRecord::Base
  attr_accessible :title, :url, :color, :style, :price, :gender

  belongs_to :user #tastemaker
  has_and_belongs_to_many :wishlists
  has_many :line_items
  has_many :orders, :through => :line_items

  has_reputation :votes, source: :user, aggregated_by: :sum

  before_destroy :ensure_not_referenced_by_any_line_item

  COLOR_OPTIONS = ["White", "Black", "Red", "Green", "Blue", "Yellow",
                   "Pink", "Grey", "Brown", "Purple", "Orange"]

  STYLE_OPTIONS = ["Elegant", "Casual", "Preppy", "Hipster"]

  PRICE_OPTIONS = ["50", "100", "200"]

  GENDER_OPTIONS = ["Male", "Female"]

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
