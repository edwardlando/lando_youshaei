class Confirmation < ActiveRecord::Base
  attr_accessible :address, :name, :total, :user_id, :order_id

  has_many :line_items
  belongs_to :order

  def add_line_items_from_order(order)
  	order.line_items.each do |line_item|
      line_item.order_id = self.id
  		self.line_items << line_item
    end
    save!
  end

end
