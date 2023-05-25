# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'

Movie.destroy_all
puts "All movies deleted."

url = 'https://tmdb.lewagon.com/movie/top_rated'
serialized_movies = URI.open(url).read
movies = JSON.parse(serialized_movies)['results']
movies.each do |movie|
  movie = Movie.create(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}",
    rating: movie['vote_average'].to_f
  )
  p movie
end

puts "#{Movie.count} movies created."
