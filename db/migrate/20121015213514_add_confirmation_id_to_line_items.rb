class AddConfirmationIdToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :confirmation_id, :integer
  end
end
