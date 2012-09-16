class Item < ActiveRecord::Base
  attr_accessible :title, :url, :color, :style, :price, :gender

  belongs_to :user #tastemaker

  COLOR_OPTIONS = ["Blue", "Green", "Red", "Yellow",
                   "Pink", "White", "Black", "Grey", "Brown", "Purple"]

  STYLE_OPTIONS = ["Elegant", "Casual", "Preppy", "Hipster"]

  PRICE_OPTIONS = ["Under $50", "Under $70", "Under $100", "Under $200"]

  GENDER_OPTIONS = ["Male", "Female"]

  
end
