# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_training-eharbor_session',
  :secret      => '10a34d1506dfc250e679cca398271ef16c4bea0b044b1a6627168945b83ff7e0c121b22763221a611ad593d01698bce530aff4cc455aeeca9689165687f576ec'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
