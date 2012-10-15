class Cart < ActiveRecord::Base
  attr_accessible :user_id
  has_many :line_items, :dependent => :destroy
  belongs_to :user


  def empty_cart
  	self.line_items.each do |line_item|
  		line_item.cart_id = nil
  	end
  end


end
