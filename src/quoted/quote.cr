module Quoted
  class Quote
    property body : String
    property author : String
    property large_image_url : String
    property medium_image_url : String

    def initialize(@body, @author, @large_image_url, @medium_image_url)
    end
  end
end
