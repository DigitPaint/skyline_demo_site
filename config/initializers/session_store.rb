# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_skyline_demo_session',
  :secret      => '1f13ba703acd675ab71cf9b6b8458972f5645733f9682686ad314747b2d8da2f8ca409c4fa3a196e731f7892eb2f258ed10a740ddb93b4634cee015f1e09030e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
