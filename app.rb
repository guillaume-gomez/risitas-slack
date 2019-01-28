require 'dotenv/load'
require 'sinatra'
require 'slim'
require 'uri'
require 'httparty'
require 'byebug'

require_relative 'app/slack_authorizer'
require_relative 'app/jv_sticker'

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