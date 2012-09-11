class AddColorPriceGenderToItems < ActiveRecord::Migration
  def change
    add_column :items, :color, :string
    add_column :items, :price, :decimal
    add_column :items, :gender, :string
  end
end
