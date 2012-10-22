class AddAgreeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :agree, :boolean, :default => false
  end
end
