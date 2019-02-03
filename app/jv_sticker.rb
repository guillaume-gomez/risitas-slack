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
    response = get("/search?query=#{search}")
    if response.success?
      urls = response.body.scan(/data-url-end=(\S*)/).flatten
      full_urls = []
      urls.each do |url|
        url_end = JSON.parse(url)
        full_urls << "https://image.noelshack.com/fichiers/" + url_end
      end
      self.new(search, full_urls)
      full_urls
    else
      # this just raises the net/http response that was raised
      raise response.response
    end
  end
end