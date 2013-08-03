module ApplicationHelper

  def release_date(movie)
    date = movie.release_date
    if date.respond_to? :strftime
      date.strftime("%b %d, %Y")
    else
      Time.parse(date).strftime("%b %d, %Y")
    end
  rescue ArgumentError
    ""
  end

end
