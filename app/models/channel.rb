class Channel < ActiveRecord::Base
  attr_accessible :color, :gender, :price, :style
  belongs_to :user # should be unique, even if the mix is the same
  # due to votes, and products already seen
end
