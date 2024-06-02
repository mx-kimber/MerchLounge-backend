json.extract! shop, :id, :user_id, :shop_name, :description, :image
json.created_at shop.created_at.in_time_zone('Central Time (US & Canada)').strftime('%m-%d-%Y %I:%M %p %Z')
json.updated_at shop.updated_at.in_time_zone('Central Time (US & Canada)').strftime('%m-%d-%Y %I:%M %p %Z')