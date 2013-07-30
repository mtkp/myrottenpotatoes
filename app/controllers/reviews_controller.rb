class ReviewsController < ApplicationController
  before_filter :has_moviegoer_and_movie

  def new
    @review = @movie.reviews.build
  end

  def create
    @current_user.reviews << @movie.reviews.build(review_params)    
  end

private
  def has_moviegoer_and_movie
    unless @current_user
      flash[:error] = "You must be logged in to create a review."
      redirect_to login_path
    end
    unless (@movie = Movie.find_by_id(params[:movie_id]))
      flash[:error] = "Review must be for an existing movie."
      redirect_to movies_path
    end
  end

  def review_params
    params.require(:review).permit(:movie, :moviegoer, :potatoes)
  end
end
