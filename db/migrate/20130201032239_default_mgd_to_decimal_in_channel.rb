class DefaultMgdToDecimalInChannel < ActiveRecord::Migration
  def change
  	change_column :channels, :mean_gene_distance, :decimal, :default => 8.94427
  end
end
