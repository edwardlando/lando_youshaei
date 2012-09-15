class AddItemIndexToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :item_index, :integer
  end
end
