class AddGenesSeenAndMeanGeneDistanceToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :genes, :string
    add_column :channels, :seen, :boolean
    add_column :channels, :mean_gene_distance, :decimal
  end
end
