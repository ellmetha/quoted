require "kemal"

module Quoted
  get "/" do
    render "src/views/quote.ecr"
  end
end
