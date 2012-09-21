class MakeItemWishlistJoinTable < ActiveRecord::Migration
  def change
  	create_table :items_wishlists, :id => false do |t|
  	t.references :item, :wishlist
  end

  add_index :items_wishlists, [:item_id, :wishlist_id]
  end
end
