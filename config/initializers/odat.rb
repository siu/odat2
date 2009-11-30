require 'action_controller/request'

ODAT_HOST = 'http://localhost:3000'
#ActionController::Base.relative_url_root = '/es'
SESSION_SECRET = 'set_this_Secret-fef90b74968219df44040ebce2a0f37e'

# Restful authentication
REST_AUTH_SITE_KEY         = 'change_this_secret-asfdsakjdfhksaudhiu293urg293rgfbds'
REST_AUTH_DIGEST_STRETCHES = 10

AVAILABLE_LANGUAGES = { 'Español' => "#{ODAT_HOST}/es", 
                        'Português' => "#{ODAT_HOST}/pt", 
                        'العربية' => "#{ODAT_HOST}/ar"}

I18n.default_locale = :es
I18n.locale = :es

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
#ActionController::Base.session_store = :active_record_store

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {  
  :key => "_odat_#{I18n.locale.language}_session",
  :secret => SESSION_SECRET
}
