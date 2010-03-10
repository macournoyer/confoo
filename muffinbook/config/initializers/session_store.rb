# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_muffinbook_session',
  :secret      => 'dc3f2a6151a798cb1befbb5084af221db3d9f0369e6910e5be85dc8ef08b964a145b2b6b2bb7008660ac47ccf36c2b505f41ff33ad5662e7d8e71f032012a838'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
