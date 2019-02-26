require './auth'
require './app'

# Initialize the app and create the API (bot) and Auth objects.
run Rack::Cascade.new [RisitasSlack, Auth]