class Changechannelpricetostring < ActiveRecord::Migration
def change
  	change_column :channels, :price, :string
  end
end
