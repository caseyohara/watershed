require 'json'
require 'bundler'
Bundler.require

require './lib/parser'

class App < Sinatra::Base
  get '/' do
    ""
  end

  get '/favicon.ico' do
    ""
  end

  get '/lake_elevation.json' do
    content_type 'application/json'
    @parser = Parser.new
    @parser.lake_elevation.to_json
  end
end
