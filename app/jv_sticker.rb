require 'uri'
require 'httparty'

class JvSticker
  include HTTParty

  base_uri "https://jvsticker.com"

  attr_accessor :search, :results

  def initialize(search, results)
    self.search = search
    self.results = results
  end

  def self.find(search)
    response = get("/search?query=#{URI::encode(search)}")
    if response.success?
      debugger
      urls = response.body.scan(/data-id=(\S*)/).flatten
      full_urls = []
      urls.each do |url|
        url_end = JSON.parse(url)
        full_urls << "https://i.jvsticker.com/" + url_end
      end
      self.new(search, full_urls)
      full_urls
    else
      # this just raises the net/http response that was raised
      []
    end
  end
end