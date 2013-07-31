include ActionView::Helpers::TextHelper

class ReviewsController < ApplicationController
  before_filter :has_moviegoer_and_movie
  before_filter :find_review, only: [:edit, :update]

  def new
    redirect_to edit_movie_review_path(@movie, @review) if moviegoer_has_review
    @review = @movie.reviews.build
  end

  def create
    @current_user.reviews << @movie.reviews.build(review_params)    
    redirect_to @movie
  end

  def edit
  end

  def update
    if @review.update_attributes review_params
      potatoes = pluralize(@review.potatoes, "potato", "potatoes")
      flash[:success] = "Your review has been updated to #{potatoes}."
      redirect_to @movie
    else
      render 'edit'
    end
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

  def moviegoer_has_review
    @review = @current_user.reviews.find_by_movie_id(@movie.id)
  end

  def find_review
    @review = Review.find_by_id params[:id]
    redirect_to @movie unless @review
    redirect_to @movie unless @review.moviegoer.id == @current_user.id
  end

end
