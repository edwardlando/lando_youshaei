class RemoveAgreeToTermsFromOrder < ActiveRecord::Migration
  def change
  	remove_column :orders, :agree 
  end
end
