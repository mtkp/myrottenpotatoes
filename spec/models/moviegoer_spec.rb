require 'spec_helper'

describe Moviegoer do
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
