require "./spec_helper"

describe Quoted::Quote do
  describe "::new" do
    it "allows to initialize a quote by specifying all the quote attributes" do
      quote = Quoted::Quote.new(
        body: "All war is based on deception.",
        author: "Sun Tzu",
        large_image_url: "https://example.com/sun-tzu/1-large.jpg",
        medium_image_url: "https://example.com/sun-tzu/1-medium.jpg",
        tag: "war"
      )
      quote.body.should eq "All war is based on deception."
      quote.author.should eq "Sun Tzu"
      quote.large_image_url.should eq "https://example.com/sun-tzu/1-large.jpg"
      quote.medium_image_url.should eq "https://example.com/sun-tzu/1-medium.jpg"
      quote.tag.should eq "war"
    end
  end

  describe "::random" do
    it "allows to generate a random quote from FavQs and Pixabay query responses" do
      WebMock.stub(:get, "https://favqs.com/api/qotd")
        .to_return(status: 200, body: fav_qs_qotd_response.to_json)
      WebMock.stub(
        :get,
        "https://pixabay.com/api/?q=great&min_width=2000&min_height=1100" \
        "&key=#{Quoted.secrets.pixabay_api_key}"
      )
        .to_return(status: 200, body: pixabay_search_response.to_json)

      quote = Quoted::Quote.random
      quote.body.should eq "If there is not the war..."
      quote.author.should eq "Theodore Roosevelt"
      quote.large_image_url.should eq "https://example.com/image/1/large.jpg"
      quote.medium_image_url.should eq "https://example.com/image/1/medium.jpg"
      quote.tag.should eq "great"
    end

    it "reuses images that were already fetches for a given tag" do
      Quoted.cache.set("images-dummy", pixabay_search_response.to_json, 60 * 10)
      WebMock.stub(:get, "https://favqs.com/api/qotd")
        .to_return(status: 200, body: fav_qs_qotd_response(tags: ["dummy"]).to_json)

      quote = Quoted::Quote.random
      quote.body.should eq "If there is not the war..."
      quote.author.should eq "Theodore Roosevelt"
      quote.large_image_url.should eq "https://example.com/image/1/large.jpg"
      quote.medium_image_url.should eq "https://example.com/image/1/medium.jpg"
      quote.tag.should eq "dummy"
    end

    it "fallbaks to a default image search keyword if the quote has no tags defined" do
      WebMock.stub(:get, "https://favqs.com/api/qotd")
        .to_return(status: 200, body: fav_qs_qotd_response(tags: [] of String).to_json)
      WebMock.stub(
        :get,
        "https://pixabay.com/api/?q=quote&min_width=2000&min_height=1100" \
        "&key=#{Quoted.secrets.pixabay_api_key}"
      )
        .to_return(status: 200, body: pixabay_search_response.to_json)

      quote = Quoted::Quote.random
      quote.body.should eq "If there is not the war..."
      quote.author.should eq "Theodore Roosevelt"
      quote.large_image_url.should eq "https://example.com/image/1/large.jpg"
      quote.medium_image_url.should eq "https://example.com/image/1/medium.jpg"
      quote.tag.should eq "quote"
    end
  end
end
