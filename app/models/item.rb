class Item < ActiveRecord::Base
  attr_accessible :title

  belongs_to :user #tastemaker
end
