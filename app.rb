require 'dotenv/load'
require 'sinatra'
require 'slim'
require 'byebug'
require 'slack-ruby-client'

require_relative 'app/jv_sticker'


def create_slack_client(slack_api_secret = ENV['SLACK_API_TOKEN'])
  Slack.configure do |config|
    config.token = slack_api_secret
    raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
  end
  Slack::Web::Client.new
end

def format_message(channel_id, risitas_url)
  text = "Est ce le risitas que tu voulais ?\n #{risitas_url}"
  attachments = [
    {
          "fallback": "You are unable to choose a game",
          "callback_id": "wopr_game",
          "color": "#3AA3E3",
          "attachment_type": "default",
          "actions": [
              {
                  "name": "previous",
                  "text": "Precedent",
                  "type": "button",
                  "value": "previous"
              },
              {
                  "name": "choose",
                  "text": "On prend celui la !",
                  "type": "button",
                  "value": "choose"
              },
              {
                  "name": "next",
                  "text": "Suivant",
                  "type": "button",
                  "value": "next"
              }
          ]
      }
  ]
  { text: text, attachments: attachments, channel: channel_id }
end


class RisitasSlack < Sinatra::Base

  def initialize(app = nil)
    super(app)
    @client = create_slack_client();
    @client.auth_test
    @last_search = nil
    @last_results  = []
  end

  post '/slack/command' do
    token = params["token"]
    
    channel_id = params["channel_id"]
    
    user_id = params["user_id"] 
    user_name = params["user_name"]
    
    text = params["text"]
    response_url = params["response_url"]
    risitas_url = JvSticker.find(text)
    puts "==================================="
    puts risitas_url.first
    puts "==================================="
    @client.chat_postMessage(format_message(channel_id, risitas_url.first))
    ""
  end

  post '/actions' do

  end


end