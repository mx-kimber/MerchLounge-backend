class AddCloudinaryToProductImages < ActiveRecord::Migration[7.1]
  def change
    add_column :product_images, :cloudinary_photo, :string
  end
end
