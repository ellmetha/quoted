require "./spec_helper"

describe Quoted::ApiClient::FavQs do
  describe "#qotd" do
    it "returns the parsed response payload when everything went fine" do
      WebMock.stub(:get, "https://favqs.com/api/qotd")
        .to_return(status: 200, body: %{{"foo": "bar"}})
      api_client = Quoted::ApiClient::FavQs.new
      api_client.qotd.should eq({"foo" => "bar"})
    end
  end
end
