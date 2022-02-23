# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
# require "json"
require "nokogiri"

# User seed
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

15.times do
  puts "Creating user"
  user = User.new(
    { email: "#{('a'..'z').to_a.sample(6).join}@#{('a'..'z').to_a.sample(6).join}.com",
      password: ('a'..'z').to_a.sample(6).join }
  )

  user.save

  puts "User #{user.id} created"
end

# url = "https://api.boardgameatlas.com/api/search?list_id=5yCPKRYJoF&client_id=OShMmavExz"

# url_json = JSON.parse(URI.open(url).read)

noko = Nokogiri::HTML(URI.open("https://boardgamegeek.com/browse/boardgame"))

titles = noko.search('.primary').map { |x| x.text.strip }
description = noko.search('.collection_objectname p').map { |x| x.text.strip }
images = noko.search('.collection_thumbnail img').map { |x| x['src'] }
# game_page_url = noko.search('.primary').map { |x| "https://boardgamegeek.com#{x['href']}" }

titles.each_with_index do |game, index|
  puts "Creating #{game}"

  # print `curl #{game['image_url']} > #{game['name'].gsub(" ", "")}.jpg`
  # x = Cloudinary::Uploader.upload("#{game['name'].gsub(' ', '')}.jpg")["public_id"]

  bg = Boardgame.new(
    name: game,
    description: description[index],
    image_url: images[index],
    rating: rand(1..5),
    user_id: User.all.sample.id,
    genre: GENRES.sample
  )

  bg.photo.attach(
    io: URI.open(images[index]),
    filename: "#{game.gsub(' ', '')}.jpg",
    content_type: 'image/jpg'
  )

  if bg.save
    puts "Created #{bg.name}"
  else
    puts "Failed"
  end
end


# game_page_url.each do |url|
#   page_noko = Nokogiri::HTML(URI.open(url))
#   p x = page_noko.search('.game-header-image')
#   # puts x
# end

# https://boardgamegeek.com/boardgame/174430/gloomhaven
