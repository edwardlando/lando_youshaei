class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
  				  :username, :role, :stripe_customer_token
            
  # attr_accessible :title, :body

  #validates_presence_of :username

  has_many :items #tastemakers
  has_many :channels
  has_one :wishlist
  has_one :cart

  def current_channel
    self.channels.each do |channel|
      if channel.current_channel == true
        return channel
      end
    end
  end

  def add_to_wishlist(item)
    self.wishlist.items << item unless self.wishlist.items.include?(item)
  end

  def total_cart_price
    total = 0
    self.cart.line_items.each do |line_item|
      total += (line_item.item.price * line_item.quantity)
      # add shipping + margin
    end
    total
  end

  # has_one :current_channel, :class_name => "Channel" # current_channel
  #  :foreign_key => :owner_id  -- maybe go with foreign_key option
end
