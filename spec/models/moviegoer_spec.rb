require 'spec_helper'

describe Moviegoer do
  describe "instance" do
    before { @moviegoer = Moviegoer.new(name: "Harry Potter", uid: "001100",
      provider: "twitter", ) }

    subject { @moviegoer }

    it { should respond_to :name }
    it { should respond_to :uid }
    it { should respond_to :provider }
    it { should respond_to :reviews }
    it { should respond_to :movies }

    it { should be_valid }
  end
  describe "it should have the class method" do
    it "find_or_create_from_auth_hash" do
      Moviegoer.should respond_to :find_or_create_from_auth_hash
    end
  end

  describe "the find_or_create_from_auth_hash method" do
    before :each do
      @auth_hash = { provider: "abc", uid: "0123", info: { name: "bob" } }
      @moviegoer = FactoryGirl.create(:moviegoer)
      @moviegoer_auth_hash = { provider: @moviegoer[:provider],
                               uid: @moviegoer[:uid],
                               info: { name: @moviegoer[:name] } }
    end
    it "should call the find or create by! method for Moviegoer model" do
      Moviegoer.should_receive(:find_or_create_by!).and_return(@moviegoer)
      Moviegoer.find_or_create_from_auth_hash(@auth_hash)
    end
    it "should get the moviegoer if that moviegoer already exists" do
      result = Moviegoer.find_or_create_from_auth_hash(@moviegoer_auth_hash)
      result.should == @moviegoer
    end
  end
end
