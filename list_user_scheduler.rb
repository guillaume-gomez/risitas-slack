require 'rubygems'
require 'sinatra'
require 'rufus/scheduler'

class ListUserScheduler < Sinatra::Base
  scheduler = Rufus::Scheduler.new

  scheduler.every '5s' do
      puts "task is running"
  end

end