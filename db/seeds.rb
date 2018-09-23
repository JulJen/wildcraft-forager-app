# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

Faker::UniqueGenerator.clear

User.destroy_all
Team.destroy_all
Project.destroy_all

50.times do |index|
  User.create!(name: Faker::FunnyName.unique.name, #=> "Kaci"
    password_digest: Faker::Internet.unique.password, #=> "*%NkOnJsH4"
    email: Faker::Internet.unique.email,  #=> "eliza@mann.net"
    status: true,
    image: Faker::LoremFlickr.image,
    time_zone: Faker::Address.unique.time_zone,
    language: Faker::Nation.language,
    gender: Faker::Gender.type,
    programlanguage: Faker::ProgrammingLanguage.name,
    interest: Faker::Educator.subject
  )
  Team.create!(name: Faker::Hipster.unique.words(1, true),
    team_admin: false,
    category: Faker::Company.industry,
    created_at: Faker::Time.between(4.months.ago, 1.month.ago),
    updated_at: Faker::Time.between(4.months.ago, 1.month.ago)
  )
  Project.create!(name: Faker::Company.unique.bs,
    description: Faker::Hipster.unique.sentences,
    status: true,
    created_at: Faker::Time.between(4.months.ago, 1.month.ago),
    updated_at: Faker::Time.between(4.months.ago, 1.month.ago)
  )
end


Industry.destroy_all
80.times do |index|
  Industry.create!(
  category: Faker::Company.unique.industry
)
end

p "Created #{User.count} users, #{Team.count} teams, #{Project.count} projects, #{Industry.count} industries"
