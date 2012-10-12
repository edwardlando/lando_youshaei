class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :item_id, :current_url
  belongs_to :item
  belongs_to :cart
  belongs_to :order
end
