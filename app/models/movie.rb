class Movie < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :moviegoers, through: :reviews

  class Movie::InvalidKeyError < StandardError; end
  RATINGS = %w[ G PG PG-13 R NC-17 ]
  @@grandfathered_date = Time.parse("1 Nov 1968")

  # validations
  validates :title, presence: true
  validates :release_date, presence: true
  validate :released_1930_or_later
  validates :rating, inclusion: { in: RATINGS }, unless: :grandfathered?

  # methods
  def grandfathered? ; self.release_date < @@grandfathered_date ; end
  def self.api_key ; ENV["TMDB_API_KEY"] ; end

  def released_1930_or_later
    errors.add(:release_date, "must be 1930 or later") if
      self.release_date <= Time.parse("31 Dec 1929")
  end

  def self.find_in_tmdb(string)
    Tmdb.api_key = self.api_key
    begin
      TmdbMovie.find(title: string, expand_results: false)
    rescue ArgumentError => tmdb_error
      raise Movie::InvalidKeyError, tmdb_error.message
    rescue RuntimeError => tmdb_error
      if tmdb_error.message =~ /status code '404'/
        raise Movie::InvalidKeyError, tmdb_error.message
      else
        raise RuntimeError, tmdb_error.message
      end
    end
  end

end
