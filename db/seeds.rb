# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.destroy_all
User.create(email: "admin@example.com", password: "12345678", role: "admin", nickname: "Default Admin")
User.create(email: "morrie@example.com", password: "12345678", role: "admin", nickname: "Default Morrie")
User.create(email: "morrie2@example.com", password: "12345678", role: "admin", nickname: "Default Morrie2")
User.create(email: "morrie3@example.com", password: "12345678", role: "admin", nickname: "Default Morrie3")