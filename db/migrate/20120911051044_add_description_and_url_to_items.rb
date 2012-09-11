class AddDescriptionAndUrlToItems < ActiveRecord::Migration
  def change
    add_column :items, :description, :text
    add_column :items, :url, :string
  end
end
