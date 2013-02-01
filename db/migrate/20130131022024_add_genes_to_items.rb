class AddGenesToItems < ActiveRecord::Migration
  def change
    add_column :items, :genes, :string
  end
end
