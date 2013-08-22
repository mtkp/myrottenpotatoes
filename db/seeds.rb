# Seed the RottenPotatoes DB with some movies.
tmdb_ids = [ 812, 813, 639, 50014, 85, 27205, 49521, 68726, 68724, 14784, 129, 751 ]

tmdb_ids.each do |tmdb_id|
  begin
    Movie.find_or_create_from_tmdb_id(tmdb_id)
  rescue Movie::InvalidKeyError
    next
  end
end

moviegoers = [
  { name: "Alice" },
  { name: "Bob" },
  { name: "Charlie" },
  { name: "Dan" },
  { name: "Emily" },
  { name: "Frank"},
  { name: "Gabby" },
  { name: "Hank" },
  { name: "Irene" },
  { name: "Jackson" },
  { name: "Kelsey" },
  { name: "Leo" },
  { name: "Melinda" },
  { name: "Nathan" },
  { name: "Olivia" },
  { name: "Peter" },
  { name: "Queenie" },
  { name: "Robert" },
  { name: "Sylvia" },
  { name: "Tucker" },
  { name: "Uma" },
  { name: "Viktor" },
  { name: "Wanda" },
  { name: "Xerxes" },
  { name: "Yolanda" },
  { name: "Zeus" }
]

COMMENT = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy."

moviegoers.each_with_index do |moviegoer, i|
  moviegoer[:uid] = (1000 + i).to_s
  moviegoer[:provider] = "twitter"
  new_moviegoer = Moviegoer.create!(moviegoer)

  # create reviews for some movies for the moviegoer
  Movie.all.sample(5).each do |movie|
    review = { potatoes: Review::POTATOES.sample, comments: COMMENT }
    new_moviegoer.reviews << movie.reviews.build(review)
  end
end
