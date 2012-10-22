class AddStatusAgainToConfirmations < ActiveRecord::Migration
  def change
    add_column :confirmations, :status, :string, :default => "new"
  end
end
