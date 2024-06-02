json.extract! product, :id, :product_name, :description, :price, :quantity
json.created_at product.created_at.in_time_zone('Central Time (US & Canada)').strftime('%m-%d-%Y %I:%M %p %Z')
json.updated_at product.updated_at.in_time_zone('Central Time (US & Canada)').strftime('%m-%d-%Y %I:%M %p %Z')

# json.url product_url(product, format: :json)
