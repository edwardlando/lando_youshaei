class Confirmation < ActiveRecord::Base
  attr_accessible :address, :name, :total, :user_id, :order_id, :line_items_attributes

  has_many :line_items
  belongs_to :order

  accepts_nested_attributes_for :line_items

  def add_line_items_from_order(order)
  	order.line_items.each do |line_item|
      line_item.confirmation_id = self.id
  		self.line_items << line_item
    end
    save!
  end

  def calculate_total
    total = 0
    self.line_items.each do |line_item|
      total += line_item.price 
    end
    total
  end

  def save_and_make_payment(customer)
    if valid?    
    p self.total
    self.status = "payed"
    total_cents = self.total * 100
    # charge the Customer 
    Stripe::Charge.create(
        :amount => total_cents.to_i, # price in cents
        :currency => "usd",
        :customer => customer.id
    )
    p "INFO: charge made without error"
      save!
    end
    rescue Stripe::InvalidRequestError => e
      logger.error "some error"
      errors.add :base, "There was a problem with your credit card."
      false
  end

end
