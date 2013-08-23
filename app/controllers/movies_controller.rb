class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, except: [:search_tmdb, :index, :show]
  before_action :admin_user, only: [:destroy]

  def index
    @movies = Movie.paginate(page: params[:page]).search(params[:search_terms])
  end

  def show
    @current_user_review = @current_user.review_for @movie if @current_user
    @average = @movie.review_average
    render partial: 'movie_float',
      locals: {movie: @movie, average: @average} and return if request.xhr?
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new movie_params
    if @movie && @movie.save
      flash[:success] = "#{@movie.title} was successfully created."
      redirect_to movies_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @movie.update_attributes movie_params
      flash[:success] = "#{@movie.title} was successfully updated."
      redirect_to @movie
    else
      render 'edit'
    end
  end

  def destroy
    @movie.destroy
    flash[:info] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  def search_tmdb
    @movies = Movie.find_in_tmdb(params[:tmdb_search_terms])
    if @movies.empty?
      flash[:info] = "'#{params[:tmdb_search_terms]}' was not found in TMDb."
      redirect_to movies_path
    end
  rescue Movie::InvalidKeyError
    flash[:danger] = "API Key is not valid!"
    redirect_to movies_path
  end

  def add_from_tmdb
    @movie = Movie.find_or_create_from_tmdb_id(params[:tmdb_id])
    redirect_to @movie
  rescue Movie::InvalidKeyError
    flash[:danger] = "There was an error with getting the movie from TMDb."
    flash[:danger] << " No movies were added."
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

  def admin_user
    unless @current_user.admin
      flash[:danger] = "You are not authorized to delete this movie."
      redirect_to @movie
    end
  end

end
