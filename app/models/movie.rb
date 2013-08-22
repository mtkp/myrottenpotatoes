class Movie < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :moviegoers, through: :reviews

  class Movie::InvalidKeyError < StandardError; end
  class Movie::InvalidIDError < StandardError; end


  RATINGS = %w[ NR G PG PG-13 R NC-17 ]
  @@small_base_image_url = "http://d3gtl9l2a4fn1j.cloudfront.net/t/p/w185"
  @@large_base_image_url = "http://d3gtl9l2a4fn1j.cloudfront.net/t/p/w370"
  @@grandfathered_date = Time.parse("1 Nov 1968")
  @@filler_image_url = "/assets/no_poster_185.jpg"

  self.per_page = 10

  # validations
  validates :title, presence: true
  validates :release_date, presence: true
  validate :released_1930_or_later
  validates :rating, inclusion: { in: RATINGS }, unless: :grandfathered?

  # methods
  def grandfathered? ; self.release_date < @@grandfathered_date ; end

  def released_1930_or_later
    errors.add(:release_date, "must be 1930 or later") if
      self.release_date <= Time.parse("31 Dec 1929")
  end

  def review_average
    self.reviews.average(:potatoes).to_f.round(1)
  end

  def small_poster
    if self.poster_path
      @@small_base_image_url + self.poster_path
    else
      @@filler_image_url
    end
  end

  def large_poster
    if self.poster_path
      @@large_base_image_url + self.poster_path
    else
      @@filler_image_url
    end
  end

  def self.find_in_tmdb(string)
    results = self.tmdb_movie_find(title: string)
    results.is_a?(Array) ? results : [results]
  end

  def self.find_or_create_from_tmdb_id(tmdb_id)
    movie = self.find_by tmdb_id: tmdb_id
    movie ||= self.create(self.movie_params_from_tmdb_movie_id(tmdb_id))
  end

private

  def self.api_key
    ENV["TMDB_API_KEY"]
  end

  def self.tmdb_movie_find(args)
    # set defaults
    args[:expand_results] ||= false
    args[:language] ||= "en"
    args[:limit] ||= 30

    # query TMDb
    Tmdb.api_key = self.api_key # set up api key
    TmdbMovie.find(args)
  rescue ArgumentError => tmdb_error
    raise Movie::InvalidKeyError, tmdb_error.message
  rescue RuntimeError => tmdb_error
    if tmdb_error.message =~ /status code '404'/
      raise Movie::InvalidKeyError, tmdb_error.message
    else
      raise RuntimeError, tmdb_error.message
    end
  end

  def self.movie_params_from_tmdb_movie_id(tmdb_id)
    tmdb_movie = self.tmdb_movie_find(id: tmdb_id, expand_results: true)
    {
      tmdb_id: tmdb_id,
      title: tmdb_movie[:title],
      release_date: tmdb_movie[:release_date],
      description: tmdb_movie[:overview],
      rating: self.tmdb_rating(tmdb_movie),
      poster_path: tmdb_movie[:poster_path] 
    }
  end

  def self.tmdb_rating(tmdb_movie)
    unless tmdb_movie.releases.nil?
      tmdb_movie.releases.each do |release|
        if release[:iso_3166_1] =~ /US/i
          return release[:certification] if RATINGS.include? release[:certification]
        end
      end
    end
    "NR"
  end

end
