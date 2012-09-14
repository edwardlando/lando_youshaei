class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :color
      t.string :style
      t.decimal :price
      t.string :gender

      t.timestamps
    end
  end
end
