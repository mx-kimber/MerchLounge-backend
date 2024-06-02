json.extract! shop, :id, :shop_name, :description, :image
json.created_at format_timestamp(shop.created_at)
json.updated_at format_timestamp(shop.updated_at)


json.user do
  json.extract! shop.user, :id, :first_name, :last_name, :email, :phone_number
  json.created_at format_timestamp(shop.user.created_at)
  json.updated_at format_timestamp(shop.user.updated_at)
end
