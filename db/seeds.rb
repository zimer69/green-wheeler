# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "[1/3] Clearing database..."
Offer.destroy_all if Rails.env.development?
User.destroy_all if Rails.env.development?

puts "[2/3] Generating seed..."
4.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3, min_numeric: 3),
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    rating: rand(0..5),
    user_type: %w[customer owner].sample
  )
  p user
  5.times do
    p Offer.create!(
      category: ['Bicycle', 'Skateboard', 'Scooter', 'Rollerblades'].sample,
      price_in_cents: Faker::Number.number(digits: 5),
      user_id: user.id,
      rating: rand(0..5),
      title: Faker::Lorem.characters(number: 10, min_alpha: 4),
      description: Faker::Lorem.sentence(word_count: 20),
      electric: [true, false].sample,
      safety_equipment: [true, false].sample,
      optional: ['None', 'Padlock', 'Backseat'].sample
    )
  end
end

puts "[3/3] Seed successfully created!"
