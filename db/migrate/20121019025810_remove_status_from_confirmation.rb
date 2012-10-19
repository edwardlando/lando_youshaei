class RemoveStatusFromConfirmation < ActiveRecord::Migration
  def change
  	remove_column :confirmations, :status
  end
end
