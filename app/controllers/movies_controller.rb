class MoviesController < ApplicationController
  before_filter :find_movie, only: [:show, :edit, :update] 

  def index
    @movies = Movie.order(:title)
  end

  def show
  end

  def new
  end

  def create
    @movie = Movie.create! movie_params
    flash[:success] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
  end

  def update
    @movie.update_attributes!(movie_params)
    flash[:success] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find_by_id params[:id]
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def search_tmdb
    @movies = Movie.find_in_tmdb(params[:search_terms])
    if @movies.empty?
      flash[:notice] = "'#{params[:search_terms]}' was not found in TMDb."
      redirect_to movies_path
    end
  rescue Movie::InvalidKeyError
    flash[:error] = "API Key is not valid!"
    redirect_to movies_path
  end

  private
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end

    def find_movie
      @movie = Movie.find_by_id params[:id]
      redirect_to movies_path unless @movie
    end

end
