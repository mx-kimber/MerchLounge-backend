json.extract! user, :id, :first_name, :last_name, :email, :phone_number, :password_digest, :seller
json.created_at format_timestamp(user.created_at)
json.updated_at format_timestamp(user.updated_at)

json.shops user.shops do |shop|
  json.extract! shop, :id, :shop_name, :description, :image, :user_id, :created_at, :updated_at
  json.created_at format_timestamp(shop.created_at)
  json.updated_at format_timestamp(shop.updated_at)
end