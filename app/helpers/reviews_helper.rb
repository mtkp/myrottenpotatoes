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
end
