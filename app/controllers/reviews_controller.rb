class ReviewsController < ApplicationController
  before_filter :has_moviegoer_and_movie
  before_filter :find_review, except: [:new, :create]

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
    flash[:notice] = "Your review for #{@movie.title} has been removed."
    redirect_to @movie
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
    params.require(:review).permit(:potatoes)
  end

  def find_review
    @review = @current_user.reviews.find_by_id params[:id]
    unless @review
      flash[:error] = "That review does not exist."
      redirect_to @movie
    end
  end

end
