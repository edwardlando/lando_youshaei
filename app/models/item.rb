class Item < ActiveRecord::Base
  attr_accessible :title, :url, :color, :style, :price, :gender

  belongs_to :user #tastemaker
  has_and_belongs_to_many :wishlists
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  COLOR_OPTIONS = ["Blue", "Green", "Red", "Yellow",
                   "Pink", "White", "Black", "Grey", "Brown", "Purple"]

  STYLE_OPTIONS = ["Elegant", "Casual", "Preppy", "Hipster"]

  PRICE_OPTIONS = ["Under $50", "Under $70", "Under $100", "Under $200"]

  GENDER_OPTIONS = ["Male", "Female"]

  private

	  def ensure_nor_referenced_by_any_line_item
	  	if line_items.empty?
	  		return true
	  	else
	  		errors.add(:base, "Line Items present")
	  		return false
	  	end
	  end
  
end
