class RemoveProductIdFromShops < ActiveRecord::Migration[7.0]
  def change
    remove_reference :shops, :product, foreign_key: true
  end
end
