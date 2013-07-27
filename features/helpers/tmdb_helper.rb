def tmdb_mock_results(string = nil)
  if string.nil? or string =~ /Movie That Does Not Exist/
    return %Q({"page":1,"results":[],"total_pages":0,"total_results":0})
  end
  %Q({"page":1,"results":[{"adult":false,"backdrop_path":"/s2bT29y0ngXxxu2IA8AOzzXTRhd.jpg","id":27205,"original_title":"#{string}","release_date":"2010-07-16","poster_path":"/tAXARVreJnWfoANIHASmgYk4SB0.jpg","popularity":13.1167032875537,"title":"#{string}","vote_average":7.7,"vote_count":2360},{"adult":false,"backdrop_path":"/2kGP9gJEONx1hjgRjbusXzAbKQf.jpg","id":64956,"original_title":"#{string} 2","release_date":"","poster_path":"/yr6XX4c7BOvxVjV6cJePwZdUlLn.jpg","popularity":2.11842089013492,"title":"#{string} 2","vote_average":6.4,"vote_count":7}],"total_pages":1,"total_results":2})
end

alias tmdb_mock_result tmdb_mock_results

def tmdb_request_url(string)
  request_url = "http://api.themoviedb.org/3/search/movie?api_key="
  request_url << ENV["TMDB_API_KEY"]
  request_url << "&language=en&query="
  request_url << string.gsub(/\s/, '%20')
end
