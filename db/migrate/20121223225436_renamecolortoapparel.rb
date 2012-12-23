class Renamecolortoapparel < ActiveRecord::Migration
  def change
  	rename_column :channels, :color, :apparel
  end
end
