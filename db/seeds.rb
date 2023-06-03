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

50.times do |i|
  "creating..."
  business = Business.new(
    name: Faker::Company.unique.name,
    address: Faker::Address.full_address,
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
  "#{business.id} has been created"
end
