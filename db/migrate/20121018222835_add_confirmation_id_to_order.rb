class AddConfirmationIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :confirmation_id, :integer
  end
end
