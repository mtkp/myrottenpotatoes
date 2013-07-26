require 'spec_helper'

describe MoviesController do
  before :each do
    @fake_result = double('movie')
  end

  describe "showing a Movie object" do
    it "should call the model method that finds the Movie object by id" do
      Movie.should_receive(:find_by_id).with("42").and_return(@fake_result)
      get :show, { id: "42" }
    end
    it "should select the movie template for rendering" do
      Movie.stub(:find_by_id).and_return(@fake_result)
      get :show, { id: "42" }
      response.should render_template('show')
    end
    it "should redirect if a movie with the specified ID does not exist" do
      Movie.stub(:find_by_id).and_return(nil)
      get :show, { id: "42" }
      response.should redirect_to(movies_path)
    end
  end

  describe "searching TMDb" do
    before :each do
      @fake_results = [double('movie1'), double('movie2')]
    end
        it "should call the model method that performs TMDb search" do
      Movie.should_receive(:find_in_tmdb).with('hardware').
        and_return(@fake_results)
      post :search_tmdb, { search_terms: 'hardware' }
    end
    describe "after valid search" do
      before :each do
        Movie.stub(:find_in_tmdb).and_return(@fake_results)
        post :search_tmdb, { search_terms: 'hardware' }
      end
      it "should select the Search Results template for rendering" do
        response.should render_template('search_tmdb')
      end
      it "should make the TMDb search results available to that template" do
        assigns(:movies).should == @fake_results
      end
    end
  end

end