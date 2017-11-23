# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'crystal_admin@crystalclearartworks.com', password: 'password_01', password_confirmation: 'password_01') if Rails.env.development?
AdminUser.create!(email: 'crystal_admin@crystalclearartworks.com', password: 'password_01', password_confirmation: 'password_01') if Rails.env.production?