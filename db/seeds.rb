# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  user = User.create!(email: 'abc@example.org', name: 'test user', password: 'test1234', password_confirmation: 'test1234')
  group = Group.new(title: 'test', description: 'blahblah')
  group.owner = user
  group.save!
  Post.create(content: 'Welcome!', group_id: group.id, user_id: user.id)
