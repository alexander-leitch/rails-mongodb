# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  config.mailer_sender = 'alex@openstyle.co.za.co.za'
  require 'devise/orm/mongoid'
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  
  config.omniauth :digitalocean, "4f828012e9a44571a0ee57855625c0fac3388b5099635d38fe2af35d01f29331", "b86d7bbbc8f3dac43875df9ae3111df0b50fbe162f53870f40f7b1cc6086e2a3"
  config.omniauth :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
end
