class Renameitemcolorandstyle < ActiveRecord::Migration
  def change
  	rename_column :items, :style, :vibe
  	rename_column :items, :color, :apparel
  end
end
