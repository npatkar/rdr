# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mynewrdr_session',
  :secret      => 'f5c31f930ac5236cb01f0d2f640c3b14462aeebdf34f136bf16438b52f8b22c56afbf05e5fc9017a51445a8fe1ac4064dca199cd3298138c2cb9e64f21a96623'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
