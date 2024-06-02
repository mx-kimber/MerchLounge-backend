class DropProductListings < ActiveRecord::Migration[7.1]
  def change
    drop_table :product_listings
  end
end

