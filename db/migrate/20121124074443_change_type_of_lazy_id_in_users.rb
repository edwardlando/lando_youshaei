class ChangeTypeOfLazyIdInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :lazy_id, :string, :null => true
  end
end
