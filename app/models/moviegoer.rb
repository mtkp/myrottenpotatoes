class Moviegoer < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :movies, through: :reviews

  def self.find_or_create_from_auth_hash(auth_hash)
    self.create_with(
      name: auth_hash[:info][:name],
      image: auth_hash[:info][:image]
    ).find_or_create_by(
      provider: auth_hash[:provider],
      uid: auth_hash[:uid]
    )
  end

  def profile_pic
    self.image or "/assets/no_profile_pic.jpg"
  end

  def review_for(movie)
    self.reviews.find_by_movie_id movie.id
  end
end
