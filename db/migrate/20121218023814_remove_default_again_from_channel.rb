class RemoveDefaultAgainFromChannel < ActiveRecord::Migration
  def change
  	change_column :channels, :name, :string, :default => nil
  end
end
