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
30.times do |index|
  User.create!(name: Faker::FunnyName.unique.name, #=> "Kaci"
    password_digest: Faker::Internet.unique.password, #=> "*%NkOnJsH4"
    email: Faker::Internet.unique.email,  #=> "eliza@mann.net"
    image: Faker::LoremFlickr.image,
    time_zone: Faker::Address.unique.time_zone,

    language: Faker::Nation.language,
    gender: Faker::Gender.type,
    programlanguage: Faker::ProgrammingLanguage.name,
    interest: Faker::Educator.subject
  )
end


Team.destroy_all
30.times do |index|
  Team.create!(name: Faker::Hipster.unique.words(1, true),
    team_admin: false,
    category: Faker::Company.unique.industry,
    created_at: Faker::Time.between(4.months.ago, 1.month.ago),
    updated_at: Faker::Time.between(4.months.ago, 1.month.ago)
  )
end


Project.destroy_all
30.times do |index|
  Project.create!(name: Faker::Company.unique.bs,
    description: Faker::Hipster.unique.sentences,
    category: Faker::Company.unique.industry,
    project_admin: false,
    created_at: Faker::Time.between(4.months.ago, 1.month.ago),
    updated_at: Faker::Time.between(4.months.ago, 1.month.ago)
  )
end

Industry.destroy_all
60.times do |index|
  Industry.create!(
  category: Faker::Company.unique.industry
)
end
20.times do |index|
  Industry.create!(
  profession: Faker::Company.unique.profession
)
end

p "Created #{User.count} users, #{Team.count} teams, #{Project.count} projects, #{Industry.count} industries"
