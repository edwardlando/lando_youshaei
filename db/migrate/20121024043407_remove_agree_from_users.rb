class RemoveAgreeFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :agree
  end
end
