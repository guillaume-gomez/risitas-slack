require 'rubygems'
require 'sinatra'
require 'rufus/scheduler'

class ListUserScheduler < Sinatra::Base
  scheduler = Rufus::Scheduler.new

  # scheduler.every '5s' do
  #     puts "task is running"
  # end

  scheduler.every '5s' do
    slack_client = SlackClient.new
    SlackUser.list_and_save_user(slack_client.default_client())
  end

end