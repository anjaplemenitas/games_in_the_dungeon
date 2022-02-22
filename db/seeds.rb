# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
require "json"

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

url = "https://api.boardgameatlas.com/api/search?list_id=5yCPKRYJoF&client_id=OShMmavExz"

url_json = JSON.parse(URI.open(url).read)

GENRES = [
  'Abstract Strategy',
  'Action Drafting',
  'Area Control',
  'Bluffing',
  'Card Drafting',
  'Cooperative',
  'Deckbuilding',
  'Dexterity',
  'Engine Building',
  'Eurogame',
  'Legacy',
  'Miniature',
  'Party',
  'Roleplaying',
  'Roll and Write',
  'Storytelling',
  'Tile Placement',
  'Trading Card',
  'Trick Taking',
  'Wargame',
  'Worker Placement'
]

url_json['games'].each do |game|
  puts "Creating #{game['name']}"

  # print `curl #{game['image_url']} > #{game['name'].gsub(" ", "")}.jpg`
  # x = Cloudinary::Uploader.upload("#{game['name'].gsub(' ', '')}.jpg")["public_id"]

  bg = Boardgame.new(
    name: game['name'],
    description: game['description'],
    image_url: game['image_url'],
    rating: rand(1..10),
    user_id: User.all.sample.id,
    genre: GENRES.sample
  )

  bg.photo.attach(io: URI.open(game['image_url']), filename: "#{game['name'].gsub(' ', '')}.jpg", content_type: 'image/jpg')

  if bg.save
    puts "Created #{bg.name}"
  else
    puts "Failed"
  end
end
