class Wishlist < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :user
  has_and_belongs_to_many :items
end
