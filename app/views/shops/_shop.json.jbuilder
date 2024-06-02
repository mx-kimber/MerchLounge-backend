json.extract! shop, :id, :shop_name, :description, :image, :created_at, :updated_at
json.created_at shop.created_at.in_time_zone('Central Time (US & Canada)').strftime('%m-%d-%Y %I:%M %p %Z')
json.updated_at shop.updated_at.in_time_zone('Central Time (US & Canada)').strftime('%m-%d-%Y %I:%M %p %Z')

json.user do
  json.extract! shop.user, :id, :first_name, :last_name, :email, :phone_number, :created_at, :updated_at
end
