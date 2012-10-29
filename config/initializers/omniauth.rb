Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '224904694230973', 'da9ccaaa03e6e08809e6380da10cb832', scope: 'publish_stream,offline_access,email,user_location,user_about_me'
end

if Rails.env.test?
  OmniAuth.config.test_mode = true
end
