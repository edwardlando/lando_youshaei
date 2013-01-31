class ChangeTypeOfSeenToTextInChannels < ActiveRecord::Migration
  def change
  	change_column :channels, :seen, :text
  end
end
