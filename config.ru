require './auth'
require './app'
require './list_user_scheduler'

# Initialize the app and create the API (bot) and Auth objects.
run Rack::Cascade.new [RisitasSlack, ListUserScheduler, Auth]