class AddUserIdToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :user_id, :bigint
  end
end
