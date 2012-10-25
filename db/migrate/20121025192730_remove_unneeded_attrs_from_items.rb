class RemoveUnneededAttrsFromItems < ActiveRecord::Migration
  def change
  	remove_column :items, :description
  	remove_column :items, :rating
  	remove_column :items, :image_url
  end
end
