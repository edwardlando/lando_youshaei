class AddDefaultNameToChannel < ActiveRecord::Migration
  def change
  	change_column :channels, :name, :string, :default => "a channel"
  end
end
