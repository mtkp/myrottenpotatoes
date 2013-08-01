require 'spec_helper'

describe ReviewsController do
  before :each do
    @movie = FactoryGirl.create(:movie)
    @moviegoer = FactoryGirl.create(:moviegoer)
    @review = FactoryGirl.create(:review, movie: @movie, moviegoer: @moviegoer)
    @review_attr = FactoryGirl.attributes_for(:review)
  end
  
  describe "filter reviews - require a logged in user" do
    it "should filter on any action (for example, new)" do
      Moviegoer.stub(:find_by_id).and_return nil # no users should be retrieved
      get :new, movie_id: @movie
      response.should redirect_to login_path
    end
  end
  describe "filter reviews - require a valid movie" do
    it "should filter on any action (for example, new)" do
      Moviegoer.stub(:find_by_id).and_return @moviegoer
      Movie.stub(:find_by_id).and_return nil
      get :new, movie_id: @movie
      response.should redirect_to movies_path
    end
  end
  describe "making a new review" do
    it "should make a new Review object" do
      Moviegoer.stub(:find_by_id).and_return @moviegoer
      Review.should_receive(:new)
      get :new, movie_id: @movie      
    end
  end
  describe "creating a review" do
    it "should build a new Review object and append it to the current user" do
      Moviegoer.stub(:find_by_id).and_return @moviegoer
      Movie.stub(:new).and_return @review
      post :create, movie_id: @movie, review: @review_attr
      @moviegoer.reviews.should include(@review)
    end
    it "should redirect to the movie" do
      Moviegoer.stub(:find_by_id).and_return @moviegoer
      post :create, movie_id: @movie, review: @review_attr
      response.should redirect_to @movie
    end
  end


end
