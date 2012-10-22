class RemoveStatusFromConfirmationAgain < ActiveRecord::Migration
 def change
  	remove_column :confirmations, :status
  end
end
