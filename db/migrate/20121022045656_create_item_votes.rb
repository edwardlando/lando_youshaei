class CreateItemVotes < ActiveRecord::Migration
  def change
    create_table :item_votes do |t|
      t.belongs_to :item
      t.belongs_to :user
      t.integer :value

      t.timestamps
    end
    add_index :item_votes, :item_id
    add_index :item_votes, :user_id
  end
end

