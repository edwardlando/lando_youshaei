class AddOrderIdToConfirmation < ActiveRecord::Migration
  def change
    add_column :confirmations, :order_id, :integer
  end
end
