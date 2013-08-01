require 'spec_helper'

describe Review do

  before :each do
    @movie = FactoryGirl.create(:movie)
    @moviegoer = FactoryGirl.create(:moviegoer)
    @review = Review.new(movie: @movie, moviegoer: @moviegoer,
    potatoes: "5" )
  end

  subject { @review }

  it { should respond_to :potatoes }
  it { should respond_to :movie }
  it { should respond_to :moviegoer }
  it { should respond_to :comments }

  it { should be_valid }

  describe "potatoes should be integers, between 1 and 5" do
    it "should be valid" do
      (1..5).each do |ranking|
        @review.potatoes = ranking
        @review.should be_valid
      end
    end
    it "should be invalid otherwise" do
      [0, 6, 10].each do |bad_ranking|
        @review.potatoes = bad_ranking
        @review.should_not be_valid
      end
    end
  end

end
