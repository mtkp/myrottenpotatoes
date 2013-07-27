module ApplicationHelper

  def release_date(movie)
    if movie.release_date.respond_to? :strftime
      movie.release_date.strftime("%B %d, %Y") 
    else
      Time.parse(movie.release_date).strftime("%B %d, %Y")
    end
  rescue ArgumentError
    ""
  end

end
