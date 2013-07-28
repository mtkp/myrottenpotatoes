require 'spec_helper'
require 'helpers/param_helper'

describe MoviesController do
  before :each do
    @movie = FactoryGirl.create(:movie)
  end

  describe "making a new Movie object" do
    it "should render the new movie template form" do
      get :new
      response.should render_template 'new'
    end
    describe "and then submitting it to be created" do
      before :each do
        @movie_attributes = FactoryGirl.attributes_for(:movie)
      end
      it "should call the Movie Model method new" do
        Movie.should_receive(:new)
        post :create, movie: @movie_attributes
      end

    end
  end

  describe "showing a Movie object" do
    it "should call the model method that finds the Movie object by id" do
      Movie.should_receive(:find_by_id).with("#{@movie.id}").and_return(@movie)
      get :show, id: @movie.id
    end
    it "should select the show movie template for rendering" do
      Movie.stub(:find_by_id).and_return(@movie)
      get :show, id: @movie.id
      response.should render_template('show')
    end
    it "should redirect if a movie with the specified ID does not exist" do
      Movie.stub(:find_by_id).and_return(nil)
      get :show, id: @movie.id
      response.should redirect_to movies_path
    end

    describe "and then editing that object" do
      it "should call the model method that finds the Movie object by id" do
        Movie.should_receive(:find_by_id).with("#{@movie.id}").and_return(@movie)
        get :edit, id: @movie.id
      end
      it "should select the edit movie template for rendering" do
        Movie.stub(:find_by_id).and_return(@movie)
        get :edit, id: @movie.id
        response.should render_template('edit')
      end
      it "should redirect if a movie with the specified ID does not exist" do
        Movie.stub(:find_by_id).and_return(nil)
        get :edit, id: @movie.id
        response.should redirect_to movies_path
      end

      describe "and then updating the object just edited" do
        before (:each) do
          @movie_attributes = FactoryGirl.attributes_for(:movie)
        end
        it "should call the model method that finds the Movie object by id" do
          Movie.should_receive(:find_by_id).with("#{@movie.id}").and_return(@movie)
          patch :update, id: @movie, movie: @movie_attributes
        end
        it "should call the model method that updates the Movie object" do
          Movie.stub(:find_by_id).and_return(@movie)
          Movie.any_instance.should_receive(:update_attributes)
          patch :update, id: @movie, movie: @movie_attributes
        end

        it "should select the show movie template for rendering" do
          Movie.stub(:find_by_id).and_return(@movie)
          patch :update, id: @movie, movie: @movie_attributes
          response.should redirect_to movie_path(@movie)
        end
        it "should redirect if a movie with the specified ID does not exist" do
          Movie.stub(:find_by_id).and_return(nil)
          patch :update, id: @movie, movie: @movie_attributes
          response.should redirect_to(movies_path)
        end
        it "should render edit if the update attr failed" do
          Movie.any_instance.stub(:update_attributes).and_return false
          patch :update, id: @movie, movie: @movie_attributes
          response.should render_template 'edit'
        end
      end
    end

    describe "and then deleting that Movie" do
      it "should call the model method that finds the Movie object by id" do
        Movie.should_receive(:find_by_id).with("#{@movie.id}").and_return(@movie)
        delete :destroy, id: @movie.id
      end
      describe "successfully" do
        before :each do
          Movie.stub(:find_by_id).and_return(@movie)          
        end
        it "should remove the movie from the model" do
          expect { delete :destroy, id: @movie.id }.to change(Movie, :count).by(-1)
        end
        it "should redirect to the movies index" do
          delete :destroy, id: @movie.id
          response.should redirect_to movies_path
        end
      end
      it "should redirect if a movie with the specified ID does not exist" do
          Movie.stub(:find_by_id).and_return(nil)
          delete :destroy, id: @movie.id
          response.should redirect_to(movies_path)
        end
    end
  end

  describe "searching TMDb" do
    before :each do
      @fake_results = [double('movie1'), double('movie2')]
    end

    it "should call the model method that performs TMDb search" do
      Movie.should_receive(:find_in_tmdb).with('hardware').
        and_return(@fake_results)
      post :search_tmdb, search_terms: 'hardware'
    end

    it "should redirect to the index page if the api key is invalid" do
      Movie.stub(:find_in_tmdb).and_raise(Movie::InvalidKeyError)
      post :search_tmdb, search_terms: 'hardware'
      response.should redirect_to(movies_path)
    end

    describe "after valid search" do
      before :each do
        Movie.stub(:find_in_tmdb).and_return(@fake_results)
        post :search_tmdb, search_terms: 'hardware'
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