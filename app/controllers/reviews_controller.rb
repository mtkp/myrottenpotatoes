class ReviewsController < ApplicationController
  before_action :find_movie_and_logged_in_user
  before_action :find_review, except: [:new, :create]

  def new
    @review = @movie.reviews.build
  end

  def create
    review = @current_user.reviews.find_or_create_by(movie_id: @movie.id)
    review.update_attributes(review_params)
    flash[:success] = "Your review for #{@movie.title} has been added."
    redirect_to @movie
  end

  def edit
  end

  def update
    @review.update_attributes(review_params)
    flash[:success] = "Your review for #{@movie.title} has been updated."
    redirect_to @movie
  end

  def destroy
    @review.destroy
    flash[:info] = "Your review for #{@movie.title} has been removed."
    redirect_to @movie
  end

private

  def find_movie_and_logged_in_user
    logged_in_user
    unless (@movie = Movie.find_by_id(params[:movie_id]))
      flash[:danger] = "Review must be for an existing movie."
      redirect_to movies_path
    end
  end

  def review_params
    params.require(:review).permit(:potatoes, :comments)
  end

  def find_review
    @review = @current_user.reviews.find_by_id params[:id]
    unless @review
      flash[:danger] = "That review does not exist."
      redirect_to @movie
    end
  end

end
