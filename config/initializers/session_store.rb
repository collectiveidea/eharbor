# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_training-eharbor_session',
  :secret      => '20dd20e2de54a21fa0b35e1b356930e5e5802c813065a3c1d65b9490fbaaac1567878308809d1ebf1825095ec05074a4e8871f1bc399fbc8b57ae00fdbcba1a8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
