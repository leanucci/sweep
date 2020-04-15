#!/usr/bin/env rackup

require File.join(File.dirname(__FILE__), 'config', 'boot')
require 'config/app'

map '/' do
  run Api::BaseApp.new
end
