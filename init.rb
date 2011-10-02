# Run as a single script

def at_exit
	require "irb"
	require "drb/acl"
end

require 'rubygems'
require 'bundler/setup'

require 'thin'

unless defined?(Ocra)
	args = %w{start -e production}
	Thin::Runner.new(args).run!
end
