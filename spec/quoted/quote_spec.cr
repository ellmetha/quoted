require "./spec_helper"

describe Quoted::Quote do
  describe "::new" do
    it "allows to initialize a quote by specifying all the quote attributes" do
      quote = Quoted::Quote.new(
        body: "All war is based on deception.",
        author: "Sun Tzu",
        large_image_url: "https://example.com/sun-tzu/1-large.jpg",
        medium_image_url: "https://example.com/sun-tzu/1-medium.jpg"
      )
      quote.body.should eq "All war is based on deception."
      quote.author.should eq "Sun Tzu"
      quote.large_image_url.should eq "https://example.com/sun-tzu/1-large.jpg"
      quote.medium_image_url.should eq "https://example.com/sun-tzu/1-medium.jpg"
    end
  end
end
