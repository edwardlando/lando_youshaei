class AddCurrentChannelToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :current_channel, :boolean
  end
end
