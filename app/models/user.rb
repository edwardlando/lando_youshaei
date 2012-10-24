class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
  				  :username, :role, :stripe_customer_token, :terms
            
  # attr_accessible :title, :body

  # validates_presence_of :username
  validates_acceptance_of :terms, :allow_nil => false,
  :message => "You must accept the terms of use", :on => :create

  has_many :items #tastemakers
  has_many :channels
  has_one :wishlist
  has_one :cart
  has_many :orders
  has_many :item_votes

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

  def total_votes
    ItemVote.joins(:item).where(items: {user_id: self.id}).sum('value')
  end

  def can_vote_for?(item)
    item_votes.build(value: 1, item: item).valid?
  end
  
end
