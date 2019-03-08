# Rakefile

require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
require './app'
require './auth'

# Initialize the app and create the API (bot) and Auth objects.
run Rack::Cascade.new [RisitasSlack, Auth]