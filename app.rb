require 'dotenv/load'
require 'sinatra'
require 'slim'
require 'byebug'
require 'slack-ruby-client'

require_relative 'app/jv_sticker'

def format_message(channel_id, risitas_url)
  pretext = "Est ce le risitas que tu voulais ?\n #{risitas_url}"
  attachments = [{
    callback_id: 'select_risitas',
    actions: [
      {
        name: 'select_risitas',
        text: 'Previous',
        value: 'previous',
        type: 'button',
        style: 'primary',
      },
      {
        name: 'select_risitas',
        text: 'Choose',
        value: 'choose',
        type: 'button',
        style: 'danger',
      },
      {
        name: 'select_risitas',
        text: 'Next',
        value: 'next',
        type: 'button',
        style: 'danger',
      },
    ],
  }
    ]
  { pretext: pretext, attachments: attachments, channel: channel_id }
end


class RisitasSlack < Sinatra::Base

  def initialize(app = nil)
    super(app)
    @last_search = nil
    @last_results  = []
  end

  post '/slack/commands' do
    team_id = params["team_id"]
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
    $teams[team_id]['client'].chat_postMessage(format_message(channel_id, risitas_url.first))
    ""
  end

  post '/slack/after_button' do
    payload = JSON.parse(params["payload"])
    channel_id = payload["channel"]["id"]
    ts = payload["message_ts"]
    team_id = payload["team"]["id"]
    action = payload["actions"].first
    action_name = action["name"]
    action_value = action["value"]
    $teams[team_id]['client'].chat_update(attachments: [], text: "coucou", channel: channel_id, ts: ts )
    ""
  end

end