# Run as a single script

def at_exit
	require "irb"
	require "drb/acl"
	require "sqlite3"
	require 'rubygems/gem_runner'
end

ENV['RAILS_ENV'] = 'production'
load("script/server", false)
