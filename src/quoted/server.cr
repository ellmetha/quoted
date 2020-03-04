module Quoted
  get "/" do
    quote = Quote.random # ameba:disable Lint/UselessAssign
    render "src/views/quote.ecr", "src/views/layouts/base.ecr"
  end
end
