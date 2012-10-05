class Cart < ActiveRecord::Base
  attr_accessible :user_id
  has_many :line_items, :dependent => :destroy
  belongs_to :user
end
