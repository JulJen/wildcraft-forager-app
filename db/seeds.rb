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
Category.destroy_all
Project.destroy_all
Post.destroy_all

100.times do |index|
  Category.create!(
  name: Faker::Company.unique.industry,

  created_at: Faker::Time.between(4.months.ago, 1.month.ago),
  updated_at: Faker::Time.between(4.months.ago, 1.month.ago)
)
end

50.times do |index|
  User.create!(
    name: Faker::FunnyName.unique.name, #=> "Kaci"
    password_digest: Faker::Internet.unique.password, #=> "*%NkOnJsH4"
    email: Faker::Internet.unique.email,  #=> "eliza@mann.net"
    status: true,
    admin: false,

    image: Faker::LoremFlickr.image,
    time_zone: Faker::Address.unique.time_zone,
    language: Faker::Nation.language,
    gender: Faker::Gender.type,
    programlanguage: Faker::ProgrammingLanguage.name,
    interest: Faker::Educator.subject,

    created_at: Faker::Time.between(4.months.ago, 1.month.ago),
    updated_at: Faker::Time.between(4.months.ago, 1.month.ago)
  )
end


50.times do |index|
  Project.create!(
    name: Faker::Hipster.unique.words(1, true),
    description: Faker::Hipster.unique.sentences,

    created_at: Faker::Time.between(4.months.ago, 1.month.ago),
    updated_at: Faker::Time.between(4.months.ago, 1.month.ago)
  )
end


100.times do |index|
  Membership.create!(
    category: Faker::Company.unique.industry,
end


50.times do |index|
  Post.create!(
    name: Faker::Company.unique.bs,
    description: Faker::Hipster.unique.sentences,

    created_at: Faker::Time.between(4.months.ago, 1.month.ago),
    updated_at: Faker::Time.between(4.months.ago, 1.month.ago)
  )
end


p "Created #{Category.count} categories, #{User.count} users, #{Project.count} projects, #{Post.count} posts"
