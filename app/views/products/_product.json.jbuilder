json.extract! product, :id, :product_name, :description, :price, :quantity
json.created_at format_timestamp(product.created_at)
json.updated_at format_timestamp(product.updated_at)
