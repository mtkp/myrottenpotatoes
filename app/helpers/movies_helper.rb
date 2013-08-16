module MoviesHelper
  def cache_key_for_movie_table
    count          = Movie.count
    max_updated_at = Movie.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "products/all-#{count}-#{max_updated_at}"
  end
end
