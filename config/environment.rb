# encoding: UTF-8
# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
#RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

if RUBY_VERSION >= '1.9'
  Encoding.default_internal = 'utf-8'
  Encoding.default_external = 'utf-8'
end

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # You have to specify the :lib option for libraries, where the Gem name (sqlite3-ruby) differs from the file itself (sqlite3)
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  #config.gem "sqlite3-ruby", :lib => "sqlite3"
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
  config.gem "prawn"
  config.gem "prawn-format",         :lib => "prawn/format"
  config.gem "SyslogLogger",         :lib => "syslog_logger"

  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  config.time_zone = 'UTC'

  # Localization can be found in config/initializers/localization.rb
  #config.i18n.default_locale = :es

  # The edition/release configuration of the app is located in config/initializers/odat.rb


  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # Please note that observers generated using script/generate observer need to have an _observer suffix
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  config.active_record.observers = :user_observer
end
