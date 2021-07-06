# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Role.destroy_all!
Role.create!(name: "concert manager")
Role.create!(name: "stage manager")
Role.create!(name: "music director")
Role.create!(name: "associate conductor")
Role.create!(name: "assistant conductor")
Role.create!(name: "tour manager")
Role.create!(name: "production manager")
Role.create!(name: "company manager")
Role.create!(name: "librarian")
Role.create!(name: "concertmaster")
Role.create!(name: "principal")
Role.create!(name: "vice principal")
Role.create!(name: "section")
Role.create!(name: "guest artist")
Role.create!(name: "videographer")
Role.create!(name: "sound engineer")
Role.create!(name: "usher")
Role.create!(name: "stage crew")
Role.create!(name: "lighting")
Role.create!(name: "ceo")
Role.create!(name: "coo")
Role.create!(name: "cfo")
Role.create!(name: "cto")
Role.create!(name: "development")
