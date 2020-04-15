require 'sinatra'

class App < Sinatra::Base
  set :environment, APP_ENV.to_sym
  set :root, File.join(APP_ROOT, 'app')
end
