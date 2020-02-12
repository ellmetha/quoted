module Quoted
  class Quote
    property body : String
    property author : String
    property large_image_url : String
    property medium_image_url : String

    def self.random
      api_client = ApiClient::FavQs.new
      quote = api_client.qotd
      new(
        body: quote["quote"]["body"].as_s,
        author: quote["quote"]["author"].as_s,
        large_image_url: "https://example.com",
        medium_image_url: "https://example.com"
      )
    end

    def initialize(@body, @author, @large_image_url, @medium_image_url)
    end
  end
end
