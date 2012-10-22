class ItemVote < ActiveRecord::Base
	attr_accessible :value, :item, :item_id

	belongs_to :item
	belongs_to :user

	validates_uniqueness_of :item_id, scope: :user_id
	validates_inclusion_of :value, in: [1, -1]
end
