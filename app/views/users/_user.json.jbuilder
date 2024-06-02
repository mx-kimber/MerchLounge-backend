json.extract! user, :id, :first_name, :last_name, :email, :phone_number, :password_digest, :seller
json.created_at user.created_at.in_time_zone('Central Time (US & Canada)').strftime('%m-%d-%Y %I:%M %p %Z')
json.updated_at user.updated_at.in_time_zone('Central Time (US & Canada)').strftime('%m-%d-%Y %I:%M %p %Z')


json.shops user.shops do |shop|
  json.id shop.id
  json.shop_name shop.shop_name
  json.description shop.description
  json.image shop.image
  json.user_id shop.user_id
  json.created_at shop.created_at.in_time_zone('Central Time (US & Canada)').strftime('%m-%d-%Y %I:%M %p %Z')
  json.updated_at shop.updated_at.in_time_zone('Central Time (US & Canada)').strftime('%m-%d-%Y %I:%M %p %Z')
end
