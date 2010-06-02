# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Enable threaded mode
# config.threadsafe!

# Use a different logger for distributed setups
config.after_initialize do
  require 'syslog_logger'
  LOGGER_FILE = "odat_#{I18n.locale.language}_#{RAILS_ENV}"
  RAILS_DEFAULT_LOGGER = SyslogLogger.new(LOGGER_FILE)
  ActiveRecord::Base.logger = RAILS_DEFAULT_LOGGER
  ActionController::Base.logger = RAILS_DEFAULT_LOGGER
end

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true

# Use a different cache store in production
# config.cache_store = :mem_cache_store

#ActionController::Base.session_store = :active_record_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false
