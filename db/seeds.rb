# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env == 'development'
	Rake::Task['hyrax:default_admin_set:create'].invoke
	Rake::Task['hyrax:default_collection_types:create'].invoke

	user = User.first_or_create!(email: 'jlakes@tcd.ie', password: 'testing123')
	admin = Role.first_or_create!(name: "admin")
	admin.users << user
	admin.save
end
