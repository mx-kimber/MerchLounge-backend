json.extract! user, :id, :first_name, :last_name, :email, :phone_number, :password_digest, :seller
json.created_at user.created_at.in_time_zone('Central Time (US & Canada)').strftime('%m-%d-%Y %I:%M %p %Z')
json.updated_at user.updated_at.in_time_zone('Central Time (US & Canada)').strftime('%m-%d-%Y %I:%M %p %Z')
