APP_ENV = ENV["APP_ENV"] ||= ENV["RACK_ENV"] ||= 'development' unless defined?(APP_ENV)

APP_ROOT = File.expand_path('..', __dir__) + '/'

$LOAD_PATH << APP_ROOT

require 'rubygems' unless defined?(Gem)

require 'bundler/setup'
require 'active_support'

paths = [
  'app/controllers',
  'config'
]

paths.each do |path|
  ActiveSupport::Dependencies.autoload_paths << File.join(APP_ROOT, path)
end
