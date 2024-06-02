class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.decimal "price", precision: 8, scale: 2
      t.text :description
      t.integer :quantity

      t.timestamps
    end
  end
end
