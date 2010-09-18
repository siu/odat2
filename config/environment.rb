# encoding: UTF-8
# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

if RUBY_VERSION >= '1.9'
  Encoding.default_internal = 'utf-8'
  Encoding.default_external = 'utf-8'
end

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]
  
  config.gem 'qoobaa-sqlite3-ruby',  :lib => 'sqlite3',  
                                     :source => 'http://gems.github.com'  
  config.gem "mocha"
  config.gem 'mislav-will_paginate', :version => '~> 2.3.7',  
                                     :lib => 'will_paginate',  
                                     :source => 'http://gems.github.com'  
  config.gem 'RedCloth'
  config.gem "locale"
  config.gem "locale_rails"
  config.gem "gettext"
  config.gem "gettext_activerecord"
  config.gem "gettext_rails"
  config.gem "prawn",                :version => '0.6.3'
  config.gem "prawn-format",         :lib => 'prawn/format'
  config.gem "SyslogLogger",         :lib => 'syslog_logger'
  config.gem "authlogic"

  config.gem "fastercsv"
  config.gem "comma",                :source => 'http://gems.github.com'  

  config.time_zone = 'UTC'
  config.i18n.default_locale = :es

  # The edition/release configuration of the app is located in config/initializers/odat.rb
end
