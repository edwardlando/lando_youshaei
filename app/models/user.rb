class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
  				  :username, :role, :stripe_customer_token, :terms, :lazy_id, :id
            
  # attr_accessible :title, :body

  validates_acceptance_of :terms, :allow_nil => false,
  :message => "You must accept the terms of use", :on => :create, :if => :no_provider
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, :on => :create, :if => :no_provider,
  format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 },
  :on => :create, :if => :no_provider
  validates_confirmation_of :password, :on => :create, :if => :no_provider
  validates :password_confirmation, presence: true, :on => :create, :if => :no_provider

  has_many :items #, :dependent => :destroy
  has_many :channels, :dependent => :destroy
  has_one :wishlist
  has_one :cart
  has_many :orders
  has_many :item_votes

  before_destroy :destroy_guest_channels_if_any

  def current_channel
    if self.lazy_id
      return Channel.find_by_guest_user_id_and_current_channel(self.lazy_id, true)
    else
      return self.channels.find_by_user_id_and_current_channel(self.id, true)
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

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.email = auth.info.email
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def no_provider
    provider.blank? || provider.nil?
  end

  def destroy_guest_channels_if_any
    if Channel.find_by_guest_user_id(self.lazy_id)
      Channel.find_all_by_guest_user_id(self.lazy_id).each do |c|
        c.destroy
      end
    end
    if cookies[:uuid]
      guest_user.destroy
      cookies.delete :uuid
    end
  end

  
end
