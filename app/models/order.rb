class Order < ActiveRecord::Base
  attr_accessible :address, :name

  validates :name, :address, :presence => true

  has_many :line_items, :dependent => :destroy
  belongs_to :user

  def add_line_items_from_cart(cart)
  	cart.line_items.each do |line_item|
  		self.line_items << line_item
  		cart.empty_cart
    end
  end

attr_accessor :stripe_card_token

def save_with_payment
  if valid?
    if get_stripe_customer_id(self.user).nil?
		# create a Customer
		customer = Stripe::Customer.create(
		  :card => stripe_card_token,
		  :description => email
		)
		# save the Customer
		save_stripe_customer_id(self.user, customer.id)
    else 
    	customer_id = get_stripe_customer_id(user) # was on the Stripe site
    	self.stipe_customer_token = customer.id    #### suggested in rails tutorial
    end
	# charge the Customer 
	Stripe::Charge.create(
	    :amount => 1000, # plug in price of the cart
	    :currency => "usd",
	    :customer => customer.id
	)

    save!
  end
rescue Stripe::InvalidRequestError => e
  logger.error "Stripe error while creating customer: #{e.message}"
  errors.add :base, "There was a problem with your credit card."
  false
end

end
