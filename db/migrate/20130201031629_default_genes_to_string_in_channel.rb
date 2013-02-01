class DefaultGenesToStringInChannel < ActiveRecord::Migration

	def change
		genes = "2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5,2.5"
    	change_column :channels, :genes, :text, :default => genes

    end
end
