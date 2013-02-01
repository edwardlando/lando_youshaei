class ChangeTypeOfGenesToTextInItemsAndChannels < ActiveRecord::Migration
  def change
  	change_column :channels, :genes, :text
  	change_column :items, :genes, :text
  end
end
