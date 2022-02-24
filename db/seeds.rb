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

pre = ['silky', 'smooth', 'ferocious', 'cute', 'flexible', 'mc', 'rough', 'judgy']
post = ['elf', 'fox', 'wolf', 'dog', 'eel', 'orc', 'halfling', 'dragon', 'kitty']
a_to_z = ('a'..'z').to_a

puts "Making the bosses!"

['al@boss.com', 'anja@boss.com', 'alex@boss.com'].each do |user|
  User.create(
    email: user,
    username: "#{pre.sample} #{user[0..-10]}",
    password: 'password'
  )

  puts "Boss #{user} made!"
end

puts "---------------------------" * 2

13.times do
  puts "Creating user"
  user = User.new(
    email: "#{a_to_z.sample(6).join}@#{a_to_z.sample(6).join}.com",
    username: "#{pre.sample} #{post.sample}",
    password: a_to_z.sample(6).join
  )

  user.save

  puts "User #{user.username} created"
end

puts "Users seeded"
puts "---------------------------" * 2
puts "Gathering info!"
puts "---------------------------" * 2
puts "This will take some time"
puts "Grab a coffee"
puts "Maybe a ciggy too"
puts "Trust me"
puts "---------------------------" * 2
puts ""

noko = Nokogiri::HTML(URI.open("https://boardgamegeek.com/browse/boardgame"))

titles = noko.search('.primary').map { |x| x.text.strip }
# description = noko.search('.collection_objectname p').map { |x| x.text.strip }
images = []
description = []
year_published = []
age_rating = []
min_playtime = []
max_playtime = []
min_players = []
max_players = []
genres = []

game_id = noko.search('.primary').map { |x| x['href'].match(/.+\/(\d*)\/.+/)[1] }

game_id.each do |gid|
  noko_xml = Nokogiri::XML(URI.open("https://api.geekdo.com/xmlapi/boardgame/#{gid}?"))
  print "."
  images << noko_xml.css('image').text
  description << noko_xml.css('description').text
  year_published << noko_xml.css('yearpublished').text.to_i
  age_rating << noko_xml.css('age').text.to_i
  min_playtime << noko_xml.css('minplaytime').text.to_i
  max_playtime << noko_xml.css('maxplaytime').text.to_i
  min_players << noko_xml.css('minplayers').text.to_i
  max_players << noko_xml.css('maxplayers').text.to_i
  tmp = noko_xml.css('boardgamecategory').map(&:text)
  genres << tmp
end

puts ""
puts "Info gathered!"

titles.each_with_index do |game, index|
  puts "---------------------------" * 2
  puts "Creating #{game}"

  bg = Boardgame.new(
    name: game,
    description: description[index],
    image_url: images[index],
    rating: rand(1..5),
    user_id: User.all.sample.id,
    genre: genres[index].join(", "),
    year_published: year_published[index],
    age_rating: age_rating[index],
    min_playtime: min_playtime[index],
    max_playtime: max_playtime[index],
    min_players: min_players[index],
    max_players: max_players[index]
  )

  bg.photo.attach(
    io: URI.open(images[index]),
    filename: "#{game.gsub(' ', '')}.jpg",
    content_type: 'image/jpg'
  )

  puts "Created #{bg.name}" if bg.save
end

puts "---------------------------" * 2
puts "Seeding complete"
puts "Thank you for being so patient"
