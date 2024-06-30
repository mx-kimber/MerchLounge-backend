json.extract! product, :id, :product_name, :description, :price, :quantity, :user_id
json.created_at format_timestamp(product.created_at)
json.updated_at format_timestamp(product.updated_at)

json.shops product.shops.map { |shop| { id: shop.id, shop_name: shop.shop_name } }
