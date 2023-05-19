require 'json'
require 'open-uri'

puts 'Destroying all movies'
Movie.destroy_all

puts "Fetching TMDB"
url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)['results']
img_root_url = 'https://image.tmdb.org/t/p/original'

movies.each do |movie|
  Movie.create(
    {
      title: movie['original_title'],
      overview: movie['overview'],
      rating: movie['vote_average'],
      poster_url: img_root_url + movie['poster_path']
    }
  )
end

puts "Number of movies created : #{Movie.count}"
puts 'Exemple of first movie:'
p Movie.first
