class CreateProductListings < ActiveRecord::Migration[7.1]
  def change
    create_table :product_listings do |t|
      t.references :shop, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
