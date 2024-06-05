json.extract! shop, :id, :shop_name, :description, :image
json.created_at format_timestamp(shop.created_at)
json.updated_at format_timestamp(shop.updated_at)

json.products shop.products do |product|
  json.partial! "products/product", product: product
end

json.user do
  json.extract! shop.user, :id, :first_name, :last_name, :email, :phone_number
end