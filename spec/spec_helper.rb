APP_ENV = 'test'

require_relative '../config/boot'

require 'rspec'
require 'rack/test'

module RSpecMixin
  include Rack::Test::Methods

  def app
    described_class
  end
end

RSpec.configure do |c|
  c.include RSpecMixin
end
