class AddGuestUserIdToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :guest_user_id, :integer
  end
end
