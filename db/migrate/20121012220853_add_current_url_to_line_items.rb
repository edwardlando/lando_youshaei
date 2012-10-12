class AddCurrentUrlToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :current_url, :string
  end
end
