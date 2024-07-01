json.array! @products do |product|
  json.extract! product, :id, :created_at, :updated_at
  json.url product_url(product, format: :json)
  json.product_name product.product_name
  json.product_images product.product_images do |product_image|
    json.extract! product_image, :id, :image_url, :created_at, :updated_at
  end
end
