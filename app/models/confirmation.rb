class Confirmation < ActiveRecord::Base
  attr_accessible :address, :name, :total, :user_id, :order_id

  has_many :line_items
  has_one :order

  def add_line_items_from_order(order)
  	order.line_items.each do |line_item|
      line_item.order_id = self.id
  		self.line_items << line_item
    end
    save!
  end

  def save_and_make_payment(customer)
    if valid?    
    # charge the Customer 
    Stripe::Charge.create(
        :amount => self.total*100, # price of the cart
        :currency => "usd",
        :customer => customer.id
    )
      save!
    end
    rescue Stripe::InvalidRequestError => e
      logger.error "some error"
      errors.add :base, "There was a problem with your credit card."
      false
  end

end
