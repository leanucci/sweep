# frozen_string_literal: true

require 'sinatra'

module Api
  class BaseApp < ::Sinatra::Base
    set :games, {}

    get '/' do
      'welcome'
    end

    post '/games' do
      content_type 'application/json'
      @game = Game.new
      settings.games[@game.id] = @game
      @game.to_json
    end

    get '/games/:id' do
      content_type 'application/json'
      settings.games[params[:id]].to_json
    end
    
    put '/games/:id' do
      content_type 'application/json'
      return 404 unless @game = settings.games[params[:id]]
      return 400 unless params.slice(:row, :col).size == 2

      @game.reveal(params[:row].to_i, params[:col].to_i)

      @game.to_json
    end
  end
end
