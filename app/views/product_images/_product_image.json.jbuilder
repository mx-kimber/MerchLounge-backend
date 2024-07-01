json.array! @product_images do |product_image|
  json.extract! product_image, :id, :image_url, :created_at, :updated_at
  json.product_name product_image.product.product_name
  # json.url product_image_url(product_image, format: :json)
end

