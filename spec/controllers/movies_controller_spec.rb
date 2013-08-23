require 'spec_helper'

describe MoviesController do


  describe "making a new Movie object" do
    before :each do
      @movie = FactoryGirl.create(:movie)
      @moviegoer = FactoryGirl.create(:moviegoer)
      Moviegoer.stub(:find_by_id).and_return @moviegoer
    end
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
      it "should redirect to the index if successfully saved" do
        Movie.any_instance.stub(:valid?).and_return(true)
        post :create, movie: @movie_attributes
        response.should redirect_to movies_path
      end
      it "should render the new page if new @movie instance is nil" do
        Movie.stub(:new).and_return(nil)
        post :create, movie: @movie_attributes
        response.should render_template 'new'
      end
      it "should render the new page if new @movie instance is nil" do
        Movie.any_instance.stub(:save).and_return(false)
        post :create, movie: @movie_attributes
        response.should render_template 'new'
      end
    end
  end

  describe "showing a Movie object" do
    before :each do
      @movie = FactoryGirl.create(:movie)
    end
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
      before :each do
        @moviegoer = FactoryGirl.create(:moviegoer)
      Moviegoer.stub(:find_by_id).and_return @moviegoer
      end
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
        before :each do
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
        Movie.should_receive(:find_by_id).with("#{@movie.id}")
        delete :destroy, id: @movie
      end
      describe "successfully" do
        before :each do
          Movie.stub(:find_by_id).and_return(@movie)
          Moviegoer.stub(:find_by_id).and_return FactoryGirl.create(:admin)
        end
        it "should remove the movie from the model" do
          expect { delete :destroy, id: @movie }.to change(Movie, :count).by(-1)
        end
        it "should redirect to the movies index" do
          delete :destroy, id: @movie
          response.should redirect_to movies_path
        end
      end
      it "should redirect if a movie with the specified ID does not exist" do
        Movie.stub(:find_by_id).and_return(nil)
        delete :destroy, id: @movie
        response.should redirect_to movies_path
      end
      it "should redirect to the movie if the current user is not an admin" do
        Movie.stub(:find_by_id).and_return(@movie)
        Moviegoer.stub(:find_by_id).and_return FactoryGirl.create(:moviegoer)
        delete :destroy, id: @movie
        response.should redirect_to @movie
      end
    end
  end

  describe "the index action" do
    before :each do
      @movies = []
      5.times do
        @movies << FactoryGirl.create(:movie)
      end
    end
    it "should get all the movies in the movie model" do
      Movie.stub(:find).and_return @movies
      get :index
      expect(assigns(:movies)).to match_array(@movies)
    end
  end

  describe "searching TMDb" do
    before :each do
      @fake_results = [double('movie1'), double('movie2')]
    end

    it "should call the model method that performs TMDb search" do
      Movie.should_receive(:find_in_tmdb).with('hardware').
        and_return(@fake_results)
      post :search_tmdb, tmdb_search_terms: 'hardware'
    end

    it "should redirect to the index page if the api key is invalid" do
      Movie.stub(:find_in_tmdb).and_raise(Movie::InvalidKeyError)
      post :search_tmdb, tmdb_search_terms: 'hardware'
      response.should redirect_to(movies_path)
    end

    describe "after valid search" do
      before :each do
        Movie.stub(:find_in_tmdb).and_return(@fake_results)
        post :search_tmdb, tmdb_search_terms: 'hardware'
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