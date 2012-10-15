class Order < ActiveRecord::Base
  attr_accessible :address, :name, :stripe_customer_token, :stripe_card_token

  validates :name, :address, :presence => true

  has_many :line_items, :dependent => :destroy
  belongs_to :user

  def add_line_items_from_cart(cart)
  	cart.line_items.each do |line_item|
      line_item.cart_id = nil
  		self.line_items << line_item
    end
    save!
  end

  
  attr_accessor :stripe_card_token

  def create_customer
    customer = Stripe::Customer.create(
      :card => stripe_card_token,
      :description => "#{self.user.email}"
    )
    # save the Customer
    self.user.stripe_customer_token = customer.id
    self.user.save
    save!
    return customer 
  end

  def retrieve_customer
    customer = Stripe::Customer.retrieve(self.user.stripe_customer_token) 
    return customer
  end

  def save_with_payment(customer)
    if valid?    
  	# charge the Customer 
  	Stripe::Charge.create(
  	    :amount => 1000,                                     # plug in price of the cart
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