class Removechannelname < ActiveRecord::Migration
  def change
  	remove_column :channels, :name
  end
end
