class AddAttributesToItemVotes < ActiveRecord::Migration
  def change
    add_column :item_votes, :item_id, :integer
    add_column :item_votes, :user_id, :integer
    add_column :item_votes, :value, :integer
  end
end
