require "spec_helper"

describe TwitterClient do

  describe ".global" do
    after :each do
      # undo caching
      described_class.instance_variable_set("@global", nil)
    end

    it "should return a Twitter::Client object" do
      described_class.global.should be_a Twitter::Client
    end

    it "should raise an exception if the config/twitter-oauth.yml file does not exist" do
      described_class.instance_variable_set("@global", nil)
      File.stub(:exist?).and_return(false)
      expect { described_class.global }.to raise_exception
    end
  end

  describe ".for_user" do
    let(:user) { mock(:consumer_key => "A", :consumer_secret => "B", :access_token => "C", :access_secret => "D") }

    it "should return a Twitter::Client object" do
      described_class.for_user(user).should be_a Twitter::Client
    end
  end
end
