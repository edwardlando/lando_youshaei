class Renamestyletovibe < ActiveRecord::Migration
  def change
  	rename_column :channels, :style, :vibe
  end
end
