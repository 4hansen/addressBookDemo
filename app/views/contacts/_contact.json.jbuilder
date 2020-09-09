json.extract! contact, :id, :first_name, :last_name, :primary_phone, :email, :user_id, :created_at, :updated_at
json.url contact_url(contact, format: :json)
