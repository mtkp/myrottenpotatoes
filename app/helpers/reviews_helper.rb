module ReviewsHelper

  def review_class(review_average)
    case review_average
    when 0.0
      "no-rating"
    when 1...2
      "low-rating"
    when 2...3
      "mid-low-rating"
    when 3...4
      "mid-high-rating"
    when 4..5
      "high-rating"
    else
      ""
    end
  end

  def cache_key_for_reviews_table(movie, page)
    count          = movie.reviews.count
    max_updated_at = movie.reviews.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "#{movie.id}/reviews" + page_cache(page) + "/#{count}-#{max_updated_at}"
  end

end
