module ReviewsHelper

  def review_class(review_average)
    case review_average
    when 0..2
      "text-danger"
    when 2...3
      "text-warning"
    when 3..5
      "text-success"
    else
      ""
    end
  end
end
