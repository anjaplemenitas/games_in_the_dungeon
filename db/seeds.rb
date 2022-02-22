# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
require "nokogiri"

## User seed

# 25.times do
#   puts "Creating user"
#   user = User.new(
#     { email: "#{('a'..'z').to_a.sample(6).join}@#{('a'..'z').to_a.sample(6).join}.com",
#       password: ('a'..'z').to_a.sample(6).join }
#   )

#   user.save

#   puts "User #{user.id} created"
# end


## Boardgame seed

open_url = URI.open("https://boardgamegeek.com/browse/boardgame")
noko_url = Nokogiri::HTML(open_url)

# genres = [
#   'Abstract Strategy',
#   'Action Drafting',
#   'Area Control',
#   'Bluffing',
#   'Card Drafting',
#   'Cooperative',
#   'Deckbuilding',
#   'Dexterity',
#   'Engine Building',
#   'Eurogame',
#   'Legacy',
#   'Miniature',
#   'Party',
#   'Roleplaying',
#   'Roll and Write',
#   'Storytelling',
#   'Tile Placement',
#   'Trading Card',
#   'Trick Taking',
#   'Wargame',
#   'Worker Placement'
# ]

# names = noko_url.search('.collection_objectname a').map { |name| name.text.strip}
# descriptions = noko_url.search('.collection_objectname p').map { |desc| desc.text.strip}
image_url_page = noko_url.search('.collection_objectname a').map do |element|
  "https://boardgamegeek.com#{element['href']}"
end

image_url = []

x = Nokogiri::HTML(URI.open(image_url_page[0]))

y = x.search('.img-responsive img').map

# image_url_page.each do |url|
#   # puts url
#   Nokogiri::HTML(URI.open(url)).search('.game-primary')
# end

# puts image_url

# names.each_with_index do |name, index|
#   puts "Adding #{name} to the database"
#   bg = Boardgame.new(
#     name: name,
#     description: descriptions[index],
#     genre: genres.sample,
#     rating: rand(1..10),
#     user_id: User.all.sample.id
#   )

#   puts "#{name} added to database" if bg.save
# end
