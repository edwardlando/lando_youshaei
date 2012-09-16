class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
  				  :username, :role
            
  # attr_accessible :title, :body

  #validates_presence_of :username

  has_many :items #tastemakers
  has_many :channels

  def current_channel
    self.channels.each do |channel|
      if channel.current_channel == true
        return channel
      end
    end

  end
  

  # has_one :current_channel, :class_name => "Channel" # current_channel
  #  :foreign_key => :owner_id  -- maybe go with foreign_key option
end
