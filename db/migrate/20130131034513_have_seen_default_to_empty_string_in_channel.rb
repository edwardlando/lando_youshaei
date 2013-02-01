class HaveSeenDefaultToEmptyStringInChannel < ActiveRecord::Migration
  def change
  	change_column :channels, :seen, :text, :default => ""
  end
end
