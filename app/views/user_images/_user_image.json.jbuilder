json.extract! user_image, :id, :picture, :user_id, :created_at, :updated_at
json.url user_image_url(user_image, format: :json)
