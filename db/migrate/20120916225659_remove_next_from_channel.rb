class RemoveNextFromChannel < ActiveRecord::Migration
  def change
  	remove_column :channels, :next
  end
end
