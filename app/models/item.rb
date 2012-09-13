class Item < ActiveRecord::Base
  attr_accessible :title, :url, :color, :style, :price, :gender

  belongs_to :user #tastemaker
end
