require "./spec_helper"

describe Quoted::ApiClient::FavQs do
  describe "#qotd" do
    it "returns the parsed response payload when everything went fine" do
      WebMock.stub(:get, "https://favqs.com/api/qotd")
        .to_return(status: 200, body: %{{"foo": "bar"}})
      api_client = Quoted::ApiClient::FavQs.new
      api_client.qotd.should eq({"foo" => "bar"})
    end

    it "raises an UnexpectedResponseError if the response is not a 200 OK" do
      WebMock.stub(:get, "https://favqs.com/api/qotd")
        .to_return(status: 500, body: "This is bad")
      api_client = Quoted::ApiClient::FavQs.new
      expect_raises(Quoted::ApiClient::FavQs::UnexpectedResponseError) do
        api_client.qotd
      end
    end
  end
end
