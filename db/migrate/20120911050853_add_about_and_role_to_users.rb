class AddAboutAndRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :text
    add_column :users, :role, :string
  end
end
