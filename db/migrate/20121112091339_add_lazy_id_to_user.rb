class AddLazyIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :lazy_id, :integer
  end
end
