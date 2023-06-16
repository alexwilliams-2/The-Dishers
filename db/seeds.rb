# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require "open-uri"

# Create businesses
Business.destroy_all
User.destroy_all
london_address = [
  "119 Kensington Church Street, London, W8 7LN",
  "Spaniards Road, Hampstead, London, NW3 7JJ",
  "117 Rotherhithe Street, London, SE16 4NF",
  "Walham Grove, Fulham, London, SW6 1QP",
  "145 Fleet Street, London, EC4A 2BU",
  "10 Downing Street, Westminster, London, SW1A 2AA",
  "Westminster Bridge Road, London, SE1 7PB",
  "Bermondsey Street, London, SE1 3TQ",
  "Dean Street, Soho, London, W1D 3SG",
  "38 Kingsway, Holborn, London, WC2B 6EY",
  "30 St Mary Axe, London, EC3A 8EP",
  "31-32 Maiden Lane, Covent Garden, London, WC2E 7JS",
  "5 Stable Street, King's Cross, London, N1C 4AB",
  "56 Commercial Street, Spitalfields, London, E1 6LT",
  "16 Albemarle Street, Mayfair, London, W1S 4HW",
  "35 Great Queen Street, Covent Garden, London, WC2B 5AA",
  "10 New Burlington Street, Mayfair, London, W1S 3BE",
  "45 Park Lane, Mayfair, London, W1K 1PN",
  "52 Holborn Viaduct, Holborn, London, EC1A 2FD",
  "20 Fenchurch Street, London, EC3M 3BY",
  "24 Brewer Street, Soho, London, W1F 0SB",
  "29 Maddox Street, Mayfair, London, W1S 2PA",
  "3 Henrietta Street, Covent Garden, London, WC2E 8LU",
  "18 Thayer Street, Marylebone, London, W1U 3JY",
  "45-47 Villiers Street, Charing Cross, London, WC2N 6NE",
  "31 Duke Street, Marylebone, London, W1U 1LG",
  "47 Beak Street, Soho, London, W1F 9SE",
  "9 Conduit Street, Mayfair, London, W1S 2XG",
  "25 Newman Street, Fitzrovia, London, W1T 1PN",
  "89-91 Old Street, Shoreditch, London, EC1V 9HW",
  "24 Cornhill, City of London, London, EC3V 3ND",
  "18-22 Craven Road, Paddington, London, W2 3PX",
  "28-30 St. John Street, Clerkenwell, London, EC1M 4DN",
  "16 Great Chapel Street, Soho, London, W1F 8FL",
  "2 Ganton Street, Soho, London, W1F 7QL",
  "41-43 Brushfield Street, Spitalfields, London, E1 6AA",
  "38-42 Duke Street, Mayfair, London, W1U 1EU",
  "17 Kingly Street, Soho, London, W1B 5PW",
  "30 Lisle Street, Leicester Square, London, WC2H 7BA"
]

10.times do |i|
  puts "creating..."
  business = Business.new(
    name: Faker::Company.unique.name,
    address: london_address.sample,
    email: Faker::Internet.unique.email,
    phone_number: Faker::PhoneNumber.unique.phone_number,
    category: ['Hotel', 'Restaurant', 'Cafe', 'Bar', 'Resort'].sample,
    size: ["1-10 employees", "11-50 employees", "51-100 employees"].sample,
    business_hours: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :short),
    description: Faker::Restaurant.description
  )
  file = URI.open(Faker::LoremFlickr.image(size: "300x300", search_terms: ['bar']))
  business.photo.attach(io: file, filename: "business_#{i}.png", content_type: "image/png")
  business.save
  puts "#{business.id} has been created"
end

  puts "creating 10 users"

  user_1 = User.create!( #As a User model is held by Devise, bio and location need to be added separately.
    username: "Joseph",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_1.photo.attach(io: File.open(Rails.root.join("app/assets/images/joseph.jpeg")), filename: "joseph.jpeg", content_type: 'image/jpeg')

  user_1.update!(
    bio: "Master of all things events and hospitality! I'll take your special occasions to the next level, crafting unforgettable moments that will have guests talking about them for years to come.",
    location: "London"
  )
puts "user created"

  user_2 = User.create!(
    username: "Maram",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_2.photo.attach(io: File.open(Rails.root.join("app/assets/images/maram.jpeg")), filename: "maram.jpeg", content_type: 'image/jpeg')

  user_2.update!(
    bio: "Friendly front desk ninja with a talent for making everyone feel instantly at ease. From check-ins to check-outs, I'm here to make your stay as smooth and enjoyable as possible!",
    location: "London"
  )
  puts "user created"

  user_3 = User.create!(
    username: "Alex",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_3.photo.attach(io: File.open(Rails.root.join("app/assets/images/alex.jpg")), filename: "alex.jpg", content_type: 'image/jpg')

  user_3.update!(
    bio: "People-pleaser extraordinaire and hospitality aficionado. I'll go above and beyond to ensure every guest feels like a VIP, with personalized service and a touch of genuine warmth.",
    location: "London"
  )
  puts "user created"

  user_4 = User.create!(
    username: "Eli",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_4.photo.attach(io: File.open(Rails.root.join("app/assets/images/eli.jpeg")), filename: "eli.jpeg", content_type: 'image/jpeg')

  user_4.update!(
    bio: "Seasoned hotel guru who knows the ins and outs of creating a great guest experience. I've got the skills to juggle any challenge and keep the vibes high, all while rocking a big smile!",
    location: "London"
  )
  puts "user created"

  user_5 = User.create!(
    username: "Brett",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_5.photo.attach(io: File.open(Rails.root.join("app/assets/images/brett.jpg")), filename: "brett.jpg", content_type: 'image/jpg')

  user_5.update!(
    bio: "Passionate hospitality rockstar with a flair for making magic happen. From surprise upgrades to secret local recommendations, I'm here to sprinkle some extra sparkle into your stay!",
    location: "London"
  )
  puts "user created"

  user_6 = User.create!(
    username: "Wojciech",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_6.photo.attach(io: File.open(Rails.root.join("app/assets/images/watch.jpeg")), filename: "watch.jpeg", content_type: 'image/jpeg')

  user_6.update!(
    bio: "Experienced hospitality pro who thrives on making people smile. Whether it's serving up delicious drinks or helping guests find hidden gems in the city, I'm all about creating unforgettable moments.",
    location: "London"
  )
  puts "user created"

  user_7 = User.create!(
    username: "Tom",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_7.photo.attach(io: File.open(Rails.root.join("app/assets/images/tom.jpeg")), filename: "tom.jpeg", content_type: 'image/jpeg')

  user_7.update!(
    bio: "Hospitality fanatic always on the lookout for opportunities to create awesome experiences. Love making guests feel right at home and going the extra mile to ensure they have a blast!",
    location: "London"
  )
  puts "user created"

  user_8 = User.create!(
    username: "Luca",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_8.photo.attach(io: File.open(Rails.root.join("app/assets/images/luca.jpeg")), filename: "luca.jpeg", content_type: 'image/jpeg')

  user_8.update!(
    bio: "Adventure-seeking hospitality enthusiast always ready to sprinkle a dash of excitement into your stay. Whether it's arranging epic activities or sharing local hidden gems, I'm your go-to person for unforgettable experiences!",
    location: "London"
  )
  puts "user created"

  user_9 = User.create!(
    username: "Omesh",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_9.photo.attach(io: File.open(Rails.root.join("app/assets/images/omesh.jpeg")), filename: "omesh.jpeg", content_type: 'image/jpeg')

  user_9.update!(
    bio: "Hospitality superhero with a passion for creating positive vibes. From crafting the coziest rooms to whipping up delicious breakfasts, I'm here to make sure your stay is filled with happy memories and belly laughs.",
    location: "London"
  )
  puts "user created"

  user_10 = User.create!(
    username: "Oli",
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 10)
  )

  user_10.photo.attach(io: File.open(Rails.root.join("app/assets/images/oli.jpeg")), filename: "oli.jpeg", content_type: 'image/jpeg')

  user_10.update!(
    bio: "Adventure-seeking hospitality enthusiast always ready to sprinkle a dash of excitement into your stay. Whether it's arranging epic activities or sharing local hidden gems, I'm your go-to person for unforgettable experiences!",
    location: "London"
  )
  puts "10 users created created"

  puts "creating 30 reviews"

  businesses = Business.all
  users = User.all
  titles = ["Great Work Environment", "Excellent Team","I hated every second there", "Flexible Schedule", "Don't work there", "They never pay on time", "They don't pay fair", "Good money", "Free lunches and good management"].sample
  user_content = titles

  30.times do
    business = businesses.sample
    user = users.sample

  Review.create!(
    business: business,
    user: user,
    title: titles,
    content: user_content,
    recommended: (titles.include?("hated") || titles.include?("don't") || titles.include?("never")) ? false : true,
    job_title: ["Manager", "Bartender", "Waitstaff", "Chef"].sample,
    rating: (titles.include?("hated") || titles.include?("don't") || titles.include?("never")) ? rand(1..3) : rand(4..5),
    wage: rand(10.0..50.0),
    votes: rand(0..10),
  )
  puts "review created"
  end
