require "./spec_helper"

describe Quoted do
  it "renders / with a random quote" do
    WebMock.stub(:get, "https://favqs.com/api/qotd")
      .to_return(status: 200, body: fav_qs_qotd_response.to_json)
    WebMock.stub(
      :get,
      "https://pixabay.com/api/?q=great&min_width=2000&min_height=1100" \
      "&key=#{Quoted.secrets.pixabay_api_key}"
    )
      .to_return(status: 200, body: pixabay_search_response.to_json)

    get "/"
    response.status_code.should eq 200
    response.headers["Content-Type"].should eq "text/html"
    response.body.should contain fav_qs_qotd_response["quote"]["body"]
    response.body.should contain fav_qs_qotd_response["quote"]["author"]
  end
end

def fav_qs_qotd_response
  {
    qotd_date: "2020-02-17T00:00:00.000+00:00",
    quote: {
      id: 42,
      tags: ["great", "peace", "time", "war"],
      url: "https://favqs.com/quotes/theodore-roosevelt/29154-if-there-is-n-",
      author: "Theodore Roosevelt",
      body: "If there is not the war...",
    },
  }
end

def pixabay_search_response
  {
    total: 2,
    hits: [
      {
        webformatURL: "https://example.com/image/1/medium.jpg",
        largeImageURL: "https://example.com/image/1/large.jpg",
      },
    ],
  }
end
