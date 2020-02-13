require "./spec_helper"

describe Quoted::Env do
  describe "#<env_name>?" do
    it "returns true if <env_name> corresponds to the current KEMAL_ENV env var" do
      Quoted::Env.new.test?.should be_true
    end

    it "returns false if <env_name> don't correspond to the current KEMAL_ENV env var" do
      Quoted::Env.new.dummy?.should be_false
    end
  end

  describe "#==" do
    it "returns true if the value corresponds to the current KEMAL_ENV env var" do
      (Quoted::Env.new == "test").should be_true
    end

    it "returns false if the value don't correspond to the current KEMAL_ENV env var" do
      (Quoted::Env.new == "dummy").should be_false
    end
  end

  describe "#id" do
    it "returns the environment identifier" do
      Quoted::Env.new.id.should eq "test"
    end
  end
end
