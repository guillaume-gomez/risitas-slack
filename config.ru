require './auth'
require './app'

# require 'sinatra'
# require 'sinatra/activerecord'
# require 'sinatra/activerecord/rake'

# Initialize the app and create the API (bot) and Auth objects.
run Rack::Cascade.new [RisitasSlack, Auth]