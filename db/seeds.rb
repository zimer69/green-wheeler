# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "[1/4] Clearing database..."
Booking.destroy_all
Offer.destroy_all
User.destroy_all

puts "[2/4] Summoning Mister Booker, your test user..."
p booker = User.create!(
  email: "booker@gmail.com",
  password: "secret",
  first_name: "Mister",
  last_name: "Booker",
  rating: rand(0..5)
)

puts "[3/4] Generating seed..."
4.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "secret",
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    rating: rand(0..5)
  )
  p user
  4.times do
    offer = Offer.create!(
      category: ['Bicycle', 'Skateboard', 'Scooter', 'Rollerblades'].sample,
      price: Faker::Number.number(digits: 2),
      user_id: user.id,
      rating: rand(0..5),
      title: Faker::Quote.yoda[0..99],
      description: Faker::Lorem.sentence(word_count: 50),
      address: Faker::Address.street_address,
      electric: [true, false].sample,
      safety_equipment: [true, false].sample,
      optional: ['None', 'Padlock', 'Backseat'].sample
    )
    2.times do
      Booking.create!(
        start_date: Date.new(2022, 8, 26),
        end_date: Date.new(2022, 8, 30),
        user_id: booker.id,
        offer_id: offer.id
      )
    end
  end
end

puts "[4/4] Seed successfully created!"
