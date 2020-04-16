# frozen_string_literal: true

require 'sinatra'

module Api
  class BaseApp < ::Sinatra::Base
    get '/' do
      'welcome'
    end
  end
end
