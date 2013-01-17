class ChangeTypeOfGuestuidChannels < ActiveRecord::Migration
  def change
  	change_column :channels, :guest_user_id, :string, :null => true
  end
end
