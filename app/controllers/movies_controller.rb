class MoviesController < ApplicationController

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:success] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  private
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end

end
