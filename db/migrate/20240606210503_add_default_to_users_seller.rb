class AddDefaultToUsersSeller < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :seller, false
  end
end
