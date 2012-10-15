class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.string :name
      t.text :address
      t.integer :user_id
      t.decimal :total

      t.timestamps
    end
  end
end
