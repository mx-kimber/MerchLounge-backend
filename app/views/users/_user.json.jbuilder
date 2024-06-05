json.extract! user, :id, :first_name, :last_name, :email, :phone_number, :password_digest, :seller
json.created_at format_timestamp(user.created_at)
json.updated_at format_timestamp(user.updated_at)

json.shops user.shops do |shop|
  json.extract! shop, :id, :shop_name, :description, :image, :user_id
  json.created_at format_timestamp(shop.created_at)
  json.updated_at format_timestamp(shop.updated_at)
end

json.products user.products do |product|
  json.extract! product, :id, :product_name, :description, :price
  json.created_at format_timestamp(product.created_at)
  json.updated_at format_timestamp(product.updated_at)
end