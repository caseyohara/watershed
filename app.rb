require 'json'
require 'bundler'
Bundler.require

require './lib/parser'

class App < Sinatra::Base
  before do
    content_type 'application/json'
    @parser = Parser.new
  end

  get '/lake_elevation.json' do
    @parser.lake_elevation.to_json
  end
end
