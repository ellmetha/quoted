require "./spec_helper"

describe Quoted::Settings do
  it "provides access to the configured settings" do
    settings = Quoted.settings
    settings.public_folder.should eq "./static"
  end
end
