require "./spec_helper"

describe Quoted::ApiClient::Pixabay do
  describe "#search" do
    it "returns the parsed response payload when everything went fine" do
      WebMock.stub(:get, "https://pixabay.com/api/?q=nature&key=#{Quoted.secrets.pixabay_api_key}")
        .to_return(status: 200, body: %{{"foo": "bar"}})
      api_client = Quoted::ApiClient::Pixabay.new
      api_client.search(q: "nature").should eq({"foo" => "bar"})
    end

    it "raises an UnexpectedResponseError if the response is not a 200 OK" do
      WebMock.stub(:get, "https://pixabay.com/api/?q=nature&key=#{Quoted.secrets.pixabay_api_key}")
        .to_return(status: 500, body: "This is bad")
      api_client = Quoted::ApiClient::Pixabay.new
      expect_raises(Quoted::ApiClient::Pixabay::UnexpectedResponseError) do
        api_client.search(q: "nature")
      end
    end
  end
end
