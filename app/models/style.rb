class Style < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :title,:genes,:gender
  belongs_to :user
  has_many :items

  GENDER_OPTIONS = ["Female", "Male", "All"]




end
