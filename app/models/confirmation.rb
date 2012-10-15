class Confirmation < ActiveRecord::Base
  attr_accessible :address, :name, :total, :user_id
end
