require 'dotenv/load'
require 'sinatra'
require 'slim'
require 'uri'
require 'httparty'
require 'byebug'

require_relative 'app/slack_authorizer'
require_relative 'app/jv_sticker'


def create_slack_client(slack_api_secret = ENV['SLACK_API_TOKEN'])
  Slack.configure do |config|
    config.token = slack_api_secret
    raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
  end
  Slack::Web::Client.new
end


use SlackAuthorizer

class RisitasSlack < Sinatra::Base

  post '/slack/command' do
    token = params["token"]
    
    channel_id = params["channel_id"]
    channel_name = params["channel_name"]
    team_id = params["team_id"]
    
    user_id = params["user_id"] 
    user_name = params["user_name"]
    
    text = params["text"]
    response_url = params["response_url"]
    result = JvSticker.find(text)
    puts "==================================="
    puts result.first
    puts "==================================="

    options  = {
      body: {
        "response_type": "in_channel",
        "text": result.first,
        "username": user_name
      }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    }
    HTTParty.post(response_url, options)
    ""
  end


end