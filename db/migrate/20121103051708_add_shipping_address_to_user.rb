class AddShippingAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :shipping_address, :text
  end
end
