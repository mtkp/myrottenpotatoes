module MoviesHelper
  def cache_key_for_movies_table
    count          = Movie.count
    max_updated_at = Movie.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "movies/all-#{count}-#{max_updated_at}"
  end
end
