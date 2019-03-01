require 'sinatra'
require 'slim'
require 'byebug'
require 'slack-ruby-client'

require_relative 'app/jv_sticker'
# todo only show message from the user before choosed
def format_message(channel_id, risitas_url, choosed = false ,ts = nil)
  actions = !choosed ?
    [
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
      },
      {
        name: 'select_risitas',
        text: 'Next',
        value: 'next',
        type: 'button',
        style: 'danger',
      },
    ] :
    []

  pretext = !choosed ? "Est ce le risitas que tu voulais ?\n" : ""

  attachments = [{
    pretext: pretext,
    image_url: risitas_url,
    callback_id: 'select_risitas',
    actions: actions
  }]

  { attachments: attachments, channel: channel_id, ts: ts }
end


class RisitasSlack < Sinatra::Base

  def initialize(app = nil)
    super(app)
    $last_search = nil
    $last_results  = []
    $current_index = 0
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
    
    $last_results = risitas_url
    $last_search = text
    $current_index = 0

    puts "==================================="
    puts $last_results[$current_index]
    puts "==================================="
    $teams[team_id]['client'].chat_postMessage(format_message(channel_id, $last_results[$current_index]))
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

    choosed = false
    if action_value == "previous"
      $current_index = $current_index - 1
    elsif action_value == "choose"
      $current_index = $current_index
      choosed = true
    elsif action_value == "next"
      $current_index = $current_index + 1
    end

    puts "==================================="
    puts $last_results[$current_index]
    puts "==================================="

    $teams[team_id]['client'].chat_update(format_message(channel_id, $last_results[$current_index], choosed ,ts))
    ""
  end

end