require "./spec_helper"

describe Quoted::Secrets do
  it "provides access to the configured secrets" do
    secrets = Quoted.secrets
    secrets.pixabay_api_key.should eq "notset"
  end
end
