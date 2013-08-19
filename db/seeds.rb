# Seed the RottenPotatoes DB with some movies.
movies = [
  { title: 'Aladdin', rating: 'G', tmdb_id: 812,
    release_date: '25-Nov-1992', description: "Aladdin, a street urchin, accidentally meets Princess Jasmine, who is in the city undercover. They love each other, but she can only marry a prince." },
  { title: 'When Harry Met Sally', rating: 'R', tmdb_id: 639,
    release_date: '21-Jul-1989', description: "Harry and Sally have known each other for years, and are very good friends, but they fear sex would ruin the friendship." },
  { title: 'The Help', rating: 'PG-13', tmdb_id: 50014,
    release_date: '10-Aug-2011', description: "An aspiring author during the civil rights movement of the 1960s decides to write a book detailing the African-American maids' point of view on the white families for which they work, and the hardships they go through on a daily basis." },
  { title: 'Raiders of the Lost Ark', rating: 'PG', tmdb_id: 85,
    release_date: '12-Jun-1981', description: "Archeologist and adventurer Indiana Jones is hired by the US government to find the Ark of the Covenant before the Nazis." },
  { title: 'Inception', rating: 'PG-13', tmdb_id: 27205,
    release_date: '16-Jul-2010', description: "A skilled extractor is offered a chance to regain his old life as payment for a task considered to be impossible." },
  { title: 'Man of Steel', rating: 'PG-13', tmdb_id: 49521,
    release_date: '14-Jun-2013', description: "A young itinerant worker is forced to confront his secret extraterrestrial heritage when Earth is invaded by members of his race." },
  { title: 'Pacific Rim', rating: 'PG-13', tmdb_id: 68726,
    release_date: '12-Jul-2013', description: "As a war between humankind and monstrous sea creatures wages on, a former pilot and a trainee are paired up to drive a seemingly obsolete special weapon in a desperate effort to save the world from the apocalypse." },
  { title: 'Elysium', rating: 'R', tmdb_id: 68724,
    release_date: '9-Aug-2013', description: "In the year 2159, two classes of people exist: the very wealthy who live on a pristine man-made space station called Elysium, and the rest, who live on an overpopulated, ruined Earth. Secretary Rhodes (Jodie Foster), a hard line government official, will stop at nothing to enforce anti-immigration laws and preserve the luxurious lifestyle of the citizens of Elysium. That doesn't stop the people of Earth from trying to get in, by any means they can. When unlucky Max (Matt Damon) is backed into a corner, he agrees to take on a daunting mission that, if successful, will not only save his life, but could bring equality to these polarized worlds." },
  { title: 'The Fall', rating: 'R', tmdb_id: 14784,
    release_date: '9-May-2008', description: "In a hospital on the outskirts of 1920s Los Angeles, an injured stuntman begins to tell a fellow patient, a little girl with a broken arm, a fantastic story about 5 mythical heroes. Thanks to his fractured state of mind and her vivid imagination, the line between fiction and reality starts to blur as the tale advances." },
  { title: 'Spirited Away', rating: 'PG', tmdb_id: 129,
    release_date: '30-Sep-2001', description: "As a war between humankind and monstrous sea creatures wages on, a former pilot and a trainee are paired up to drive a seemingly obsolete special weapon in a desperate effort to save the world from the apocalypse." }
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

moviegoers.each_with_index do |moviegoer, i|
  moviegoer[:uid] = (1000 + i).to_s
  moviegoer[:provider] = "twitter"
  new_moviegoer = Moviegoer.create!(moviegoer)

  # create reviews for some movies for the moviegoer
  Movie.all.sample(3).each do |movie|
    review = { potatoes: Review::POTATOES.sample }
    new_moviegoer.reviews << movie.reviews.build(review)
  end
end
