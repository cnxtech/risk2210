Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
           Rails.application.secrets.facebook['application_key'],
           Rails.application.secrets.facebook['application_secret'],
           scope: 'publish_stream,offline_access,email,user_location,user_about_me'
end

OmniAuth.config.logger = Rails.logger

if Rails.env.test?
  OmniAuth.config.test_mode = true
end

if Rails.env.production?
  OmniAuth.config.full_host = "https://risk2210.net"
end
