# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([{ first_name: 'Admin', email: 'admin@fake-provider.com', password: 'admin', confirmed_at: Time.now.utc, is_admin: true },
  { first_name: 'Manager', email: 'manager@fake-provider.com', password: 'manager', confirmed_at: Time.now.utc, is_manager: true },
  { first_name: 'Regular', email: 'regular@fake-provider.com', password: 'regular', confirmed_at: Time.now.utc }])
