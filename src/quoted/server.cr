require "kemal"

module Quoted
  get "/" do
    render "src/views/quote.ecr", "src/views/layouts/base.ecr"
  end
end
