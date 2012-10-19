class AddStatusToConfirmation < ActiveRecord::Migration
  def change
    add_column :confirmations, :status, :string, :default => "not_payed"
  end
end
