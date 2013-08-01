# Seed the RottenPotatoes DB with some movies.
movies = [
  { title: 'Aladdin', rating: 'G',
    release_date: '25-Nov-1992', description: "Aladdin, a street urchin, accidentally meets Princess Jasmine, who is in the city undercover. They love each other, but she can only marry a prince." },
  { title: 'When Harry Met Sally', rating: 'R',
    release_date: '21-Jul-1989', description: "Harry and Sally have known each other for years, and are very good friends, but they fear sex would ruin the friendship." },
  { title: 'The Help', rating: 'PG-13',
    release_date: '10-Aug-2011', description: "An aspiring author during the civil rights movement of the 1960s decides to write a book detailing the African-American maids' point of view on the white families for which they work, and the hardships they go through on a daily basis." },
  { title: 'Raiders of the Lost Ark', rating: 'PG',
    release_date: '12-Jun-1981', description: "Archeologist and adventurer Indiana Jones is hired by the US government to find the Ark of the Covenant before the Nazis." },
  { title: 'Inception', rating: 'PG-13',
    release_date: '16-Jul-2010', description: "A skilled extractor is offered a chance to regain his old life as payment for a task considered to be impossible." },
  { title: 'Man of Steel', rating: 'PG-13',
    release_date: '14-Jun-2013', description: "A young itinerant worker is forced to confront his secret extraterrestrial heritage when Earth is invaded by members of his race." },
  { title: 'Pacific Rim', rating: 'PG-13',
    release_date: '12-Jul-2013', description: "As a war between humankind and monstrous sea creatures wages on, a former pilot and a trainee are paired up to drive a seemingly obsolete special weapon in a desperate effort to save the world from the apocalypse." }

]

movies.each do |movie|
  Movie.create!(movie)
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
  { name: "Nathan" }
]

moviegoers.each_with_index do |moviegoer, i|
  moviegoer[:uid] = (1000 + i).to_s
  moviegoer[:provider] = "twitter"
  new_moviegoer = Moviegoer.create!(moviegoer)

  # create reviews for some movies for the moviegoer
  Movie.all.sample(4).each do |movie|
    review = { potatoes: Review::POTATOES.sample }
    new_moviegoer.reviews << movie.reviews.build(review)
  end
end
