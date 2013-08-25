module MoviesHelper
  def cache_key_for_movies_table(page, search_terms)
    count          = Movie.count
    max_updated_at = Movie.maximum(:updated_at).try(:utc).try(:to_s, :number)
    if search_terms && !search_terms.empty?
      "movie_search//#{count}-#{max_updated_at}"
    else
      "movie_index/page-#{page}/#{count}-#{max_updated_at}"
    end
    "movie" + search_cache(search_terms) + page_cache(page) + "/#{count}-#{max_updated_at}"
  end

  # append a unique string based on a query of the movie model
  def search_cache(search_terms)
    if search_terms && !search_terms.empty?
      "/search-#{search_terms.downcase}"
    else
      ""
    end
  end

end
